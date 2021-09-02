-- Data for table authors
INSERT INTO `alumni_website`.`authors` (`authorID`, `lastName`, `firstName`, `authorType`) VALUES ('1', 'Tarantino', 'Quentin', 'alumni');
INSERT INTO `alumni_website`.`authors` (`authorID`, `lastName`, `firstName`, `authorType`) VALUES ('2', 'Nolan', 'Christopher', 'alumni');
INSERT INTO `alumni_website`.`authors` (`authorID`, `lastName`, `firstName`, `authorType`) VALUES ('3', 'Scott', 'Ridley', 'alumni');
INSERT INTO `alumni_website`.`authors` (`authorID`, `lastName`, `firstName`, `authorType`) VALUES ('4', 'Burton', 'Tim', 'staff');
INSERT INTO `alumni_website`.`authors` (`authorID`, `lastName`, `firstName`, `authorType`) VALUES ('5', 'Sorkin', 'Aaron', 'staff');

-- Data for table article_entry
INSERT INTO `alumni_website`.`article_entry` (`articleID`, `articleAbstract`, `articleTitle`, `authorID`) VALUES ('1', 'Database competitions', 'mySQL competition', '2');
INSERT INTO `alumni_website`.`article_entry` (`articleID`, `articleTitle`, `authorID`) VALUES ('2', 'Front-end developers', '5');
INSERT INTO `alumni_website`.`article_entry` (`articleID`, `articleTitle`, `authorID`) VALUES ('3', 'Top 10 uses of databases', '1');
INSERT INTO `alumni_website`.`article_entry` (`articleID`, `articleTitle`, `authorID`) VALUES ('4', 'CIT minor application', '4');
INSERT INTO `alumni_website`.`article_entry` (`articleID`, `articleTitle`, `authorID`) VALUES ('5', 'Careers in tech', '3');

-- Data for table comments
INSERT INTO `alumni_website`.`comments` (`commentID`, `articleID`, `lastName`, `firstName`, `commentText`) VALUES ('1', '1', 'Sorkin', 'Aaron', 'Amazing!');
INSERT INTO `alumni_website`.`comments` (`commentID`, `articleID`, `lastName`, `firstName`, `commentText`) VALUES ('2', '2', 'Burton', 'Tim', 'Very cool.');
INSERT INTO `alumni_website`.`comments` (`commentID`, `articleID`, `lastName`, `firstName`, `commentText`) VALUES ('3', '3', 'Burton', 'Tim', 'Extraordinary');
INSERT INTO `alumni_website`.`comments` (`commentID`, `articleID`, `lastName`, `firstName`, `commentText`) VALUES ('4', '4', 'Schill', 'Michael', 'What unprecedented times');
INSERT INTO `alumni_website`.`comments` (`commentID`, `articleID`, `lastName`, `firstName`, `commentText`) VALUES ('5', '5', 'Knight', 'Phil', 'Money!');
