create database pizzahub;



create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id) );

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id varchar(50) not null,
quantity int not null,
primary key(order_details_id) );


select * from pizza_types;
select * from pizzas;
select * from orders;
select * from order_details;

--Find & Retrieve the total number of orders placed.

select count(order_id) as Total_No_Of_Orders from orders;

--Calculate the total revenue generated from pizza sales.

select Round(sum(pizzas.price*order_details.quantity),0) as Total_Revenue
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id;

--Identify the highest-priced pizza.

select top 1 pizza_types.name,pizza_types.category,pizza_types.ingredients, pizzas.price 
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by price desc;

--Identify the most common pizza size ordered.

Select pizzas.size, COUNT(order_details.order_details_id) as Max_Order_Count
From pizzas join order_details 
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by COUNT(order_details.order_details_id) desc;

--List the top 5 most ordered pizza types along with their quantities.

Select top 5 pizza_types.name, sum(order_details.quantity) as Maximum_orders
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by Maximum_orders desc;

--Join the necessary tables to find the total quantity of each pizza category ordered.

Select pizza_types.category, SUM(order_details.quantity) as Total_Quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by Total_Quantity desc;

--Determine the distribution of orders by hour of the day

select * from orders;

Select DATEPART(hour, orders.order_time) as Hour_of_the_day, count(orders.order_id) as Total_orders
from orders
group by DATEPART(hour, orders.order_time) order by count(orders.order_id) desc;

--Group the orders by date and calculate the average number of pizzas ordered per day.

Select orders.order_date, sum(order_details.quantity)
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.order_date

--Join relevant tables to find the category-wise distribution of pizzas.

Select pizza_types.category as Category_name, COUNT( pizza_types.name) as Pizzacount_categorywise
from pizza_types
group by pizza_types.category order by COUNT( pizza_types.name) desc;









