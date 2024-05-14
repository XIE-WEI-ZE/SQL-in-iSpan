-- day1
create database day2_gohometest;

use day2_gohometest;

create table users(
	id int primary key not null identity(1,1),
	username varchar(50) not null
);
insert into users(username)
values
('阿明'),
('Tom'),
('Sara'),
('小美');

select * from users;

create table photos(
	-- id設為pk
	id int primary key not null identity(1,1),
	url varchar(200) not null,
	fk_users_id int
	-- 通常會在欲令為fk的變數選告命名為fk_...，方便記憶
	foreign key(fk_users_id) references users(id)
);

insert into photos(url, fk_users_id)
values
('https://123.jpg',4),
('https://456.jpg',1),
('https://789.jpg',1),
('https://sdf.jpg',1),
('https://12qwe3.jpg',2),
('https://123.jpg',4),
('https://12sdad3.jpg',3);

select * from photos,users;

select *
from photos
join users on users.id = photos.fk_users_id;


select url,username
from photos
join users on users.id = photos.fk_users_id;

-- 找出阿明的id
select id from users where username = '阿明';

-- 返回所有fk_users_id = 1的照片紀錄,包含所有與照片相關的欄位
select * from photos where fk_users_id = 1;

-- 他會無法執行，因為insert陳述式與fk條件發生衝突
insert into photos(url, fk_users_id)
values('http://asdad.jpg',999);

-- 但是我們如果加上null就可以
insert into photos(url, fk_users_id)
values('http://asdad.jpg',null);
-- 會看到被設為null的id會比我們原先設計資料的id多1，這是正常的
select * from photos;

-- 刪除id為7的那欄位
-- ˋ這個delect很危險，因為他會將id=7的東西完全刪除，導致以後新增資料，會從除了id=7以後值加入
select * from photos where id = 7;
delete   from photos where id = 7;
select * from photos where id = 7;
select * from photos ;



select * from users where id = 1;
-- 外來鍵刪除測試
-- no action: 預設，如果刪除大表時，弱小表有對應資料，則跳出錯誤，無法刪除
-- <刪除id為1的時候會違反fk的一致性，所以刪不掉>
delete from users where id = 1;

drop table photos;

create table photos(
	id int not null primary key identity(1,1),
	url varchar(200),
	fk_users_id int,
	foreign key (fk_users_id)references users(id) on delete cascade

);

insert into photos(url, fk_users_id)
values
('https://123.jpg',4),
('https://456.jpg',1),
('https://789.jpg',1),
('https://sdf.jpg',1),
('https://12qwe3.jpg',2),
('https://12sdad3.jpg',3),
('https://12s.jpg',4);

select * from photos,users;

-- cascade:當刪除大資料表時，若小資料表有對應資料，兩邊一起刪除
-- 不能隨便亂用 不然會造成後面創新值時會出問題
delete from users where id = 1;




select * from users,photos;




drop table photos;

-- set null: 刪除大表時，如果小表有對應資料，則將小表對應資料的fk設定為null，小表不會刪除，大表會刪
-- 常用於社交軟體
CREATE TABLE photos(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	url VARCHAR(200),
	fk_users_id INT,
	FOREIGN KEY (fk_users_id) REFERENCES users(id) ON DELETE SET NULL
);

SELECT id, username FROM users;

INSERT INTO photos(url,fk_users_id)
VALUES
('https://123.jpg', 4),
--('https://456.jpg', 1),
--('https://789.jpg', 1),
--('https://sdf.jpg', 1),
('https://12qwe3.jpg', 2),
('https://12sdad3.jpg', 3),
('https://12s.jpg', 4);

-- 因為曾經刪除過id=1的資料 所以現在先註記掉
select * from photos,users;
delete from users where id = 4;
select * from users,photos;

-- 與truncate 不一樣 delete是全部都刪除 但id會從你剛剛資料的下一筆開始
delete from employee;
-- table還在資料清除 所以id會從1開始
truncate table emplyee;
-- update與delete都不可復原，只能覆蓋
-- 先搜尋，再做update和delete(切記)

-- join
use photo_app2;

select * 
-- 通常包含fk比較多的寫from旁邊
from comments
join users
 --user id 跟 comment id 意義相同 users.id = table.欄位
on comments.users_id = users.id;

select contents, username
from comments
join users on comments.users_id = users.id

-- P139 實作
-- 從comments表格拿到contents

-- 第一步 先找全部
select * from comments ,photos

-- 第二步 找出users_id相同的，因為皆有fk
select *
from comments
join photos on comments.users_id = photos.users_id;

-- 最後一步 顯示comments中的contents跟photos中的urls
select contents, urls
from comments
join photos on comments.users_id = photos.users_id;

--join注意事項，如果欄位名稱相同，table名稱就要寫出來
-- 無法執行
select comments,photos
from comments
-- comments跟photos呼叫自己的id
join photos on comments.photos_id = photos_id

select comments.id ,photos.id
from comments
join photos on comments.photos_id = photos_id
-- 要替他們取小名
select comments.id as comments_id, photos.id as photos_id
from comments
join photos on comments.photos_id = photos.id

-- 如果from, join table先後顛倒 ，好像會出問題
select *
from photos
join comments on comments.photos_id = photos.id;

-- 如果table有別名，其他地方也要使用別名，就算select也沒差
select c.contents,p.urls
from comments as c
join photos as p on c.photos_id = p.id

-- 省略as的寫法
select c.contents,p.urls
from comments c
join photos p on c.photos_id = p.id

--四種join
insert into photos(urls, users_id)
values('http://no-user-image', null);

select * from photos ,users

-- inner join: 當關聯資料內有null則不會被選出
select *
from photos
inner join users
on photos.users_id = users.id

