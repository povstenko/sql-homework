USE master
CREATE DATABASE PublishDB
GO

USE PublishDB


-- create PublisherInfo + Publishers
CREATE TABLE Publishers (
	PublisherID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	[State] NVARCHAR(50),
	Country NVARCHAR(50) NOT NULL
)

CREATE TABLE PublisherInfo (
	PubInfoID INT PRIMARY KEY IDENTITY NOT NULL,
	PublisherID INT FOREIGN KEY REFERENCES Publishers(PublisherID) NOT NULL,
	Logo NVARCHAR(255),-- Path to logo image file
	Info NVARCHAR(255)-- Additional information about publisher
)


-- create Employee + Jobs
CREATE TABLE Jobs (
	JobID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Level] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	Minit INT,
	JobID INT FOREIGN KEY REFERENCES Jobs(JobID) NOT NULL,
	PublisherID INT FOREIGN KEY REFERENCES Publishers(PublisherID) NOT NULL,
	HireDate DATE NOT NULL,
)


-- create Titles
CREATE TABLE Titles (
	TitleID INT PRIMARY KEY IDENTITY NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	[Type] NVARCHAR(50) NOT NULL,
	PublisherID INT FOREIGN KEY REFERENCES Publishers(PublisherID) NOT NULL,
	Price money NOT NULL CHECK(Price>=0),
	Advance money CHECK(Advance>=0),
	Royalty money CHECK(Royalty>=0),
	SalesYearToDate DATE NOT NULL,
	Notes NVARCHAR(255),-- Additional information about title
	PublishDate DATE NOT NULL-- Date of publish
)


-- create Sales + Stores + Discounts
CREATE TABLE Stores (
	StoreID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	[State] NVARCHAR(50),
	Zip INT CHECK(Zip BETWEEN 0 AND 100000)-- Zip code, check if number is 5-digit
)

CREATE TABLE Sales (
	SaleID INT PRIMARY KEY IDENTITY NOT NULL,
	OrderNumber INT NOT NULL,
	TitleID INT FOREIGN KEY REFERENCES Titles(TitleID) NOT NULL,
	Quantity INT CHECK(Quantity>=0) NOT NULL,
	StoreID INT FOREIGN KEY REFERENCES Stores(StoreID) NOT NULL,
	PayTerms NVARCHAR(255),
	OrderDate DATE NOT NULL
)

CREATE TABLE Discounts (
	DiscountID INT PRIMARY KEY IDENTITY NOT NULL,
	StoreID INT FOREIGN KEY REFERENCES Stores(StoreID) NOT NULL,
	Discount money CHECK(Discount>=0) NOT NULL,
	[Type] NVARCHAR(50),
	LowQuantity INT CHECK(LowQuantity>=0),
	HighQuantity INT CHECK(HighQuantity>=0)
)