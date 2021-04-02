-- корректируем типы медиа
UPDATE media_types SET name = 'video' WHERE id=1;
UPDATE media_types SET name = 'music' WHERE id=2;
UPDATE media_types SET name = 'image' WHERE id=3;
UPDATE media_types SET name = 'book' WHERE id=4;

SELECT * FROM media_types mt ;
SELECT * FROM messages;
-- корректируем получателей, так как сам себе не может отправлять
UPDATE messages SET to_user_id= to_user_id+1 WHERE to_user_id <100 ;
UPDATE messages SET to_user_id= to_user_id-5 WHERE to_user_id =100 ;
-- корректируем время обновление, так как оно не может быть меньше времени создания
UPDATE messages SET update_at = current_timestamp WHERE created_at > update_at ;
SELECT * FROM posts p ;
UPDATE posts p SET updated_at = current_timestamp WHERE created_at > updated_at ;
SELECT * FROM friend_requests fr ;
-- корректируем пользователей , сами себя не можем добавить в друзья
UPDATE friend_requests SET to_user_id= to_user_id-5 WHERE to_user_id =100 ;
UPDATE friend_requests SET to_user_id= to_user_id+1 WHERE to_user_id <100 ;
SELECT * FROM users u ;
-- добавляем номера телефонов из другого генератора данных в дополнительную таблицу
CREATE TABLE `users_phone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
 
  `phone` char(11) NOT NULL,

  PRIMARY KEY (`id`)
) ;
INSERT INTO `users_phone` (`phone`) VALUES ('86267556546');
INSERT INTO `users_phone` (`phone`) VALUES ('87140457115');
INSERT INTO `users_phone` (`phone`) VALUES ('83594135888');
INSERT INTO `users_phone` (`phone`) VALUES ('80098655946');
INSERT INTO `users_phone` (`phone`) VALUES ('81076017475');
INSERT INTO `users_phone` (`phone`) VALUES ('86564107886');
INSERT INTO `users_phone` (`phone`) VALUES ('82417214012');
INSERT INTO `users_phone` (`phone`) VALUES ('84659268135');
INSERT INTO `users_phone` (`phone`) VALUES ('81057882526');
INSERT INTO `users_phone` (`phone`) VALUES ('88388234889');
INSERT INTO `users_phone` (`phone`) VALUES ('86720963810');
INSERT INTO `users_phone` (`phone`) VALUES ('86480872714');
INSERT INTO `users_phone` (`phone`) VALUES ('80149678563');
INSERT INTO `users_phone` (`phone`) VALUES ('87541658207');
INSERT INTO `users_phone` (`phone`) VALUES ('84012017810');
INSERT INTO `users_phone` (`phone`) VALUES ('85761295774');
INSERT INTO `users_phone` (`phone`) VALUES ('83032266769');
INSERT INTO `users_phone` (`phone`) VALUES ('80276918914');
INSERT INTO `users_phone` (`phone`) VALUES ('84194051454');
INSERT INTO `users_phone` (`phone`) VALUES ('81334167212');
INSERT INTO `users_phone` (`phone`) VALUES ('84854093793');
INSERT INTO `users_phone` (`phone`) VALUES ('86201108310');
INSERT INTO `users_phone` (`phone`) VALUES ('80533521536');
INSERT INTO `users_phone` (`phone`) VALUES ('81823854773');
INSERT INTO `users_phone` (`phone`) VALUES ('85018102588');
INSERT INTO `users_phone` (`phone`) VALUES ('88700347300');
INSERT INTO `users_phone` (`phone`) VALUES ('80757229955');
INSERT INTO `users_phone` (`phone`) VALUES ('84146470559');
INSERT INTO `users_phone` (`phone`) VALUES ('87319973900');
INSERT INTO `users_phone` (`phone`) VALUES ('80955053988');
INSERT INTO `users_phone` (`phone`) VALUES ('89780905704');
INSERT INTO `users_phone` (`phone`) VALUES ('87092854443');
INSERT INTO `users_phone` (`phone`) VALUES ('81921526810');
INSERT INTO `users_phone` (`phone`) VALUES ('87695811677');
INSERT INTO `users_phone` (`phone`) VALUES ('83732356561');
INSERT INTO `users_phone` (`phone`) VALUES ('82438892444');
INSERT INTO `users_phone` (`phone`) VALUES ('82233914506');
INSERT INTO `users_phone` (`phone`) VALUES ('80969637358');
INSERT INTO `users_phone` (`phone`) VALUES ('88194523905');
INSERT INTO `users_phone` (`phone`) VALUES ('89644068051');
INSERT INTO `users_phone` (`phone`) VALUES ('85871510918');
INSERT INTO `users_phone` (`phone`) VALUES ('85704234748');
INSERT INTO `users_phone` (`phone`) VALUES ('86865901303');
INSERT INTO `users_phone` (`phone`) VALUES ('87838906939');
INSERT INTO `users_phone` (`phone`) VALUES ('84979544422');
INSERT INTO `users_phone` (`phone`) VALUES ('89247549832');
INSERT INTO `users_phone` (`phone`) VALUES ('87893583255');
INSERT INTO `users_phone` (`phone`) VALUES ('80837336362');
INSERT INTO `users_phone` (`phone`) VALUES ('85878064726');
INSERT INTO `users_phone` (`phone`) VALUES ('80031585404');
INSERT INTO `users_phone` (`phone`) VALUES ('84020552099');
INSERT INTO `users_phone` (`phone`) VALUES ('88149289271');
INSERT INTO `users_phone` (`phone`) VALUES ('89155979120');
INSERT INTO `users_phone` (`phone`) VALUES ('85030460690');
INSERT INTO `users_phone` (`phone`) VALUES ('89208556537');
INSERT INTO `users_phone` (`phone`) VALUES ('85054288995');
INSERT INTO `users_phone` (`phone`) VALUES ('88409453008');
INSERT INTO `users_phone` (`phone`) VALUES ('86110479764');
INSERT INTO `users_phone` (`phone`) VALUES ('88098454869');
INSERT INTO `users_phone` (`phone`) VALUES ('87760179431');
INSERT INTO `users_phone` (`phone`) VALUES ('86130347422');
INSERT INTO `users_phone` (`phone`) VALUES ('83636476883');
INSERT INTO `users_phone` (`phone`) VALUES ('82214409370');
INSERT INTO `users_phone` (`phone`) VALUES ('85499170236');
INSERT INTO `users_phone` (`phone`) VALUES ('85162400843');
INSERT INTO `users_phone` (`phone`) VALUES ('83917853085');
INSERT INTO `users_phone` (`phone`) VALUES ('88088269667');
INSERT INTO `users_phone` (`phone`) VALUES ('83502852522');
INSERT INTO `users_phone` (`phone`) VALUES ('89652263068');
INSERT INTO `users_phone` (`phone`) VALUES ('87725148069');
INSERT INTO `users_phone` (`phone`) VALUES ('86867095829');
INSERT INTO `users_phone` (`phone`) VALUES ('84842969704');
INSERT INTO `users_phone` (`phone`) VALUES ('80529078948');
INSERT INTO `users_phone` (`phone`) VALUES ('89042784825');
INSERT INTO `users_phone` (`phone`) VALUES ('81090230493');
INSERT INTO `users_phone` (`phone`) VALUES ('87824079093');
INSERT INTO `users_phone` (`phone`) VALUES ('87221753018');
INSERT INTO `users_phone` (`phone`) VALUES ('87711047957');
INSERT INTO `users_phone` (`phone`) VALUES ('87383113745');
INSERT INTO `users_phone` (`phone`) VALUES ('81479082018');
INSERT INTO `users_phone` (`phone`) VALUES ('84288813720');
INSERT INTO `users_phone` (`phone`) VALUES ('87824550485');
INSERT INTO `users_phone` (`phone`) VALUES ('85578736321');
INSERT INTO `users_phone` (`phone`) VALUES ('82260507266');
INSERT INTO `users_phone` (`phone`) VALUES ('83150503873');
INSERT INTO `users_phone` (`phone`) VALUES ('89402485722');
INSERT INTO `users_phone` (`phone`) VALUES ('87569484164');
INSERT INTO `users_phone` (`phone`) VALUES ('86256958249');
INSERT INTO `users_phone` (`phone`) VALUES ('85270906146');
INSERT INTO `users_phone` (`phone`) VALUES ('85319617103');
INSERT INTO `users_phone` (`phone`) VALUES ('80522179394');
INSERT INTO `users_phone` (`phone`) VALUES ('88444007328');
INSERT INTO `users_phone` (`phone`) VALUES ('84150197470');
INSERT INTO `users_phone` (`phone`) VALUES ('84756039882');
INSERT INTO `users_phone` (`phone`) VALUES ('87465052486');
INSERT INTO `users_phone` (`phone`) VALUES ('84120494262');
INSERT INTO `users_phone` (`phone`) VALUES ('89896097438');
INSERT INTO `users_phone` (`phone`) VALUES ('83772974142');
INSERT INTO `users_phone` (`phone`) VALUES ('81809408240');
INSERT INTO `users_phone` (`phone`) VALUES ('80723171246');


-- меняем в нашей таблице users номера телефонов на более жизненые)


UPDATE users SET phone = (SELECT phone 
		FROM users_phone WHERE  users.id=users_phone.id)  ;
-- удаляем ненужную таблицу
	DROP TABLE users_phone ;
SELECT * FROM vk1.users u ;

-- задание на курсовую. создание базы данных пансионата( проживание, лечение, экскурскии, и т.д)
