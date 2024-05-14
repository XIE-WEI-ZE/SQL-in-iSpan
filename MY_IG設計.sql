create table users(
	id int primary key not null identity(1,1),
	username varchar(100) not null unique,
	create_at datetime not null default getDate()
);

insert into users(username)
values
('馬子晴'),
('王欣怡'),
('TOMOO');

select * from users;

create table photos(
	id int primary key not null identity(1,1),
	image_url varchar(200) not null,
	[user_id] int,
	create_at datetime not null default getDate()
	foreign key ([user_id]) references users(id)
);

insert into photos(image_url,[user_id])
values
('https://reurl.cc/2YzZAr',1),
('https://img.wumaow.org/upload/tu/67398189.jpg',1),
('https://realsound.jp/wp-content/uploads/2022/08/20220803-tomoo-05.jpg',2),
('https://reurl.cc/0v9p8x',2);

select * from photos;

create table comments(
	id int primary key not null identity(1,1),
	comment_text varchar(2000) not null,
	[user_id] int,
	photo_id int,
	create_at datetime not null default getDate(),
	foreign key([user_id]) references users(id),
	foreign key(photo_id) references photos(id)
)

-- 評論的功能
insert into comments([user_id],photo_id,comment_text)
values
(3,1,'牙齒好白'),
(1,1,'歌聲真迷人'),
(1,2,'卡哇伊'),
(2,1,'愛笑的眼睛');

select * from comments

-- 喜歡的功能
create table likes(
	[user_id] int,
	photo_id int,
	create_at datetime not null default getDate(),
	foreign key ([user_id]) references users(id),
	foreign key (photo_id) references photos(id),
	-- 唯一性保證:避免了同一用戶對同一照片重複點讚的情況。
	primary key ([user_id],photo_id)
)

insert into likes([user_id],photo_id)
values
(1,1),
(1,2),
(2,1),
(2,2);

-- 追蹤
create table follows(
	follower_id int,
	followee_id int,
	create_at datetime not null default getDate(),
	foreign key (follower_id) references users(id),
	foreign key (followee_id) references users(id),
	primary key (follower_id,followee_id)
)


insert into follows(follower_id,followee_id)
values
(3,1),
(1,2),
(2,1);

select * from follows


create table tags(
	id int primary key not null identity(1,1),
	tag_name varchar(30) not null unique,
	create_at datetime not null default getDate()
)

insert into tags(tag_name)
values
('冰山美人'),
('歌手'),
('國民老婆');

select * from tags

create table photo_tags(
	photo_id int not null,
	tag_id int not null,
	foreign key (photo_id) references photos(id),
	foreign key (tag_id) references tags(id),
	primary key (photo_id,tag_id)
);

select id, image_url from photos;
select id, tag_name from tags;

insert into photo_tags(photo_id,tag_id)
values
(1,1),
(1,2),
(2,2);

select * from photos

-- 統計每個用戶的照片數量
select u.username,count(p.id) as photo_count
from users u
left join photos p on u.id = p.user_id
group by u.username;

-- 顯示所有照片以及對應的最新評論
select p.image_url,max(c.create_at) as latest_comment_time
from photos p 
left join comments c on p.id = c.photo_id
group by p.image_url;


-- 列出每位用戶收到的最後一條評論
select u.username,max(c.create_at) as last_comment_time
from users u
left join photos p on u.id = p.user_id
left join comments c on p.id = c.photo_id
group by u.username;

select * from users

-- 列出所有標籤以及關聯的照片數
select t.tag_name,count(pt.photo_id) as photo_count
from tags as t
left join photo_tags pt on t.id = pt.tag_id
group by t.tag_name;

select * from tags