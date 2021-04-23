/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах
 users, catalogs и products в таблицу logs помещается время и дата создания записи,
 название таблицы, идентификатор первичного ключа и содержимое поля name.
 */
DROP TABLE logs;
CREATE TABLE  logs (
tablename VARCHAR(255) NOT NULL COMMENT 'Название таблицы',
extenal_id INT NOT NULL COMMENT 'Первичный ключ таблицы tablename',
name VARCHAR(255) NOT NULL COMMENT 'Поле name таблицы tablename',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) COMMENT = 'Журнал интернет-магазина' ENGINE=Archive;

DELIMITER //
CREATE TRIGGER log_after_insert_to_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('users', NEW.id, NEW.name);
END//

INSERT INTO users (name, birthday_at) VALUES ('Роман', '1995-11-05')//
DELIMITER ;
-- Триггер для таблицы Products
DELIMITER //
CREATE TRIGGER log_after_insert_to_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('products', NEW.id, NEW.name);
END//
DELIMITER ;
-- Триггер для таблицы Catalogs
DELIMITER //
CREATE TRIGGER log_after_insert_to_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('catalogs', NEW.id, NEW.name);
END//
DELIMITER ;
-- проверка заполнения журнала при изменениях таблиц
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-81', 'Процессор для настолых компьютеров, основанных на платформе Intel.', 789.00, 1);


 INSERT INTO users (name, birthday_at) VALUES
  ('Геннggадий', '1960-10-05');
 SELECT * FROM logs ;