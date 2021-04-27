/* База данных пансионата. Задача базы. Регистрация гостей пансионата, размещение в номерах, предоставление различных услуг, питание.
 * услуги встречи, проводы. 
 */


DROP DATABASE IF EXISTS pansionat;

CREATE DATABASE pansionat;

USE pansionat;

-- регистрация гостя пансионата

DROP TABLE IF EXISTS guest;

CREATE TABLE guest (
	id bigint unsigned NOT NULL AUTO_INCREMENT,
	first_name varchar(145) NOT NULL comment 'имя гостя',
	last_name varchar(145) NOT NULL comment 'фамилия гостя',
	email varchar(145) NOT NULL COMMENT 'эл.почта гостя ',
	phone char(11) NOT NULL COMMENT 'телефон',
	created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания',
	PRIMARY KEY (id),
	UNIQUE KEY email_idx (email),
	UNIQUE KEY phone_idx (phone)
 ) ENGINE=InnoDB ;

INSERT INTO
  guest (first_name, last_name, phone, email, created_at)
VALUES
  ('Геннадий', 'Иванов', '89032349012', 'test@mail.ru', DEFAULT),
  ('Дмитрий', 'Петров', '89038342012', 'test1@mail.ru', DEFAULT),
  ('Сергей', 'Сидоров', '89032345426', 'test2@mail.ru', DEFAULT),
  ('Ирина', 'Николаева', '88973249012', 'test5@mail.ru', DEFAULT),
  ('Ольга', 'Суринова', '89032349165', 'test3@mail.ru', DEFAULT),
  ('Петр', 'Куприн', '89038129012', 'test6@mail.ru', DEFAULT);

-- данные гостя 
CREATE TABLE profiles (
	guest_id bigint unsigned NOT NULL,
	gender enum('f','m') NOT NULL COMMENT 'пол',
	birthday date NOT NULL COMMENT 'Дата рождения',
	city varchar(130) NOT NULL COMMENT 'город проживания',
	country varchar(130) NOT NULL DEFAULT 'Russia' COMMENT 'страна проживания',
	PRIMARY KEY (guest_id),
	CONSTRAINT fk_profiles_guest FOREIGN KEY (guest_id) REFERENCES guest (id)
) ENGINE=InnoDB;

INSERT INTO
  profiles (guest_id , gender, birthday, city, country)
VALUES
  (1, 'f', '1980-10-05', 'Moscow', DEFAULT),
  (2, 'f', '1977-06-15', 'Smolensk', DEFAULT),
  (3, 'f', '1965-04-12', 'Rostov', DEFAULT),
  (4, 'm', '1960-01-22', 'Kazan', DEFAULT),
  (5, 'm', '1970-09-14', 'Minsk', 'Belarus'),
  (6, 'f', '1990-06-11', 'Alma-Ata', 'Kazahstan');
	
-- данные по приезду и отъезду
 
CREATE TABLE data_train ( 
	id_guest bigint unsigned NOT NULL,
	data_arrival datetime NOT NULL comment 'дата прилета',
	data_departure datetime NOT NULL comment 'дата вылета',
	need_meet tinyint(1) NOT NULL DEFAULT '0' comment 'надо ли встречать',
	need_take tinyint(1) NOT NULL DEFAULT '0' comment 'надо ли провожать',
	PRIMARY KEY (id_guest),
	CONSTRAINT fk_data_tarin_id FOREIGN KEY (id_guest) REFERENCES guest (id)
);

INSERT INTO
  data_train (id_guest , data_arrival, data_departure, need_meet, need_take)
VALUES
	(1,'2021-05-01 10:00:00', '2021-05-11 11:00:00', DEFAULT, '1' ),
	(2,'2021-06-01 10:00:00', '2021-06-11 11:00:00', '1', DEFAULT),
	(3,'2021-07-01 10:00:00', '2021-07-11 11:00:00', DEFAULT, '1' ),
	(4,'2021-08-01 10:00:00', '2021-08-11 11:00:00', DEFAULT, DEFAULT),
	(5,'2021-05-01 10:00:00', '2021-05-11 11:00:00', DEFAULT, '1' ),
	(6,'2021-06-01 10:00:00', '2021-06-11 11:00:00', DEFAULT, '1' );

-- SELECT TIMESTAMPDIFF(DAY , data_arrival, data_departure) AS how_day FROM data_train dt WHERE id_guest = 1;
-- SELECT id_guest FROM data_train dt WHERE data_arrival > '2021-06-01 10:00:00';
-- база номеров и их статус комфортности
CREATE TABLE room (
	id_room bigint unsigned NOT NULL comment 'номер номера',
	number_room tinyint(1)  NOT NULL comment 'количетсво комнат в номере',
	status_room char(20) NOT NULL DEFAULT 'standart' comment 'статус номера (стандарт, люкс, полулюкс)',
	PRIMARY KEY (id_room),
	UNIQUE KEY id_room_idx (id_room)
) ;

