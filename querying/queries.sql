select
    *
from
    users;

-- alter table users drop column age;
-- alter table users add column age int;
select
    *
from
    users
where
    age is not null;

select
    *
from
    posts p
    left join favorites f on f.post_id = p.id
select
    *
from
    favorites f
    right join posts p on f.post_id = p.id;

update
    users
set
    age = age - 10
where
    age < 25;

select
    *
from
    users;

delete from
    users
where
    last_name is null;

--  1 to m
-- 1 to many
select
    *
from
    posts;

-- delete from users
-- where id = 1;
-- delete from posts
-- where creator_id = 4;
select
    u.id user_id,
    p.id post_id,
    first_name,
    title
from
    users u
    inner join posts p on u.id = p.creator_id
where
    p.title ilike '%fr%'
    and u.id = 1;

-- 1 single user
-- 2 posts
-- x * (y, z) = (x, y), (x, z)
-- 1 to many with posts
-- 1 to many with users
select
    *
from
    posts;

-- users who posted on who commented
select
    c.message,
    p.title,
    u.id user_id_for_post,
    u2.id user_id_for_comment
from
    comments c
    inner join posts p on c.post_id = p.id
    inner join users u on p.creator_id = u.id
    inner join users u2 on c.creator_id = u2.id;

/*
 Recap:
 1. create a table for each thing
 - user
 - post
 - comment
 2. setup relationships
 - m to n (many users to many posts)
 - join table with foreign keys
 - 1 to m (one user maps to many posts)
 - foreign key
 - 1 to 1 (profile for a user)
 - usually collapse into a single table
 */
select
    *
from
    users;

alter table
    posts
add
    column created_at date default now() - (random() * interval '100 days');

-- feed
select
    p.created_at,
    p.title,
    substr(p.body, 1, 30),
    u.first_name
from
    posts p
    inner join users u on p.creator_id = u.id
where
    created_at > '2019-12-02'
order by
    created_at desc;

-- post
select
    c.message,
    p.title,
    u.id user_id_for_post,
    u.first_name as name,
    u2.id user_id_for_comment,
    c.message as comment,
    u2.first_name as commentor_name
from
    comments c
    inner join posts p on c.post_id = p.id
    inner join users u on p.creator_id = u.id
    inner join users u2 on c.creator_id = u2.id
where
    p.id = 2;

-- way to know of the current user has favorited the post or not
select
    *
from
    favorites
where
    post_id = 7
    and user_id = 74;

-- comments made against a post id and user id
select
    *
from
    comments c
    inner join users u2 on u2.id = c.creator_id
where
    c.post_id = 4
    and c.creator_id = 5;

-- count of comments made against a post id and user id
select
    count(*)
from
    comments c
    inner join users u2 on u2.id = c.creator_id
where
    c.post_id = 4
    and c.creator_id = 5;

-- way to include favorite inside a post
select
    p.title,
    u.first_name,
    c.message,
    u2.first_name comment_creator,
    f.user_id is not null has_favorited
from
    posts p
    inner join users u on p.creator_id = u.id
    inner join comments c on p.id = c.post_id
    inner join users u2 on u2.id = c.creator_id
    left join favorites f on f.post_id = p.id
    and f.user_id = 3 -- on f.post_id = p.id and f.user_id = 5
where
    p.id = 1;

select
    *
from
    users;

-- who has the most friends
select
    *
from
    users u
    inner join friends f on f.user_id1 = u.id;

select
    user_id1,
    count(user_id2)
from
    friends
group by
    user_id1;

select
    user_id1,
    array_agg(user_id2),
    count(user_id2)
from
    friends
group by
    user_id1;

select
    user_id1,
    array_agg(user_id2),
    count(user_id2)
from
    friends
group by
    user_id1;

select
    user_id1,
    array_agg(user_id2),
    count(user_id2)
from
    friends
group by
    user_id1
order by
    count(*) desc;

-- we wish to fetch the name hence join it against user table
-- who has the most friends
select
    array_agg(u.first_name),
    user_id1,
    array_agg(user_id2),
    count(*)
from
    friends f
    inner join users u on u.id = f.user_id1
group by
    user_id1
order by
    count(*) desc;

