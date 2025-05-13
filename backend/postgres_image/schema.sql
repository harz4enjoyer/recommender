create table app_user(username text primary key, password_bcrypt_hash text not null);

create table item(name text primary key);

create table feature(name text primary key);

create table item_feature(
    item text references item(name),
    feature text references feature(name),

    primary key (item, feature)
);

create table review(
    username text references app_user on delete cascade on update cascade,
    item text references item on delete cascade on update cascade,
    rating int not null check (rating >= 0 and rating <= 10),
    primary key (username, item)
);

create materialized view pearson as (
    with common_ratings as (
        select
            r1.item,
            r1.username as ua,
            r1.rating as ra,
            r2.username as ub,
            r2.rating as rb
        from review as r1
        join review as r2
            on r1.item = r2.item
            and r1.username < r2.username
    ),
    average_ratings as (
        select
            username,
            avg(rating) as avg_rating
        from review
        group by username
    )
    select
        ua,
        ub,
        sum((ra - aa.avg_rating) * (rb - ab.avg_rating))
            / (sqrt(sum((ra - aa.avg_rating)^2)) * sqrt(sum((rb - ab.avg_rating)^2))) as similarity
    from common_ratings
        join lateral 
            (select avg_rating from average_ratings where username = ua) as aa
            on true
        join lateral
            (select avg_rating from average_ratings where username = ub) as ab
            on true
    group by ua, ub
);
