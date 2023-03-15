-- INDEXES SECTION

SHOW indexes from customers;

CREATE index last_name_idx on customers(last_name);

select * from customers where last_name = "Puff";
select * from customers where first_name = "Poppy";

create index last_name_first_name_idx on customers(last_name, first_name);

alter table customers drop index last_name_idx;	

-- SUBQUERIES SECTION
select first_name, last_name, hourly_pay, 
(select avg(hourly_pay) from employee) as avg_pay
from employee;

select first_name, last_name, hourly_pay from employee where hourly_pay > 15.45;
-- (Select avg(hourly_pay) from employee);

select * from transactions;
select * from customers;
select first_name, last_name from customers where customer_id in (select distinct customer_id from transactions where customer_id is not null);

select first_name, last_name from customers where customer_id not in (1,2,3);