INSERT INTO
  	room (id_room , number_room, status_room)
VALUES
	(1, 2, DEFAULT ),
	(2, 1, 'Lux' ),
	(3, 4, DEFAULT ),
	(4, 1, 'junior suite' ),
	(5, 2, DEFAULT );


-- стоимость номеров за сутки
CREATE TABLE price_room_day (
	id bigint UNSIGNED  NOT NULL,
	price_room int(5) NOT NULL comment 'стоимость номера',
	PRIMARY KEY (id),
	CONSTRAINT fk_price_room_day_id FOREIGN KEY (id) REFERENCES room(id_room)
) ;

INSERT INTO
  	price_room_day (id , price_room)
VALUES
	(1, 4500 ),
	(2, 7500 ),
	(3, 5500 ),
	(4, 6500 ),
	(5, 4500 );
	
-- каталог услуг
CREATE TABLE services (
	id bigint unsigned NOT NULL AUTO_INCREMENT,
	name_services varchar(50) NOT NULL comment 'название услуг',
	PRIMARY KEY (id)
)ENGINE=InnoDB;

INSERT INTO
  	services ( name_services)
VALUES
	('Сауна' ),
	('Горные лыжи' ),
	('Пешие прогулки' ),
	('Обзорная экскурсия'),
	('Тренажерный зал' ),
	('Поездка в горы' ),
	('Поездка нра океан' ),
	('Сплав по реке');

-- питание
CREATE TABLE food (
	id bigint unsigned NOT NULL AUTO_INCREMENT,
	type_food varchar (50) NOT NULL comment 'тип питания (стандарт, диетическое, без питания )',
	PRIMARY KEY (id)
)ENGINE=InnoDB;

INSERT INTO
  	food (type_food)
VALUES
	('Стандартное' ),
	('Диетическое' ),
	('Без питания' ),
	('только завтраки' );
	
-- тип отдыха
CREATE TABLE rest (
	id bigint unsigned NOT NULL AUTO_INCREMENT,
	type_rest varchar (50) NOT NULL  comment 'тип отдыха (стандарт, маршрут выходного дня)',
	PRIMARY KEY (id)
)ENGINE=InnoDB;

INSERT INTO
  	rest (type_rest)
VALUES
	('стандарт' ),
	('маршрут выходного дня' );

-- платные услуги которыми пользуется гость пансионата
CREATE TABLE use_services (
	id_guest bigint unsigned NOT NULL,
	id_services bigint unsigned NOT NULL, 
	PRIMARY KEY (id_services, id_guest),
	CONSTRAINT fk_use_services_id_services FOREIGN KEY (id_services) REFERENCES services(id),
	CONSTRAINT fk_use_services_id_guest FOREIGN KEY (id_guest) REFERENCES guest(id)
);
INSERT INTO
  	use_services ( id_guest,id_services)
VALUES
	(1, 1 ), (1, 3 ),(1, 2 ),(2, 1 ),(2, 5 ),(1, 5 ),(3, 6 ),(5, 4 ),(4,2  ),(6, 3 );
	
	
-- данные по проживанию гостя
CREATE TABLE data_guest (
	id_guest bigint unsigned NOT NULL AUTO_INCREMENT,
	id_room bigint UNSIGNED NOT NULL,-- номер проживания
	id_rest bigint UNSIGNED NOT NULL,-- тип отдыха
	id_food bigint UNSIGNED NOT NULL,-- тип питания
	CONSTRAINT fk_data_guest_id_guest FOREIGN KEY (id_guest) REFERENCES guest(id),
	CONSTRAINT fk_data_guest_room FOREIGN KEY (id_room) REFERENCES room(id_room),
	CONSTRAINT fk_data_guest_rest FOREIGN KEY (id_rest) REFERENCES rest(id),
	CONSTRAINT fk_data_guest_food FOREIGN KEY (id_food) REFERENCES food(id),
	PRIMARY KEY (id_guest)

)ENGINE=InnoDB;
INSERT INTO
  	data_guest (id_guest, id_room, id_rest, id_food )
VALUES
	(1, 1, 1, 2 ), (2, 2, 1, 2 ), (3, 1, 2, 1 ),(4, 1, 1, 2 ),(5, 4, 1, 2 ),(6, 3, 1, 2 );

