drop database if exists kinopoisk;
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
	duration smallint unsigned
);

drop table if exists countrys;
-- Справочник "Страны"

create table countrys(
	id serial primary key,
	country varchar(255) unique not null
);

drop table if exists photos;

-- Фото режиссеров и актеров и полбзователей

create table photos(
	id serial primary key,
	file varchar(255)
);

drop table if exists persons;

-- Справочник "Режиссеры и актёры"

create table persons(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	role enum('Режиссёр', 'Актёр'),
	photo_id bigint unsigned,
	foreign key (photo_id) references photos(id)
);



drop table if exists genres;

-- справочник "Жанры"

create table genres(
	id serial primary key,
	genre varchar(150) unique
);

drop table if exists film_country;

-- страна/страны выпустившие фильмы
create table film_country(
	film_id bigint unsigned not null,
	country_id bigint unsigned not null,
	primary key (film_id, country_id),
	foreign key(film_id) references films(id),
	foreign key(country_id) references countrys(id)
);



drop table if exists film_producers_artists;
-- Режиссер/режиссеры фильмов

create table film_producers_artists(
	film_id bigint unsigned not null,
	person_id bigint unsigned not null,
	primary key (film_id, person_id),
	foreign key(film_id) references films(id),
	foreign key(person_id) references persons(id)
);


drop table if exists posters;

-- Афиши к фильмам

create table posters(
	id serial primary key,
	film_id bigint unsigned not null,
	file varchar(255),
	foreign key(film_id) references films(id)
);


drop table if exists film_genres;

-- Жанр/жанры фильма

create table film_genres(
	film_id bigint unsigned not null,
	genre_id bigint unsigned not null,
	primary key (film_id, genre_id),
	foreign key(film_id) references films(id),
	foreign key(genre_id) references genres(id)
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
	id bigint unsigned not null primary key,
	firstname varchar(150),
	lastname varchar(150) not null,
	gender char(1),
	birthday date,
	photo_id bigint unsigned not null,
	foreign key (id) references users(id)
);

drop table if exists film_estimations;

-- Оценка фильма

create table film_estimations(
	id serial primary key,
	film_id bigint unsigned not null,
	user_id bigint unsigned not null,
	score tinyint(2) unsigned,
	created_at date default current_timestamp,
	foreign key (user_id) references users(id),
	foreign key (film_id) references films(id)
);

