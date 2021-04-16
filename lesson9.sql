
-- Транзакции, переменные, представления
/* 1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM users;-- смотрим что таблица пустая

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;-- база shop из архива задания
COMMIT;

SELECT * FROM users;-- смотрим что таблица заполнилась из базы shop

/* 2. Создайте представление, которое выводит название (name) товарной позиции из
 таблицы products и соответствующее название (name) каталога из таблицы catalogs.
 */
use shop;
CREATE OR REPLACE VIEW prods_desc(prod_id, prod_name, cat_name) AS
SELECT p.id AS prod_id, p.name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat
ON p.catalog_id = cat.id;

SELECT * FROM prods_desc;

-- Хранимые процедуры и функции, триггеры
/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
 в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
 с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

USE shop;
DROP FUNCTION IF EXISTS hello;
DELIMITER //

CREATE FUNCTION  hello ()
RETURNS TINYTEXT  DETERMINISTIC
BEGIN
	DECLARE hour INT;
	SET hour = HOUR(NOW());
	CASE
		WHEN hour BETWEEN 0 AND 5 THEN RETURN "Доброй ночи";
		WHEN hour BETWEEN 6 AND 11 THEN RETURN "Доброе утро";
		WHEN hour BETWEEN 12 AND 17 THEN RETURN "Добрый день";
		WHEN hour BETWEEN 18 AND 23 THEN RETURN "Добрый вечер";
	END CASE;
END//
DELIMITER ;
SELECT NOW(), hello();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
 Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
 значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
 были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
DELIMITER ;

/* 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

DROP FUNCTION IF EXISTS fibonacci;
DELIMITER //
CREATE FUNCTION `fibonacci`( n INT )
    RETURNS INT DETERMINISTIC
    COMMENT 'Вычисление чисел Фибоначчи'
BEGIN
	DECLARE f1 int;
	DECLARE f2 int;
	DECLARE f3 int;
   	DECLARE i int;

    SET f1 = 0;
    SET f2 = 1;
    SET f3 = 1;
    SET i = 3;
    IF n=1 OR n=2 THEN
       SET f3=1;
    ELSE
       REPEAT
           SET f1 = f2;
           SET f2 = f3;
           SET f3 = f2 + f1;
           SET i  = i +1;
       UNTIL i > n
       END REPEAT;
    END IF;
    RETURN f3;
END//

DELIMITER ;
SELECT fibonacci(10);

