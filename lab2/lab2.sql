USE master
CREATE DATABASE lab2
GO

USE lab2

CREATE TABLE publishers (
	pub_id int primary key identity not null,
	pub_name nvarchar(50) not null,
	city nvarchar(50) not null,
	[state] nvarchar(50),
	country nvarchar(50) not null
)

CREATE TABLE pub_info (
	pub_id int foreign key references publishers(pub_id) not null,
	logo nvarchar(255),
	pr_info nvarchar(255)
)

CREATE TABLE employee (
	emp_id int primary key identity not null,
	fname nvarchar(50) not null,
	minit int not null,
	lname nvarchar(50) not null,
	job_id int not null,
	job_lvl nvarchar(50) not null,
	pub_id int foreign key references publishers(pub_id) not null,
	hire_date date not null,
)

CREATE TABLE titles (
	title_id int primary key identity not null,
	title nvarchar(50) not null,
	[type] nvarchar(50) not null,
	pub_id int foreign key references publishers(pub_id) not null,
	price money not null,
	advance money,
	royalty money,
	ytd_sales date not null,
	notes nvarchar(255),
	pubdate date not null
)

CREATE TABLE sales (
	stor_id int primary key identity not null,
	ord_num int not null,
	ord_date date not null,
	qty int not null,
	payterms nvarchar(255),
	title_id int foreign key references titles(title_id) not null
)

CREATE TABLE stores (
	stor_id int primary key identity not null,
	stor_name nvarchar(50) not null,
	stor_address nvarchar(100) not null,
	city nvarchar(50) not null,
	[state] nvarchar(50),
	zip nvarchar(5)
)

CREATE TABLE discounts (
	discounttype nvarchar(50) not null,
	stor_id int foreign key references stores(stor_id) not null,
	lowqty int,
	highqty int,
	discount money not null
)