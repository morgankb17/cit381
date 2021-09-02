DROP VIEW IF EXISTS vw_getBigScores;
CREATE VIEW vw_getBigScores AS
SELECT
	a.author,
    p.title,
    p.score,
    CONCAT(FROM_UNIXTIME(p.created_utc)) as 'posting date'
FROM
	posting p
INNER JOIN authorInfo a on p.author = a.author
WHERE p.score >= 
	(SELECT 
		AVG(score)
	FROM
		posting
	);

