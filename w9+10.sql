create database sql_w9;
use sql_w9;

CREATE TABLE post (
  code INTEGER PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  income DECIMAL(10, 2) NOT NULL
);

CREATE TABLE employee (
  number INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  position_code INTEGER NOT NULL,
  supervisor INTEGER,
  department_code INTEGER NOT NULL
);

ALTER TABLE employee
ADD FOREIGN KEY (position_code) REFERENCES post(code),
ADD FOREIGN KEY (supervisor) REFERENCES employee(number),
ADD FOREIGN KEY (department_code) REFERENCES department(code);


CREATE TABLE department (
  code INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL,
  director INTEGER,
  FOREIGN KEY (director) REFERENCES employee(number)
);

CREATE TABLE commission (
  employee_number INTEGER NOT NULL,
  date DATE NOT NULL,
  value DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (employee_number) REFERENCES employee(number)
);

CREATE TABLE history (
  employee_number INTEGER NOT NULL,
  position_code INTEGER NOT NULL,
  start_date DATE NOT NULL,
  FOREIGN KEY (employee_number) REFERENCES employee(number),
  FOREIGN KEY (position_code) REFERENCES post(code)
);

-- Insert sample positions
INSERT INTO post (code, title, income) VALUES
(1, 'Manager', 5000),
(2, 'Supervisor', 4000),
(3, 'Employee', 3000);

-- Insert sample departments
INSERT INTO department (code, name, location, director) VALUES
(1, 'Sales', 'New York', NULL),
(2, 'Marketing', 'Los Angeles', NULL),
(3, 'Human Resources', 'Chicago', NULL);

update department set director = 4 where code = 2;

select * from department;

-- Insert sample employees
INSERT INTO employee (number, name, position_code, supervisor, department_code) VALUES
(7, 'John ss', 2, 1, 1);
-- (2, 'Jane Doe', 2, 1, 1),
-- (3, 'Bob Johnson', 3, 1, 1),
-- (4, 'Mary Williams', 2, 1, 2),
-- (5, 'Tom Brown', 3, 1, 2),
-- (6, 'David Lee', 3, 2, 3);

-- Insert sample commissions
INSERT INTO commission (employee_number, date, value) VALUES
(2, '2022-01-01', 100),
(3, '2022-01-01', 50),
(4, '2022-01-01', 75),
(5, '2022-01-01', 25),
(6, '2022-01-01', 125);

-- Insert sample employment history
INSERT INTO history (employee_number, position_code, start_date) VALUES
(1, 1, '2021-01-01'),
(2, 2, '2021-01-01'),
(3, 3, '2021-01-01'),
(4, 2, '2021-01-01'),
(5, 3, '2021-01-01'),
(6, 3, '2021-01-01');

select * from department;
select * from employee;
-- Exercise 1
-- 1 
SELECT e_supervisor.name AS supervisor_name, COUNT(*) AS num_employees
FROM employee e
JOIN employee e_supervisor ON e.supervisor = e_supervisor.number
JOIN department d ON e.department_code = d.code
WHERE e.supervisor IS NOT NULL AND d.location <> 'Hanoi'
GROUP BY e_supervisor.name;
-- 2
Select p.code as post_code, d.name as department_name, count(*) as num_emp FROM Post p, Department d, Employee WHERE department_code = d.code AND position_code = p.code GROUP BY p.code, d.name; 
-- 3
select p.code as post_code, p.income as post_income, count(*) as num_emp from Post p, Employee e, Department d Where p.code = e.position_code and d.code = e.department_code and d.location <>  'Ha Noi' GROUP BY p.code, p.income;

select p.code, p.income, count(*) as num_emp from post p, employee where position_code = p.code and p.income > (Select AVG(income) from post) group by p.code; 
-- 4
SELECT e.name, p.income*12 AS annual_income
FROM employee e, post p 
WHERE ABS(p.income - (SELECT AVG(p.income) FROM post p)) <= 100;
-- 5
select e.name, p.income as highest_salary from Employee e inner join Post p on e.position_code = p.code inner join Department d on e.department_code = d.code where d.location = 'New York' and p.income = (select MAX(p.income) FROM post p);
-- 6
select e_supervisor.name as supervisor_name, count(*) as num_employees From employee e JOIN employee e_supervisor ON e.supervisor = e_supervisor.number GROUP BY e_supervisor.name  ORDER BY count(*) desc Limit 1;
-- 7
select e.name as employee_name, d.name as department_name, count(*) as num_employees from Employee e 
INNER JOIN Department d on d.director = e.number
INNER JOIN employee emp ON d.code = emp.department_code group by e.name, d.name;


