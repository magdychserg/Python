/* «Операторы, фильтрация, сортировка и ограничение». Для задания 1. */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
 /* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
  Заполните их текущими датой и временем.*/
UPDATE users  set created_at =current_timestamp, updated_at =current_timestamp;

SELECT * FROM users ;

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 2. */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 /*Таблица users была неудачно спроектирована. Записи created_at и updated_at 
  были заданы типом VARCHAR и в них долгое время помещались значения в формате
  20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохрани ввведённые ранее значения.
  */ 
 
UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i"), updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;
SELECT * FROM users;
SHOW COLUMNS FROM users;

-- 

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 3. */
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
/*В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
 если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким 
 образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться 
 в конце, после всех записей*/
 
 SELECT value FROM storehouses_products ORDER BY CASE VALUE WHEN value IS NULL THEN '65535' END, value;
  
/* «Операторы, фильтрация, сортировка и ограничение». Для задания 4. */
/* «Агрегация данных». Для заданий 1, 2. */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at)
VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '2006-08-29');
 
 -- Подсчитайте средний возраст пользователей в таблице users.
 SELECT round(avg((YEAR(CURRENT_DATE)-YEAR(`birthday_at`))-(RIGHT(CURRENT_DATE,5)<RIGHT(`birthday_at`,5)
  ))) AS `AVG.age` FROM `users`;
 
 /* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 Следует учесть, что необходимы дни недели текущего года, а не года рождения. */
 SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;

 
 /*(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
  Месяцы заданы в виде списка английских названий (may, august)*/

SELECT
    name, birthday_at, 
    CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;
   
/* «Операторы, фильтрация, сортировка и ограничение». Для задания 5. */
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
 /*(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/
SELECT * FROM catalogs  WHERE id IN (5, 1, 2) ORDER BY  FIELD(`id`, 5,1,2);

/* «Агрегация данных». Для задания 3. */
DROP TABLE IF EXISTS x;
CREATE TABLE x (id INT PRIMARY KEY);

INSERT INTO x VALUES (1), (2), (3), (4), (5);

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.

SELECT ROUND(exp(SUM(ln(id))), 0) AS factorial FROM x;

