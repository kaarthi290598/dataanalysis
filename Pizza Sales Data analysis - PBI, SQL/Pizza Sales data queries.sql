select * from dbo.pizza_sales

-- change data type of column
ALTER TABLE dbo.pizza_sales
ALTER COLUMN order_date DATE;

--conver to style dd-mm-yyyy
UPDATE dbo.pizza_sales
SET order_date = CONVERT(DATE, order_date, 105);


--KPI

--Total Revenue
select round(sum(total_price), 2) as total_sales from pizza_sales

--AVERAGE ORDER VALUE
select  sum(total_price)/count(distinct(order_id)) as Average_Order_value from pizza_sales


--TOTAL PIZZA sold
select sum(quantity) as total_pizza_sold from pizza_sales

--Average Pizza per order
select cast( cast(SUM(quantity) AS decimal(10,2)) /  
cast(count( distinct(order_id))  AS decimal(10,2) ) as decimal(10,2) ) as Average_pizza_per_order
from pizza_sales


--Insights

-- daily trend for order
select DATENAME(DW, order_date) as WeekDay, COUNT(distinct order_id) as count
from pizza_sales
group by DATENAME(DW, order_date) 
order by count desc

--Monthly count
select DATENAME(Month, order_date) as MonthName, COUNT(distinct order_id) as count
from pizza_sales
group by DATENAME(Month, order_date) 
order by count desc

--Pizza percentage by category
select pizza_category,  round(sum(total_price) ,2) as Total_sales , 
round(sum(total_price) *100/ (select sum(total_price) from pizza_sales), 2)  as percentage
from pizza_sales
group by pizza_category
order by percentage desc


--Pizza percentage by size
select pizza_size,  round(sum(total_price) ,2) as Total_sales , 
round(sum(total_price) *100/ (select sum(total_price) from pizza_sales), 2)  as percentage
from pizza_sales
group by pizza_size
order by percentage desc



select top 5 pizza_name, round(sum(total_price), 2) as Total_revenue_Top5 from pizza_sales
group by pizza_name
order by Total_revenue_Top5 desc

select  top 5 pizza_name, round(sum(total_price), 2) as Total_revenue_Bottom5 from pizza_sales
group by pizza_name
order by Total_revenue_Bottom5 asc

select  top 5 pizza_name, count(distinct order_id) as Total_order_top5 from pizza_sales
group by pizza_name
order by Total_order_top5 desc


