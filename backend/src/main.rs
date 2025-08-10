use std::{env::args, str::FromStr};

use anyhow::{Context, anyhow};
use argon2::{Argon2, PasswordHash, PasswordHasher, PasswordVerifier, password_hash::SaltString};
use axum::{
    Json, Router,
    extract::{self, FromRequestParts, OptionalFromRequestParts},
    http::StatusCode,
    response::IntoResponse,
    routing::{delete, get, post},
};
use axum_extra::{
    either::Either::{self, E1, E2},
    extract::{
        CookieJar,
        cookie::{Cookie, Expiration},
    },
};
use base64::Engine;
use deadpool::managed::Object;
use deadpool_postgres::Manager;
use rand_core::OsRng;
use serde::{Deserialize, Serialize};
use tokio::{
    net::TcpListener,
    signal::{
        self,
        unix::{SignalKind, signal},
    },
    sync::broadcast,
    time,
};
use tokio_postgres::{
    Row, Statement,
    types::{ToSql, Type},
};
use tower_http::services::{ServeDir, ServeFile};

fn b64() -> base64::engine::GeneralPurpose {
    base64::engine::GeneralPurpose::new(
        &base64::alphabet::STANDARD,
        base64::engine::general_purpose::NO_PAD,
    )
}

mod sql_queries;

#[derive(Debug, Clone)]
struct State {
    db: deadpool_postgres::Pool,
}

impl State {
    async fn get_db(&self) -> anyhow::Result<Object<Manager>> {
        self.db.get().await.context("failed getting db")
    }

    async fn prepare(
        &self,
        db: &Object<Manager>,
        query: &'static str,
        types: &[Type],
    ) -> anyhow::Result<Statement> {
        db.prepare_typed_cached(query, types)
            .await
            .context("failed preparing query")
    }

    async fn prepare_and_query_one(
        &self,
        db: &Object<Manager>,
        query: &'static str,
        types: &[Type],
        params: &[&(dyn ToSql + Sync)],
    ) -> anyhow::Result<Row> {
        db.query_one(&self.prepare(db, query, types).await?, params)
            .await
            .context("failed querying")
    }

    async fn prepare_and_query_opt(
        &self,
        db: &Object<Manager>,
        query: &'static str,
        types: &[Type],
        params: &[&(dyn ToSql + Sync)],
    ) -> anyhow::Result<Option<Row>> {
        db.query_opt(
            &self
                .prepare(db, query, types)
                .await
                .context("failed preparing query")?,
            params,
        )
        .await
        .context("failed querying")
    }

    async fn prepare_and_query(
        &self,
        db: &Object<Manager>,
        query: &'static str,
        types: &[Type],
        params: &[&(dyn ToSql + Sync)],
    ) -> anyhow::Result<Vec<Row>> {
        db.query(
            &self
                .prepare(db, query, types)
                .await
                .context("failed preparing query")?,
            params,
        )
        .await
        .context("failed querying")
    }

    async fn prepare_and_exec(
        &self,
        db: &Object<Manager>,
        query: &'static str,
        types: &[Type],
        params: &[&(dyn ToSql + Sync)],
    ) -> anyhow::Result<u64> {
        db.execute(
            &self
                .prepare(db, query, types)
                .await
                .context("failed preparing query")?,
            params,
        )
        .await
        .context("failed executing")
    }
}

async fn shutdown_signal(shutdown_sender: broadcast::Sender<()>) {
    println!("listening for signals");

    let ctrl_c = async {
        signal::ctrl_c()
            .await
            .expect("Failed to install CTRL+C handler");
    };

    let mut sigterm = signal(SignalKind::terminate()).expect("Failed to create SIGTERM handler");

    tokio::select! {
        _ = ctrl_c => {},
        _ = sigterm.recv() => {},
    }

    println!("got signal");
    shutdown_sender.send(()).expect("failed sending shutdown");
}

