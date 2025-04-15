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
            and review.username = 'bla'
        )
where
    review.item is null
order by random()
fetch first 1 row only;";
