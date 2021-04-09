/*1. Пусть задан некоторый пользователь.
Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал пользователю наибольшее число сообщений. 
*/
	
SELECT CONCAT(first_name, ' ', last_name) AS name , id
	FROM users 
	WHERE id = (
			SELECT from_user_id FROM messages  WHERE to_user_id =6 
			AND (SELECT count(*) FROM messages) GROUP BY from_user_id LIMIT 1) 
			AND id IN (SELECT DISTINCT IF(to_user_id = 6, from_user_id, to_user_id) 
					FROM friend_requests 
					WHERE request_type = (SELECT id FROM friend_requests_types WHERE name = 'accepted') 
										AND (to_user_id = users.id OR from_user_id = users.id)
				);

						
/*2.*Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет*/
			
SELECT (SELECT  count(like_type) FROM posts_likes WHERE like_type = 1 AND user_id= posts.user_id) AS number_of_likes
	FROM posts 
		WHERE user_id  IN 
					(SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 18) GROUP BY number_of_likes;
		

/*3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?*/

SELECT (SELECT CASE (gender) 
	   WHEN 'f' THEN 'female'
	   WHEN 'm' THEN 'man'
	   WHEN 'x' THEN 'not defined'
	   END  
FROM profiles WHERE  user_id =posts_likes.user_id) AS gender, count(*) AS number_of_likes 
	  		FROM posts_likes  WHERE like_type = 1 GROUP BY gender LIMIT 1;

-- единственно не понятно х пол специально упущен или он учавствует  в подсчете
	  	

