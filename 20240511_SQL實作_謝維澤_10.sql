use AdventureWorks2019;
  
-- 1.
/*
請寫一個查詢語句，根據 HumanResources.Employee
資料表，列出 JobTitle 為 Research and Development
Engineer 的所有員工，並顯示其 BusinessEntityID,
JobTitle, LoginID 欄位的資料。
*/
select BusinessEntityID,JobTitle,LoginID 
from HumanResources.Employee 
where JobTitle = 'Research and Development Engineer';


-- 2.(有錯，已改正)
/*
請寫一個查詢語句，根據 Person.Person 資料表，列出
在 2013 年 12 月 29 日後修改的資料 ( ModifiedDate)，並
顯示以下欄位的資訊 BusinessEntityID, FirstName,
MiddleName, LastName, ModifiedDate
*/
select BusinessEntityID,FirstName,MiddleName,LastName,ModifiedDate
from Person.Person
where ModifiedDate > '2013-12-29'


-- 3.
/*
請根據上題，列出在 2013 年期間修改資料的人員
*/
select  BusinessEntityID,FirstName,MiddleName,LastName, ModifiedDate 
from Person.Person
where ModifiedDate between '2013-01-01' and '2013-12-31';

-- 3-1 優化寫法
select BusinessEntityID,FirstName,MiddleName,LastName, ModifiedDate 
from Person.Person
where ModifiedDate like '%2013%';



-- 4.
/*
請根據上題，列出「不」在 2013 年期間修改資料的人員
*/
select BusinessEntityID,FirstName,MiddleName,LastName, ModifiedDate 
from Person.Person
where ModifiedDate not between '2013-01-01' and '2013-12-31';



-- 5.
/*
請根據 Production.Product 資料表，列出名稱為
Chain 開頭的商品，並顯示其 product ID 和 Name 兩
個欄位的資料
*/
select ProductID,Name
from Production.Product
-- %放尾巴 就是開頭意思
where Name LIKE 'Chain%';



-- 6.
/*
請根據上題，條件改為列出名稱內含有 helmet 的商品，
並顯示其 product ID 和 name 兩個欄位的資料
*/
select productID,name
from Production.Product
where Name LIKE '%helmet%'



-- 7.
/*
請根據上題，條件改為列出名稱「不含」 helmet 的商
品，並顯示其 product ID 和 name 兩個欄位的資料
*/
select productID,name
from Production.Product
where Name not LIKE '%helmet%'

-- 8.
/*
請根據 Sales.SalesOrderHeader 資料表，選出 2011 年
9 月份的訂單中金額 (total due)大於 3950 的資料列出
order ID, order date, total due 的欄位資料就好
*/
select SalesOrderID,OrderDate,TotalDue
from Sales.SalesOrderHeader
where OrderDate between '2011-09-01' and '2013-09-30'
and TotalDue > 3950


-- 9.
/*
請根據 Production.Product 資料表，找出沒有填寫商
品顏色的資料 (null)，需列出 ProductID, Name, Color
欄位的資料
*/
select ProductID, Name,Color
from Production.Product
where Color is null


-- 10.
/*
請查詢 Person.Person 資料表，並根據以下順序排序資
料 LastName, FirstName, MiddleName ，並列出以下
欄位的資料 BusinessEntityID, LastName, FirstName,
MiddleName
*/
select BusinessEntityID, LastName, FirstName,MiddleName
from Person.Person
order by LastName, FirstName, MiddleName


-- 11.
/*
Person.Person 資料表有顧客的姓名，請合併
Sales.Customer 資料表，
列出 CustomerID, StoreID, TerritoryID, FirstName,
MiddleName, LastName 等欄位的資訊
提示 關聯的欄位為Person.Person的BusinessEntityID 和 Sales.Customer 的 PersionID
*/
select CustomerID,StoreID,TerritoryID,FirstName,MiddleName,LastName
from Sales.Customer
join Person.Person on PersonID = BusinessEntityID

-- 可讀性的問題，建議用此
select c.CustomerID,c.StoreID,c.TerritoryID,p.FirstName,p.MiddleName,p.LastName
from Sales.Customer as c 
join Person.Person as p on c.PersonID = p.BusinessEntityID