select
    max(u.first_name),
    user_id1,
    array_agg(user_id2),
    count(*)
from
    friends f
    inner join users u on u.id = f.user_id1
group by
    user_id1
order by
    count(*) desc;

-- what's the most popular post
-- select the most popular post
-- we can start this way in which
-- such as select * from posts;
-- but the post which has has favorite we cant to know
-- hence we can start with select * from favorites
select
    *
from
    favorites;

-- group_by against post_id since we want to know the most favorited post
select
    post_id,
    count(*)
from
    favorites f
group by
    post_id
order by
    count(*) desc;

-- so lets just inner join post_id
select
    max(p.title),
    post_id,
    count(*)
from
    favorites f
    inner join posts p on f.post_id = p.id
group by
    post_id
order by
    count(*) desc;

-- who has no friends
-- who has written no posts
-- basically lets do left join, left joins are great when they do not have something
select
    *
from
    users u
    left join friends f on f.user_id1 = u.id
    or f.user_id2 = u.id -- whether the user is on left side or right side of the relationship
where
    f.user_id1 is null;

-- count number of users who do not have any friends
select
    count(*)
from
    users u
    left join friends f on f.user_id1 = u.id
    or f.user_id2 = u.id -- whether the user is on left side or right side of the relationship
where
    f.user_id1 is null;

-- who has no posts by posts first
select
    *
from
    posts p
    left join users u on u.id = p.creator_id
where
    p.creator_id is null;

-- get information of the user who has not made any posts
-- by users firsts
select
    *
from
    users u
    left join posts p on p.creator_id = u.id
where
    p.creator_id is null;

-- advanced feed
select
    *
from
    users
where
    id = 1;

-- lets do that by having select * from posts;
-- select all the posts written by your friends
select
    u.id as uid,
    *
from
    posts p
    left join friends f on (
        f.user_id1 = p.creator_id
        or f.user_id2 = p.creator_id
    )
    left join users u on (
        u.id = f.user_id1
        or u.id = f.user_id2
    )
where
    u.id = 2
    and p.creator_id != 2 -- now lets just select posts which have been favorited by 
    -- a friend
    -- one friend did not wrote the post but you might also want to see the post
    -- freind on either side so it will show double results
select
    u.id as uid,
    *
from
    posts p
    left join friends f on (
        f.user_id1 = p.creator_id
        or f.user_id2 = p.creator_id
    )
    left join users u on (
        u.id = f.user_id1
        or u.id = f.user_id2
    )
    left join favorites f2 on f2.post_id = p.id
    left join friends f3 on (
        f3.user_id1 = f2.user_id
        or f3.user_id2 = f2.user_id
    )
    and (
        f3.user_id1
        where
            u.id = 3
            and p.creator_id != 3 -- now lets just remove the duplicates or make sure we see only posts liked by friend 
            -- of certain user
        select
            u.id as uid,
            *
        from
            posts p
            left join friends f on (
                f.user_id1 = p.creator_id
                or f.user_id2 = p.creator_id
            )
            left join users u on (
                u.id = f.user_id1
                or u.id = f.user_id2
            )
            left join favorites f2 on f2.post_id = p.id
            left join friends f3 on (
                f3.user_id1 = f2.user_id
                or f3.user_id2 = f2.user_id
            )
            and (
                f3.user_id1 = 3
                or f3.user_id2 = 3
            )
        where
            u.id = 3
            and p.creator_id != 3
        select
            *
        from
            posts p
            left join friends f on (
                f.user_id1 = p.creator_id
                or f.user_id2 = p.creator_id
            )
            and (
                f.user_id1 = 1
                or f.user_id2 = 1
            )
            left join favorites f2 on f2.post_id = p.id
            left join friends f3 on (
                f3.user_id1 = f2.user_id
                or f3.user_id2 = f2.user_id
            )
            and (
                f3.user_id1 = 3
                or f3.user_id2 = 3
            )
        where
            u.id = 3
            and creator_id != 3
            and (
                -- since we are doing left joins we wish to make sure the user is present on the join or it is not null
                f.user_id1 is not null
                or f3.user_id1 is not null -- since we are doing left joins we wish to make sure the user is present on the join or it is not null
            );