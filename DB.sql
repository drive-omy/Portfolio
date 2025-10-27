create database day4;
use day4;

# set SQL_safe_updates = 0; #

create table test(OrderID int, CustomerName varchar(20), Product varchar(20), Category varchar (20), Quantity int, Price int, OrderDate date);

insert into test values	(1001,'Antonio','MacBook','Electronics',1,155500,'2025-09-28'),
						(1002,'Joseph','PS-5','Games',2,12000,'2024-09-09'),
                        (1003,'Robert','iPhone','Electronics',1,129900,'2025-02-12'),
                        (1004,'Louis','Jeans','Clothing',4,900,'2024-05-14'),
                        (1005,'Stephanie','Cetaphil','Beauty',2,430,'2025-08-26'),
                        (1006,'Brian','Shirt','Clothing',4,400,'2025-01-01'),
                        (1007,'Georgia','Biscuit','Snacks',1,80,'2023-03-11'),
                        (1008,'Kyla','Lipstick','Beauty',8,120,'2025-04-19'),
                        (1009,'Amelia','Omega-3','HealthCare',1,350,'2024-12-15'),
                        (1010,'Oliver','Cleanser','Beauty',1,550,'2025-07-28');

select * from test;

select CustomerName, Product from test;

select * from test where Category = 'Electronics';


#Add, Remove, Rename, Modify Columns (Alter)

alter table DA add column Country varchar(20);

alter table test modify column Price decimal(10,2) first;


#Make Primary Key

alter table test add constraint PK_OrderID primary key (OrderID);

alter table test add primary key (OrderID);


#Sort (Order By)

select * from test order by Price desc;

select * from test order by OrderDate;


#Operators (=, >, AND, +)

select CustomerName, Quantity from test where Quantity > 2;

select * from test where Price >=20000;

select Category, Price from test where Price > 50000;


#Left, Right

select left(OrderDate, 4) from test;

select Right(OrderDate, 5) from test;

select mid(OrderDate, 6) from test;


#Substring

select substring('Om Dahima',4) as Name from test;

select substring('HZL_Udaipur',5) as Name from test;


#Current Time & Date

select now();
select date(now()) as Date;
select time(now()) as Time;
select CURRENT_TIME as Time;
select CURRENT_DATE as Date;

select character_length('SQL');

#Limit, #Offset

select * from test limit 3 offset 3;

select * from test order by Price desc limit 5;


#Aggregates

select count(*) as Total_Products from test;

select sum(Price) as Total_Price from test;

select sum(Price*Quantity) as TotalPrice from test;

select Category, sum(Price*Quantity) as TotalPrice from test group by Category;

select avg(Price) as Avg_Price from test;

select avg(Price) from test where Category = 'Electronics';

select *, sum(Price) over (order by OrderDate) as CumulativeSales from test;

select *, avg(Price) over (partition by Category) as Average_Spend_Per_Category from test;

select *, sum(Price) over (partition by Category) as Total_Revenue_Per_Category from test;

select min(Price) as Cheapest_Product, max(Price) as Most_Expensive_Product from test;

select upper(Product) as Product_Name_Upper from test;

select round(Price, 2) as Rounded_Price from test;

select count(distinct OrderID) as TotalUniqueOrders from test;


#Merge Multiple Columns into One

select OrderID, CustomerName, concat(OrderID,' ',CustomerName) as ID_Name from test;

select CustomerName, Product, Category, concat(CustomerName,' ',Product,' ',Category) as Name_Product_Category from test;


#Create Clone Table

create table tests like test;
insert into tests select * from test;

rename table tests to test2;

select * from test;
select * from test2;


##Windows Functions
#Lead, #Lag

select * , lead (CustomerName,1) over (partition by Category) as Next from test;

select * , lag (CustomerName,1) over (partition by Category) as Back from test;


#Rank

select *, row_number() over (order by Category) as RowNumber from test;

select *, row_number() over (partition by Category) as Partitions from test;

select *, rank() over (order by Category) as ranks from test;

select *, dense_rank() over (order by Category) as dense_ranks from test;

select *, 
row_number() over (partition by Category order by Price desc) as RN_Price,
rank() over (partition by Category order by Price desc) as Rank_Price, 
dense_rank() over (partition by Category order by Price desc) as Dense_Price from test;

#with x

with x as (select *, dense_rank() over (order by Category) as dense_ranks from test) select * from x where dense_ranks = 1;

with x as (select *, dense_rank() over (order by Category) as dense_ranks from test) select * from x where dense_ranks in (2,3,4,5);


#Joins

select * from test inner join test2 on test.OrderID = test2.OrderID;

select * from test left join test2 on test.OrderID = test2.OrderID;

select * from test right join test2 on test.OrderID = test2.OrderID;

select * from test;
select * from test2;


#Update

update test set F_Name = "Pawan", L_Name = "Gayari" where No = 2;

update test2 set
		CustomerName = case
        when OrderID = 1001 then 'Anika'
        when OrderID = 1002 then 'Prisha'
        when OrderID = 1003 then 'Ira'
        when OrderID = 1004 then 'Yahvi'
        when OrderID = 1005 then 'Sarisha'
        when OrderID = 1006 then 'Myra'
        when OrderID = 1007 then 'Saanvi'
        when OrderID = 1008 then 'Aadhya'
        when OrderID = 1009 then 'Inaaya'
        when OrderID = 1010 then 'Vamika'
        end,
        Price = case
        when OrderID = 1001 then 100.50
        when OrderID = 1002 then 150.75
        when OrderID = 1003 then 120.60
        when OrderID = 1004 then 90.20
        when OrderID = 1005 then 200.30
        when OrderID = 1006 then 250.40
        when OrderID = 1007 then 180.00
        when OrderID = 1008 then 160.90
        when OrderID = 1009 then 140.50
        when OrderID = 1010 then 130.10
		end
		where OrderID in (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);
        
        
select * from test inner join test2 on test.OrderID = test2.OrderID;
