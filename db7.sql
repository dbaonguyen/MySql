-- INDEXES SECTION

-- INDEX(BTree data structure)
-- INDEXES are used to find values within a specific column more quickly
-- MySQL normally searches sequentially through a column
-- The longer the column, the more expensive the operation is
-- UPDATE takes more time, SELECT takes less time

SHOW indexes from customers;

CREATE index last_name_idx on customers(last_name);

select * from customers where last_name = "Puff";
select * from customers where first_name = "Poppy";

create index last_name_first_name_idx on customers(last_name, first_name);

alter table customers drop index last_name_idx;	

-- SUBQUERIES SECTION
-- a query within another query
-- query(subquery)

select first_name, last_name, hourly_pay, 
(select avg(hourly_pay) from employee) as avg_pay
from employee;

select first_name, last_name, hourly_pay from employee where hourly_pay > 15.45;
-- (Select avg(hourly_pay) from employee);

select * from transactions;
select * from customers;
select first_name, last_name from customers where customer_id in (select distinct customer_id from transactions where customer_id is not null);

select first_name, last_name from customers where customer_id not in (1,2,3);

-- GROUP BY SECTION

-- GROUP BY = aggregate all rows by a specific column often used with aggregate functions 
-- ex. SUM(),MAX(),MIN(),AVG(),COUNT()

select * from transactions;

alter table transactions add column order_date date;

update transactions set order_date = '2023-01-03' where transaction_id = 1006;

select sum(amount), order_date from transactions group by order_date;
select max(amount), order_date from transactions group by order_date;
select min(amount), order_date from transactions group by order_date;
select count(amount), order_date from transactions group by order_date;

select sum(amount), customer_id from transactions group by customer_id;
select max(amount), customer_id from transactions group by customer_id;
select min(amount), customer_id from transactions group by customer_id;
select count(amount), customer_id from transactions group by customer_id;

select count(amount), customer_id from transactions group by customer_id having count(amount) > 1 and customer_id is not null;