-- left join: 保留所有left join左邊的表格所有資料
-- 右邊沒有對象資料則顯示NULL
select *
from photos
left join users
on photos.users_id = users.id

select * 
from photos 
right join users 
on photos.users_id = users.id

insert into users(username)
values('賭神');

select * 
from photos 
full join users 
on photos.users_id = users.id

-- join 搭配 where -- 在自己的照片底下留言(21筆)
select * from comments,photos

select *
from comments
join photos on comments.photos_id = photos.id
where comments.users_id = photos.users_id

-- 3 table join 搭配 where
-- 在自己照片底下留言的使用者
select * from comments, photos, users

select contents, urls, username
from comments
join photos on comments.photos_id = photos.id
join users on users.id = comments.users_id
WHERE comments.users_id = photos.users_id

-- 練習(需要到絕對熟練)
-- 找出能評論出自己書的人
select * from comments, photos,users

-- :
select title,authorName,rating
from reviews
join books on reviews.fk_book_id = books.id
join author on reviews.fk_reviewer_id = author.id
where books.fk_author_id = author.id

-- Order by 排序
-- asc為預設
select * from comments order by users_id asc;
-- 也等於下面這個
select * from comments order by users_id;
-- desc
select * from comments order by users_id desc;

select * from comments order by id desc;

select * from comments order by id;
-- 兩個都會升序
select * from comments order by users_id,photos_id;
-- 第一順位由小排到大 第二順位由大排到小
select * from comments order by users_id, photos_id desc;
-- 除非兩個都定義
select * from comments order by users_id desc , photos_id desc;



select users_id 
from comments
group by users_id

select * from comments;

select max(id) from comments;

select min(id) from comments;

-- 去掉餘數(原本資料型別是Int)
select avg(id) from comments;

select count(id) from comments;

select sum(id) from comments;

-- 每組有多少人
select users_id,count(id) 
from comments
group by users_id

-- 每組id最小值
select users_id,min(id) 
from comments
group by users_id

-- 每組id最大值
select users_id,max(id) 
from comments
group by users_id

select users_id,count(contents) 
from comments
group by users_id

select users_id,count(*)
from comments
group by users_id

-- 取別名
select users_id,count(*) as [使用者留言次數]
from comments
group by users_id

-- P164實作

select * from comments;

select photos_id,count(*) as [使用者留言次數]
from comments
group by photos_id

-- P166實作
select * from songs
-- 顯示歌手名跟唱幾首歌
select * 
from songs
join artists
on artists.id = songs.artist_id

select artist_name,count(songs_id)
from songs
join artists
on artists.id = songs.artist_id
group by artist_name;

select artist_name,count(songs.id) as number_of_songs
from songs
join artists
on artists.id = songs.artist_id
group by artist_name;

select artist_name, count(songs.id) as number_of_songs
from artists
join songs on artists.id = songs.artist_id
group by artist_name;

select photos_id, count(*) 
from comments 
where photos_id <3
group by photos_id
-- 分組條件，
having count(*) >= 2

-- P170 
select users_id,count(*) as [留言次數]
from comments
-- 條件是前50張照片
where photos_id <=50
-- 算出每個人留言幾次
group by users_id
-- 留言超過20次
having count(*) > 20

use eCommence;

select * from users;
select * from products;
select * from orders;

-- P174
select paid,count(*) as [count number] 
from orders
group by paid 

select first_name,last_name,paid
from users
join orders 
on users.id = orders.users_id

-- order by
select *
from products order by price

select *
from products order by price desc

select *
from products order by price, weights

select *
from products order by price,weights desc

select *
from products order by p_name --英文字串排序

select *
from products order by p_name desc

select top(10) * from products order by price

-- 選比較貴的前十名 但相同名次會有陷阱
select top(10) * from products order by price desc

select top(11) * from products order by price desc

-- 會把相同名次的加入進來 看最後一個 order by
select top(3) with ties * from products order by price desc

-- 分頁
select * from users order by id
offset 15 rows
fetch next 5 rows only

-- sql 超過範圍部會報錯 他只會算到最後一筆
select * from users order by id
offset 5 rows
fetch next 99 row only

-- 另一個語法 fetch next == fetch first
select * from users order by id
-- 大部分只會動這邊
offset 5 rows
fetch first 99 row only

select * from products

-- subquery
select * from products where department = 'Toys'

select max(price) from products where department = 'Toys'

select * from products where price >
(select max(price) from products where department = 'Toys')

-- distinct 把重複的去除
select distinct department from products;

select * from products;

select count(distinct department ) from products;

select distinct department,p_name from products;

select distinct p_name from products;

-- 誰重複了(商品名稱)?
select p_name,count(*) from products
group by p_name 
having count(*)>1;

-- like %表示其他字串
select * from products where p_name like '%ball%';
-- 會找不道
select * from products where p_name like 'ball%';

select * from products where p_name like '%ball';

select * from products where p_name like '%rubber%';
-- 找開頭
select * from products where p_name like 'rubber%';

-- 找結尾
select * from products where p_name like '%rubber';

select * from products where p_name like '%soap%';

select * from products where p_name like '%soap';

-- 找雙位數
select * from products where price like '__';

-- 找一位數
select * from products where price like '_';

select * from products where p_name like '%soap'and weights like '_';

-- 找%要用[]包起來

truncate table from eCommence

-- (not)in
select * from products where department in ('toys','movies','beauty');

select * from products where department not in ('toys','movies','beauty');


select TABLE_SCHEMA,TABLE_NAME 
from INFORMATION_SCHEMA.TABLES 
where TABLE_NAME = 'Employee';

select BusinessEntityID,JobTitle,LoginID 
from HumanResources.Employee 
where JobTitle = 'Research and Development Engineer';