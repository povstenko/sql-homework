-- insert PublisherInfo + Publishers
INSERT INTO Publishers
([Name], City, [State], Country)
VALUES
('PubUA', 'Kyiv', null, 'Ukraine'),
('BooksPub', 'Lviv', null, 'Ukraine'),
('NewYorkPublisher', 'New York', 'NY', 'USA'),
('BerlinPage', 'Berlin', null, 'German'),
('LARader', 'Los Angeles', 'LA', 'USA'),
('Int.ReadPub', 'Washington', 'WS', 'USA'),
('Official St.13', 'Los Angeles', 'LA', 'USA')
SELECT * FROM Publishers

INSERT INTO PublisherInfo
(PublisherID, Logo, info)
VALUES
(1, 'images/pubs/ua/pubua/logo.png', 'Famous Ukrainian Publisher located in Kyiv'),
(2, 'images/pubs/ua/bookspub/icon.png', 'Lviv BooksPub International'),
(3, 'images/pubs/usa/nypublisher/image.JPG', 'USA Writeres New York company'),
(4, 'images/pubs/ge/german-b-p/bp.PNG', null),
(5, null, 'losAng company #13'),
(6, 'images/pubs/international/usa/readpub', null),
(7, null, 'American LA Official Writers at state 13')
SELECT * FROM PublisherInfo


-- insert Employee + Jobs
INSERT INTO Jobs
([Name], [Level])
VALUES
('Manager', 'middle'),
('CEO', 'top'),
('Seller', 'lvl1')
SELECT * FROM Jobs

INSERT INTO Employee
([Name], Surname, Minit, JobID, PublisherID, HireDate)
VALUES
('Vitaly', 'Povsteko', null, 2, 2, '08-30-2018'),
('John', 'Doe', null, 1, 5, '10-11-2015'),
('Ozzy', 'Osbourne', 10, 1, 1, '01-10-2013'),
('Tony', 'Iommi', 1, 2, 1, '10-15-2018'),
('Corey', 'Taylor', null, 3, 4, '12-12-2019'),
('Kurt', 'Cobain', null, 3, 6, '06-10-2009'),
('Faruh', 'Bulsara', 100, 3, 7, '07-04-2013'),
('David', 'Gilmour', null, 3, 7, '04-24-2013'),
('Faruh', 'Bulsara', null, 3, 7, '03-27-2017')
SELECT * FROM Employee


-- insert Titles
INSERT INTO Titles
(Title, [Type], PublisherID, Price, Advance, Royalty, SalesYearToDate, Notes, PublishDate)
VALUES
('the Universe in the Nutshell', 'sciense', 1, 56.0, null, null, '09-10-2017', 'the Stephen Hawking pop-science phisycs book', '03-11-2003'),
('Java Tutorials', 'programming', 1, 36.75, 1.0, 10.0, '12-12-2020', 'Learn how to make a programms on Java 5', '12-12-2012'),
('Ukraine history', 'history', 2, 60.0, 1.0, 10.0, '03-04-2015', 'Ukrain history from past to our days', '12-15-2013'),
('World War 2', 'history', 5, 99.99, null, null, '08-12-2017', null, '11-15-1999'),
('Sharlock Holmes', 'detective', 5, 100.0, 5.0, 15.0, '01-01-2013', null, '08-21-1894'),
('Linus Torvalds: Just for Fun', 'autobiography', 7, 85.50, null, null, '03-24-2018', null, '06-30-2006'),
('Autobigraphy of Elon Musk', 'autobiography', 6, 85.50, 50.0, 50.0, '04-23-2018', null, '08-25-2013')
SELECT * FROM Titles


-- insert Sales + Stores + Discounts
INSERT INTO Stores
([Name], [Address], City, [State], Zip)
VALUES
('AmazonShop', 'Street addr', 'New York', 'NY', 32052),
('Walmart', 'Trump str.', 'Washington', 'WS', 14562),
('Bookinist', 'addr', 'Dallas', 'DL', 15623),
('HomeBooks', 'HomeSweet', 'Alabama', 'AL', 15623),
('LosAngeles books', 'addr', 'LA', 'LA', 15623),
('Reeadshop', 'Rynok square', 'Lviv', null, 41241),
('Auchan', 'Chornovola', 'Lviv', null, 63421)
SELECT * FROM Stores

INSERT INTO Sales
(OrderNumber, TitleID, Quantity, StoreID, PayTerms, OrderDate)
VALUES
(576, 1, 1, 1, null, '01-20-2018'),
(576, 4, 1, 1, null, '01-20-2018'),
(576, 2, 1, 1, null, '01-20-2018'),
(577, 3, 1, 5, null, '05-17-2018'),
(577, 1, 1, 5, null, '05-17-2018'),
(578, 7, 2, 7, null, '08-21-2019'),
(579, 6, 1, 2, null, '08-25-2019'),
(580, 2, 3, 3, null, '10-13-2019'),
(580, 5, 1, 3, null, '10-13-2019'),
(580, 4, 1, 3, null, '10-13-2019'),
(581, 2, 1, 4, null, '01-16-2020'),
(581, 3, 2, 4, null, '01-16-2020')
SELECT * FROM Sales

INSERT INTO Discounts
(StoreID, Discount, [Type], LowQuantity, HighQuantity)
VALUES
(1, 10.0, 'discount', 50, 500),
(4, 15.0, 'sale', 30, 60),
(3, 10.50, 'offer', 100, null),
(1, 50.0, 'discount', 10000, 20000),
(7, 5.0, 'cashback', null, null),
(5, 30.0, 'coupone', 10, null)
SELECT * FROM Discounts