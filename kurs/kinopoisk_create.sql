create database kinopoisk;
use kinopoisk;

-- база данных популярного портала КиноПоиск
-- создаем таблицы

drop table if exists films;
-- информация о фильме
create table films(
	id serial primary key,
	name varchar(255) unique not null,
	description text,
	type enum('Фильм', 'Сериал', 'Документальный фильм') not null,
	rating decimal(2, 1),
	year year(4),
	duration smallint unsigned,
	poster_id bigint unsigned
);

drop table if exists film_country;

-- страна/страны выпустившие фильмы
create table film_country(
	id serial primary key,
	film_id bigint unsigned not null,
	country_id bigint unsigned not null
);

drop table if exists countrys;
-- Справочник "Страны"

create table countrys(
	id serial primary key,
	country varchar(255) unique not null
);

drop table if exists film_producers;
-- Режиссер/режиссеры фильмов

create table film_producers(
	id serial primary key,
	film_id bigint unsigned not null,
	producer_id bigint unsigned not null
);

drop table if exists producers;
-- Справочник "Продюссеры"

create table producers(
	id serial primary key,
	firstname varchar(100),
	lastname varchar(100) not null,
	photo_id bigint unsigned
);

drop table if exists posters;

-- Афиши к фильмам

create table posters(
	id serial primary key,
	film_id bigint unsigned not null,
	file varchar(255)
);


drop table if exists film_genres;

-- Жанр/жанры фильма

create table film_genres(
	id serial primary key,
	film_id bigint unsigned not null,
	genre_id bigint unsigned not null
);

drop table if exists genres;

-- справочник "Жанры"

create table genres(
	id serial primary key,
	genre varchar(150) unique
);

drop table if exists film_main_roless;

-- В главных ролях

create table film_main_roles(
	id serial primary key,
	film_id bigint unsigned not null,
	artist_id bigint unsigned not null
);

drop table if exists artists;

-- Справочник "Актеры"

create table artists(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	photo_id bigint unsigned
);

drop table if exists photos;

-- Фото режиссеров и актеров

create table photos(
	id serial primary key,
	file varchar(255)
);

drop table if exists users;

-- Регистрационные данные

create table users(
	id serial primary key,
	email varchar(150) not null unique,
	password varchar(150) not null,
	created_at date default current_timestamp
);

drop table if exists profiles;

-- Профиль пользователя

create table profiles(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	gender char(1),
	birthday date,
	photo_id bigint unsigned not null
);

drop table if exists film_estimations;

-- Оценка фильма

create table film_estimations(
	id serial primary key,
	film_id bigint unsigned not null,
	user_id bigint unsigned not null,
	score decimal(2, 1),
	created_at date
);