-- 12. (錯，但已改正)
/*
根據上一題，請再多合併一個資料表
Sales.SalesOrderHeader( 與 Sales.Customer 資料表合
併 ))，並在現有的顯示欄位中加入 SalesOrderID 欄位的
資訊
*/
select Sales.Customer.CustomerID,
	   Sales.Customer.PersonID,
	   Sales.Customer.StoreID,
	   Sales.Customer.TerritoryID,
	   Person.Person.BusinessEntityID,
	   Person.Person.FirstName,
	   Person.Person.MiddleName,
	   Person.Person.LastName,
	   Sales.SalesOrderHeader.SalesOrderID
from Sales.Customer
join Person.Person on Sales.Customer.PersonID = Person.Person.BusinessEntityID
join Sales.SalesOrderHeader on Customer.CustomerID = Sales.SalesOrderHeader.CustomerID

-- 優化寫法
select c.CustomerID,
	   c.PersonID,
	   c.StoreID,
	   c.TerritoryID,
	   p.BusinessEntityID,
	   p.FirstName,
	   p.MiddleName,
	   p.LastName,
	   s.SalesOrderID
from Sales.Customer as c
join Person.Person as p on c.PersonID = p.BusinessEntityID
join Sales.SalesOrderHeader as s on s.CustomerID = c.CustomerID

-- 13. (這題我也錯，已改正)
/*
請合併 Sales.SalesPerson 和 Sales.SalesOrderHeader 資料
表，並選出所有在 Sales.SalesPerson 表格內的資料 沒有對應的
SalesOrderHeader 資料也要
列出以下欄位資料 SalesOrderID, SalesPersonID, SalesYTD
*/
select Sales.SalesOrderHeader.SalesOrderID,
	   Sales.SalesPerson.BusinessEntityID as SalesPersonID,
	   Sales.SalesPerson.SalesYTD
from Sales.SalesPerson
--沒有對應的資料也要
left join Sales.SalesOrderHeader 
on  Sales.SalesPerson.BusinessEntityID = Sales.SalesOrderHeader.SalesPersonID;

-- 優化寫法
select s.SalesOrderID,
	   sp.BusinessEntityID as SalesPersonID,
	   sp.SalesYTD
from Sales.SalesPerson as sp
-- 沒有對應的SalesOrderHeader 資料也要
left join Sales.SalesOrderHeader as s  on sp.BusinessEntityID = s.SalesPersonID;


-- 14.
/*
請用子查詢找出 Production.Product中被訂購的商品
從 Sales.SalesOrderDetail 判斷
並列出 ProductID, Name 的欄位資料
可參考 SQL Server 的 IN 關鍵字
*/
-- 選擇 ProductID 和 Name 從 Production.Product 表
select ProductID,Name
from Production.Product
where ProductID
-- 從 Sales.SalesOrderDetail 表中選擇 ProductID，並用於 IN 條件中。
in (select ProductID from Sales.SalesOrderDetail)

-- 優化寫法
select p.ProductID,p.Name
from Production.Product as p
where p.ProductID in (select sod.ProductID from Sales.SalesOrderDetail as sod)


-- 15.
/*
請透過 Sales.SalesOrderDetail 資料表算出每一件商品
被訂購的總數也就是每一 件商品自己的 OrderQty 總和
*/
select ProductID,sum(OrderQty) as [被訂購之總數]
from Sales.SalesOrderDetail
-- 按照 ProductID 分組，以便計算每個產品的訂購總數。
group by ProductID

select ProductID,sum(OrderQty) as [被訂購之總數]
from Sales.SalesOrderDetail
group by ProductID

-- 優化寫法
select sod.ProductID,sum(sod.OrderQty) as [被訂閱之總數]
from Sales.SalesOrderDetail as sod
group by sod.ProductID;

-- 16.
/*
請根據 Production.Product 資料表，列出每一個產品
線 (ProductLine)有多少樣商品
*/
select ProductLine,count(*) as [有多少商品]
from Production.Product
group by ProductLine

-- 優化寫法
select p.ProductLine,count(*) as [有多少的商品]
from Production.Product
group by ProductLine;


-- 17.
