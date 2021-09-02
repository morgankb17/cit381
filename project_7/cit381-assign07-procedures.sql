-- inserts data into table authorInfo
DROP PROCEDURE IF EXISTS sp_insertUser;
DELIMITER //
CREATE PROCEDURE sp_insertUser 
	(IN 
		username VARCHAR(20),
        flair_text VARCHAR(45),
        flair_text_color VARCHAR(45),
        flair_background_color VARCHAR(45)
	)
BEGIN
INSERT INTO `authorInfo` (`author`, `author_flair_text`, `author_flair_text_color`, `author_flair_background_color`) 
VALUES (username, flair_text, flair_text_color, flair_background_color);
END //
DELIMITER ;

-- inserts data into table posting
DROP PROCEDURE IF EXISTS sp_insertPostData;
DELIMITER //
CREATE PROCEDURE sp_insertPostData
	(IN 
		id VARCHAR(45),
		title VARCHAR(300),
		author VARCHAR(20),
        created_utc INT,
        score INT,
        articleLink VARCHAR(225),
        num_crossposts INT,
        num_comments INT,
        selftext MEDIUMTEXT
	)
BEGIN
INSERT INTO `posting` (`id`, `title`, `author`, `created_utc`, `score`, `articleLink`, `num_crossposts`, `num_comments`, `selftext`)
VALUES (id, title, author, created_utc, score, articleLink, num_crossposts, num_comments, selftext);
END //
DELIMITER ;