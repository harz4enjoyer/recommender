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

pub const GET_ITEMS: &str = "select name from item order by name";

pub const CREATE_ITEM: &str = r"
insert into item(
    name
) values (
    $1
) on conflict(
    name
) do nothing
returning name";

pub const DELETE_ITEM: &str = r"
with
    item_delete
as (
    delete from item
    where name = $1
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

pub const GET_ITEM_FEATURES: &str = "select feature from item_feature where item = $1";

pub const CREATE_ITEM_FEATURE: &str = r"
insert into item_feature(
    item,
    feature
) values (
    $1,
    $2
) on conflict(
    item,
    feature
) do nothing
returning item, feature";

pub const DELETE_ITEM_FEATURE: &str = r"
with
    item_feature_delete
as (
    delete from item_feature
    where
        item = $1
        and feature = $2
    returning 1
) select exists(select * from item_feature_delete)";

pub const GET_REVIEWS: &str = "select item, rating from review where username = $1";

pub const CREATE_OR_UPDATE_REVIEW: &str = r"
insert into review(
    username,
    item,
    rating
) values (
    $1,
    $2,
    $3
) on conflict (
    username,
    item
) do update set rating = $3";

pub const DELETE_REVIEW: &str = r"
with
    review_delete
as (
    delete from review
    where
        username = $1
        and item = $2
    returning 1
) select exists(select * from review_delete)";

pub const GET_RANDOM_UNREVIEWED: &str = r"
select
    name
from 
    item left outer join review
        on (
            item.name = review.item
            and review.username = $1
        )
where
    review.item is null
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
candidate_items as (
    select
        r.item,
        ua,
        r.username as ub,
        r.rating,
        n.similarity
    from review as r
        join lateral
            (select * from top_neighbors where ub = r.username) as n on true
        left outer join review re on (r.item = re.item and re.username = ua)
    where re.item is null
),
canidate_items_score as (
    select
        item,
        ua,
        ub,
        avg_rating + sum((rating - avg_rating) * similarity) / sum(abs(similarity)) as score
    from candidate_items
        join lateral
            (select * from average_ratings where username = ua) as aa on true
    group by item, ua, ub, avg_rating
    order by score desc
)
select item from canidate_items_score where ua = $1 fetch first 10 rows only";
