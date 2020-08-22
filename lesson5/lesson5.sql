use shop;
-- 1.

update users set created_at = null, updated_at = null;
update users set created_at = now(), updated_at = now();

-- 2.
alter table users modify created_at varchar(255);
alter table users modify updated_at varchar(255);

alter table users modify created_at datetime;
alter table users modify updated_at datetime;

-- 3.

insert into storehouses_products (
	storehouse_id, product_id, value, created_at, updated_at 
) value
(1,1, 1000, now(), now()),
(1,2, 10000, now(), now()),
(2,5, 2000, now(), now()),
(1,7, 150, now(), now()),
(3,1, 5000, now(), now()),
(2,1, 4000, now(), now()),
(1,6, 0, now(), now()),
(2,7, 0, now(), now());

select value from storehouses_products order by case value when 0 then 65535 end, value;

-- 4.

select * from users where (case birthday_at when birthday_at then date_format(birthday_at, '%M') end) = 'may' or 
							(case birthday_at when birthday_at then date_format(birthday_at, '%M') end) = 'august'; 
				
-- 5.

select * from catalogs where id in(5, 1, 2) order by case id when 5 then 0
															when 1 then 1
															when 2 then 2
															end;
														
-- агрегаци€ данных
-- 1.

select avg(timestampdiff(year, birthday_at, now())) as '—редний возраст' from users;

-- 2.

select name, birthday_at, date_format((date_add(birthday_at, interval year(now()) - year(birthday_at ) year)), '%W') as weekly, count(*) 
from users group by weekly;

-- 3.

select  exp(sum(log(id))) as 'произведение' from users;

