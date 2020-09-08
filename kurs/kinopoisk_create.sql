create database kinopoisk;
use kinopoisk;

-- ���� ������ ����������� ������� ���������
-- ������� �������

drop table if exists films;
-- ���������� � ������
create table films(
	id serial primary key,
	name varchar(255) unique not null,
	description text,
	type enum('�����', '������', '�������������� �����') not null,
	rating decimal(2, 1),
	year year(4),
	duration smallint unsigned,
	poster_id bigint unsigned
);

drop table if exists film_country;

-- ������/������ ����������� ������
create table film_country(
	id serial primary key,
	film_id bigint unsigned not null,
	country_id bigint unsigned not null
);

drop table if exists countrys;
-- ���������� "������"

create table countrys(
	id serial primary key,
	country varchar(255) unique not null
);

drop table if exists film_producers;
-- ��������/��������� �������

create table film_producers(
	id serial primary key,
	film_id bigint unsigned not null,
	producer_id bigint unsigned not null
);

drop table if exists producers;
-- ���������� "����������"

create table producers(
	id serial primary key,
	firstname varchar(100),
	lastname varchar(100) not null,
	photo_id bigint unsigned
);

drop table if exists posters;

-- ����� � �������

create table posters(
	id serial primary key,
	film_id bigint unsigned not null,
	file varchar(255)
);


drop table if exists film_genres;

-- ����/����� ������

create table film_genres(
	id serial primary key,
	film_id bigint unsigned not null,
	genre_id bigint unsigned not null
);

drop table if exists genres;

-- ���������� "�����"

create table genres(
	id serial primary key,
	genre varchar(150) unique
);

drop table if exists film_main_roless;

-- � ������� �����

create table film_main_roles(
	id serial primary key,
	film_id bigint unsigned not null,
	artist_id bigint unsigned not null
);

drop table if exists artists;

-- ���������� "������"

create table artists(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	photo_id bigint unsigned
);

drop table if exists photos;

-- ���� ���������� � �������

create table photos(
	id serial primary key,
	file varchar(255)
);

drop table if exists users;

-- ��������������� ������

create table users(
	id serial primary key,
	email varchar(150) not null unique,
	password varchar(150) not null,
	created_at date default current_timestamp
);

drop table if exists profiles;

-- ������� ������������

create table profiles(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	gender char(1),
	birthday date,
	photo_id bigint unsigned not null
);

drop table if exists film_estimations;

-- ������ ������

create table film_estimations(
	id serial primary key,
	film_id bigint unsigned not null,
	user_id bigint unsigned not null,
	score decimal(2, 1),
	created_at date
);

