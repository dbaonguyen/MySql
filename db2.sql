CREATE TABLE test(
	my_date date,
    my_time time,
    my_datetime datetime
);

SELECT * FROM test;

INSERT INTO test values(current_date(), current_time(), now());
INSERT INTO test values(current_date(), null, null);

drop table test;


create table products(
	product_id int,
    product_name varchar(25) unique,
    price decimal(4,2)

);

alter table products add constraint unique(product_name);

select * from products;



insert into products values (100,"hamburger",3.99),
							(101,"fries",1.89),
							(102, "soda",1.00),
                            (103,"ice cream",1.49);
insert into products value(105,"cookie",0);

alter table products modify price decimal(4,2) not null;
alter table employee add constraint chk_hourly_pay check(hourly_pay >= 10.00);

alter table employee drop check chk_hourly_pay;

insert into products(product_id,product_name) values (104,"straw"),
							(106, "fork"),
                            (107,"spoon"),
                            (108,"napkin");

delete from products where product_id >= 104;

Select * from products;	



alter table products alter price set default 0;