fn check_hash(password: &[u8], hash: &str) -> bool {
    Argon2::default()
        .verify_password(
            &password,
            &PasswordHash::new(&hash).expect("invalid password hash"),
        )
        .is_ok()
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let args: Vec<String> = args().skip(1).collect();
    if args.len() != 3 {
        return Err(anyhow!(
            "expected connection_url, listen_addr and static dir"
        ));
    }
    let db = deadpool_postgres::Pool::builder(deadpool_postgres::Manager::from_config(
        tokio_postgres::Config::from_str(&args[0]).context("invalid postgres connect url")?,
        tokio_postgres::NoTls,
        deadpool_postgres::ManagerConfig::default(),
    ))
    .build()
    .context("failed to build postgres connection pool")?;

    let _ = db.get().await.context("failed to connect to postgres")?;

    let app = Router::new()
        .nest(
            "/api",
            Router::new()
                .route(
                    "/items",
                    get(get_items_handler)
                        .post(post_item_handler)
                        .delete(delete_item_handler),
                )
                .route(
                    "/features",
                    get(get_features_handler)
                        .post(post_feature_handler)
                        .delete(delete_feature_handler),
                )
                .route(
                    "/item_features",
                    get(get_item_features_handler)
                        .post(post_item_feature_handler)
                        .delete(delete_item_feature_handler),
                )
                .route(
                    "/reviews",
                    get(get_reviews_handler)
                        .post(post_review_handler)
                        .delete(delete_review_handler),
                )
                .route("/recommendations", get(recommendations_handler))
                .route("/logout", post(logout_handler))
                .route("/delete_account", delete(delete_account_handler))
                .route("/random_unreviewed", get(random_unreviewed_handler))
                .route("/login", post(login_handler))
                .route("/register", post(register_handler))
                .route("/login_status", get(login_status_handler)),
        )
        .fallback_service(ServeDir::new(&args[2]).fallback(ServeFile::new("/frontend/index.html")))
        .with_state(State { db: db.clone() });

    let listener = TcpListener::bind(&args[1])
        .await
        .context("failed to bind")?;

    let (shutdown_sender, mut shutdown_receiver) = broadcast::channel(1);

    tokio::spawn(refresh_pearson(db, shutdown_sender.subscribe()));

    tokio::spawn(shutdown_signal(shutdown_sender));

    axum::serve(listener, app)
        .with_graceful_shutdown(async move {
            shutdown_receiver
                .recv()
                .await
                .expect("failed receiving shutdown")
        })
        .await
        .context("failed to serve")?;

    Ok(())
}

async fn refresh_pearson(db: deadpool_postgres::Pool, mut shutdown: broadcast::Receiver<()>) {
    let mut timer = time::interval(time::Duration::from_secs(30));

    loop {
        tokio::select! {
            _ = timer.tick() => {
                db.get()
                    .await
                    .expect("failed connecting to database")
                    .execute("refresh materialized view pearson", &[])
                    .await
                    .expect("failed refreshing pearson");
            }
            _ = shutdown.recv() => {
                break;
            }
        }
    }
}

struct LoggedInUser(String);

