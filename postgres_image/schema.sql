create table app_user(username text primary key, password_bcrypt_hash text not null);

create table item(name text primary key);

create table review(
    username text references app_user on delete cascade on update cascade,
    item text references item on delete cascade on update cascade,
    rating int not null check (rating >= 0 and rating <= 10),
    primary key (username, item)
);
