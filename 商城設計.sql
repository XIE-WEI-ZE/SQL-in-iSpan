create table users(
	id int primary key identity(1,1),
	username varchar(50),
	pwd varchar(50),
);

insert into users(username,pwd)
values
('謝維澤','xie8610'),
('馬子晴','ma8603'),
('TOMOO','tomoo628'),
('王心怡','heart520');

select * from users

create table users_detail(
	id int primary key ,
	email varchar(100),
	user_address varchar(100),
	user_card varchar(100),
	phone varchar(50),
	foreign key (id) references users(id)
);


insert into  users_detail(id,email,user_address,user_card,phone)
values
(1,'jkldsa1347@gmail.com','新北市','123456789','0985070243'),
(2,'mzc666@gmail.com','新北市','123456788','0985070234'),
(3,'tomoo628@gmail.com','東京都','123456787','0985070342'),
(4,'wxi777@gmail.com','湖北省','123457689','0966666666');

select * from users_detail

create table products_type(
	id int primary key identity(1,1) not null,
	typeName nvarchar(50)
);

insert into products_type(typeName)
values
('文青'),
('教育'),
('其他');

select * from products_type

create table products(
	id int primary key identity(1,1) not null,
	product_name nvarchar(200) not null default '未知',
	price int,
	quantity int,
	product_type int,
	storage_time datetime not null default getDate(),
	foreign key (product_type) references products_type(id)

);

insert into products(product_name,price,quantity,product_type,storage_time)
values
('房東的貓演唱會門票VVVIP',999,10,1,GETDATE()),
('TOMOO等身抱枕',100,1,2,GETDATE()),
('張春生老師JAVA實戰24堂課',24000,999,3,GETDATE());

select * from products

-- shoppingcart 的quantity數量不能大於products

create table shoppingCart(
	users_id int,
	products_id int,
	quantity int,
	foreign key(users_id) references users(id),
	foreign key(products_id) references products(id),
	primary key(users_id,products_id)
);

insert into shoppingCart(users_id,products_id,quantity)
values
(1,1,1),
(2,2,30),
(3,3,100);

select * from shoppingCart

create table user_orders(
	id int primary key identity(1,1) not null,
	users_id int,
	created_date datetime not null default getDate(),
	total_price int,
	payment tinyint,
	ship_status bit,
	foreign key(users_id) references users(id)
);

insert into user_orders(users_id,created_date,total_price,payment,ship_status)
values
(1,GETDATE(),1099,1,0),
(2,GETDATE(),24000,2,1);

select * from user_orders

create table user_orders_detail(
  id int primary key identity(1,1) not null,
  order_id int,
  users_id int,
  product_id int,
  onePrice int,
  quantity int,
  foreign key (users_id) references users(id),
  foreign key (product_id) references products(id),
  foreign key (order_id) references user_orders(id)
);

create table coupon(
 id int primary key identity(1,1) not null,
 coupon_name nvarchar(50),
 discount_price int,
 discount_persent tinyint,
 started_date datetime,
 ended_date datetime
);

create table coupon_owner(
  users_id int,
  coupon_id int,
  quantity tinyint,
  foreign key (users_id) references users(id),
  foreign key (coupon_id) references coupon(id)
);
