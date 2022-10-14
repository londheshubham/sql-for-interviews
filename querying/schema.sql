create table users (
    id serial primary key,
    first_name varchar(255) not null,
    last_name text,
    age int,
    email text unique not null
);

create table posts(
    id serial primary key,
    title text not null,
    body text default '...',
    creator_id int references users(id) not null
);

create table comments (
    id serial primary key,
    message text not null,
    post_id int references posts(id),
    creator_id int references users(id)
);

create table favorites(
   user_id int references users(id),
   post_id int references posts(id),
   primary key (user_id, post_id) -- composite key
);

create table friends (
    user_id1 int references users(id),
    user_id2 int references users(id),
    primary key (user_id1, user_id2)
);
insert into users (first_name,last_name,age,email) values ('Kevon','Lebsack',null,'Daniela.Lindgren42@gmail.com');
insert into users (first_name,last_name,age,email) values ('Vada','Waelchi',51,'Zita.Bradtke78@hotmail.com');
insert into users (first_name,last_name,age,email) values ('Virgil','Friesen',63,'Lizzie.Huels2@yahoo.com');
insert into users (first_name,last_name,age,email) values ('Jerrell','Bode',20,'Reyna.Blanda@yahoo.com');
insert into users (first_name,last_name,age,email) values ('Murray','Murray',85,'Joany.Kuhlman@gmail.com');

insert into posts (title,body,creator_id) values ('front-end transform relationships','Tempora ut soluta quis quam. Hic et et quas doloribus id repellat aut asperiores. Repellendus consectetur delectus officiis.

Qui nihil et qui rerum consequatur accusantium. Dolores et vitae. Blanditiis quis dolorem architecto. Accusantium repellendus id natus harum nulla.

Quas corrupti mollitia dolorem explicabo. Sunt tempore dolores commodi. Est et non quas inventore pariatur. Maxime inventore delectus voluptatum sapiente doloremque distinctio alias quaerat. Illo aut ipsum maiores maiores sit distinctio. Velit ut et voluptatem consequatur fugit laboriosam quo.',1);
insert into posts (title,body,creator_id) values ('robust extend communities','Animi aperiam sed voluptas. Ut assumenda nihil et quaerat quod quisquam quaerat consectetur. Accusantium dolore id et facilis amet eum sit consequatur.

Temporibus a qui unde accusantium sequi et aut fuga quod. Perferendis ratione cumque eveniet temporibus dolorem in cumque. Et vitae qui exercitationem est aut explicabo velit.

Adipisci omnis et consequatur accusantium assumenda voluptas pariatur voluptatem ab. Cum aspernatur quia id veritatis nam sit saepe debitis. Sunt ipsum non commodi deleniti exercitationem non voluptatem sed nostrum.',2);
insert into posts (title,body,creator_id) values ('global extend supply-chains','Voluptas natus iste hic nihil ut. Ipsam delectus sed ut et blanditiis non et. Consequuntur cumque beatae quae sint voluptas nulla voluptate delectus quo. Sit libero neque est distinctio enim neque et consequuntur aut. Odio fuga voluptatem non minus.

Vero nisi non saepe occaecati illo. Delectus neque ut sint eius rerum. Expedita quo voluptas porro aut libero itaque.

Aliquid nulla similique aperiam atque assumenda ea sint cum. Est qui repellendus quia aliquid accusantium. Ea dolores perferendis libero ipsam qui. Autem itaque excepturi adipisci asperiores eaque eaque doloribus consequatur dolorum.',3);
insert into posts (title,body,creator_id) values ('efficient implement platforms','Quam aliquid odit inventore est ipsa. Nulla odio accusantium repellendus in inventore repellat laudantium ea atque. Quas aliquid et et totam. Dolor corporis sequi sequi dolorem hic. Voluptas veniam quia.

Eveniet non vitae quia sed. Alias sunt ut consequatur aut quas eius eum facilis. Molestiae quaerat optio quia aut quia nobis.

Consequatur ut iure sunt quam eum deleniti et. Minima non perspiciatis dolore nesciunt ut sit. Aliquid dignissimos tempora enim.',4);
insert into posts (title,body,creator_id) values ('world-class reinvent web-readiness','Sit magnam vero qui. Eos quibusdam accusamus exercitationem qui et. Ratione rerum ut consequatur quibusdam id omnis quia consequatur. Quae et rem veniam beatae aut ipsum quas laudantium ex.

Sit ullam eos. Aut quae ut ipsam doloremque dolor et praesentium omnis. Et ea et beatae repudiandae neque et modi earum sed.

Impedit nesciunt dolorem maiores ut iste. Quod aliquam asperiores reprehenderit ut ad aperiam et architecto est. Eaque blanditiis quasi ut enim blanditiis qui.',5);

insert into comments (message,post_id,creator_id) values ('Odit cupiditate aliquid aut quaerat tempora ut.',1,2);
insert into comments (message,post_id,creator_id) values ('Hic et et quas doloribus id repellat aut asperiores.',1,3);
insert into comments (message,post_id,creator_id) values ('Officiis magnam dolorum qui nihil et qui rerum consequatur accusantium.',4,5);
insert into comments (message,post_id,creator_id) values ('Adipisci blanditiis quis.',2,4);
insert into comments (message,post_id,creator_id) values ('Repellendus id natus.',2,5);
insert into comments (message,post_id,creator_id) values ('Quas corrupti mollitia dolorem explicabo.',1,5);

insert into favorites (user_id,post_id) values (1,5);
insert into favorites (user_id,post_id) values (2,5);
insert into favorites (user_id,post_id) values (3,5);
insert into favorites (user_id,post_id) values (2,2);
insert into favorites (user_id,post_id) values (5,1);
insert into favorites (user_id,post_id) values (1,4);

insert into friends (user_id1,user_id2) values (1,5);
insert into friends (user_id1,user_id2) values (1,4);
insert into friends (user_id1,user_id2) values (1,2);
insert into friends (user_id1,user_id2) values (1,3);
insert into friends (user_id1,user_id2) values (2,3);
insert into friends (user_id1,user_id2) values (3,4);
