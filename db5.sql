-- AND, OR, NOT SECTION
alter table employee add column job varchar(25) after hourly_pay;
select * from employee;
update employee set job = "manager" where employee_id = 1;
update employee set job = "cashier" where employee_id = 2; 
update employee set job = "cook" where employee_id = 3; 
update employee set job = "cook" where employee_id = 4; 
update employee set job = "assistant manager" where employee_id = 5;

select * from employee where job = "cook" and hire_date < "2023-01-05";
select * from employee where job = "cook" or job = "cashier";
select * from employee where not job = "manager" and not job = "assistant manager";
select * from employee where hire_date between "2023-01-04" and "2023-01-07";
select * from employee where job in ("cook", "cashier","manager");

-- WILD CARDS system

select * from employee where first_name like "s%";
select * from employee where last_name like "%r";
select * from employee where first_name like "sp%";
select * from employee where job like "_ook";
select * from employee where hire_date like "____-__-03";
select * from employee where job like "_a%";

-- ORDER BY SECTION
select * from employee order by last_name;
select * from employee order by last_name desc;

select * from employee order by first_name;
select * from employee order by first_name desc;

select * from employee order by hire_date;
select * from employee order by hire_date desc;

select * from transactions order by amount, customer_id;

-- LIMIT SECTION
-- LIMIT clause is used to limit the number of records
-- Useful if you're working with a lot of data
-- Can be used to display a large data on papers (pagination)
select * from customers limit 1;
select * from customers limit 2;
select * from customers limit 3;
select * from customers limit 4;

select * from customers order by last_name limit 1;
select * from customers order by last_name desc limit 1;

select * from customers limit 1,3;

-- UNIONS SECTION
-- Combines the results of two or more select statements
Select first_name, last_name from employee union all select first_name, last_name from customers;

select * from customers;
