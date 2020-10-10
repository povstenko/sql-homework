INSERT INTO publishers
VALUES
('pub1', 'Lviv', null, 'Ukraine'),
('qwerty', 'Dnipro', null, 'Ukraine'),
('american_publisher', 'New York', 'NY', 'USA'),
('name', 'Iowa', 'IW', 'USA')
SELECT * FROM publishers

INSERT INTO pub_info
VALUES
(1, 'img/pub/logo/pub1.png', 'publlisher in lviv'),
(2, null, 'qwerty dnipro'),
(3, 'img/pub/logo/am_pub.jpg', 'USA New York publisher #1'),
(4, 'img/pub/logo/iowa-name.png', null)
SELECT * FROM pub_info

INSERT INTO employee
VALUES
('Vitaly', 0, 'Povsteko', 1, 'qwerty', 2, '10-08-2010'),
('John', 0, 'Doe', 1, 'lvl', 3, '10-10-2020'),
('Corey', 0, 'Taylor', 10, 'lvl', 4, '11-10-1999')
SELECT * FROM employee

INSERT INTO titles
VALUES
('data', 'type1', 3, 50.0, 0.0, 10.0, '09-12-2018', 'qwerty notes about this title', '09-10-2001'),
('name', 'type2', 2, 36.75, 10.0, 1.0, '09-12-2019', 'note', '12-12-2012'),
('cats', 'animals', 1, 100.0, 5.0, 15.0, '01-07-2017', 'cats are cutes animals', '10-19-2001'),
('dogs', 'animals', 1, 85.50, 50.0, 0.50, '04-27-2017', null, '08-30-2005')
SELECT * FROM titles

INSERT INTO sales
VALUES
(1234, '01-24-2017', 1, null, 1),
(1234, '01-24-2017', 1, null, 2),
(1234, '01-24-2017', 1, null, 4),
(2245, '10-19-2018', 10, null, 3),
(3452, '05-24-2018', 1, null, 4),
(3453, '03-30-2019', 2, null, 3)
SELECT * FROM sales

INSERT INTO stores
VALUES
('walmart', 'City Street USA', 'New York', 'NY', '3250'),
('walmart', 'IOWA USA', 'Iowa', 'IW', '4214'),
('Shop', 'addr', 'Dallas', 'DL', '425'),
('books', 'Chornovola str', 'Lviv', null, '6325'),
('market', 'Rynok sqr', 'Lviv', null, '4525')
SELECT * FROM stores

INSERT INTO discounts
VALUES
('sale', 1, 30, 60, 500.0),
('coupone', 4, 10, 100, 25.0)
SELECT * FROM discounts