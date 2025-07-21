create table app_user(username text primary key, password_argon2_hash text not null);

create table item(name text, category text, primary key (name, category));

create table feature(name text primary key);

create table item_feature(
    item_name text,
    item_category text,
    foreign key (item_name, item_category) references item on delete cascade on update cascade,

    feature text references feature(name),

    primary key (item_name, item_category, feature)
);

create table review(
    username text references app_user on delete cascade on update cascade,
    item_name text,
    item_category text,
    rating int not null check (rating >= 0 and rating <= 10),
    foreign key (item_name, item_category) references item on delete cascade on update cascade,
    primary key (username, item_name, item_category)
);

create materialized view pearson as (
    with common_ratings as (
        select
            r1.item_name,
            r1.item_category,
            r1.username as ua,
            r1.rating as ra,
            r2.username as ub,
            r2.rating as rb
        from review as r1
        join review as r2
            on r1.item_name = r2.item_name and r1.item_category = r2.item_category
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