impl FromRequestParts<State> for LoggedInUser {
    type Rejection = Either<(StatusCode, CookieJar, &'static str), AnyhowResponse>;
    async fn from_request_parts(
        parts: &mut axum::http::request::Parts,
        state: &State,
    ) -> Result<Self, Self::Rejection> {
        let jar = CookieJar::from_request_parts(parts, state)
            .await
            .expect("infallible");

        let deleted_jar = jar.clone().add(Cookie::build("credential").removal());

        let require_logged_in = Err(E1((
            StatusCode::UNAUTHORIZED,
            deleted_jar,
            "action requires user to be logged in",
        )));

        let Some(cred) = jar.get("credentials") else {
            return require_logged_in;
        };

        let Ok([user, pass]): Result<[&str; 2], _> =
            cred.value().split(";").collect::<Vec<_>>().try_into()
        else {
            return require_logged_in;
        };

        let b64 = b64();

        let Ok(user) = b64.decode(user) else {
            return require_logged_in;
        };

        let Ok(user) = String::from_utf8(user) else {
            return require_logged_in;
        };

        let Some(pass) = b64.decode(pass).ok() else {
            return require_logged_in;
        };

        let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

        let hash_row = state
            .prepare_and_query_opt(&db, sql_queries::GET_USER_HASH, &[Type::TEXT], &[&user])
            .await
            .context("failed retrieving hash for user")
            .map_err(AnyhowResponse)
            .map_err(E2)?;

        let Some(hash_row) = hash_row else {
            return require_logged_in;
        };

        if check_hash(&pass, &hash_row.get::<_, String>(0)) {
            Ok(Self(user))
        } else {
            require_logged_in
        }
    }
}

impl OptionalFromRequestParts<State> for LoggedInUser {
    type Rejection = AnyhowResponse;
    async fn from_request_parts(
        parts: &mut axum::http::request::Parts,
        state: &State,
    ) -> Result<Option<Self>, Self::Rejection> {
        match <LoggedInUser as FromRequestParts<State>>::from_request_parts(parts, state).await {
            Ok(user) => Ok(Some(user)),
            Err(E1(_)) => Ok(None),
            Err(E2(err)) => Err(err),
        }
    }
}

struct AnyhowResponse(anyhow::Error);

impl IntoResponse for AnyhowResponse {
    fn into_response(self) -> axum::response::Response {
        (StatusCode::INTERNAL_SERVER_ERROR, format!("{:#}", self.0)).into_response()
    }
}

impl From<anyhow::Error> for AnyhowResponse {
    fn from(value: anyhow::Error) -> Self {
        Self(value)
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
struct Review {
    item: Item,
    rating: i32,
}

#[axum::debug_handler]
async fn get_reviews_handler(
    LoggedInUser(username): LoggedInUser,
    extract::State(state): extract::State<State>,
) -> Result<Json<Vec<Review>>, AnyhowResponse> {
    let db = state.get_db().await?;

    Ok(Json(
        state
            .prepare_and_query(&db, sql_queries::GET_REVIEWS, &[Type::TEXT], &[&username])
            .await
            .context("getting user reviews")?
            .into_iter()
            .map(|row| Review {
                item: Item {
                    name: row.get(0),
                    category: row.get(1),
                },
                rating: row.get(2),
            })
            .collect(),
    ))
}

#[axum::debug_handler]
async fn post_review_handler(
    LoggedInUser(username): LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(Review { item, rating }): Json<Review>,
) -> Result<(), AnyhowResponse> {
    let db = state.get_db().await?;

    state
        .prepare_and_exec(
            &db,
            sql_queries::CREATE_OR_UPDATE_REVIEW,
            &[Type::TEXT, Type::TEXT, Type::TEXT, Type::INT4],
            &[&username, &item.name, &item.category, &rating],
        )
        .await
        .context("creating or updating review")?;

    Ok(())
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
struct ReviewItemOnly {
    item: Item,
}

#[axum::debug_handler]
async fn delete_review_handler(
    LoggedInUser(username): LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(ReviewItemOnly { item }): Json<ReviewItemOnly>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let success: bool = state
        .prepare_and_query_one(
            &db,
            sql_queries::DELETE_REVIEW,
            &[Type::TEXT, Type::TEXT, Type::TEXT],
            &[&username, &item.name, &item.category],
        )
        .await
        .context("deleting review")
        .map_err(AnyhowResponse)
        .map_err(E2)?
        .get(0);

    if !success {
        return Err(E1((StatusCode::NOT_FOUND, "no such review")));
    }

    Ok(())
}

#[axum::debug_handler]
async fn delete_account_handler(
    extract::State(state): extract::State<State>,
    LoggedInUser(username): LoggedInUser,
) -> Result<CookieJar, AnyhowResponse> {
    let db = state.get_db().await?;
    state
        .prepare_and_exec(&db, sql_queries::DELETE_USER, &[Type::TEXT], &[&username])
        .await
        .context("deleting user")?;

    Ok(CookieJar::new().add(Cookie::build("credentials").removal()))
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
struct Feature {
    name: String,
}

#[axum::debug_handler]
async fn get_features_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
) -> Result<Json<Vec<Feature>>, AnyhowResponse> {
    let db = state.get_db().await?;

    let rows = state
        .prepare_and_query(&db, sql_queries::GET_FEATURES, &[], &[])
        .await
        .context("getting features")?;

    let features = rows
        .into_iter()
        .map(|row| Feature { name: row.get(0) })
        .collect();

    Ok(Json(features))
}

#[axum::debug_handler]
async fn post_feature_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(feature): Json<Feature>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let name_row = state
        .prepare_and_query_opt(
            &db,
            sql_queries::CREATE_FEATURE,
            &[Type::TEXT],
            &[&feature.name],
        )
        .await
        .context("creating feature")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if name_row.is_none() {
        Err(E1((StatusCode::CONFLICT, "feature already exists")))
    } else {
        Ok(())
    }
}

#[axum::debug_handler]
async fn delete_feature_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(feature): Json<Feature>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let row = state
        .prepare_and_query_one(
            &db,
            sql_queries::DELETE_FEATURE,
            &[Type::TEXT],
            &[&feature.name],
        )
        .await
        .context("deleting feature")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if !row.get::<_, bool>(0) {
        return Err(E1((StatusCode::NOT_FOUND, "no such feature")));
    }

    Ok(())
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
struct Item {
    name: String,
    category: String,
}

#[axum::debug_handler]
async fn get_item_features_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(item): Json<Item>,
) -> Result<Json<Vec<Feature>>, Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let rows = state
        .prepare_and_query(
            &db,
            sql_queries::GET_ITEM_FEATURES,
            &[Type::TEXT],
            &[&item.name, &item.category],
        )
        .await
        .context("getting item features")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    let features = rows
        .into_iter()
        .map(|row| Feature { name: row.get(0) })
        .collect();

