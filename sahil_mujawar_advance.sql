-- Database setup
create database shop;
use shop;

create table customers (
    customer_id int primary key,
    customer_name varchar(100) not null,
    city varchar(50),
    email varchar(100) unique
);

create table products (
    product_id int primary key,
    product_name varchar(100) not null,
    category varchar(50),
    price decimal(10,2) not null
);

create table orders (
    order_id int primary key,
    customer_id int not null,
    product_id int not null,
    quantity int not null,
    order_date date not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);

insert into customers (customer_id, customer_name, city, email) values
(1, 'Aarav Sharma', 'Mumbai', 'aarav.sharma@gmail.com'),
(2, 'Priya Patil', 'Pune', 'priya.patil@yahoo.com'),
(3, 'Rohan Deshmukh', 'Nagpur', 'rohan.deshmukh@gmail.com'),
(4, 'Sneha Iyer', 'Chennai', 'sneha.iyer@outlook.com'),
(5, 'Vikram Singh', 'Delhi', 'vikram.singh@gmail.com'),
(6, 'Ananya Reddy', 'Hyderabad', 'ananya.reddy@yahoo.in'),
(7, 'Karan Mehta', 'Ahmedabad', 'karan.mehta@gmail.com'),
(8, 'Neha Kulkarni', 'Pune', 'neha.kulkarni@rediffmail.com'),
(9, 'Arjun Nair', 'Kochi', 'arjun.nair@gmail.com'),
(10, 'Pooja Joshi', 'Nagpur', 'pooja.joshi@yahoo.com');

insert into products (product_id, product_name, category, price) values
(1, 'Smartphone X', 'Electronics', 24999.00),
(2, 'Laptop Pro 14', 'Electronics', 58999.00),
(3, 'Bluetooth Headphones', 'Electronics', 2499.00),
(4, 'Smart Watch', 'Electronics', 4999.00),
(5, 'USB-C Cable', 'Accessories', 399.00),
(6, 'Laptop Backpack', 'Accessories', 1299.00),
(7, 'Wireless Mouse', 'Accessories', 699.00),
(8, 'Phone Case', 'Accessories', 349.00),
(9, 'Mixer Grinder', 'Home Appliances', 3499.00),
(10, 'Air Fryer', 'Home Appliances', 5999.00),
(11, 'Electric Kettle', 'Home Appliances', 1199.00),
(12, 'Study Desk Lamp', 'Home Appliances', 899.00);

insert into orders (order_id, customer_id, product_id, quantity, order_date) values
(1, 1, 1, 1, '2024-01-15'),
(2, 1, 5, 2, '2024-01-15'),
(3, 2, 2, 1, '2024-02-10'),
(4, 2, 7, 1, '2024-02-10'),
(5, 3, 3, 2, '2024-03-05'),
(6, 3, 9, 1, '2024-03-20'),
(7, 4, 4, 1, '2024-04-12'),
(8, 4, 6, 1, '2024-04-12'),
(9, 5, 10, 1, '2024-05-08'),
(10, 5, 11, 2, '2024-05-25'),
(11, 6, 1, 1, '2024-06-14'),
(12, 6, 8, 3, '2024-06-14'),
(13, 7, 12, 2, '2024-07-02'),
(14, 7, 5, 4, '2024-07-19'),
(15, 8, 3, 1, '2024-08-09'),
(16, 8, 7, 2, '2024-08-09'),
(17, 1, 3, 1, '2025-01-20'),
(18, 2, 9, 1, '2025-02-14'),
(19, 3, 5, 3, '2025-03-03'),
(20, 5, 2, 1, '2025-03-18'),
(21, 6, 10, 1, '2025-04-07'),
(22, 4, 11, 1, '2025-04-21'),
(23, 7, 4, 2, '2025-05-10'),
(24, 8, 6, 2, '2025-05-26');


-- Section 1: Advanced Joins

-- Task 1: Display each customer along with the products they ordered.
select
    c.customer_id as "Customer ID",
    c.customer_name as "Customer Name",
    p.product_name as "Product Name",
    o.order_id as "Order ID"
from customers as c
left join orders as o on c.customer_id = o.customer_id
left join products as p on o.product_id = p.product_id;

-- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
select c.customer_name, p.product_name
from customers as c
cross join products as p;

-- Task 3: Display all customers and their orders, including customers who have not placed any orders.
select
    c.customer_name as "Customer Name",
    o.order_id as "Order ID"
from customers as c
left join orders as o on c.customer_id = o.customer_id;


-- Section 2: Subqueries

-- Task 4: Find products priced above the average product price.
select *
from products as p
where p.price > (select avg(price) from products);

-- Task 5: Display customers whose total purchase amount is greater than the average customer purchase amount.
select
    c.customer_id as "Customer ID",
    c.customer_name as "Customer Name",
    sum(p.price * o.quantity) as "Total Purchase"
from customers as c
inner join orders as o on o.customer_id = c.customer_id
inner join products as p on p.product_id = o.product_id
group by c.customer_id, c.customer_name
having sum(p.price * o.quantity) > (
    select avg(customer_totals.total_amount)
    from (
        select sum(p2.price * o2.quantity) as total_amount
        from orders as o2
        inner join products as p2 on p2.product_id = o2.product_id
        group by o2.customer_id
    ) as customer_totals
);

-- Task 6: Find the highest-priced product in each category using a correlated subquery.
select p.product_id, p.product_name, p.category, p.price
from products as p
where p.price = (
    select max(p2.price)
    from products as p2
    where p2.category = p.category
);


-- Section 3: Set Operations

-- Task 7: Combine products from two different categories using UNION.
select product_id, product_name, category, price
from products
where category = 'Electronics'
union
select product_id, product_name, category, price
from products
where category = 'Accessories';

