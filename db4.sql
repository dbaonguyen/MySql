use new_db;
-- AUTO INCREAMENT SECTION
create table customers(
	customer_id int primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50)

);

select * from customers;

insert into customers (first_name,last_name) values ("Fred","Fish"),("Larry","Lobster"),("Bubble","Bass");

drop table transactions;


-- FOREIGN KEY SECTION	
create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal(5,2),
    customer_id int,
    foreign key (customer_id) references customers(customer_id)

);
alter table transactions auto_increment = 1000;

select * from transactions;

alter table transactions drop foreign key transactions_ibfk_1;
alter table transactions add constraint fk_customer_id foreign key(customer_id) references customers(customer_id);

DELETE FROM transactions;

select * from transactions;

insert into transactions(amount,customer_id) values (4.99,3),(2.89,2),(3.38,3),(4.99,1);

-- delete from transactions where customer_id = 3;
insert into transactions(amount,customer_id) values (4.99,3),(3.38,3);

-- JOIN SECTION

insert into transactions(amount,customer_id) values (1.00,null);

insert into customers(first_name,last_name) values  ("Poppy", "Puff");

select * from customers;

select * from transactions inner join customers on transactions.customer_id = customers.customer_id;
select transaction_id,amount,first_name,last_name from transactions inner join customers on transactions.customer_id = customers.customer_id;


select * from transactions left join customers on transactions.customer_id = customers.customer_id;

select * from transactions right join customers on transactions.customer_id = customers.customer_id;

-- FUNCTIONS SECTION
select count(amount) as count from transactions;
select max(amount) as max_value from transactions;
select min(amount) as min_value from transactions;
select avg(amount) as avg from transactions;
select sum(amount) as sum from transactions;

select concat(first_name," ",last_name) as full_name from employee;
