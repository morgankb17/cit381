CREATE VIEW vw_alumni_author_articles
	AS
SELECT
	a.authorID as 'ID',
	concat(a.firstName,' ', a.lastName) as 'Author',
    e.articleTitle as 'Title',
    c.commentText as 'Comment'
FROM authors a
INNER JOIN article_entry e on a.authorID = e.authorID
INNER JOIN comments c on c.articleID = e.articleID;