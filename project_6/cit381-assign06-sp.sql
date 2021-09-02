DELIMITER //
CREATE PROCEDURE sp_delete_article(IN p_id INT)
BEGIN
DELETE FROM article_entry
WHERE articleID = p_id;
END //
DELIMITER ;