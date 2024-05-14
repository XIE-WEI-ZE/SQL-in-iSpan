SELECT TOP (1000) [emp_id]
      ,[emp_name]
      ,[emp_department]
      ,[emp_age]
  FROM [data_shop].[dbo].[employee]

use data_shop

create view age_more_30
as
select emp_id,emp_name,emp_department from employee
where emp_age>30;

select * from age_more_30;

create view age_more_30_enc
with encryption
as
select emp_id,emp_name,emp_department from employee
where emp_age>30;

-- 從加密的 age_more_30_enc 視圖中選擇所有記錄
select * from age_more_30_enc;

-- 從 sys.syscomments 系統表中選擇所有記錄
-- 按照 encrypted 列進行降序排列，以檢查加密的對象
select * from sys.syscomments order by encrypted desc

-- 從 sys.syscomments 系統表中選擇所有記錄
-- 按照 encrypted 列進行升序排列，以檢查加密的對象
select * from sys.syscomments order by encrypted 

-- 使用alter view 將視圖 age_more_30_check進行修改
-- 包括加密視圖定義和添加檢查選項
alter view age_more_30_check
-- 使用encryption 選項來加密視圖定義
with encryption
as
select emp_id,emp_name,emp_department,emp_age 
from employee
where emp_age >=16
with check option;

-- 刪除
drop view age_more_30_check;




update employee set emp_age = 36 where emp_id = 1

update age_more_30_check set emp_age = 20 where emp_id = 1

select * from age_more_30_check

insert into age_more_30_check(emp_name,emp_department,emp_age)
values('阿明','HR',35);
select * from age_more_30_check

-- variable
declare @product varchar(50);
set @product = '冰美式'
select @product
-- 與 select二選一即可
print @product

-- 連續宣告
declare @product varchar(50), @price int , @create_date date

set @product = '摩卡'
set @price = 100
set @create_date = GETDATE()

select @product as product,
	   @price as price,
	   @create_date as create_date

-- if
declare @myId int 
set @myId = 9
if @myId < 5
begin
	print @myId 
end

-- while
use eCommerce
declare @myId int, @name varchar(50)
set @myId = 1
-- 印出四個
while @myId<5
begin
	select @name = p_name from products where id = @myId
	print @name
	set @myId = @myId + 1
end

-- break
-- 做三個
use eCommerce
declare @myId int, @name varchar(50)
set @myId = 1
-- 印出四個
while @myId<5
begin
	select @name = p_name from products where id = @myId
	print @name
	set @myId = @myId + 1
	-- 第四個break
	if @myId = 4
		break
end

-- continue
use eCommerce
declare @myId int, @name varchar(50)
set @myId = 1
-- 印出四個
while @myId<5
begin
	select @name = p_name from products where id = @myId
	print @name
	set @myId = @myId + 1
	continue
	print 'daf;jkhdfaksjhfdjksaj'
end

-- 第二筆不印
use eCommerce
declare @myId int, @name varchar(50)
set @myId = 1
-- 印出四個
while @myId < 5
begin  
    if @myId = 2
    begin
		--@myId加一
        set @myId = @myId + 1
        continue
    end
    select @name = p_name from products where id = @myId
    print @name
    set @myId = @myId + 1
end


-- Transaction
create table accounts(
 id int primary key identity(1,1),
 username varchar(50) not null,
 balance bigint check(balance >= 0)
)

insert into accounts(username,balance)
values
('Amy',10000),
('Tom',10000);

select * from accounts
begin transaction
update accounts set balance = balance -50 where username = 'Tom'

update accounts set balance = balance +50 where username = 'Amy'

commit transaction

select * from accounts
update accounts set balance = balance - 100 where username = 'Tom';