    Ok(Json(features))
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
struct ItemFeature {
    item: Item,
    feature: String,
}

#[axum::debug_handler]
async fn post_item_feature_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(ItemFeature { item, feature }): Json<ItemFeature>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let item_feature_row = state
        .prepare_and_query_opt(
            &db,
            sql_queries::CREATE_ITEM_FEATURE,
            &[Type::TEXT, Type::TEXT, Type::TEXT],
            &[&item.name, &item.category, &feature],
        )
        .await
        .context("creating item feature")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if item_feature_row.is_none() {
        Err(E1((StatusCode::CONFLICT, "item feature already exists")))
    } else {
        Ok(())
    }
}

#[axum::debug_handler]
async fn delete_item_feature_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(ItemFeature { item, feature }): Json<ItemFeature>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let row = state
        .prepare_and_query_one(
            &db,
            sql_queries::DELETE_ITEM_FEATURE,
            &[Type::TEXT, Type::TEXT],
            &[&item.name, &item.category, &feature],
        )
        .await
        .context("deleting item feature")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if !row.get::<_, bool>(0) {
        return Err(E1((StatusCode::NOT_FOUND, "no such item feature")));
    }

    Ok(())
}

#[axum::debug_handler]
async fn get_items_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
) -> Result<Json<Vec<Item>>, AnyhowResponse> {
    let db = state.get_db().await?;

    let rows = state
        .prepare_and_query(&db, sql_queries::GET_ITEMS, &[], &[])
        .await
        .context("getting items")?;

    let items = rows
        .into_iter()
        .map(|row| Item {
            name: row.get(0),
            category: row.get(1),
        })
        .collect();

    Ok(Json(items))
}

#[axum::debug_handler]
async fn post_item_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(item): Json<Item>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let name_row = state
        .prepare_and_query_opt(
            &db,
            sql_queries::CREATE_ITEM,
            &[Type::TEXT, Type::TEXT],
            &[&item.name, &item.category],
        )
        .await
        .context("creating item")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if name_row.is_none() {
        Err(E1((StatusCode::CONFLICT, "item already exists")))
    } else {
        Ok(())
    }
}

#[axum::debug_handler]
async fn delete_item_handler(
    _user: LoggedInUser,
    extract::State(state): extract::State<State>,
    Json(item): Json<Item>,
) -> Result<(), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let row = state
        .prepare_and_query_one(
            &db,
            sql_queries::DELETE_ITEM,
            &[Type::TEXT],
            &[&item.name, &item.category],
        )
        .await
        .context("deleting item")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    if !row.get::<_, bool>(0) {
        return Err(E1((StatusCode::NOT_FOUND, "no such item")));
    }

    Ok(())
}

