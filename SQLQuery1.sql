#Total revenue
Select SUM(total_price) as Total_Revenue from pizza_sales;

#Average order_value
Select SUM(total_price)/Count(DISTINCT order_id) as Avg_order_value from pizza_sales;

#Total pizzas sold
Select SUM(quantity) as Total_pizzas_sold from pizza_sales;

#Total orders place
Select Count(distinct order_id) as Total_orders from pizza_sales;

#Average pizzas per order - Rounding off
Select Sum(quantity)/Count(distinct order_id) as Average_pizzas_per_order from pizza_sales;

#Average pizzas per order - With decimals
#(10,2) - Gets upto 10 decimal points but displays just two
Select CAST(CAST(Sum(quantity) AS DECIMAL(10,2)) / cast(Count(distinct order_id) as DECIMAL (10,2)) AS Decimal(10,2)) as Average_pizzas_per_order from pizza_sales;

#Daily trend for total orders
select datename(weekday, order_date) as order_day, Count(distinct order_id) as total_orders from pizza_sales
group by datename(weekday, order_date);

#Monthly trend
select datename(month, order_date) as order_day, Count(distinct order_id) as total_orders from pizza_sales
group by datename(month, order_date);

select pizza_name, Count(distinct order_id)*100 / (select count(distinct order_id) from pizza_sales) as sales_per_name
from pizza_sales 
group by pizza_name;

#Percentage of sales by pizza category
select pizza_category, sum(total_price) as Total_sales_per_Category, CAST(Sum(total_price)*100 / (select sum(total_price) from pizza_sales Where Month(order_date) = 1) as decimal (10,2)) as sales_per_pizza_category
from pizza_sales
Where Month(order_date) = 1
Group by pizza_category;

#Percentage of sales by pizza size
Select pizza_size, CAST(sum(total_price) As Decimal(10,2)) as Total_sales_per_size, CAST(Sum(total_price)*100 / (select sum(total_price) from pizza_sales Where DATEPART(quarter, order_date) = 1) as decimal (10,2)) as Sales_by_pizza_size
from pizza_sales
Where DATEPART(quarter, order_date) = 1
group by pizza_size;

#total pizzas sold by pizza category
Select Count(distinct order_id) as pizzas_per_category, pizza_category from pizza_sales 
group by pizza_category;

#Top 5 pizzas based on the revenue
select TOP 5 pizza_name, CAST(sum(total_price) as decimal (10,2)) as price_per_name from pizza_sales 
group by pizza_name
Order by price_per_name desc;

#Bottom 5 pizzas based on revenue
Select Top 5 pizza_name, CAST(sum(total_price) as decimal (10,2)) as price_per_name from pizza_sales
group by pizza_name
order by price_per_name asc;

#Top 5 pizzas based on the quantity
Select Top 5 pizza_name, CAST(sum(quantity) as decimal (10,2)) as quantity_per_name from pizza_sales
group by pizza_name
order by quantity_per_name desc;

#Bottom 5 pizzas based on quantity
Select Top 5 pizza_name, CAST(sum(quantity) as decimal (10,2)) as quantity_per_name from pizza_sales
group by pizza_name
order by quantity_per_name asc;