-- Query 1: Return the type of authors and the corresponding article title
SELECT
	a.authorType,
    e.articleTitle
FROM authors a
INNER JOIN article_entry e on a.authorID = e.authorID;

-- Query 2: Return an author's ID, their name, their article titles, and any comments they have on their articles
SELECT
	a.authorID as 'ID',
	concat(a.firstName,' ', a.lastName) as 'Author',
    e.articleTitle as 'Title',
    c.commentText as 'Comment'
FROM authors a
INNER JOIN article_entry e on a.authorID = e.authorID
INNER JOIN comments c on c.articleID = e.articleID;

-- Query 3: Return articles with their commenters and comments who's length is longer than the average comment length
SELECT
	e.articleID,
	concat(c.firstName, ' ', c.lastName) as 'Commenter',
    c.commentText as 'Comment'
FROM comments c
INNER JOIN article_entry e on e.articleID = c.articleID
WHERE LENGTH(commentText) >=
	(SELECT avg(LENGTH(commentText)) FROM comments);

-- Query 4: Return the data from the authors table where an author has a article title longer than 18 characters
SELECT * FROM authors
WHERE authorID IN
(SELECT authorID FROM article_entry WHERE LENGTH(articleTitle) > 18);

-- Query 5: Return authors who include or don't include an abstract for their written articles
SELECT
	concat(a.firstName,' ', a.lastName) as 'Author',
    e.articleAbstract as 'Abstract'
FROM authors a
LEFT JOIN article_entry e ON a.authorID = e.authorID