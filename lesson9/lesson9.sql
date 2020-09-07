-- 1.1.
start transaction;
select @name := name from shop.users where id = 1;
insert into sample.users (name) values (@name);
commit;

-- 1.2.

use shop;
create view products_view as select products.name as 'product', catalogs.name as 'catalog' from products
join
 catalogs
on catalog_id = catalogs.id;

select * from products_view;

-- 1.3.
create temporary table august (`date` datetime, flag int );
insert into august values
('2020-08-01 00:00:00', 0),
('2020-08-02 00:00:00', 0),
('2020-08-03 00:00:00', 0),
('2020-08-04 00:00:00', 0),
('2020-08-05 00:00:00', 0),
('2020-08-06 00:00:00', 0),
('2020-08-07 00:00:00', 0),
('2020-08-08 00:00:00', 0),
('2020-08-09 00:00:00', 0),
('2020-08-10 00:00:00', 0),
('2020-08-11 00:00:00', 0),
('2020-08-12 00:00:00', 0),
('2020-08-13 00:00:00', 0),
('2020-08-14 00:00:00', 0),
('2020-08-15 00:00:00', 0),
('2020-08-16 00:00:00', 0),
('2020-08-17 00:00:00', 0),
('2020-08-18 00:00:00', 0),
('2020-08-19 00:00:00', 0),
('2020-08-20 00:00:00', 0),
('2020-08-21 00:00:00', 0),
('2020-08-22 00:00:00', 0),
('2020-08-23 00:00:00', 0),
('2020-08-24 00:00:00', 0),
('2020-08-25 00:00:00', 0),
('2020-08-26 00:00:00', 0),
('2020-08-27 00:00:00', 0),
('2020-08-28 00:00:00', 0),
('2020-08-29 00:00:00', 0),
('2020-08-30 00:00:00', 0),
('2020-08-31 00:00:00', 0);


select created_at, (select 1) as flag from users
union
select * from august where august.date not in (select created_at from users)
order by created_at;

-- 1.4.

delete from users where created_at < (select created_at from users order by created_at desc limit 4, 1);

select * from users;

-- 2.1.

create user shop_read;
create user shop;
grant usage, select on shop.* to shop_read; 
grant all on shop.* to shop; 

-- 2.2.
create table shop.account (
	id serial primary key,
	name varchar(255),
	password varchar(255)
);

insert into shop.account values
	(default, 'Вася', '1234'),
	(default, 'Ваня', '12345'),
	(default, 'Петя', '123456');

create view shop.username as select id, name from shop.account;

create user user_read;
grant usage on shop.* to user_read;
grant select on shop.username to user_read;

-- 3.1.

use shop;
drop function if exists hello;
delimiter //
create function hello ()
returns varchar(255) deterministic
begin
	if (time(now()) > '06:00' and time(now()) <='12:00') then 
		return 'Доброе утро';
	elseif (time(now()) > '12:00' and time(now()) <= '18:00') then 
		return 'Добрый день';
	elseif (time(now()) > '18:00' and time(now()) <= '23:59') then 
		return 'Добрый вечер';
	else 
		return 'Доброй ночи';
	end if;
end//

select  hello();

-- 3.2.
drop trigger if exists check_name_description;

delimiter //
create trigger check_name_description before insert on products
for each row
begin
	if (new.name is null and new.description is null) then
		signal sqlstate '45000' set message_text = 'Поля пустые';
	end if;
end//

insert into products values
(default, null, null, '10000.00', 1, now(), default);

-- 3.3.

drop function if exists fibonacci;

delimiter //
create function fibonacci (num int)
returns int deterministic
begin
	declare prev1, prev2, i int;
	set prev1 = 0;
	set prev2 = 1;
	set i = 1;
	while i < num do
		set @current = prev1 + prev2;
		set prev1 = prev2;
		set prev2 = @current;
		set i = i + 1;
	end while;
	return @current;
end//

select fibonacci(10);
