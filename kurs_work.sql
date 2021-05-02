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
	KEY guest_last_namex (last_name),
	KEY guest_phonex (phone),
	KEY guest_email (email),
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
	PRIMARY KEY (id_guest, data_arrival, data_departure),
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


-- база номеров и их статус комфортности
CREATE TABLE room (
	id_room bigint unsigned NOT NULL comment 'номер номера',
	number_room tinyint(1)  NOT NULL comment 'количетсво комнат в номере',
	status_room char(20) NOT NULL DEFAULT 'standart' comment 'статус номера (стандарт, люкс, полулюкс)',
	PRIMARY KEY (id_room),
	KEY room_id_roomx (id_room),
	KEY room_status_roomx (status_room),
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
	(1, 4500 ),	(2, 7500 ),	(3, 5500 ),	(4, 6500 ),	(5, 4500 );
	
-- каталог услуг
CREATE TABLE services (
	id bigint unsigned NOT NULL AUTO_INCREMENT,
	name_services varchar(50) NOT NULL comment 'название услуг',
	PRIMARY KEY (id),
	KEY services_name_servicesx (name_services)
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

-- стоимость услуг за час
CREATE TABLE price_services_hours (
	id bigint UNSIGNED  NOT NULL,
	price_services int(5) NOT NULL comment 'стоимость услуги в час',
	PRIMARY KEY (id),
	CONSTRAINT fk_price_services_hours_id FOREIGN KEY (id) REFERENCES services(id)
) ;

INSERT INTO
  	price_services_hours (id , price_services)
VALUES
	(1, 2500 ),(2, 1500 ),(3, 1500 ),(4, 7500 ),(5, 4500 ),(6, 2500 ),(7, 4500 ),(8, 14500 );

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
	
-- стоимость питанрия
CREATE TABLE price_foods (
	id bigint UNSIGNED  NOT NULL,
	price_foods int(5) NOT NULL comment 'стоимость питанрия',
	PRIMARY KEY (id),
	CONSTRAINT fk_price_foods_id FOREIGN KEY (id) REFERENCES food(id)
) ;

INSERT INTO
  	price_foods (id , price_foods)
VALUES
	(1, 2500 ),(2, 1500 ),(3, 0 ),(4, 500 );


-- платные услуги которыми пользуется гость пансионата
CREATE TABLE use_services (
	id_guest bigint unsigned NOT NULL,
	id_services bigint unsigned NOT NULL,
	time_services datetime NOT NULL DEFAULT CURRENT_TIMESTAMP comment 'время начала ',
	duration_services time NOT NULL DEFAULT '1:00:00' comment'продолжительность услуги',
	PRIMARY KEY (id_services, id_guest, time_services),
	CONSTRAINT fk_use_services_id_services FOREIGN KEY (id_services) REFERENCES services(id),
	CONSTRAINT fk_use_services_id_guest FOREIGN KEY (id_guest) REFERENCES guest(id)
);
INSERT INTO
  	use_services ( id_guest,id_services,time_services, duration_services )
VALUES
	(1, 1,'2021-05-01 10:00:00', '3:00:00'  ), 
	(1, 3,'2021-06-01 10:00:00', DEFAULT  ),
	(6, 1,'2021-05-01 10:00:00', DEFAULT  ),
	(2, 1,'2021-08-01 10:00:00', DEFAULT  ),
	(2, 5,'2021-06-01 10:00:00', '4:00:00'  ),
	(1, 1,'2021-07-01 10:00:00', '2:00:00' ),
	(3, 6,'2021-05-01 10:00:00', '12:00:00'  ),
	(5, 4,'2021-04-01 10:00:00', '6:00:00'  ),
	(4, 2,'2021-08-01 10:00:00', '4:00:00'   ),
	(6, 3,'2021-09-01 10:00:00', '7:00:00'  );
	
	
-- данные по проживанию гостя
CREATE TABLE data_guest (
	id_guest bigint unsigned NOT NULL AUTO_INCREMENT,
	id_room bigint UNSIGNED NOT NULL,-- номер проживания
	id_food bigint UNSIGNED NOT NULL,-- тип питания
	CONSTRAINT fk_data_guest_id_guest FOREIGN KEY (id_guest) REFERENCES guest(id),
	CONSTRAINT fk_data_guest_room FOREIGN KEY (id_room) REFERENCES room(id_room),
	CONSTRAINT fk_data_guest_food FOREIGN KEY (id_food) REFERENCES food(id),
	PRIMARY KEY (id_guest)

)ENGINE=InnoDB;
INSERT INTO
  	data_guest (id_guest, id_room, id_food )
VALUES
	(1, 1,  2 ), (2, 2,  2 ), (3, 1,  1 ),(4, 1,  2 ),(5, 4,  2 ),(6, 3,  2 );

DROP TRIGGER IF EXISTS check_birthday_before_insert;
DROP TRIGGER IF EXISTS check_birthday_before_update;

DELIMITER //

CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON profiles
FOR EACH ROW
begin
    IF NEW.birthday >= CURRENT_DATE() THEN -- если полученная дата рождения больше текущей - отправляем сигнал об ошибке
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Birthday must be in the past!';
    END IF;
END//

CREATE TRIGGER check_birthday_before_update BEFORE UPDATE ON profiles
FOR EACH ROW
begin
    IF NEW.birthday >= CURRENT_DATE() THEN -- если полученная дата рождения больше текущей - отправляем сигнал об ошибке
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Canceled. Birthday must be in the past!';
    END IF;
END//


DELIMITER ;

/*
 -- проверка тригера на добавление ошибочного дня рождения
 INSERT INTO
  profiles (guest_id , gender, birthday, city, country)
VALUES
  (1, 'f', '2022-10-05', 'Moscow', DEFAULT);*/

-- представление показывающие прибывающих гостей  
CREATE or replace VIEW view_guest
AS 
SELECT  
	last_name,
	first_name,
	profiles.city,
	profiles.country,
	profiles.birthday,
	data_train.data_arrival,
	data_train.data_departure 
FROM guest 
    JOIN profiles 
		ON guest.id = profiles.guest_id
	JOIN data_train
		ON guest.id = data_train.id_guest 
-- WHERE DATE_FORMAT(data_train.data_arrival, '%m') > 06 comment 'можно выбрать месяц прибытия'
ORDER BY  data_train.data_arrival, last_name ;

SELECT * FROM view_guest;

-- представление в котором собрана вся информация о используемых платных услугах гостей в период пребывания
CREATE or replace VIEW view_guest_use_services
AS 
SELECT  
	last_name,
	first_name,
	services.name_services ,
	use_services.time_services,
	HOUR(use_services.duration_services) AS `time_duration` ,
	price_services_hours.price_services, 
	sum((HOUR (use_services.duration_services))*price_services_hours.price_services)  AS total_price
FROM guest 
    JOIN use_services 
		ON guest.id = use_services.id_guest 
	JOIN services 
		ON use_services.id_services= services.id 
	JOIN price_services_hours
		ON use_services.id_services = price_services_hours.id 
GROUP BY last_name, services.name_services, use_services.duration_services ;

SELECT * FROM view_guest_use_services;