-- Task 8: MySQL alternatives for INTERSECT and EXCEPT using INNER JOIN and LEFT JOIN.

-- INTERSECT alternative (INNER JOIN)
select c.customer_id, c.customer_name
from customers as c
inner join (
    select distinct o.customer_id
    from orders as o
    inner join products as p on p.product_id = o.product_id
    where p.category = 'Electronics'
) as electronics_buyers on electronics_buyers.customer_id = c.customer_id
inner join (
    select distinct o.customer_id
    from orders as o
    inner join products as p on p.product_id = o.product_id
    where p.category = 'Accessories'
) as accessories_buyers on accessories_buyers.customer_id = c.customer_id;

-- EXCEPT alternative (LEFT JOIN)
select c.customer_id, c.customer_name
from customers as c
inner join (
    select distinct o.customer_id
    from orders as o
    inner join products as p on p.product_id = o.product_id
    where p.category = 'Electronics'
) as electronics_buyers on electronics_buyers.customer_id = c.customer_id
left join (
    select distinct o.customer_id
    from orders as o
    inner join products as p on p.product_id = o.product_id
    where p.category = 'Accessories'
) as accessories_buyers on accessories_buyers.customer_id = c.customer_id
where accessories_buyers.customer_id is null;


-- Section 4: Window Functions

-- Task 9: Rank products by price within each category.
select
    product_id as "Product ID",
    product_name as "Product Name",
    category as "Category",
    price as "Price",
    rank() over (partition by category order by price desc) as "Price Rank"
from products;

-- Task 10: Display the previous product price (LAG) and a running total of product prices.
select
    product_id as "Product ID",
    product_name as "Product Name",
    price as "Price",
    lag(price) over (order by product_id) as "Previous Price",
    sum(price) over (order by product_id) as "Running Total"
from products;


-- Section 5: Common Table Expressions (CTEs)

-- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
with customer_totals as (
    select
        c.customer_id,
        c.customer_name,
        sum(p.price * o.quantity) as total_purchase
    from customers as c
    inner join orders as o on o.customer_id = c.customer_id
    inner join products as p on p.product_id = o.product_id
    group by c.customer_id, c.customer_name
)
select
    customer_id as "Customer ID",
    customer_name as "Customer Name",
    total_purchase as "Total Purchase"
from customer_totals
where total_purchase > (select avg(total_purchase) from customer_totals);

-- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
with recursive numbers as (
    select 1 as n
    union all
    select n + 1 from numbers where n < 10
)
select n from numbers;


-- Section 6: Views

-- Task 13: Create a view that displays products priced above ₹1,000 and retrieve data from the view.
create view expensive_products as
select product_id, product_name, category, price
from products
where price > 1000;

select * from expensive_products;


-- Section 7: Indexes and Query Performance

-- Task 14: Create an index on the category column of the Products table.
create index idx_products_category on products(category);

-- Task 15: Use EXPLAIN to analyze a query that filters products by category.
explain
select product_id, product_name, price
from products
where category = 'Electronics';


-- Section 8: Stored Procedures and Functions

-- Task 16: Create a stored procedure to retrieve products by category.
delimiter //

create procedure get_products_by_category(in p_category varchar(50))
begin
    select product_id, product_name, category, price
    from products
    where category = p_category;
end //

delimiter ;

call get_products_by_category('Electronics');

-- Task 17: Create a function to calculate the total price of an order (price × quantity).
delimiter //

create function get_order_total(p_order_id int)
returns decimal(12,2)
reads sql data
begin
    declare v_total decimal(12,2);

    select p.price * o.quantity
    into v_total
    from orders as o
    inner join products as p on p.product_id = o.product_id
    where o.order_id = p_order_id;

    return v_total;
end //

delimiter ;

select
    order_id as "Order ID",
    get_order_total(order_id) as "Order Total"
from orders;


-- Section 9: Transactions

-- Task 18: Write a transaction that updates a product's price and demonstrate the use of COMMIT and ROLLBACK.

-- COMMIT
start transaction;

update products set price = 26999.00 where product_id = 1;

select product_id, product_name, price from products where product_id = 1;

commit;

select product_id, product_name, price from products where product_id = 1;

-- ROLLBACK
start transaction;

update products set price = 19999.00 where product_id = 1;

select product_id, product_name, price from products where product_id = 1;

rollback;

select product_id, product_name, price from products where product_id = 1;


-- Section 10: SQL Triggers

-- Task 19: Create a trigger that automatically records new orders in an Order_Audit table whenever a new order is inserted.
create table order_audit (
    audit_id int auto_increment primary key,
    order_id int,
    customer_id int,
    product_id int,
    quantity int,
    order_date date,
    logged_at timestamp default current_timestamp
);

delimiter //

create trigger trg_orders_after_insert
after insert on orders
for each row
begin
    insert into order_audit (order_id, customer_id, product_id, quantity, order_date)
    values (new.order_id, new.customer_id, new.product_id, new.quantity, new.order_date);
end //

delimiter ;

insert into orders (order_id, customer_id, product_id, quantity, order_date)
values (25, 9, 7, 1, '2025-06-15');

select * from order_audit;


-- Section 11: Performance Tuning

-- Task 20: Optimize the queries by applying SQL performance tuning best practices.

-- Before optimization
select distinct *
from orders
where year(order_date) = 2024 and product_id = 3;

-- Supporting index
create index idx_orders_product_date on orders(product_id, order_date);

-- After optimization
select order_id, customer_id, quantity, order_date
from orders
where product_id = 3
  and order_date >= '2024-01-01'
  and order_date < '2025-01-01';