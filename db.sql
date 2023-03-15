create database new_db;
use new_db;

create table employee(
	employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    hourly_pay decimal(5,2),
    hire_date date
);

INSERT INTO employee value(1,"Eugene","Krab",25.50,"2023-01-02");
INSERT INTO employee value(2, "Squidward", "Tentacles", 15.00, "2023-01-03"),
						(3, "Spongebob","Squarepants",12.50,"2023-01-04"),
						(4, "Patrick", "Star", 12.50, "2023-01-05"),
						(5, "Sandy","Cheeks",17.25,"2023-01-08");
insert into employee(employee_id,first_name,last_name) value(6,"Sheldon","Plankton");
SELECT * FROM employee; -- Select all the data in the table employee
Select first_name, last_name from employee;-- Select the first_name and last name data in the table employee
Select * from employee where employee_id = 1; -- Select all the data in the table employee where the first_name column equals to 1
select * from employee where first_name = "Spongebob";
select * from employee where hourly_pay >= 15;
select * from employee where hire_date <= "2023-01-03";
select * from employee where employee_id = 1;
select * from employee where hire_date is not null;

update employee set hourly_pay = 10.25 where employee_id = 6;
update employee set hire_date = null where employee_id = 6;

delete from employee where employee_id = 6;

commit;
set AUTOCOMMIT = OFF;
set AUTOCOMMIT = ON;

