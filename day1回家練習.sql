-- day1
create database MyShop;
/*
	select name,database_id,create_data
	from sys.databases
*/
-- 名字不能重複
-- 盡量不要同時使用create跟database來做命名 保留關鍵字
-- 中文命名盡量不要做 真要做也要用[]標記
create database [database];

-- 盡量不要使用空格，要用也要用[]框起
create database [drink shop];


create database data_shop;

-- 已刪除就會顯示無法卸除資料庫'database',原因是他部會存在或沒有權限
-- 最直接就右鍵刪除
-- drop database [database]
create table members2(
	memberId int,
	memberNumber nvarchar(50)

);
-- 刪除資料夾
drop table members;

-- 創建資料夾(table)
create table members(
	memberId int,
	memberName nvarchar(50),
	memberLocation nvarchar(50),
	memberOrder tinyint
);
-- 刪除 table內資料，但保留資料夾
-- 有時候紅字會騙人
insert into members(memberId, memberName, memberLocation, memberOrder)
values
(1001, '謝維澤','新北市',181),
(1002, '陳小美','台北市',143),
(1003, '葉筱彤','澎湖縣',160);

-- P57 實作練習
select * from members;

-- 刪除資料夾，留表格
truncate table members;

select * from members;
-- 記得擺放位置很重要
-- 新增全部欄位的狀況
insert into members(memberId, memberName, memberLocation, memberOrder)
values
(1001, '謝維澤','新北市',181),
(1002, '陳小美','台北市',143),
(1003, '葉筱彤','澎湖縣',160);

create table phone_products(
-- 字串沒給長度會出錯，所以一般來說設定50，超過8000用max
	product_name nvarchar(50),
	brand nvarchar(50),
	price int 
);



insert into phone_products(product_name, brand, price)
values
('IPhone 13', 'APPLE',30000),
('PIXEL 5','GOOGLE',21000),
('Mi10','XiaoMi',13000);

select * from phone_products;
-- not null 如果沒有放值就會報錯
create table phone_products2(
	product_name nvarchar(50) not null,
	brand nvarchar(50) not null,
	price int not null
);

truncate table phone_products2;

insert into phone_products2(brand)
values
('Apple');

select * from phone_products2;

-- default 'String'
create table phone_products3(
	product_name nvarchar(50) not null,
	-- 有預設值就可以不放 相較not null寬鬆許多
	brand nvarchar(50) not null default 'not sure',
	price int not null
);

insert into phone_products3(product_name, price)
values('iPhone 16 Pro', 40000);

select * from phone_products3;


-- primary key(PK)
create table my_products(
	id int primary key not null,
	product_name varchar(50),
	price int
);

insert into my_products(id,product_name,price)
values(1001, '四季春',35);

insert into my_products(id, product_name, price)
values(1002,'綠茶',30);

select * from my_products;
-- 違反 PRIMARY KEY 條件約束 'PK__my_produ__3213E83FF6D77529'。無法在物件 'dbo.my_products' 中插入重複的索引鍵。
insert into my_products(id, product_name, price)
values(1002,'高山茶',60);


create table my_products2(
	id int primary key identity(1001,1) not null,
	product_name varchar(50),
	price int
);

truncate table my_products2;

insert into my_products2(product_name,price)
values('柳橙汁', 70);

select * from my_products2;

insert into my_products2(product_name,price)
values('芭樂汁',80);

--當 IDENTITY_INSERT 設為 OFF 時，無法將外面值插入資料表 'my_products2' 的識別欄位中。
--要下指令 set identity_insert my_products2 on;
--不建議
--insert into my_products2(id,product_name,price)
--values(999,'奇異果汁',100);



insert into my_products2(product_name,price)
values('奇異果汁',100);

select * from my_products2;
-- identity(start_id,i++) 第一個值為自定義的id初始值，第二個則為每次遞增的值
-- P81實作
create table my_food(
	food_id int primary key identity(1,1) not null,
	food_name nvarchar(50)  not null,
	food_location nvarchar(50),
	food_price int
);

truncate table my_food;

insert into my_food(food_name,food_location,food_price)
values
('我家牛排','新北市', 170),
('你家羊排','台北市',180),
('他家魚排','基隆市',230);


select * from my_food;

-- 產生uuid
select newid();

-- uuid
create table app_products(
	-- primary key
	product_id uniqueidentifier not null primary key default newid(),
	product_name varchar(50) not null,
	price int not null default 0
)

insert into app_products(product_name, price)
values
('fb',0),
('原神',0),
('幻獸帕魯',499);

select * from app_products;

-- unique
create table user_account(
	id int primary key not null identity(1,1),
	users_email varchar(50) not null unique,
	users_password varchar(50) not null
);
-- 如果有創建過，就再也無法新增，會顯示
-- 違反 UNIQUE KEY 條件約束 'UQ__user_acc__D156B4FE45DBBA29'。
-- 無法在物件 'dbo.user_account' 中插入重複的索引鍵。
insert into user_account(users_email,users_password)
values('jkldsa1347@gmail.com','6666');

