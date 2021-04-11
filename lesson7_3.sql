/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `from` VARCHAR(255) NOT NULL COMMENT 'name from flights',
  `to` VARCHAR(255) NOT NULL COMMENT 'name to flights',
 CONSTRAINT fk_from_id FOREIGN KEY(`from`) REFERENCES city(label),
 CONSTRAINT fk_to__id FOREIGN KEY(`to`) REFERENCES city(label)
);
INSERT INTO flights VALUES
	(NULL, 'moscow', 'omsk'),
	(NULL, 'novgorod', 'kazan'),
	(NULL, 'irkutsk', 'moscow'),
	(NULL, 'omsk', 'irkutsk'),
	(NULL, 'moscow', 'kazan');
	
DROP TABLE IF EXISTS city;
CREATE TABLE city (
  label VARCHAR(255) PRIMARY KEY COMMENT 'english name',
  name VARCHAR(255) COMMENT 'russian name'
 
  );
  
 INSERT INTO city VALUES 
 		('moscow', 'Москва'),
 		('omsk', 'Омск'),
 		('irkutsk', 'Иркутск'),
 		('kazan', 'Казань'),
 		('novgorod', 'Новгород');
 		
 SELECT
	id AS flight_id,
	(SELECT name FROM city WHERE label = `from`) AS `from`,
	(SELECT name FROM city WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;