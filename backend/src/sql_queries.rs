pub const CREATE_USER: &str = r"
with
    user_insert
as (
    insert into app_user(
        username,
        password_bcrypt_hash
    ) values (
        $1,
        $2
    ) on conflict (
        username
    ) do nothing
    returning 1
)
select exists (select * from user_insert)";

pub const GET_USER_HASH: &str = "select password_bcrypt_hash from app_user where username = $1";

pub const DELETE_USER: &str = "delete from app_user where username = $1";

pub const GET_ITEMS: &str = "select name, category from item order by name";

pub const CREATE_ITEM: &str = r"
insert into item(
    name,
    category
) values (
    $1,
    $2
) on conflict(
    name,
    category
) do nothing
returning name";

pub const DELETE_ITEM: &str = r"
with
    item_delete
as (
    delete from item
    where name = $1
        and category = $2
    returning 1
) select exists(select * from item_delete)";

pub const GET_FEATURES: &str = "select name from feature order by name";

pub const CREATE_FEATURE: &str = r"
insert into feature(
    name
) values (
    $1
) on conflict(
    name
) do nothing
returning name";

pub const DELETE_FEATURE: &str = r"
with
    feature_delete
as (
    delete from feature
    where name = $1
    returning 1
) select exists(select * from feature_delete)";

pub const GET_ITEM_FEATURES: &str =
    "select feature from item_feature where item_name = $1 and item_category = $2";

pub const CREATE_ITEM_FEATURE: &str = r"
insert into item_feature(
    item_name,
    item_category,
    feature
) values (
    $1,
    $2,
    $3
) on conflict(
    item_name,
    item_category,
    feature
) do nothing
returning item_name, item_category, feature";

pub const DELETE_ITEM_FEATURE: &str = r"
with
    item_feature_delete
as (
    delete from item_feature
    where
        item_name = $1
        and item_category = $2
        and feature = $3
    returning 1
) select exists(select * from item_feature_delete)";

pub const GET_REVIEWS: &str =
    "select item_name, item_category, rating from review where username = $1";

pub const CREATE_OR_UPDATE_REVIEW: &str = r"
insert into review(
    username,
    item_name,
    item_category,
    rating
) values (
    $1,
    $2,
    $3,
    $4
) on conflict (
    username,
    item_name,
    item_category
) do update set rating = $4";

pub const DELETE_REVIEW: &str = r"
with
    review_delete
as (
    delete from review
    where
        username = $1
        and item_name = $2
        and item_category = $3
    returning 1
) select exists(select * from review_delete)";

pub const GET_RANDOM_UNREVIEWED: &str = r"
select
    name,
    category
from 
    item left outer join review
        on (
            item.name = review.item_name
            and item.category = review.item_category
            and review.username = $1
        )
where
    review.item_name is null
order by random()
fetch first 1 row only;";

pub const GET_ITEM_RECOMMENDATIONS: &str = r"
with top_neighbors as (
    select
        ua,
        ub,
        similarity
    from pearson
    where similarity > 0.2
    order by similarity desc
    fetch first 50 rows only
),
average_ratings as (
    select
        username,
        avg(rating) as avg_rating
    from review
    group by username
),
candidate_items as (
    select
        r.item_name,
        r.item_category,
        ua,
        r.username as ub,
        r.rating,
        n.similarity
    from review as r
        join lateral
            (select * from top_neighbors where ub = r.username) as n on true
        left outer join review re on (r.item_name = re.item_name and r.item_category = re.item_category and re.username = ua)
    where re.item_name is null
),
candidate_items_score as (
    select
        item_name,
        item_category,
        ua,
        ub,
        avg_rating + sum((rating - avg_rating) * similarity) / sum(abs(similarity)) as score
    from candidate_items
        join lateral
            (select * from average_ratings where username = ua) as aa on true
    group by item_name, item_category, ua, ub, avg_rating
    order by score desc
)
select item_name, item_category from candidate_items_score where ua = $1 fetch first 10 rows only";