select * from user_account;
-- values('jkldsa1347@gmail.com','6666')

insert into user_account(users_email,users_password)
values('jklda1347@gmail.com','6666')

select * from user_account;

create table user_account2(
	-- 令id為pk
	id int primary key not null identity(1,1),
	users_email varchar(50) not null unique,
	users_password varchar(50) not null,
	created_at datetime not null
);
-- 紀錄時間
insert into user_account2(users_email,users_password,created_at)
values('jkldsa1347@gmail.com','6666', '2024-05-02 15:14:22');

select * from user_account2;

-- 取得當前時間
select getDate();
-- 一個table可以有很多unique的欄位
create table user_account3(
	id int primary key not null identity(1,1),
	-- 設定為unique的欄位，底下資料不可重複
	users_email varchar(50) not null unique,
	users_password varchar(50) not null,
	-- getDate() 抓時間
	created_at datetime not null default getDate()
);

insert into user_account3(users_email,users_password)
values
('jkldsa1347@gmail.com','6666'),
('jkldsa13477@gmail.com','6666'),
('jkldsa137@gmail.com','6666'),
('jkldsa17@gmail.com','6666');

select * from user_account3;

-- CRUD練習
-- CREATE READ UPDATE DELETE
create table employee(
	emp_id int not null primary key identity(1,1),
	emp_name nvarchar(50),
	emp_department nvarchar(50),
	emp_age int,
);

insert into employee(emp_name, emp_department, emp_age)
values('Tony','HR',35),
      ('Amy','RD',30),
	  ('Jenny','Sells',28),
	  ('Tom','RD',22),
	  ('Betty','HR',25),
	  ('John','Account',30),
	  ('Mary','Sells',22);

-- select 搭配where 作條件搜尋
-- 從employee表中搜索所有人
select * from employee;
-- 從employee表中搜索emp_name
select emp_name from employee;
-- 從employee表中搜索emp_age跟emp_name
select emp_age, emp_name from employee; 
-- 從employee表中搜索emp_age = 22的資料
select * from employee where emp_age = 22;
-- 從employee表中搜索emp_age <= 22的資料
select * from employee where emp_age <= 22;
-- 從employee表中搜索emp_age >22的資料
select * from employee where emp_age > 22;
-- 不等於
select * from employee where emp_age != 22; 
-- 不等於
select * from employee where emp_age <> 22; 
-- 注意資料型別，決定是否要有單引號(' ')把資料包起來
-- 字串英文大小寫都可以找到，方便查詢，例如email
select * from employee where emp_name = 'tom';

select * from employee where emp_name = 'mary';

select * from employee where emp_name != 'mary';

-- 語系 collate 強制分辨英文大小寫搜尋(case sensitive) 查密碼必用 (挺重要的) SQL_Latin1_General_CP1_CS_AS
select * from employee where emp_name = 'tom' collate SQL_Latin1_General_CP1_CS_AS;

--  where 判斷是否為null if is null 才能找到
select * from phone_products2 where product_name is null;

select * from phone_products2 where product_name is not null;

-- p93 實作
select emp_name, emp_department from employee;

select emp_id from employee;

select emp_name, emp_age from employee where emp_department = 'HR';

-- 取綽號 :欄位別名
-- 從員工表裡，找出emp_name令他為Names，再找出emp_department並令他為部門
select emp_name as Names, emp_department as [部門] from employee;

select emp_name as 'Employee Names', emp_department as '部門' from employee;
select emp_name as [Employee Names], emp_department as [部門] from employee;
-- as 語法可以省略
select emp_name Names, emp_department [部門] from employee;

use data_shop;

-- day2
--update更新資料 此更新是無法復原的 只能在update覆蓋過去
select * from employee where emp_department = 'Account';
update employee set emp_department ='Accounting' where emp_department='Account';
select * from employee where emp_department = 'Accounting';

-- Mary 換到會計部門
select * from employee where emp_name = 'Mary';
update employee set emp_department = 'Accounting' where emp_name = 'Mary';
-- P96 實作練習
select * from employee where emp_name = 'Amy';

update employee set emp_age = 31 where emp_name = 'Amy';

select * from employee where emp_name = 'John';

update employee set emp_name = 'Johnny' where emp_name = 'John';

select * from employee where emp_name = 'Johnny';

select * from employee;

--delete
select * from employee where emp_name = 'Johnny';

delete from employee where emp_name = 'Johnny';

select * from employee;

-- 與truncate 不一樣 delete是全部都刪除 但id會從你剛剛資料的下一筆開始
delete from employee;
-- table還在資料清除 所以id會從1開始
truncate table emplyee;
-- update與delete都不可復原，只能覆蓋
-- 先搜尋，再做update和delete(切記)