#[axum::debug_handler]
async fn logout_handler() -> CookieJar {
    CookieJar::new().add(Cookie::build("credentials").removal())
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
struct RegisterData {
    username: String,
    password: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
struct LoginStatusData {
    username: Option<String>,
}

#[axum::debug_handler]
async fn login_status_handler(
    user: Option<LoggedInUser>,
    extract::State(_state): extract::State<State>,
) -> Json<LoginStatusData> {
    Json(LoginStatusData {
        username: user.map(|LoggedInUser(user)| user),
    })
}

#[axum::debug_handler]
async fn register_handler(
    extract::State(state): extract::State<State>,
    form: Json<RegisterData>,
) -> Result<(CookieJar, ()), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let hash = Argon2::default()
        .hash_password(form.password.as_bytes(), &SaltString::generate(&mut OsRng))
        .expect("failed hashing password")
        .to_string();

    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let success: bool = state
        .prepare_and_query_one(
            &db,
            sql_queries::CREATE_USER,
            &[Type::TEXT, Type::TEXT],
            &[&form.username, &hash],
        )
        .await
        .context("creating user")
        .map_err(AnyhowResponse)
        .map_err(E2)?
        .get(0);

    if !success {
        return Err(E1((StatusCode::CONFLICT, "user already exists")));
    }

    let mut total = String::new();
    let b64 = b64();
    total.push_str(&b64.encode(&form.username));
    total.push(';');
    total.push_str(&b64.encode(&form.password));
    let jar = CookieJar::new().add(
        Cookie::build(("credentials", total))
            .http_only(true)
            .expires(Expiration::Session)
            .build(),
    );
    Ok((jar, ()))
}

#[axum::debug_handler]
async fn login_handler(
    extract::State(state): extract::State<State>,
    Json(RegisterData { username, password }): Json<RegisterData>,
) -> Result<(CookieJar, ()), Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let user_hash = state
        .prepare_and_query_opt(&db, sql_queries::GET_USER_HASH, &[Type::TEXT], &[&username])
        .await
        .context("getting hash for user")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    let unauth = Err(E1((StatusCode::UNAUTHORIZED, "wrong user or password")));

    let Some(hash) = user_hash else {
        return unauth;
    };

    if !check_hash(password.as_bytes(), &hash.get::<_, String>(0)) {
        return unauth;
    }

    let mut total = String::new();
    let b64 = b64();
    total.push_str(&b64.encode(&username));
    total.push(';');
    total.push_str(&b64.encode(&password));
    let jar = CookieJar::new().add(
        Cookie::build(("credentials", total))
            .http_only(true)
            .expires(Expiration::Session)
            .build(),
    );
    Ok((jar, ()))
}

#[axum::debug_handler]
async fn random_unreviewed_handler(
    LoggedInUser(username): LoggedInUser,
    extract::State(state): extract::State<State>,
) -> Result<Json<Item>, Either<(StatusCode, &'static str), AnyhowResponse>> {
    let db = state.get_db().await.map_err(AnyhowResponse).map_err(E2)?;

    let row = state
        .prepare_and_query_opt(
            &db,
            sql_queries::GET_RANDOM_UNREVIEWED,
            &[Type::TEXT],
            &[&username],
        )
        .await
        .context("getting random unreviewed item")
        .map_err(AnyhowResponse)
        .map_err(E2)?;

    let Some(row) = row else {
        return Err(E1((StatusCode::NOT_FOUND, "no more unreviewed items")));
    };

    Ok(Json(Item {
        name: row.get(0),
        category: row.get(1),
    }))
}

#[axum::debug_handler]
async fn recommendations_handler(
    LoggedInUser(username): LoggedInUser,
    extract::State(state): extract::State<State>,
) -> Result<Json<Vec<Item>>, AnyhowResponse> {
    let db = state.get_db().await?;

    let rows = state
        .prepare_and_query(
            &db,
            sql_queries::GET_ITEM_RECOMMENDATIONS,
            &[Type::TEXT],
            &[&username],
        )
        .await
        .context("getting recommendations")?;

    Ok(Json(
        rows.into_iter()
            .map(|row| Item {
                name: row.get(0),
                category: row.get(1),
            })
            .collect(),
    ))
}
