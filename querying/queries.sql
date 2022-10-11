select * from users;

-- alter table users drop column age;
-- alter table users add column age int;

select * from users where age is not null;

update users
set age = age - 10
where age < 25;

select * from users;

delete from users
where last_name is null;
--  1 to m
-- 1 to many


select * from posts;

-- delete from users
-- where id = 1;

-- delete from posts
-- where "creatorId" = 4;

select u.id user_id, p.id post_id,
first_name, title from users u
inner join posts p on u.id = p."creatorId"
where p.title ilike '%my%Post%' and u.id = 1;

-- 1 single user
-- 2 posts
-- x * (y, z) = (x, y), (x, z)

-- 1 to many with posts
-- 1 to many with users


select * from posts;

select c.message, p.title,
u.id user_id_for_post,
u2.id user_id_for_comment
from comments c
inner join posts p on c.post_id = p.id
inner join users u on p."creatorId" = u.id
inner join users u2 on c.creator_id = u2.id;

-- favorites/upvotes/likes
-- user - post
-- NOT a 1 to many relationship
-- many to many relationship

-- join table

select * from users;
select * from posts;


select * from favorites;

-- friend
-- user - user
-- NOT a 1 to many
-- many to many
-- bob -> marry
-- bob -> tom
-- tom -> marry
-- tom -> jack




select * from  friends;


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

select * from users;

alter table posts
    add column created_at date
default now() - (random() * interval '100 days');

-- feed

select p.created_at, p.title,
       substr(p.body, 1, 30), u.first_name
from posts p
inner join users u on p."creatorId" = u.id
where created_at < '2019-12-02'
order by created_at desc
limit 20;

-- post

select p.title,
       u.first_name,
       c.message,
       u2.first_name comment_creator,
       f.user_id is not null has_favorited
from posts p
inner join users u on p."creatorId" = u.id
inner join comments c on p.id = c.post_id
inner join users u2  on u2.id = c.creator_id
left join favorites f
    on f.post_id = p.id and f.user_id = 4
where p.id = 7;

select * from favorites
where post_id = 7 and user_id = 74;

select count(*) from comments c
inner join users u2  on u2.id = c.creator_id
where post_id = 7;

select * from users;

-- who has the most friends
-- what's the most popular post



select * from users u
inner join friends f on f.user_id1 = u.id;

select
       max(u.first_name),
       user_id1,
       array_agg(user_id2),
       count(*)
from friends f
inner join users u on u.id = f.user_id1
group by user_id1
order by count(*) desc;


select max(p.title), post_id, count(*)
from favorites f
inner join posts p on f.post_id = p.id
group by post_id
order by count(*) desc;

-- who has no friends
-- who has written no posts



select * from users u
left join friends f
    on f.user_id1 = u.id
           or f.user_id2 = u.id
where f.user_id1 is null;

select * from posts p
left join users u
    on u.id = p."creatorId"
where p."creatorId" is null;

-- 100 posts
-- 58 users

select count(distinct "creatorId") from posts;

select * from users u
left join posts p
    on p."creatorId" = u.id
where p."creatorId" is null;

-- 100 users
-- 100 posts


-- advanced feed


select * from users where id = 1;

select * from posts p
left join friends f
on (f.user_id1 = p."creatorId"
or f.user_id2 = p."creatorId")
and (f.user_id1 = 1 or f.user_id2 = 1)
left join favorites f2 on f2.post_id = p.id
left join friends f3
on (f3.user_id1 = f2.user_id
     or f3.user_id2 = f2.user_id)
and (f3.user_id1 = 1 or f3.user_id2 = 1)
where "creatorId" != 1
and (
   f.user_id1 is not null
    or f3.user_id1 is not null
    );
