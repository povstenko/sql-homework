CREATE DATABASE test_db
USE test_db

CREATE TABLE employee (
	emp_id int PRIMARY KEY IDENTITY,
	fname nvarchar(255),
	minit int,
	lname nvarchar(255),
	job_id int,
	job_lvl nvarchar(255),
	pub_id int FOREIGN KEY REFERENCES publishers(pub_id),--fk
	hire_date datetime,
)

CREATE TABLE publishers (
	pub_id int primary key identity,
	pub_name nvarchar(50),
	city nvarchar(50),
	[state] nvarchar(50),
	country nvarchar(50)
)

CREATE TABLE pub_info (
	pub_id int primary key identity,
	logo nvarchar(255),
	pr_info nvarchar(255)
)

CREATE TABLE titles (
	title_id int primary key identity,
	title nvarchar(255),
	[type] nvarchar(255),
	pub_id int FOREIGN KEY REFERENCES publishers(pub_id),
	price money,
	advance money,
	royalty money,
	ytd_sales int,--?
	notes nvarchar(255),
	pubdate datetime
)

CREATE TABLE sales (
	stor_id int primary key identity,
	ord_num int,
	ord_date datetime,
	qty int,
	payterms nvarchar(255),
	title_id int FOREIGN KEY REFERENCES titles(title_id)
)

CREATE TABLE stores (
	stor_id int primary key identity,
	stor_name nvarchar(50),
	stor_address nvarchar(100),
	city nvarchar(50),
	[state] nvarchar(50),
	zip nvarchar(10)
)

CREATE TABLE discounts (
	discounttype nvarchar(255),
	stor_id int FOREIGN KEY REFERENCES stores(stor_id),
	lowqty int,
	highqty int,
	discount money
)