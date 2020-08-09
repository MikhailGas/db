create DATABASE if not exists example;

use example;
drop table users;
create table if not exists users( 
	id INT auto_increment not null primary key,
	name VARCHAR(100));

create DATABASE if not exists sample;
