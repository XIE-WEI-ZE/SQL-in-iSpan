 -- join 3 table 實作

create table author( id int not null primary key identity(1,1), authorName nvarchar(50));
go
create table books(
 id int not null primary key identity(1,1),
 title nvarchar(50), 
 fk_author_id int, 
 foreign key (fk_author_id) references author(id)
 );
 go
create table reviews(
id int not null primary key identity(1,1), 
rating int,  
fk_reviewer_id int,  
fk_book_id int,  
foreign key (fk_reviewer_id) references author(id) on delete cascade, 
foreign key (fk_book_id) references books(id) on delete cascade);
go


insert into author (authorName)values('金庸'),('JK Rowling'), ('查理蒙格');

insert into books(title, fk_author_id)values('天龍八部',1),('哈利波特',2),('窮查理的普通常識',3);

insert into reviews (rating, fk_reviewer_id, fk_book_id)values(3,1,2),(4,2,1),(5,3,3);