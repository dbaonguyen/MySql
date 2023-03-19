-- SELF JOIN SECTION
-- join another copy of a table to itself
-- used to compare rows of the same table
-- helps to display a heirarchy of data


alter table customers add referral_id int;
select * from customers;

update customers set referral_id = 1 where customer_id = 2;
update customers set referral_id = 2 where customer_id = 3;
update customers set referral_id = 2 where customer_id = 4;

select * from customers as 	a inner join customers as b on a.referral_id = b.customer_id; --  finding all customers who have a referral and joining them with their respective referrers.
select a.customer_id,a.first_name,a.last_name, b.first_name, b.last_name from customers as a inner join customers as b on a.referral_id = b.customer_id;

select a.customer_id,a.first_name,a.last_name,concat(b.first_name, " ", b.last_name) as "referred by" from customers as a inner join customers as b on a.referral_id = b.customer_id;
select a.customer_id,a.first_name,a.last_name,concat(b.first_name, " ", b.last_name) as "referred by" from customers as a left join customers as b on a.referral_id = b.customer_id;

alter table employee add supervisor_id int;
select * from employee;

update employee set supervisor_id = 5 where employee_id = 2;
update employee set supervisor_id = 5 where employee_id = 3;
update employee set supervisor_id = 5 where employee_id = 4;
update employee set supervisor_id = 5 where employee_id = 6;
update employee set supervisor_id = 1 where employee_id = 5;

select * from employee as a inner join employee as b on a.supervisor_id = b.supervisor_id;
select a.first_name, a.last_name, concat(b.first_name, " ", b.last_name) as "report to" from employee as a inner join employee as b on a.supervisor_id = b.supervisor_id;
select a.first_name, a.last_name, concat(b.first_name, " ", b.last_name) as "report to" from employee as a left join employee as b on a.supervisor_id = b.supervisor_id;

-- VIEWS SECTION
-- A virtual table based on the result-set of an SQL statement
-- The fields in a view are fields from one or more real tables in the database
-- They're not real tables, but can be interacted with as if they were


Select * from employee;

create view employee_attendance as
select first_name, last_name from employeeemployee_attendanceemployee_attendance;

select * from employee_attendance order by last_name;
-- drop view employee_attendance
select * from customers;

alter table customers add column email varchar(50);

update customers set email = "Ffish@gmail.com" where customer_id =1;
update customers set email = "LLobster@gmail.com" where customer_id =2;
update customers set email = "BBass@gmail.com" where customer_id =3;
update customers set email = "PPuff@gmail.com" where customer_id =4;

create view customer_emails as select email from customers;

select * from customer_emails;

insert into customers values(5, "Pearl", "Krabs", null, "PKrabs@gmail.com");

