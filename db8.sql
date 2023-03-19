-- ROLLUP SECTION
-- ROLLUP, extension of the GROUP BY clause
-- produces another row and shows the GRAND TOTAL (super-aggregate value)

SELECT * FROM transactions;

SELECT SUM(amount), order_date from transactions group by order_date;
SELECT SUM(amount), order_date from transactions group by order_date with rollup;

SELECT COUNT(transaction_id), order_date from transactions group by order_date with rollup;

SELECT COUNT(transaction_id) as "# of orders", customer_id from transactions group by customer_id with rollup;

SELECT * FROM employee;

SELECT SUM(hourly_pay) as "hourly pay", employee_id from employee group by employee_id with rollup;

-- ON DELETE SECTION
-- ON DELETE SET NULL = WHen a FK is deleted, replace FK with NULL
-- ON DELETE CASCADE = When a FK is deleted, delete row

SET foreign_key_checks = 1;

SELECT * FROM transactions;
SELECT * FROM customers;

DELETE FROM customers where customer_id = 4;
INSERT INTO customers VALUES(4,"Poppy","Puff",2,"PPuf@gmail.com");

alter table transactions drop foreign key transactions_ibfk_1;

alter table transactions add constraint fk_customer_id foreign key(customer_id) references customers(customer_id) on delete set null;

delete from customers where customer_id = 4;

alter table transactions drop foreign key fk_customer_id;
alter table transactions add constraint fk_customer_id foreign key(customer_id) references customers(customer_id) on delete cascade;
update transactions set customer_id = 4 where transaction_id = 1005;
delete from customers where customer_id = 4;


-- STORED PROCEDURES SECTION
-- Stored procedure = is prepared SQL code that you can save great if there's a query that you write often
-- reduces network traffic
-- increases performance
-- secure, admin can grant permission to use
-- increase memory usage of every connection
DELIMITER $$
create procedure get_customers()
begin
	select * from customers;
END; $$
DELIMITER ;

CALL get_customers();

drop procedure get_customers;

DELIMITER $$
CREATE procedure find_customer(IN id INT)
BEGIN
	select * from customers where customer_id = id;
END $$
DELIMITER ;

DROP procedure find_customer;


DELIMITER $$
CREATE procedure find_customer(IN f_name varchar(50), IN l_name varchar(50))

BEGIN
	SELECT * FROM customers where first_name = f_name and last_name = l_name;
END $$
DELIMITER ;

CALL find_customer("Larry","Lobster");