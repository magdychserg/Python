-- 2. оздайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name
CREATE DATABASE IF NOT EXISTS example;
USE example;
CREATE TABLE IF NOT EXISTS  users (id INT, 
name VARCHAR(255) COMMENT 'User name');

INSERT INTO users VALUES
  ('1', 'Nik'),
  ('2', 'Kate'),
  ('3', 'Nikoly');
 
SELECT * FROM users;
-- 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample

CREATE DATABASE IF NOT EXISTS sample;

-- из командной строки

mysqldump example > sample.sql;

-- заходим в mysql
use sample;
source sample.sql;
select * from sample;
-- 4.Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
mysqldump mysql help_keyword --where="1=1 order by help_keyword_id asc limit 100"> mysql.sql