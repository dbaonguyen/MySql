create table transactions(
	transaction_id int primary key,
    amount decimal(5,2)

);

select * from transactions;

-- alter table transactions add constraint primary key(transaction_id);
insert into transactions values (1000,4.99);
insert into transactions values (1001,2.78);
insert into transactions values (1002,4.78);
insert into transactions values (1003,1.78);

select amount from transactions where transaction_id = 1003;

drop table transactions;

create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal(5,2)

);

insert into transactions(amount) values (4.99);
insert into transactions(amount)values (2.78);

alter table transactions auto_increment = 1000;

delete from transactions;