
CREATE DATABASE SalesOrders
go
USE SalesOrders

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDERS') and o.name = 'FK_ORDERS_CUSTOMERS_CUSTOMER')
alter table ORDERS
   drop constraint FK_ORDERS_CUSTOMERS_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDERS') and o.name = 'FK_ORDERS_EMPLOEEYS_EMPLOYEE')
alter table ORDERS
   drop constraint FK_ORDERS_EMPLOEEYS_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDER_DETAILS') and o.name = 'FK_ORDER_DE_DETAILS_P_PRODUCTS')
alter table ORDER_DETAILS
   drop constraint FK_ORDER_DE_DETAILS_P_PRODUCTS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDER_DETAILS') and o.name = 'FK_ORDER_DE_ORDER_DET_ORDERS')
alter table ORDER_DETAILS
   drop constraint FK_ORDER_DE_ORDER_DET_ORDERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTS') and o.name = 'FK_PRODUCTS_CATEGORIE_CATEGORI')
alter table PRODUCTS
   drop constraint FK_PRODUCTS_CATEGORIE_CATEGORI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCT_VENDORS') and o.name = 'FK_PRODUCT__PRODUCTS__PRODUCTS')
alter table PRODUCT_VENDORS
   drop constraint FK_PRODUCT__PRODUCTS__PRODUCTS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCT_VENDORS') and o.name = 'FK_PRODUCT__VENDORS_P_VENDORS')
alter table PRODUCT_VENDORS
   drop constraint FK_PRODUCT__VENDORS_P_VENDORS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATEGORIES')
            and   type = 'U')
   drop table CATEGORIES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMERS')
            and   type = 'U')
   drop table CUSTOMERS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EMPLOYEES')
            and   type = 'U')
   drop table EMPLOYEES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDERS')
            and   name  = 'EMPLOEEYS_ORDERS_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDERS.EMPLOEEYS_ORDERS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDERS')
            and   name  = 'CUSTOMERS_ORDERS_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDERS.CUSTOMERS_ORDERS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ORDERS')
            and   type = 'U')
   drop table ORDERS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDER_DETAILS')
            and   name  = 'DETAILS_PRODUCTS_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDER_DETAILS.DETAILS_PRODUCTS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDER_DETAILS')
            and   name  = 'ORDER_DETAILS_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDER_DETAILS.ORDER_DETAILS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ORDER_DETAILS')
            and   type = 'U')
   drop table ORDER_DETAILS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCTS')
            and   name  = 'CATEGORIES_PRODUCTS_FK'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCTS.CATEGORIES_PRODUCTS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCTS')
            and   type = 'U')
   drop table PRODUCTS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCT_VENDORS')
            and   name  = 'VENDORS_PRODUCTS_FK'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCT_VENDORS.VENDORS_PRODUCTS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCT_VENDORS')
            and   name  = 'PRODUCTS_VENDORS_FK'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCT_VENDORS.PRODUCTS_VENDORS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCT_VENDORS')
            and   type = 'U')
   drop table PRODUCT_VENDORS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VENDORS')
            and   type = 'U')
   drop table VENDORS
go

/*==============================================================*/
/* Table: CATEGORIES                                            */
/*==============================================================*/
create table CATEGORIES (
   CATEGORYID           bigint               not null,
   CATEGORYDESCRIPTION  varchar(1024)        null,
   constraint PK_CATEGORIES primary key nonclustered (CATEGORYID)
)
go
INSERT INTO Categories
  VALUES (1, 'Accessories')
INSERT INTO Categories
  VALUES (2, 'Bikes')
INSERT INTO Categories
  VALUES (3, 'Clothing')
INSERT INTO Categories
  VALUES (4, 'Components')
INSERT INTO Categories
  VALUES (5, 'Car racks')
INSERT INTO Categories
  VALUES (6, 'Wheels')

/*==============================================================*/
/* Table: CUSTOMERS                                             */
/*==============================================================*/
create table CUSTOMERS (
   CUSTOMERID           bigint               not null,
   CUSTFIRSTNAME        char(50)             null,
   CUSTLASTNAME         char(50)             null,
   CUSTSTREETADDRESS    varchar(50)          null,
   CUSTCITY             varchar(50)          null,
   CUSTSTATE            char(30)             null,
   CUSTZIPCODE          bigint               null,
   CUSTAREACODE         bigint               null,
   CUSTPHONENUMBER      varchar(20)          null,
   constraint PK_CUSTOMERS primary key nonclustered (CUSTOMERID)
)
go

INSERT INTO Customers
  VALUES (1001, 'Suzanne', 'Viescas', '15127 NE 24th, #383', 
   'Redmond', 'WA', '98052', 425, '555-2686')
INSERT INTO Customers
  VALUES (1002, 'Will', 'Thompson', '122 Spring River Drive', 
   'Duvall', 'WA', '98019', 425, '555-2681')
INSERT INTO Customers
  VALUES (1003, 'Gary', 'Hallmark', 'Route 2, Box 203B', 
   'Auburn', 'WA', '98002', 253, '555-2676')
INSERT INTO Customers
  VALUES (1004, 'Michael', 'Davolio', '672 Lamont Ave', 
   'Houston', 'TX', '77201', 713, '555-2491')
INSERT INTO Customers
  VALUES (1005, 'Kenneth', 'Peacock', '4110 Old Redmond Rd.', 
   'Redmond', 'WA', '98052', 425, '555-2506')
INSERT INTO Customers
  VALUES (1006, 'John', 'Viescas', '15127 NE 24th, #383', 
   'Redmond', 'WA', '98052', 425, '555-2511')
INSERT INTO Customers
  VALUES (1007, 'Laura', 'Callahan', '901 Pine Avenue', 
   'Portland', 'OR', '97208', 503, '555-2526')
INSERT INTO Customers
  VALUES (1008, 'Neil', 'Patterson', '233 West Valley Hwy', 
   'San Diego', 'CA', '92199', 619, '555-2541')
INSERT INTO Customers
  VALUES (1009, 'Jeffrey', 'Davolio', '507 - 20th Ave. E.
Apt. 2A', 
   'Seattle', 'WA', '98115', 206, '555-2586')
INSERT INTO Customers
  VALUES (1010, 'Margaret', 'Peacock', '667 Red River Road', 
   'Austin', 'TX', '78710', 512, '555-2571')
INSERT INTO Customers
  VALUES (1011, 'Alaina', 'Hallmark', 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', 425, '555-2631')
INSERT INTO Customers
  VALUES (1012, 'Amelia', 'Buchanan', '13920 S.E. 40th Street', 
   'Bellevue', 'WA', '98006', 425, '555-2556')
INSERT INTO Customers
  VALUES (1013, 'Rachel', 'Patterson', '2114 Longview Lane', 
   'San Diego', 'CA', '92199', 619, '555-2546')
INSERT INTO Customers
  VALUES (1014, 'John', 'Leverling', '611 Alpine Drive', 
   'Palm Springs', 'CA', '92263', 760, '555-2611')
INSERT INTO Customers
  VALUES (1015, 'Samuel', 'Peacock', '2601 Seaview Lane', 
   'Chico', 'CA', '95926', 530, '555-2616')
INSERT INTO Customers
  VALUES (1016, 'David', 'Callahan', '101 NE 88th', 
   'Salem', 'OR', '97301', 503, '555-2636')
INSERT INTO Customers
  VALUES (1017, 'Andrea', 'Buchanan', '66 Spring Valley Drive', 
   'Medford', 'OR', '97501', 541, '555-2641')
INSERT INTO Customers
  VALUES (1018, 'David', 'Smith', '311 20th Ave. N.E.', 
   'Fremont', 'CA', '94538', 510, '555-2646')
INSERT INTO Customers
  VALUES (1019, 'Zachary', 'Ehrlich', '12330 Kingman Drive', 
   'Glendale', 'CA', '91209', 818, '555-2721')
INSERT INTO Customers
  VALUES (1020, 'Joyce', 'Bonnicksen', '2424 Thames Drive', 
   'Bellevue', 'WA', '98006', 425, '555-2726')
INSERT INTO Customers
  VALUES (1021, 'Estella', 'Pundt', '2500 Rosales Lane', 
   'Dallas', 'TX', '75260', 972, '555-9938')
INSERT INTO Customers
  VALUES (1022, 'Gregory', 'Piercy', '4501 Wetland Road', 
   'Long Beach', 'CA', '90809', 562, '555-0037')
INSERT INTO Customers
  VALUES (1023, 'Julia', 'Schnebly', '2343 Harmony Lane', 
   'Seattle', 'WA', '99837', 206, '555-9936')
INSERT INTO Customers
  VALUES (1024, 'Mark', 'Rosales', '323 Advocate Lane', 
   'El Paso', 'TX', '79915', 915, '555-2286')
INSERT INTO Customers
  VALUES (1025, 'Consuelo', 'Maynez', '3445 Cheyenne Road', 
   'El Paso', 'TX', '79915', 915, '555-2291')
INSERT INTO Customers
  VALUES (1026, 'Ryan', 'Ehrlich', '455 West Palm Ave', 
   'San Antonio', 'TX', '78284', 210, '555-2311')
INSERT INTO Customers
  VALUES (1027, 'Allan', 'Davis', '877 145th Ave SE', 
   'Portland', 'OR', '97208', 503, '555-2316')

/*==============================================================*/
/* Table: EMPLOYEES                                             */
/*==============================================================*/
create table EMPLOYEES (
   EMPLOYEEID           bigint               not null,
   EMPFIRSTNAME         char(50)             null,
   EMPLASTNAME          char(50)             null,
   EMPSTREETADDRESS     varchar(50)          null,
   EMPCITY              char(50)             null,
   EMPSTATTE            char(50)             null,
   EMPZIPCODE           bigint               null,
   EMPAREACODE          bigint               null,
   EMPPHONENUMBER       varchar(20)          null,
   constraint PK_EMPLOYEES primary key nonclustered (EMPLOYEEID)
)
go
INSERT INTO Employees
  VALUES (701, 'Ann', 'Patterson', '16 Maple Lane', 
   'Auburn', 'WA', '98002', 253, '555-2591')
INSERT INTO Employees
  VALUES (702, 'Mary', 'Thompson', '122 Spring River Drive', 
   'Duvall', 'WA', '98019', 425, '555-2516')
INSERT INTO Employees
  VALUES (703, 'Thomas', 'Fuller', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', 253, '555-2581')
INSERT INTO Employees
  VALUES (704, 'Janet', 'Leverling', '722 Moss Bay Blvd.', 
   'Kirkland', 'WA', '98033', 425, '555-2576')
INSERT INTO Employees
  VALUES (705, 'John', 'Callahan', '4726 - 11th Ave. N.E.', 
   'Seattle', 'WA', '98105', 206, '555-2561')
INSERT INTO Employees
  VALUES (706, 'David', 'Viescas', '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', 425, '555-2661')
INSERT INTO Employees
  VALUES (707, 'Peter', 'Davolio', '507 - 20th Ave. E.
Apt. 2A', 
   'Seattle', 'WA', '98105', 206, '555-2601')
INSERT INTO Employees
  VALUES (708, 'Susan', 'McLain', '511 Lenora Ave', 
   'Bellevue', 'WA', '98006', 425, '555-2301')

/*==============================================================*/
/* Table: ORDERS                                                */
/*==============================================================*/
create table ORDERS (
   ORDERNUMBER          bigint               not null,
   ORDERDATE            datetime             null,
   SHIPDATE             datetime             null,
   CUSTOMERID           bigint               not null,
   EMPLOYEEID           bigint               not null,
   constraint PK_ORDERS primary key nonclustered (ORDERNUMBER)
)
go

INSERT INTO Orders
  VALUES (1, '1999-07-01', '1999-07-04', 1018, 707)
INSERT INTO Orders
  VALUES (2, '1999-07-01', '1999-07-03', 1001, 703)
INSERT INTO Orders
  VALUES (3, '1999-07-01', '1999-07-04', 1002, 707)
INSERT INTO Orders
  VALUES (4, '1999-07-01', '1999-07-03', 1009, 703)
INSERT INTO Orders
  VALUES (5, '1999-07-01', '1999-07-01', 1024, 708)
INSERT INTO Orders
  VALUES (6, '1999-07-01', '1999-07-05', 1014, 702)
INSERT INTO Orders
  VALUES (7, '1999-07-01', '1999-07-04', 1001, 708)
INSERT INTO Orders
  VALUES (8, '1999-07-01', '1999-07-01', 1003, 703)
INSERT INTO Orders
  VALUES (9, '1999-07-01', '1999-07-04', 1007, 708)
INSERT INTO Orders
  VALUES (10, '1999-07-01', '1999-07-04', 1012, 701)
INSERT INTO Orders
  VALUES (11, '1999-07-02', '1999-07-04', 1020, 706)
INSERT INTO Orders
  VALUES (12, '1999-07-02', '1999-07-05', 1024, 706)
INSERT INTO Orders
  VALUES (13, '1999-07-02', '1999-07-02', 1024, 704)
INSERT INTO Orders
  VALUES (14, '1999-07-02', '1999-07-03', 1013, 704)
INSERT INTO Orders
  VALUES (15, '1999-07-02', '1999-07-06', 1004, 701)
INSERT INTO Orders
  VALUES (16, '1999-07-02', '1999-07-06', 1001, 707)
INSERT INTO Orders
  VALUES (17, '1999-07-02', '1999-07-03', 1014, 702)
INSERT INTO Orders
  VALUES (18, '1999-07-02', '1999-07-03', 1016, 708)
INSERT INTO Orders
  VALUES (19, '1999-07-02', '1999-07-06', 1027, 707)
INSERT INTO Orders
  VALUES (20, '1999-07-02', '1999-07-02', 1011, 706)
INSERT INTO Orders
  VALUES (21, '1999-07-03', '1999-07-03', 1014, 702)
INSERT INTO Orders
  VALUES (22, '1999-07-03', '1999-07-07', 1026, 702)
INSERT INTO Orders
  VALUES (23, '1999-07-03', '1999-07-04', 1017, 705)
INSERT INTO Orders
  VALUES (24, '1999-07-03', '1999-07-05', 1010, 705)
INSERT INTO Orders
  VALUES (25, '1999-07-03', '1999-07-04', 1017, 708)
INSERT INTO Orders
  VALUES (26, '1999-07-04', '1999-07-08', 1013, 707)
INSERT INTO Orders
  VALUES (27, '1999-07-04', '1999-07-05', 1014, 703)
INSERT INTO Orders
  VALUES (28, '1999-07-04', '1999-07-08', 1004, 703)
INSERT INTO Orders
  VALUES (29, '1999-07-04', '1999-07-08', 1015, 707)
INSERT INTO Orders
  VALUES (30, '1999-07-04', '1999-07-08', 1010, 708)
INSERT INTO Orders
  VALUES (31, '1999-07-05', '1999-07-09', 1014, 701)
INSERT INTO Orders
  VALUES (32, '1999-07-05', '1999-07-09', 1012, 704)
INSERT INTO Orders
  VALUES (33, '1999-07-05', '1999-07-06', 1024, 704)
INSERT INTO Orders
  VALUES (34, '1999-07-06', '1999-07-07', 1010, 705)
INSERT INTO Orders
  VALUES (35, '1999-07-06', '1999-07-06', 1012, 701)
INSERT INTO Orders
  VALUES (36, '1999-07-06', '1999-07-07', 1007, 705)
INSERT INTO Orders
  VALUES (37, '1999-07-07', '1999-07-11', 1027, 702)
INSERT INTO Orders
  VALUES (38, '1999-07-07', '1999-07-11', 1017, 702)
INSERT INTO Orders
  VALUES (39, '1999-07-07', '1999-07-10', 1004, 704)
INSERT INTO Orders
  VALUES (40, '1999-07-07', '1999-07-07', 1017, 703)
INSERT INTO Orders
  VALUES (41, '1999-07-07', '1999-07-07', 1008, 706)
INSERT INTO Orders
  VALUES (42, '1999-07-07', '1999-07-10', 1012, 704)
INSERT INTO Orders
  VALUES (43, '1999-07-07', '1999-07-11', 1020, 705)
INSERT INTO Orders
  VALUES (44, '1999-07-07', '1999-07-08', 1005, 701)
INSERT INTO Orders
  VALUES (45, '1999-07-08', '1999-07-08', 1008, 708)
INSERT INTO Orders
  VALUES (46, '1999-07-08', '1999-07-09', 1018, 707)
INSERT INTO Orders
  VALUES (47, '1999-07-08', '1999-07-10', 1023, 708)
INSERT INTO Orders
  VALUES (48, '1999-07-08', '1999-07-11', 1004, 707)
INSERT INTO Orders
  VALUES (49, '1999-07-08', '1999-07-08', 1015, 704)
INSERT INTO Orders
  VALUES (50, '1999-07-08', '1999-07-12', 1002, 704)
INSERT INTO Orders
  VALUES (51, '1999-07-08', '1999-07-08', 1018, 707)
INSERT INTO Orders
  VALUES (52, '1999-07-09', '1999-07-11', 1001, 701)
INSERT INTO Orders
  VALUES (53, '1999-07-09', '1999-07-09', 1004, 706)
INSERT INTO Orders
  VALUES (54, '1999-07-09', '1999-07-09', 1007, 707)
INSERT INTO Orders
  VALUES (55, '1999-07-09', '1999-07-11', 1001, 707)
INSERT INTO Orders
  VALUES (56, '1999-07-09', '1999-07-12', 1014, 702)
INSERT INTO Orders
  VALUES (57, '1999-07-09', '1999-07-10', 1009, 703)
INSERT INTO Orders
  VALUES (58, '1999-07-09', '1999-07-13', 1006, 701)
INSERT INTO Orders
  VALUES (59, '1999-07-09', '1999-07-09', 1004, 704)
INSERT INTO Orders
  VALUES (60, '1999-07-09', '1999-07-13', 1013, 708)
INSERT INTO Orders
  VALUES (61, '1999-07-09', '1999-07-10', 1009, 706)
INSERT INTO Orders
  VALUES (62, '1999-07-10', '1999-07-13', 1003, 703)
INSERT INTO Orders
  VALUES (63, '1999-07-10', '1999-07-13', 1023, 708)
INSERT INTO Orders
  VALUES (64, '1999-07-10', '1999-07-14', 1027, 708)
INSERT INTO Orders
  VALUES (65, '1999-07-10', '1999-07-13', 1021, 703)
INSERT INTO Orders
  VALUES (66, '1999-07-10', '1999-07-11', 1026, 703)
INSERT INTO Orders
  VALUES (67, '1999-07-10', '1999-07-11', 1025, 702)
INSERT INTO Orders
  VALUES (68, '1999-07-11', '1999-07-12', 1027, 702)
INSERT INTO Orders
  VALUES (69, '1999-07-11', '1999-07-13', 1021, 705)
INSERT INTO Orders
  VALUES (70, '1999-07-12', '1999-07-16', 1016, 706)
INSERT INTO Orders
  VALUES (71, '1999-07-12', '1999-07-14', 1016, 708)
INSERT INTO Orders
  VALUES (72, '1999-07-12', '1999-07-16', 1003, 708)
INSERT INTO Orders
  VALUES (73, '1999-07-12', '1999-07-15', 1005, 705)
INSERT INTO Orders
  VALUES (74, '1999-07-12', '1999-07-13', 1002, 703)
INSERT INTO Orders
  VALUES (75, '1999-07-12', '1999-07-14', 1014, 706)
INSERT INTO Orders
  VALUES (76, '1999-07-12', '1999-07-15', 1012, 703)
INSERT INTO Orders
  VALUES (77, '1999-07-12', '1999-07-13', 1008, 706)
INSERT INTO Orders
  VALUES (78, '1999-07-13', '1999-07-16', 1007, 701)
INSERT INTO Orders
  VALUES (79, '1999-07-13', '1999-07-17', 1006, 703)
INSERT INTO Orders
  VALUES (80, '1999-07-13', '1999-07-16', 1025, 708)
INSERT INTO Orders
  VALUES (81, '1999-07-13', '1999-07-13', 1006, 705)
INSERT INTO Orders
  VALUES (82, '1999-07-13', '1999-07-16', 1005, 701)
INSERT INTO Orders
  VALUES (83, '1999-07-13', '1999-07-16', 1021, 708)
INSERT INTO Orders
  VALUES (84, '1999-07-13', '1999-07-13', 1022, 707)
INSERT INTO Orders
  VALUES (85, '1999-07-13', '1999-07-15', 1015, 705)
INSERT INTO Orders
  VALUES (86, '1999-07-13', '1999-07-16', 1009, 701)
INSERT INTO Orders
  VALUES (87, '1999-07-13', '1999-07-14', 1002, 704)
INSERT INTO Orders
  VALUES (88, '1999-07-14', '1999-07-17', 1026, 707)
INSERT INTO Orders
  VALUES (89, '1999-07-14', '1999-07-17', 1003, 703)
INSERT INTO Orders
  VALUES (90, '1999-07-14', '1999-07-15', 1017, 706)
INSERT INTO Orders
  VALUES (91, '1999-07-14', '1999-07-18', 1010, 703)
INSERT INTO Orders
  VALUES (92, '1999-07-14', '1999-07-17', 1011, 704)
INSERT INTO Orders
  VALUES (93, '1999-07-14', '1999-07-17', 1023, 707)
INSERT INTO Orders
  VALUES (94, '1999-07-14', '1999-07-14', 1010, 701)
INSERT INTO Orders
  VALUES (95, '1999-07-15', '1999-07-19', 1021, 704)
INSERT INTO Orders
  VALUES (96, '1999-07-15', '1999-07-16', 1025, 703)
INSERT INTO Orders
  VALUES (97, '1999-07-15', '1999-07-18', 1026, 703)
INSERT INTO Orders
  VALUES (98, '1999-07-15', '1999-07-16', 1009, 706)
INSERT INTO Orders
  VALUES (99, '1999-07-15', '1999-07-18', 1002, 703)
INSERT INTO Orders
  VALUES (100, '1999-07-15', '1999-07-16', 1002, 707)
INSERT INTO Orders
  VALUES (101, '1999-07-15', '1999-07-18', 1023, 707)
INSERT INTO Orders
  VALUES (102, '1999-07-15', '1999-07-17', 1010, 705)
INSERT INTO Orders
  VALUES (103, '1999-07-15', '1999-07-16', 1025, 702)
INSERT INTO Orders
  VALUES (104, '1999-07-15', '1999-07-15', 1017, 708)
INSERT INTO Orders
  VALUES (105, '1999-07-16', '1999-07-18', 1005, 704)
INSERT INTO Orders
  VALUES (106, '1999-07-16', '1999-07-20', 1020, 708)
INSERT INTO Orders
  VALUES (107, '1999-07-16', '1999-07-20', 1001, 703)
INSERT INTO Orders
  VALUES (108, '1999-07-16', '1999-07-19', 1004, 701)
INSERT INTO Orders
  VALUES (109, '1999-07-16', '1999-07-16', 1013, 703)
INSERT INTO Orders
  VALUES (110, '1999-07-17', '1999-07-19', 1015, 708)
INSERT INTO Orders
  VALUES (111, '1999-07-17', '1999-07-21', 1021, 707)
INSERT INTO Orders
  VALUES (112, '1999-07-18', '1999-07-19', 1009, 703)
INSERT INTO Orders
  VALUES (113, '1999-07-18', '1999-07-22', 1010, 702)
INSERT INTO Orders
  VALUES (114, '1999-07-18', '1999-07-22', 1011, 706)
INSERT INTO Orders
  VALUES (115, '1999-07-19', '1999-07-21', 1003, 704)
INSERT INTO Orders
  VALUES (116, '1999-07-19', '1999-07-21', 1004, 701)
INSERT INTO Orders
  VALUES (117, '1999-07-20', '1999-07-22', 1005, 705)
INSERT INTO Orders
  VALUES (118, '1999-07-20', '1999-07-22', 1021, 708)
INSERT INTO Orders
  VALUES (119, '1999-07-20', '1999-07-20', 1013, 701)
INSERT INTO Orders
  VALUES (120, '1999-07-20', '1999-07-21', 1024, 702)
INSERT INTO Orders
  VALUES (121, '1999-07-20', '1999-07-21', 1025, 701)
INSERT INTO Orders
  VALUES (122, '1999-07-20', '1999-07-24', 1009, 707)
INSERT INTO Orders
  VALUES (123, '1999-07-20', '1999-07-22', 1004, 704)
INSERT INTO Orders
  VALUES (124, '1999-07-21', '1999-07-23', 1007, 705)
INSERT INTO Orders
  VALUES (125, '1999-07-21', '1999-07-21', 1011, 707)
INSERT INTO Orders
  VALUES (126, '1999-07-22', '1999-07-24', 1016, 708)
INSERT INTO Orders
  VALUES (127, '1999-07-22', '1999-07-25', 1009, 705)
INSERT INTO Orders
  VALUES (128, '1999-07-22', '1999-07-26', 1022, 708)
INSERT INTO Orders
  VALUES (129, '1999-07-22', '1999-07-22', 1007, 708)
INSERT INTO Orders
  VALUES (130, '1999-07-22', '1999-07-24', 1011, 705)
INSERT INTO Orders
  VALUES (131, '1999-07-22', '1999-07-22', 1014, 706)
INSERT INTO Orders
  VALUES (132, '1999-07-22', '1999-07-25', 1007, 705)
INSERT INTO Orders
  VALUES (133, '1999-07-22', '1999-07-22', 1027, 706)
INSERT INTO Orders
  VALUES (134, '1999-07-22', '1999-07-24', 1003, 703)
INSERT INTO Orders
  VALUES (135, '1999-07-23', '1999-07-26', 1005, 701)
INSERT INTO Orders
  VALUES (136, '1999-07-23', '1999-07-26', 1008, 707)
INSERT INTO Orders
  VALUES (137, '1999-07-23', '1999-07-23', 1001, 706)
INSERT INTO Orders
  VALUES (138, '1999-07-24', '1999-07-27', 1001, 702)
INSERT INTO Orders
  VALUES (139, '1999-07-24', '1999-07-26', 1024, 704)
INSERT INTO Orders
  VALUES (140, '1999-07-24', '1999-07-24', 1002, 706)
INSERT INTO Orders
  VALUES (141, '1999-07-24', '1999-07-27', 1014, 706)
INSERT INTO Orders
  VALUES (142, '1999-07-25', '1999-07-29', 1018, 702)
INSERT INTO Orders
  VALUES (143, '1999-07-25', '1999-07-28', 1021, 706)
INSERT INTO Orders
  VALUES (144, '1999-07-25', '1999-07-29', 1018, 704)
INSERT INTO Orders
  VALUES (145, '1999-07-26', '1999-07-30', 1027, 701)
INSERT INTO Orders
  VALUES (146, '1999-07-26', '1999-07-26', 1021, 708)
INSERT INTO Orders
  VALUES (147, '1999-07-26', '1999-07-26', 1026, 708)
INSERT INTO Orders
  VALUES (148, '1999-07-26', '1999-07-30', 1027, 704)
INSERT INTO Orders
  VALUES (149, '1999-07-27', '1999-07-28', 1004, 707)
INSERT INTO Orders
  VALUES (150, '1999-07-27', '1999-07-27', 1024, 701)
INSERT INTO Orders
  VALUES (151, '1999-07-27', '1999-07-28', 1001, 707)
INSERT INTO Orders
  VALUES (152, '1999-07-28', '1999-08-01', 1017, 704)
INSERT INTO Orders
  VALUES (153, '1999-07-29', '1999-07-30', 1003, 702)
INSERT INTO Orders
  VALUES (154, '1999-07-29', '1999-08-01', 1001, 703)
INSERT INTO Orders
  VALUES (155, '1999-07-29', '1999-08-02', 1004, 703)
INSERT INTO Orders
  VALUES (156, '1999-07-29', '1999-07-30', 1004, 703)
INSERT INTO Orders
  VALUES (157, '1999-07-29', '1999-07-31', 1010, 707)
INSERT INTO Orders
  VALUES (158, '1999-07-29', '1999-08-02', 1021, 705)
INSERT INTO Orders
  VALUES (159, '1999-07-29', '1999-08-02', 1005, 707)
INSERT INTO Orders
  VALUES (160, '1999-07-30', '1999-07-30', 1021, 706)
INSERT INTO Orders
  VALUES (161, '1999-07-30', '1999-07-30', 1011, 707)
INSERT INTO Orders
  VALUES (162, '1999-07-30', '1999-07-31', 1021, 704)
INSERT INTO Orders
  VALUES (163, '1999-07-30', '1999-07-30', 1004, 707)
INSERT INTO Orders
  VALUES (164, '1999-07-31', '1999-08-03', 1021, 707)
INSERT INTO Orders
  VALUES (165, '1999-08-01', '1999-08-01', 1017, 702)
INSERT INTO Orders
  VALUES (166, '1999-08-02', '1999-08-05', 1022, 706)
INSERT INTO Orders
  VALUES (167, '1999-08-02', '1999-08-02', 1017, 706)
INSERT INTO Orders
  VALUES (168, '1999-08-02', '1999-08-04', 1027, 706)
INSERT INTO Orders
  VALUES (169, '1999-08-02', '1999-08-05', 1025, 708)
INSERT INTO Orders
  VALUES (170, '1999-08-03', '1999-08-03', 1004, 704)
INSERT INTO Orders
  VALUES (171, '1999-08-03', '1999-08-04', 1026, 707)
INSERT INTO Orders
  VALUES (172, '1999-08-03', '1999-08-06', 1018, 704)
INSERT INTO Orders
  VALUES (173, '1999-08-03', '1999-08-03', 1015, 704)
INSERT INTO Orders
  VALUES (174, '1999-08-03', '1999-08-07', 1006, 703)
INSERT INTO Orders
  VALUES (175, '1999-08-03', '1999-08-06', 1013, 706)
INSERT INTO Orders
  VALUES (176, '1999-08-03', '1999-08-03', 1025, 701)
INSERT INTO Orders
  VALUES (177, '1999-08-03', '1999-08-07', 1008, 706)
INSERT INTO Orders
  VALUES (178, '1999-08-03', '1999-08-06', 1022, 702)
INSERT INTO Orders
  VALUES (179, '1999-08-03', '1999-08-07', 1017, 708)
INSERT INTO Orders
  VALUES (180, '1999-08-04', '1999-08-07', 1015, 708)
INSERT INTO Orders
  VALUES (181, '1999-08-04', '1999-08-04', 1017, 708)
INSERT INTO Orders
  VALUES (182, '1999-08-04', '1999-08-05', 1002, 702)
INSERT INTO Orders
  VALUES (183, '1999-08-04', '1999-08-04', 1020, 708)
INSERT INTO Orders
  VALUES (184, '1999-08-04', '1999-08-08', 1023, 707)
INSERT INTO Orders
  VALUES (185, '1999-08-04', '1999-08-08', 1017, 702)
INSERT INTO Orders
  VALUES (186, '1999-08-04', '1999-08-04', 1002, 704)
INSERT INTO Orders
  VALUES (187, '1999-08-05', '1999-08-06', 1022, 702)
INSERT INTO Orders
  VALUES (188, '1999-08-05', '1999-08-06', 1002, 706)
INSERT INTO Orders
  VALUES (189, '1999-08-05', '1999-08-06', 1012, 702)
INSERT INTO Orders
  VALUES (190, '1999-08-05', '1999-08-09', 1024, 708)
INSERT INTO Orders
  VALUES (191, '1999-08-05', '1999-08-06', 1015, 701)
INSERT INTO Orders
  VALUES (192, '1999-08-05', '1999-08-08', 1022, 702)
INSERT INTO Orders
  VALUES (193, '1999-08-05', '1999-08-05', 1025, 708)
INSERT INTO Orders
  VALUES (194, '1999-08-05', '1999-08-07', 1017, 708)
INSERT INTO Orders
  VALUES (195, '1999-08-06', '1999-08-09', 1025, 703)
INSERT INTO Orders
  VALUES (196, '1999-08-06', '1999-08-10', 1009, 707)
INSERT INTO Orders
  VALUES (197, '1999-08-06', '1999-08-09', 1002, 703)
INSERT INTO Orders
  VALUES (198, '1999-08-06', '1999-08-08', 1002, 703)
INSERT INTO Orders
  VALUES (199, '1999-08-06', '1999-08-08', 1008, 707)
INSERT INTO Orders
  VALUES (200, '1999-08-06', '1999-08-07', 1026, 706)
INSERT INTO Orders
  VALUES (201, '1999-08-06', '1999-08-07', 1018, 701)
INSERT INTO Orders
  VALUES (202, '1999-08-06', '1999-08-08', 1020, 705)
INSERT INTO Orders
  VALUES (203, '1999-08-07', '1999-08-07', 1023, 708)
INSERT INTO Orders
  VALUES (204, '1999-08-07', '1999-08-07', 1026, 701)
INSERT INTO Orders
  VALUES (205, '1999-08-07', '1999-08-11', 1006, 706)
INSERT INTO Orders
  VALUES (206, '1999-08-07', '1999-08-11', 1021, 704)
INSERT INTO Orders
  VALUES (207, '1999-08-07', '1999-08-09', 1015, 704)
INSERT INTO Orders
  VALUES (208, '1999-08-08', '1999-08-10', 1019, 704)
INSERT INTO Orders
  VALUES (209, '1999-08-09', '1999-08-10', 1002, 703)
INSERT INTO Orders
  VALUES (210, '1999-08-09', '1999-08-11', 1024, 701)
INSERT INTO Orders
  VALUES (211, '1999-08-09', '1999-08-12', 1014, 701)
INSERT INTO Orders
  VALUES (212, '1999-08-09', '1999-08-10', 1007, 704)
INSERT INTO Orders
  VALUES (213, '1999-08-10', '1999-08-11', 1001, 707)
INSERT INTO Orders
  VALUES (214, '1999-08-10', '1999-08-10', 1021, 703)
INSERT INTO Orders
  VALUES (215, '1999-08-10', '1999-08-10', 1002, 708)
INSERT INTO Orders
  VALUES (216, '1999-08-10', '1999-08-10', 1016, 707)
INSERT INTO Orders
  VALUES (217, '1999-08-11', '1999-08-13', 1020, 703)
INSERT INTO Orders
  VALUES (218, '1999-08-11', '1999-08-14', 1014, 707)
INSERT INTO Orders
  VALUES (219, '1999-08-11', '1999-08-12', 1018, 706)
INSERT INTO Orders
  VALUES (220, '1999-08-11', '1999-08-13', 1014, 705)
INSERT INTO Orders
  VALUES (221, '1999-08-11', '1999-08-13', 1008, 705)
INSERT INTO Orders
  VALUES (222, '1999-08-11', '1999-08-15', 1007, 703)
INSERT INTO Orders
  VALUES (223, '1999-08-11', '1999-08-14', 1025, 708)
INSERT INTO Orders
  VALUES (224, '1999-08-11', '1999-08-14', 1011, 705)
INSERT INTO Orders
  VALUES (225, '1999-08-12', '1999-08-12', 1017, 704)
INSERT INTO Orders
  VALUES (226, '1999-08-12', '1999-08-14', 1023, 705)
INSERT INTO Orders
  VALUES (227, '1999-08-13', '1999-08-16', 1006, 704)
INSERT INTO Orders
  VALUES (228, '1999-08-14', '1999-08-14', 1017, 701)
INSERT INTO Orders
  VALUES (229, '1999-08-14', '1999-08-17', 1024, 707)
INSERT INTO Orders
  VALUES (230, '1999-08-14', '1999-08-18', 1008, 708)
INSERT INTO Orders
  VALUES (231, '1999-08-14', '1999-08-16', 1016, 706)
INSERT INTO Orders
  VALUES (232, '1999-08-14', '1999-08-15', 1017, 703)
INSERT INTO Orders
  VALUES (233, '1999-08-15', '1999-08-17', 1014, 708)
INSERT INTO Orders
  VALUES (234, '1999-08-15', '1999-08-18', 1010, 702)
INSERT INTO Orders
  VALUES (235, '1999-08-15', '1999-08-18', 1015, 705)
INSERT INTO Orders
  VALUES (236, '1999-08-16', '1999-08-18', 1021, 704)
INSERT INTO Orders
  VALUES (237, '1999-08-16', '1999-08-18', 1027, 702)
INSERT INTO Orders
  VALUES (238, '1999-08-16', '1999-08-19', 1005, 705)
INSERT INTO Orders
  VALUES (239, '1999-08-16', '1999-08-17', 1012, 703)
INSERT INTO Orders
  VALUES (240, '1999-08-17', '1999-08-17', 1022, 701)
INSERT INTO Orders
  VALUES (241, '1999-08-17', '1999-08-17', 1008, 705)
INSERT INTO Orders
  VALUES (242, '1999-08-17', '1999-08-19', 1010, 705)
INSERT INTO Orders
  VALUES (243, '1999-08-17', '1999-08-20', 1020, 708)
INSERT INTO Orders
  VALUES (244, '1999-08-17', '1999-08-20', 1014, 708)
INSERT INTO Orders
  VALUES (245, '1999-08-17', '1999-08-18', 1015, 704)
INSERT INTO Orders
  VALUES (246, '1999-08-18', '1999-08-21', 1004, 703)
INSERT INTO Orders
  VALUES (247, '1999-08-18', '1999-08-21', 1005, 702)
INSERT INTO Orders
  VALUES (248, '1999-08-18', '1999-08-19', 1021, 705)
INSERT INTO Orders
  VALUES (249, '1999-08-18', '1999-08-21', 1016, 703)
INSERT INTO Orders
  VALUES (250, '1999-08-18', '1999-08-20', 1023, 707)
INSERT INTO Orders
  VALUES (251, '1999-08-18', '1999-08-21', 1005, 705)
INSERT INTO Orders
  VALUES (252, '1999-08-18', '1999-08-19', 1010, 702)
INSERT INTO Orders
  VALUES (253, '1999-08-19', '1999-08-19', 1024, 706)
INSERT INTO Orders
  VALUES (254, '1999-08-20', '1999-08-24', 1002, 703)
INSERT INTO Orders
  VALUES (255, '1999-08-20', '1999-08-20', 1008, 707)
INSERT INTO Orders
  VALUES (256, '1999-08-20', '1999-08-20', 1016, 705)
INSERT INTO Orders
  VALUES (257, '1999-08-20', '1999-08-20', 1007, 708)
INSERT INTO Orders
  VALUES (258, '1999-08-21', '1999-08-21', 1016, 705)
INSERT INTO Orders
  VALUES (259, '1999-08-21', '1999-08-21', 1009, 702)
INSERT INTO Orders
  VALUES (260, '1999-08-21', '1999-08-21', 1006, 701)
INSERT INTO Orders
  VALUES (261, '1999-08-21', '1999-08-25', 1020, 708)
INSERT INTO Orders
  VALUES (262, '1999-08-21', '1999-08-23', 1020, 707)
INSERT INTO Orders
  VALUES (263, '1999-08-21', '1999-08-24', 1011, 705)
INSERT INTO Orders
  VALUES (264, '1999-08-21', '1999-08-21', 1002, 702)
INSERT INTO Orders
  VALUES (265, '1999-08-21', '1999-08-24', 1014, 702)
INSERT INTO Orders
  VALUES (266, '1999-08-21', '1999-08-25', 1021, 708)
INSERT INTO Orders
  VALUES (267, '1999-08-21', '1999-08-22', 1004, 706)
INSERT INTO Orders
  VALUES (268, '1999-08-22', '1999-08-23', 1021, 704)
INSERT INTO Orders
  VALUES (269, '1999-08-22', '1999-08-23', 1016, 706)
INSERT INTO Orders
  VALUES (270, '1999-08-22', '1999-08-25', 1007, 703)
INSERT INTO Orders
  VALUES (271, '1999-08-23', '1999-08-23', 1010, 702)
INSERT INTO Orders
  VALUES (272, '1999-08-23', '1999-08-25', 1005, 701)
INSERT INTO Orders
  VALUES (273, '1999-08-23', '1999-08-23', 1024, 704)
INSERT INTO Orders
  VALUES (274, '1999-08-23', '1999-08-25', 1004, 703)
INSERT INTO Orders
  VALUES (275, '1999-08-23', '1999-08-27', 1009, 701)
INSERT INTO Orders
  VALUES (276, '1999-08-23', '1999-08-23', 1018, 702)
INSERT INTO Orders
  VALUES (277, '1999-08-23', '1999-08-23', 1012, 701)
INSERT INTO Orders
  VALUES (278, '1999-08-23', '1999-08-24', 1024, 707)
INSERT INTO Orders
  VALUES (279, '1999-08-24', '1999-08-28', 1017, 706)
INSERT INTO Orders
  VALUES (280, '1999-08-24', '1999-08-26', 1016, 702)
INSERT INTO Orders
  VALUES (281, '1999-08-24', '1999-08-26', 1006, 708)
INSERT INTO Orders
  VALUES (282, '1999-08-25', '1999-08-27', 1005, 702)
INSERT INTO Orders
  VALUES (283, '1999-08-25', '1999-08-26', 1015, 702)
INSERT INTO Orders
  VALUES (284, '1999-08-25', '1999-08-29', 1016, 701)
INSERT INTO Orders
  VALUES (285, '1999-08-25', '1999-08-26', 1024, 705)
INSERT INTO Orders
  VALUES (286, '1999-08-25', '1999-08-26', 1019, 705)
INSERT INTO Orders
  VALUES (287, '1999-08-25', '1999-08-28', 1018, 708)
INSERT INTO Orders
  VALUES (288, '1999-08-25', '1999-08-29', 1027, 704)
INSERT INTO Orders
  VALUES (289, '1999-08-26', '1999-08-30', 1002, 708)
INSERT INTO Orders
  VALUES (290, '1999-08-27', '1999-08-27', 1018, 706)
INSERT INTO Orders
  VALUES (291, '1999-08-27', '1999-08-31', 1025, 705)
INSERT INTO Orders
  VALUES (292, '1999-08-27', '1999-08-27', 1013, 708)
INSERT INTO Orders
  VALUES (293, '1999-08-27', '1999-08-28', 1025, 706)
INSERT INTO Orders
  VALUES (294, '1999-08-28', '1999-08-29', 1017, 706)
INSERT INTO Orders
  VALUES (295, '1999-08-28', '1999-08-28', 1012, 701)
INSERT INTO Orders
  VALUES (296, '1999-08-28', '1999-08-28', 1014, 707)
INSERT INTO Orders
  VALUES (297, '1999-08-28', '1999-08-31', 1008, 701)
INSERT INTO Orders
  VALUES (298, '1999-08-28', '1999-08-31', 1005, 701)
INSERT INTO Orders
  VALUES (299, '1999-08-29', '1999-09-02', 1021, 704)
INSERT INTO Orders
  VALUES (300, '1999-08-29', '1999-08-29', 1011, 706)
INSERT INTO Orders
  VALUES (301, '1999-08-29', '1999-09-02', 1025, 704)
INSERT INTO Orders
  VALUES (302, '1999-08-29', '1999-08-31', 1007, 702)
INSERT INTO Orders
  VALUES (303, '1999-08-30', '1999-09-02', 1011, 705)
INSERT INTO Orders
  VALUES (304, '1999-08-30', '1999-09-03', 1015, 701)
INSERT INTO Orders
  VALUES (305, '1999-08-30', '1999-09-03', 1013, 708)
INSERT INTO Orders
  VALUES (306, '1999-08-30', '1999-09-01', 1026, 701)
INSERT INTO Orders
  VALUES (307, '1999-08-30', '1999-08-31', 1013, 704)
INSERT INTO Orders
  VALUES (308, '1999-08-30', '1999-08-31', 1002, 701)
INSERT INTO Orders
  VALUES (309, '1999-08-30', '1999-09-02', 1020, 707)
INSERT INTO Orders
  VALUES (310, '1999-08-30', '1999-09-01', 1025, 703)
INSERT INTO Orders
  VALUES (311, '1999-08-31', '1999-09-02', 1003, 708)
INSERT INTO Orders
  VALUES (312, '1999-08-31', '1999-08-31', 1003, 707)
INSERT INTO Orders
  VALUES (313, '1999-08-31', '1999-08-31', 1024, 701)
INSERT INTO Orders
  VALUES (314, '1999-08-31', '1999-09-02', 1007, 706)
INSERT INTO Orders
  VALUES (315, '1999-08-31', '1999-09-04', 1024, 702)
INSERT INTO Orders
  VALUES (316, '1999-08-31', '1999-09-04', 1018, 705)
INSERT INTO Orders
  VALUES (317, '1999-08-31', '1999-08-31', 1012, 703)
INSERT INTO Orders
  VALUES (318, '1999-08-31', '1999-09-01', 1024, 703)
INSERT INTO Orders
  VALUES (319, '1999-09-01', '1999-09-02', 1005, 701)
INSERT INTO Orders
  VALUES (320, '1999-09-01', '1999-09-05', 1001, 707)
INSERT INTO Orders
  VALUES (321, '1999-09-01', '1999-09-03', 1011, 701)
INSERT INTO Orders
  VALUES (322, '1999-09-01', '1999-09-02', 1001, 701)
INSERT INTO Orders
  VALUES (323, '1999-09-01', '1999-09-03', 1011, 706)
INSERT INTO Orders
  VALUES (324, '1999-09-01', '1999-09-02', 1016, 704)
INSERT INTO Orders
  VALUES (325, '1999-09-01', '1999-09-02', 1002, 706)
INSERT INTO Orders
  VALUES (326, '1999-09-01', '1999-09-05', 1024, 704)
INSERT INTO Orders
  VALUES (327, '1999-09-01', '1999-09-01', 1012, 703)
INSERT INTO Orders
  VALUES (328, '1999-09-01', '1999-09-04', 1009, 702)
INSERT INTO Orders
  VALUES (329, '1999-09-02', '1999-09-04', 1004, 708)
INSERT INTO Orders
  VALUES (330, '1999-09-02', '1999-09-05', 1021, 708)
INSERT INTO Orders
  VALUES (331, '1999-09-02', '1999-09-04', 1018, 702)
INSERT INTO Orders
  VALUES (332, '1999-09-03', '1999-09-03', 1006, 704)
INSERT INTO Orders
  VALUES (333, '1999-09-03', '1999-09-05', 1003, 708)
INSERT INTO Orders
  VALUES (334, '1999-09-03', '1999-09-07', 1009, 707)
INSERT INTO Orders
  VALUES (335, '1999-09-03', '1999-09-04', 1020, 703)
INSERT INTO Orders
  VALUES (336, '1999-09-04', '1999-09-05', 1020, 703)
INSERT INTO Orders
  VALUES (337, '1999-09-04', '1999-09-05', 1011, 706)
INSERT INTO Orders
  VALUES (338, '1999-09-04', '1999-09-04', 1009, 708)
INSERT INTO Orders
  VALUES (339, '1999-09-04', '1999-09-08', 1005, 705)
INSERT INTO Orders
  VALUES (340, '1999-09-04', '1999-09-08', 1026, 707)
INSERT INTO Orders
  VALUES (341, '1999-09-05', '1999-09-06', 1022, 704)
INSERT INTO Orders
  VALUES (342, '1999-09-06', '1999-09-08', 1013, 702)
INSERT INTO Orders
  VALUES (343, '1999-09-06', '1999-09-09', 1025, 708)
INSERT INTO Orders
  VALUES (344, '1999-09-06', '1999-09-10', 1005, 702)
INSERT INTO Orders
  VALUES (345, '1999-09-06', '1999-09-09', 1008, 701)
INSERT INTO Orders
  VALUES (346, '1999-09-06', '1999-09-10', 1001, 702)
INSERT INTO Orders
  VALUES (347, '1999-09-07', '1999-09-07', 1020, 705)
INSERT INTO Orders
  VALUES (348, '1999-09-07', '1999-09-09', 1015, 703)
INSERT INTO Orders
  VALUES (349, '1999-09-07', '1999-09-08', 1001, 703)
INSERT INTO Orders
  VALUES (350, '1999-09-07', '1999-09-09', 1019, 703)
INSERT INTO Orders
  VALUES (351, '1999-09-08', '1999-09-12', 1012, 704)
INSERT INTO Orders
  VALUES (352, '1999-09-08', '1999-09-09', 1020, 706)
INSERT INTO Orders
  VALUES (353, '1999-09-08', '1999-09-12', 1026, 704)
INSERT INTO Orders
  VALUES (354, '1999-09-09', '1999-09-10', 1021, 706)
INSERT INTO Orders
  VALUES (355, '1999-09-09', '1999-09-10', 1014, 702)
INSERT INTO Orders
  VALUES (356, '1999-09-09', '1999-09-13', 1018, 702)
INSERT INTO Orders
  VALUES (357, '1999-09-09', '1999-09-11', 1003, 705)
INSERT INTO Orders
  VALUES (358, '1999-09-09', '1999-09-13', 1012, 701)
INSERT INTO Orders
  VALUES (359, '1999-09-10', '1999-09-11', 1024, 707)
INSERT INTO Orders
  VALUES (360, '1999-09-10', '1999-09-12', 1013, 707)
INSERT INTO Orders
  VALUES (361, '1999-09-10', '1999-09-11', 1016, 706)
INSERT INTO Orders
  VALUES (362, '1999-09-10', '1999-09-11', 1012, 701)
INSERT INTO Orders
  VALUES (363, '1999-09-10', '1999-09-11', 1010, 706)
INSERT INTO Orders
  VALUES (364, '1999-09-10', '1999-09-13', 1010, 705)
INSERT INTO Orders
  VALUES (365, '1999-09-10', '1999-09-11', 1011, 705)
INSERT INTO Orders
  VALUES (366, '1999-09-10', '1999-09-11', 1004, 708)
INSERT INTO Orders
  VALUES (367, '1999-09-10', '1999-09-10', 1011, 703)
INSERT INTO Orders
  VALUES (368, '1999-09-11', '1999-09-12', 1017, 708)
INSERT INTO Orders
  VALUES (369, '1999-09-11', '1999-09-12', 1003, 707)
INSERT INTO Orders
  VALUES (370, '1999-09-11', '1999-09-11', 1025, 708)
INSERT INTO Orders
  VALUES (371, '1999-09-11', '1999-09-14', 1009, 701)
INSERT INTO Orders
  VALUES (372, '1999-09-11', '1999-09-13', 1025, 707)
INSERT INTO Orders
  VALUES (373, '1999-09-11', '1999-09-14', 1014, 701)
INSERT INTO Orders
  VALUES (374, '1999-09-11', '1999-09-11', 1005, 701)
INSERT INTO Orders
  VALUES (375, '1999-09-12', '1999-09-14', 1004, 704)
INSERT INTO Orders
  VALUES (376, '1999-09-12', '1999-09-12', 1015, 704)
INSERT INTO Orders
  VALUES (377, '1999-09-12', '1999-09-16', 1019, 705)
INSERT INTO Orders
  VALUES (378, '1999-09-12', '1999-09-13', 1014, 707)
INSERT INTO Orders
  VALUES (379, '1999-09-12', '1999-09-16', 1025, 706)
INSERT INTO Orders
  VALUES (380, '1999-09-12', '1999-09-15', 1023, 704)
INSERT INTO Orders
  VALUES (381, '1999-09-13', '1999-09-15', 1012, 701)
INSERT INTO Orders
  VALUES (382, '1999-09-14', '1999-09-14', 1017, 705)
INSERT INTO Orders
  VALUES (383, '1999-09-15', '1999-09-18', 1017, 702)
INSERT INTO Orders
  VALUES (384, '1999-09-15', '1999-09-15', 1021, 708)
INSERT INTO Orders
  VALUES (385, '1999-09-16', '1999-09-19', 1019, 701)
INSERT INTO Orders
  VALUES (386, '1999-09-16', '1999-09-16', 1021, 705)
INSERT INTO Orders
  VALUES (387, '1999-09-16', '1999-09-20', 1010, 708)
INSERT INTO Orders
  VALUES (388, '1999-09-16', '1999-09-20', 1008, 705)
INSERT INTO Orders
  VALUES (389, '1999-09-16', '1999-09-19', 1005, 706)
INSERT INTO Orders
  VALUES (390, '1999-09-16', '1999-09-19', 1016, 708)
INSERT INTO Orders
  VALUES (391, '1999-09-16', '1999-09-16', 1024, 702)
INSERT INTO Orders
  VALUES (392, '1999-09-16', '1999-09-20', 1006, 708)
INSERT INTO Orders
  VALUES (393, '1999-09-17', '1999-09-19', 1011, 704)
INSERT INTO Orders
  VALUES (394, '1999-09-17', '1999-09-20', 1001, 702)
INSERT INTO Orders
  VALUES (395, '1999-09-18', '1999-09-22', 1014, 703)
INSERT INTO Orders
  VALUES (396, '1999-09-18', '1999-09-19', 1019, 706)
INSERT INTO Orders
  VALUES (397, '1999-09-18', '1999-09-18', 1020, 701)
INSERT INTO Orders
  VALUES (398, '1999-09-19', '1999-09-21', 1004, 708)
INSERT INTO Orders
  VALUES (399, '1999-09-19', '1999-09-22', 1007, 704)
INSERT INTO Orders
  VALUES (400, '1999-09-19', '1999-09-23', 1026, 705)
INSERT INTO Orders
  VALUES (401, '1999-09-19', '1999-09-20', 1003, 702)
INSERT INTO Orders
  VALUES (402, '1999-09-19', '1999-09-21', 1017, 704)
INSERT INTO Orders
  VALUES (403, '1999-09-19', '1999-09-19', 1006, 702)
INSERT INTO Orders
  VALUES (404, '1999-09-19', '1999-09-20', 1019, 708)
INSERT INTO Orders
  VALUES (405, '1999-09-19', '1999-09-22', 1023, 702)
INSERT INTO Orders
  VALUES (406, '1999-09-20', '1999-09-24', 1012, 706)
INSERT INTO Orders
  VALUES (407, '1999-09-21', '1999-09-24', 1001, 701)
INSERT INTO Orders
  VALUES (408, '1999-09-22', '1999-09-26', 1001, 703)
INSERT INTO Orders
  VALUES (409, '1999-09-22', '1999-09-23', 1024, 704)
INSERT INTO Orders
  VALUES (410, '1999-09-22', '1999-09-23', 1008, 702)
INSERT INTO Orders
  VALUES (411, '1999-09-23', '1999-09-24', 1002, 708)
INSERT INTO Orders
  VALUES (412, '1999-09-23', '1999-09-26', 1026, 708)
INSERT INTO Orders
  VALUES (413, '1999-09-23', '1999-09-24', 1001, 708)
INSERT INTO Orders
  VALUES (414, '1999-09-23', '1999-09-27', 1020, 703)
INSERT INTO Orders
  VALUES (415, '1999-09-23', '1999-09-26', 1013, 705)
INSERT INTO Orders
  VALUES (416, '1999-09-23', '1999-09-24', 1024, 705)
INSERT INTO Orders
  VALUES (417, '1999-09-23', '1999-09-26', 1017, 703)
INSERT INTO Orders
  VALUES (418, '1999-09-23', '1999-09-23', 1012, 705)
INSERT INTO Orders
  VALUES (419, '1999-09-24', '1999-09-24', 1006, 708)
INSERT INTO Orders
  VALUES (420, '1999-09-24', '1999-09-24', 1024, 704)
INSERT INTO Orders
  VALUES (421, '1999-09-24', '1999-09-27', 1022, 704)
INSERT INTO Orders
  VALUES (422, '1999-09-24', '1999-09-25', 1027, 707)
INSERT INTO Orders
  VALUES (423, '1999-09-24', '1999-09-28', 1010, 708)
INSERT INTO Orders
  VALUES (424, '1999-09-24', '1999-09-26', 1025, 706)
INSERT INTO Orders
  VALUES (425, '1999-09-25', '1999-09-29', 1001, 707)
INSERT INTO Orders
  VALUES (426, '1999-09-25', '1999-09-28', 1001, 707)
INSERT INTO Orders
  VALUES (427, '1999-09-25', '1999-09-28', 1020, 702)
INSERT INTO Orders
  VALUES (428, '1999-09-25', '1999-09-26', 1024, 703)
INSERT INTO Orders
  VALUES (429, '1999-09-25', '1999-09-28', 1016, 701)
INSERT INTO Orders
  VALUES (430, '1999-09-25', '1999-09-29', 1009, 707)
INSERT INTO Orders
  VALUES (431, '1999-09-26', '1999-09-29', 1016, 705)
INSERT INTO Orders
  VALUES (432, '1999-09-26', '1999-09-29', 1022, 702)
INSERT INTO Orders
  VALUES (433, '1999-09-26', '1999-09-26', 1017, 708)
INSERT INTO Orders
  VALUES (434, '1999-09-26', '1999-09-28', 1012, 703)
INSERT INTO Orders
  VALUES (435, '1999-09-26', '1999-09-28', 1016, 706)
INSERT INTO Orders
  VALUES (436, '1999-09-26', '1999-09-29', 1014, 703)
INSERT INTO Orders
  VALUES (437, '1999-09-26', '1999-09-28', 1002, 705)
INSERT INTO Orders
  VALUES (438, '1999-09-26', '1999-09-30', 1020, 708)
INSERT INTO Orders
  VALUES (439, '1999-09-27', '1999-10-01', 1025, 703)
INSERT INTO Orders
  VALUES (440, '1999-09-27', '1999-09-28', 1027, 708)
INSERT INTO Orders
  VALUES (441, '1999-09-27', '1999-09-27', 1010, 701)
INSERT INTO Orders
  VALUES (442, '1999-09-27', '1999-09-30', 1002, 705)
INSERT INTO Orders
  VALUES (443, '1999-09-28', '1999-10-01', 1001, 704)
INSERT INTO Orders
  VALUES (444, '1999-09-28', '1999-09-29', 1002, 706)
INSERT INTO Orders
  VALUES (445, '1999-09-28', '1999-09-29', 1007, 705)
INSERT INTO Orders
  VALUES (446, '1999-09-28', '1999-10-02', 1010, 708)
INSERT INTO Orders
  VALUES (447, '1999-09-28', '1999-09-29', 1018, 702)
INSERT INTO Orders
  VALUES (448, '1999-09-28', '1999-09-30', 1001, 701)
INSERT INTO Orders
  VALUES (449, '1999-09-28', '1999-09-28', 1025, 707)
INSERT INTO Orders
  VALUES (450, '1999-09-29', '1999-10-03', 1004, 705)
INSERT INTO Orders
  VALUES (451, '1999-09-29', '1999-10-01', 1003, 706)
INSERT INTO Orders
  VALUES (452, '1999-09-29', '1999-10-01', 1001, 702)
INSERT INTO Orders
  VALUES (453, '1999-09-29', '1999-10-03', 1027, 708)
INSERT INTO Orders
  VALUES (454, '1999-09-29', '1999-10-01', 1010, 703)
INSERT INTO Orders
  VALUES (455, '1999-09-29', '1999-09-30', 1005, 702)
INSERT INTO Orders
  VALUES (456, '1999-09-30', '1999-10-01', 1015, 705)
INSERT INTO Orders
  VALUES (457, '1999-09-30', '1999-10-04', 1019, 701)
INSERT INTO Orders
  VALUES (458, '1999-10-01', '1999-10-01', 1003, 702)
INSERT INTO Orders
  VALUES (459, '1999-10-01', '1999-10-02', 1007, 707)
INSERT INTO Orders
  VALUES (460, '1999-10-02', '1999-10-04', 1013, 704)
INSERT INTO Orders
  VALUES (461, '1999-10-02', '1999-10-06', 1021, 703)
INSERT INTO Orders
  VALUES (462, '1999-10-02', '1999-10-02', 1004, 705)
INSERT INTO Orders
  VALUES (463, '1999-10-03', '1999-10-06', 1015, 705)
INSERT INTO Orders
  VALUES (464, '1999-10-03', '1999-10-06', 1020, 705)
INSERT INTO Orders
  VALUES (465, '1999-10-03', '1999-10-03', 1012, 706)
INSERT INTO Orders
  VALUES (466, '1999-10-04', '1999-10-05', 1026, 704)
INSERT INTO Orders
  VALUES (467, '1999-10-04', '1999-10-04', 1013, 706)
INSERT INTO Orders
  VALUES (468, '1999-10-04', '1999-10-05', 1010, 708)
INSERT INTO Orders
  VALUES (469, '1999-10-04', '1999-10-04', 1011, 708)
INSERT INTO Orders
  VALUES (470, '1999-10-04', '1999-10-07', 1014, 703)
INSERT INTO Orders
  VALUES (471, '1999-10-04', '1999-10-06', 1025, 701)
INSERT INTO Orders
  VALUES (472, '1999-10-04', '1999-10-08', 1023, 707)
INSERT INTO Orders
  VALUES (473, '1999-10-04', '1999-10-07', 1016, 702)
INSERT INTO Orders
  VALUES (474, '1999-10-04', '1999-10-07', 1006, 703)
INSERT INTO Orders
  VALUES (475, '1999-10-05', '1999-10-09', 1001, 702)
INSERT INTO Orders
  VALUES (476, '1999-10-05', '1999-10-09', 1014, 705)
INSERT INTO Orders
  VALUES (477, '1999-10-05', '1999-10-05', 1009, 708)
INSERT INTO Orders
  VALUES (478, '1999-10-05', '1999-10-09', 1004, 707)
INSERT INTO Orders
  VALUES (479, '1999-10-05', '1999-10-08', 1024, 705)
INSERT INTO Orders
  VALUES (480, '1999-10-05', '1999-10-05', 1011, 703)
INSERT INTO Orders
  VALUES (481, '1999-10-06', '1999-10-09', 1009, 702)
INSERT INTO Orders
  VALUES (482, '1999-10-06', '1999-10-06', 1011, 705)
INSERT INTO Orders
  VALUES (483, '1999-10-06', '1999-10-07', 1005, 704)
INSERT INTO Orders
  VALUES (484, '1999-10-07', '1999-10-08', 1021, 707)
INSERT INTO Orders
  VALUES (485, '1999-10-07', '1999-10-09', 1003, 707)
INSERT INTO Orders
  VALUES (486, '1999-10-07', '1999-10-08', 1022, 705)
INSERT INTO Orders
  VALUES (487, '1999-10-07', '1999-10-09', 1009, 704)
INSERT INTO Orders
  VALUES (488, '1999-10-07', '1999-10-09', 1025, 703)
INSERT INTO Orders
  VALUES (489, '1999-10-07', '1999-10-07', 1005, 701)
INSERT INTO Orders
  VALUES (490, '1999-10-07', '1999-10-09', 1009, 702)
INSERT INTO Orders
  VALUES (491, '1999-10-07', '1999-10-08', 1007, 708)
INSERT INTO Orders
  VALUES (492, '1999-10-08', '1999-10-10', 1008, 702)
INSERT INTO Orders
  VALUES (493, '1999-10-08', '1999-10-12', 1005, 708)
INSERT INTO Orders
  VALUES (494, '1999-10-08', '1999-10-12', 1012, 701)
INSERT INTO Orders
  VALUES (495, '1999-10-08', '1999-10-09', 1012, 702)
INSERT INTO Orders
  VALUES (496, '1999-10-09', '1999-10-09', 1014, 701)
INSERT INTO Orders
  VALUES (497, '1999-10-09', '1999-10-10', 1002, 701)
INSERT INTO Orders
  VALUES (498, '1999-10-09', '1999-10-11', 1018, 708)
INSERT INTO Orders
  VALUES (499, '1999-10-09', '1999-10-13', 1016, 704)
INSERT INTO Orders
  VALUES (500, '1999-10-09', '1999-10-09', 1007, 705)
INSERT INTO Orders
  VALUES (501, '1999-10-10', '1999-10-13', 1001, 702)
INSERT INTO Orders
  VALUES (502, '1999-10-10', '1999-10-13', 1025, 707)
INSERT INTO Orders
  VALUES (503, '1999-10-10', '1999-10-12', 1026, 706)
INSERT INTO Orders
  VALUES (504, '1999-10-10', '1999-10-13', 1004, 707)
INSERT INTO Orders
  VALUES (505, '1999-10-10', '1999-10-14', 1006, 707)
INSERT INTO Orders
  VALUES (506, '1999-10-10', '1999-10-12', 1016, 704)
INSERT INTO Orders
  VALUES (507, '1999-10-10', '1999-10-10', 1017, 705)
INSERT INTO Orders
  VALUES (508, '1999-10-10', '1999-10-13', 1012, 704)
INSERT INTO Orders
  VALUES (509, '1999-10-11', '1999-10-12', 1010, 701)
INSERT INTO Orders
  VALUES (510, '1999-10-11', '1999-10-12', 1015, 703)
INSERT INTO Orders
  VALUES (511, '1999-10-11', '1999-10-11', 1026, 706)
INSERT INTO Orders
  VALUES (512, '1999-10-11', '1999-10-13', 1027, 708)
INSERT INTO Orders
  VALUES (513, '1999-10-11', '1999-10-14', 1012, 707)
INSERT INTO Orders
  VALUES (514, '1999-10-11', '1999-10-13', 1025, 705)
INSERT INTO Orders
  VALUES (515, '1999-10-11', '1999-10-14', 1003, 705)
INSERT INTO Orders
  VALUES (516, '1999-10-11', '1999-10-15', 1021, 703)
INSERT INTO Orders
  VALUES (517, '1999-10-12', '1999-10-14', 1007, 706)
INSERT INTO Orders
  VALUES (518, '1999-10-12', '1999-10-13', 1007, 704)
INSERT INTO Orders
  VALUES (519, '1999-10-12', '1999-10-14', 1018, 701)
INSERT INTO Orders
  VALUES (520, '1999-10-12', '1999-10-16', 1027, 704)
INSERT INTO Orders
  VALUES (521, '1999-10-12', '1999-10-16', 1009, 708)
INSERT INTO Orders
  VALUES (522, '1999-10-12', '1999-10-16', 1009, 708)
INSERT INTO Orders
  VALUES (523, '1999-10-13', '1999-10-15', 1003, 704)
INSERT INTO Orders
  VALUES (524, '1999-10-14', '1999-10-18', 1002, 701)
INSERT INTO Orders
  VALUES (525, '1999-10-14', '1999-10-17', 1019, 705)
INSERT INTO Orders
  VALUES (526, '1999-10-14', '1999-10-17', 1011, 705)
INSERT INTO Orders
  VALUES (527, '1999-10-14', '1999-10-18', 1009, 707)
INSERT INTO Orders
  VALUES (528, '1999-10-15', '1999-10-16', 1026, 701)
INSERT INTO Orders
  VALUES (529, '1999-10-15', '1999-10-17', 1013, 703)
INSERT INTO Orders
  VALUES (530, '1999-10-15', '1999-10-17', 1009, 701)
INSERT INTO Orders
  VALUES (531, '1999-10-15', '1999-10-15', 1012, 707)
INSERT INTO Orders
  VALUES (532, '1999-10-16', '1999-10-17', 1027, 706)
INSERT INTO Orders
  VALUES (533, '1999-10-16', '1999-10-19', 1017, 702)
INSERT INTO Orders
  VALUES (534, '1999-10-16', '1999-10-16', 1017, 706)
INSERT INTO Orders
  VALUES (535, '1999-10-16', '1999-10-17', 1020, 703)
INSERT INTO Orders
  VALUES (536, '1999-10-16', '1999-10-19', 1020, 702)
INSERT INTO Orders
  VALUES (537, '1999-10-16', '1999-10-19', 1003, 703)
INSERT INTO Orders
  VALUES (538, '1999-10-17', '1999-10-18', 1008, 703)
INSERT INTO Orders
  VALUES (539, '1999-10-18', '1999-10-22', 1008, 701)
INSERT INTO Orders
  VALUES (540, '1999-10-18', '1999-10-22', 1007, 707)
INSERT INTO Orders
  VALUES (541, '1999-10-19', '1999-10-21', 1006, 701)
INSERT INTO Orders
  VALUES (542, '1999-10-20', '1999-10-23', 1008, 704)
INSERT INTO Orders
  VALUES (543, '1999-10-20', '1999-10-23', 1005, 707)
INSERT INTO Orders
  VALUES (544, '1999-10-20', '1999-10-20', 1009, 704)
INSERT INTO Orders
  VALUES (545, '1999-10-20', '1999-10-24', 1010, 707)
INSERT INTO Orders
  VALUES (546, '1999-10-20', '1999-10-20', 1013, 702)
INSERT INTO Orders
  VALUES (547, '1999-10-20', '1999-10-20', 1011, 708)
INSERT INTO Orders
  VALUES (548, '1999-10-20', '1999-10-22', 1004, 707)
INSERT INTO Orders
  VALUES (549, '1999-10-20', '1999-10-20', 1024, 703)
INSERT INTO Orders
  VALUES (550, '1999-10-21', '1999-10-23', 1003, 706)
INSERT INTO Orders
  VALUES (551, '1999-10-22', '1999-10-26', 1010, 705)
INSERT INTO Orders
  VALUES (552, '1999-10-22', '1999-10-25', 1023, 705)
INSERT INTO Orders
  VALUES (553, '1999-10-22', '1999-10-26', 1002, 705)
INSERT INTO Orders
  VALUES (554, '1999-10-22', '1999-10-23', 1002, 701)
INSERT INTO Orders
  VALUES (555, '1999-10-22', '1999-10-25', 1003, 703)
INSERT INTO Orders
  VALUES (556, '1999-10-22', '1999-10-26', 1019, 701)
INSERT INTO Orders
  VALUES (557, '1999-10-22', '1999-10-22', 1026, 702)
INSERT INTO Orders
  VALUES (558, '1999-10-23', '1999-10-24', 1009, 708)
INSERT INTO Orders
  VALUES (559, '1999-10-23', '1999-10-25', 1011, 706)
INSERT INTO Orders
  VALUES (560, '1999-10-23', '1999-10-27', 1016, 707)
INSERT INTO Orders
  VALUES (561, '1999-10-23', '1999-10-26', 1025, 704)
INSERT INTO Orders
  VALUES (562, '1999-10-23', '1999-10-26', 1006, 705)
INSERT INTO Orders
  VALUES (563, '1999-10-23', '1999-10-24', 1020, 704)
INSERT INTO Orders
  VALUES (564, '1999-10-23', '1999-10-25', 1001, 706)
INSERT INTO Orders
  VALUES (565, '1999-10-24', '1999-10-26', 1014, 705)
INSERT INTO Orders
  VALUES (566, '1999-10-24', '1999-10-25', 1007, 706)
INSERT INTO Orders
  VALUES (567, '1999-10-24', '1999-10-26', 1001, 703)
INSERT INTO Orders
  VALUES (568, '1999-10-24', '1999-10-25', 1024, 704)
INSERT INTO Orders
  VALUES (569, '1999-10-24', '1999-10-26', 1004, 707)
INSERT INTO Orders
  VALUES (570, '1999-10-24', '1999-10-28', 1022, 707)
INSERT INTO Orders
  VALUES (571, '1999-10-25', '1999-10-28', 1019, 704)
INSERT INTO Orders
  VALUES (572, '1999-10-25', '1999-10-25', 1003, 703)
INSERT INTO Orders
  VALUES (573, '1999-10-25', '1999-10-27', 1019, 701)
INSERT INTO Orders
  VALUES (574, '1999-10-25', '1999-10-25', 1003, 704)
INSERT INTO Orders
  VALUES (575, '1999-10-25', '1999-10-29', 1027, 707)
INSERT INTO Orders
  VALUES (576, '1999-10-26', '1999-10-26', 1005, 705)
INSERT INTO Orders
  VALUES (577, '1999-10-26', '1999-10-26', 1014, 706)
INSERT INTO Orders
  VALUES (578, '1999-10-26', '1999-10-27', 1026, 708)
INSERT INTO Orders
  VALUES (579, '1999-10-26', '1999-10-30', 1012, 707)
INSERT INTO Orders
  VALUES (580, '1999-10-26', '1999-10-26', 1011, 705)
INSERT INTO Orders
  VALUES (581, '1999-10-27', '1999-10-27', 1003, 704)
INSERT INTO Orders
  VALUES (582, '1999-10-27', '1999-10-30', 1004, 703)
INSERT INTO Orders
  VALUES (583, '1999-10-27', '1999-10-27', 1003, 702)
INSERT INTO Orders
  VALUES (584, '1999-10-28', '1999-10-30', 1004, 707)
INSERT INTO Orders
  VALUES (585, '1999-10-28', '1999-10-28', 1009, 704)
INSERT INTO Orders
  VALUES (586, '1999-10-28', '1999-10-29', 1023, 707)
INSERT INTO Orders
  VALUES (587, '1999-10-28', '1999-11-01', 1001, 701)
INSERT INTO Orders
  VALUES (588, '1999-10-28', '1999-10-28', 1003, 701)
INSERT INTO Orders
  VALUES (589, '1999-10-28', '1999-10-28', 1013, 708)
INSERT INTO Orders
  VALUES (590, '1999-10-28', '1999-11-01', 1018, 708)
INSERT INTO Orders
  VALUES (591, '1999-10-29', '1999-11-01', 1023, 702)
INSERT INTO Orders
  VALUES (592, '1999-10-29', '1999-10-31', 1005, 707)
INSERT INTO Orders
  VALUES (593, '1999-10-29', '1999-11-01', 1026, 701)
INSERT INTO Orders
  VALUES (594, '1999-10-29', '1999-10-29', 1017, 706)
INSERT INTO Orders
  VALUES (595, '1999-10-30', '1999-11-02', 1015, 703)
INSERT INTO Orders
  VALUES (596, '1999-10-30', '1999-11-03', 1001, 702)
INSERT INTO Orders
  VALUES (597, '1999-10-30', '1999-10-30', 1006, 707)
INSERT INTO Orders
  VALUES (598, '1999-10-30', '1999-10-31', 1013, 701)
INSERT INTO Orders
  VALUES (599, '1999-10-31', '1999-10-31', 1011, 703)
INSERT INTO Orders
  VALUES (600, '1999-10-31', '1999-11-04', 1006, 704)
INSERT INTO Orders
  VALUES (601, '1999-10-31', '1999-11-01', 1011, 706)
INSERT INTO Orders
  VALUES (602, '1999-10-31', '1999-11-04', 1025, 708)
INSERT INTO Orders
  VALUES (603, '1999-10-31', '1999-11-02', 1015, 707)
INSERT INTO Orders
  VALUES (604, '1999-10-31', '1999-11-01', 1006, 702)
INSERT INTO Orders
  VALUES (605, '1999-10-31', '1999-11-01', 1020, 701)
INSERT INTO Orders
  VALUES (606, '1999-11-01', '1999-11-02', 1007, 702)
INSERT INTO Orders
  VALUES (607, '1999-11-01', '1999-11-04', 1012, 704)
INSERT INTO Orders
  VALUES (608, '1999-11-01', '1999-11-05', 1001, 706)
INSERT INTO Orders
  VALUES (609, '1999-11-01', '1999-11-05', 1017, 705)
INSERT INTO Orders
  VALUES (610, '1999-11-01', '1999-11-01', 1020, 704)
INSERT INTO Orders
  VALUES (611, '1999-11-01', '1999-11-03', 1005, 706)
INSERT INTO Orders
  VALUES (612, '1999-11-01', '1999-11-02', 1005, 705)
INSERT INTO Orders
  VALUES (613, '1999-11-02', '1999-11-04', 1015, 706)
INSERT INTO Orders
  VALUES (614, '1999-11-03', '1999-11-04', 1004, 704)
INSERT INTO Orders
  VALUES (615, '1999-11-04', '1999-11-05', 1027, 707)
INSERT INTO Orders
  VALUES (616, '1999-11-04', '1999-11-05', 1022, 705)
INSERT INTO Orders
  VALUES (617, '1999-11-04', '1999-11-04', 1012, 702)
INSERT INTO Orders
  VALUES (618, '1999-11-04', '1999-11-08', 1026, 707)
INSERT INTO Orders
  VALUES (619, '1999-11-04', '1999-11-05', 1008, 707)
INSERT INTO Orders
  VALUES (620, '1999-11-04', '1999-11-06', 1023, 702)
INSERT INTO Orders
  VALUES (621, '1999-11-04', '1999-11-07', 1007, 707)
INSERT INTO Orders
  VALUES (622, '1999-11-05', '1999-11-05', 1002, 707)
INSERT INTO Orders
  VALUES (623, '1999-11-05', '1999-11-07', 1007, 708)
INSERT INTO Orders
  VALUES (624, '1999-11-05', '1999-11-08', 1014, 701)
INSERT INTO Orders
  VALUES (625, '1999-11-05', '1999-11-07', 1006, 708)
INSERT INTO Orders
  VALUES (626, '1999-11-05', '1999-11-09', 1023, 702)
INSERT INTO Orders
  VALUES (627, '1999-11-05', '1999-11-07', 1027, 705)
INSERT INTO Orders
  VALUES (628, '1999-11-05', '1999-11-06', 1026, 704)
INSERT INTO Orders
  VALUES (629, '1999-11-06', '1999-11-10', 1014, 704)
INSERT INTO Orders
  VALUES (630, '1999-11-06', '1999-11-08', 1026, 702)
INSERT INTO Orders
  VALUES (631, '1999-11-06', '1999-11-06', 1012, 707)
INSERT INTO Orders
  VALUES (632, '1999-11-06', '1999-11-10', 1001, 706)
INSERT INTO Orders
  VALUES (633, '1999-11-06', '1999-11-08', 1021, 705)
INSERT INTO Orders
  VALUES (634, '1999-11-06', '1999-11-10', 1002, 703)
INSERT INTO Orders
  VALUES (635, '1999-11-06', '1999-11-09', 1002, 703)
INSERT INTO Orders
  VALUES (636, '1999-11-06', '1999-11-09', 1002, 703)
INSERT INTO Orders
  VALUES (637, '1999-11-06', '1999-11-09', 1008, 702)
INSERT INTO Orders
  VALUES (638, '1999-11-06', '1999-11-08', 1003, 705)
INSERT INTO Orders
  VALUES (639, '1999-11-07', '1999-11-09', 1019, 705)
INSERT INTO Orders
  VALUES (640, '1999-11-07', '1999-11-10', 1008, 706)
INSERT INTO Orders
  VALUES (641, '1999-11-07', '1999-11-10', 1012, 701)
INSERT INTO Orders
  VALUES (642, '1999-11-07', '1999-11-09', 1012, 708)
INSERT INTO Orders
  VALUES (643, '1999-11-07', '1999-11-10', 1011, 701)
INSERT INTO Orders
  VALUES (644, '1999-11-07', '1999-11-08', 1021, 706)
INSERT INTO Orders
  VALUES (645, '1999-11-07', '1999-11-11', 1024, 703)
INSERT INTO Orders
  VALUES (646, '1999-11-07', '1999-11-08', 1017, 705)
INSERT INTO Orders
  VALUES (647, '1999-11-08', '1999-11-12', 1014, 703)
INSERT INTO Orders
  VALUES (648, '1999-11-08', '1999-11-09', 1015, 701)
INSERT INTO Orders
  VALUES (649, '1999-11-08', '1999-11-12', 1001, 707)
INSERT INTO Orders
  VALUES (650, '1999-11-08', '1999-11-08', 1005, 706)
INSERT INTO Orders
  VALUES (651, '1999-11-08', '1999-11-11', 1025, 704)
INSERT INTO Orders
  VALUES (652, '1999-11-09', '1999-11-09', 1024, 701)
INSERT INTO Orders
  VALUES (653, '1999-11-09', '1999-11-12', 1015, 701)
INSERT INTO Orders
  VALUES (654, '1999-11-09', '1999-11-13', 1024, 704)
INSERT INTO Orders
  VALUES (655, '1999-11-09', '1999-11-13', 1007, 701)
INSERT INTO Orders
  VALUES (656, '1999-11-09', '1999-11-09', 1024, 707)
INSERT INTO Orders
  VALUES (657, '1999-11-09', '1999-11-12', 1001, 706)
INSERT INTO Orders
  VALUES (658, '1999-11-09', '1999-11-09', 1010, 701)
INSERT INTO Orders
  VALUES (659, '1999-11-09', '1999-11-11', 1023, 705)
INSERT INTO Orders
  VALUES (660, '1999-11-10', '1999-11-13', 1027, 702)
INSERT INTO Orders
  VALUES (661, '1999-11-10', '1999-11-14', 1011, 706)
INSERT INTO Orders
  VALUES (662, '1999-11-10', '1999-11-12', 1006, 706)
INSERT INTO Orders
  VALUES (663, '1999-11-10', '1999-11-13', 1025, 707)
INSERT INTO Orders
  VALUES (664, '1999-11-10', '1999-11-10', 1015, 707)
INSERT INTO Orders
  VALUES (665, '1999-11-10', '1999-11-10', 1020, 704)
INSERT INTO Orders
  VALUES (666, '1999-11-10', '1999-11-12', 1012, 707)
INSERT INTO Orders
  VALUES (667, '1999-11-10', '1999-11-13', 1009, 708)
INSERT INTO Orders
  VALUES (668, '1999-11-10', '1999-11-13', 1018, 708)
INSERT INTO Orders
  VALUES (669, '1999-11-10', '1999-11-13', 1017, 708)
INSERT INTO Orders
  VALUES (670, '1999-11-11', '1999-11-15', 1021, 701)
INSERT INTO Orders
  VALUES (671, '1999-11-11', '1999-11-11', 1008, 707)
INSERT INTO Orders
  VALUES (672, '1999-11-11', '1999-11-14', 1005, 707)
INSERT INTO Orders
  VALUES (673, '1999-11-11', '1999-11-11', 1026, 708)
INSERT INTO Orders
  VALUES (674, '1999-11-11', '1999-11-11', 1016, 705)
INSERT INTO Orders
  VALUES (675, '1999-11-11', '1999-11-12', 1016, 702)
INSERT INTO Orders
  VALUES (676, '1999-11-11', '1999-11-14', 1002, 701)
INSERT INTO Orders
  VALUES (677, '1999-11-12', '1999-11-15', 1005, 708)
INSERT INTO Orders
  VALUES (678, '1999-11-12', '1999-11-15', 1013, 704)
INSERT INTO Orders
  VALUES (679, '1999-11-12', '1999-11-13', 1026, 707)
INSERT INTO Orders
  VALUES (680, '1999-11-12', '1999-11-15', 1013, 703)
INSERT INTO Orders
  VALUES (681, '1999-11-12', '1999-11-13', 1015, 702)
INSERT INTO Orders
  VALUES (682, '1999-11-12', '1999-11-14', 1018, 704)
INSERT INTO Orders
  VALUES (683, '1999-11-12', '1999-11-12', 1018, 702)
INSERT INTO Orders
  VALUES (684, '1999-11-13', '1999-11-16', 1027, 708)
INSERT INTO Orders
  VALUES (685, '1999-11-13', '1999-11-14', 1005, 704)
INSERT INTO Orders
  VALUES (686, '1999-11-13', '1999-11-17', 1026, 701)
INSERT INTO Orders
  VALUES (687, '1999-11-13', '1999-11-15', 1021, 705)
INSERT INTO Orders
  VALUES (688, '1999-11-13', '1999-11-17', 1002, 702)
INSERT INTO Orders
  VALUES (689, '1999-11-13', '1999-11-14', 1015, 705)
INSERT INTO Orders
  VALUES (690, '1999-11-13', '1999-11-13', 1016, 702)
INSERT INTO Orders
  VALUES (691, '1999-11-13', '1999-11-17', 1004, 707)
INSERT INTO Orders
  VALUES (692, '1999-11-14', '1999-11-17', 1019, 701)
INSERT INTO Orders
  VALUES (693, '1999-11-14', '1999-11-17', 1002, 705)
INSERT INTO Orders
  VALUES (694, '1999-11-14', '1999-11-15', 1019, 708)
INSERT INTO Orders
  VALUES (695, '1999-11-14', '1999-11-16', 1010, 708)
INSERT INTO Orders
  VALUES (696, '1999-11-14', '1999-11-15', 1002, 708)
INSERT INTO Orders
  VALUES (697, '1999-11-14', '1999-11-14', 1005, 704)
INSERT INTO Orders
  VALUES (698, '1999-11-15', '1999-11-16', 1022, 705)
INSERT INTO Orders
  VALUES (699, '1999-11-16', '1999-11-17', 1013, 701)
INSERT INTO Orders
  VALUES (700, '1999-11-16', '1999-11-16', 1013, 707)
INSERT INTO Orders
  VALUES (701, '1999-11-16', '1999-11-18', 1001, 707)
INSERT INTO Orders
  VALUES (702, '1999-11-16', '1999-11-19', 1020, 704)
INSERT INTO Orders
  VALUES (703, '1999-11-16', '1999-11-18', 1007, 704)
INSERT INTO Orders
  VALUES (704, '1999-11-16', '1999-11-20', 1024, 704)
INSERT INTO Orders
  VALUES (705, '1999-11-16', '1999-11-19', 1015, 706)
INSERT INTO Orders
  VALUES (706, '1999-11-16', '1999-11-16', 1016, 703)
INSERT INTO Orders
  VALUES (707, '1999-11-16', '1999-11-17', 1002, 707)
INSERT INTO Orders
  VALUES (708, '1999-11-17', '1999-11-20', 1009, 708)
INSERT INTO Orders
  VALUES (709, '1999-11-17', '1999-11-17', 1018, 702)
INSERT INTO Orders
  VALUES (710, '1999-11-18', '1999-11-20', 1007, 702)
INSERT INTO Orders
  VALUES (711, '1999-11-18', '1999-11-20', 1019, 704)
INSERT INTO Orders
  VALUES (712, '1999-11-18', '1999-11-21', 1024, 705)
INSERT INTO Orders
  VALUES (713, '1999-11-18', '1999-11-22', 1007, 701)
INSERT INTO Orders
  VALUES (714, '1999-11-18', '1999-11-22', 1019, 707)
INSERT INTO Orders
  VALUES (715, '1999-11-18', '1999-11-22', 1020, 707)
INSERT INTO Orders
  VALUES (716, '1999-11-19', '1999-11-23', 1016, 701)
INSERT INTO Orders
  VALUES (717, '1999-11-19', '1999-11-19', 1008, 701)
INSERT INTO Orders
  VALUES (718, '1999-11-19', '1999-11-20', 1010, 705)
INSERT INTO Orders
  VALUES (719, '1999-11-19', '1999-11-22', 1027, 703)
INSERT INTO Orders
  VALUES (720, '1999-11-20', '1999-11-24', 1010, 707)
INSERT INTO Orders
  VALUES (721, '1999-11-20', '1999-11-21', 1015, 705)
INSERT INTO Orders
  VALUES (722, '1999-11-20', '1999-11-21', 1006, 703)
INSERT INTO Orders
  VALUES (723, '1999-11-20', '1999-11-23', 1001, 707)
INSERT INTO Orders
  VALUES (724, '1999-11-21', '1999-11-21', 1017, 704)
INSERT INTO Orders
  VALUES (725, '1999-11-21', '1999-11-23', 1009, 702)
INSERT INTO Orders
  VALUES (726, '1999-11-21', '1999-11-25', 1015, 703)
INSERT INTO Orders
  VALUES (727, '1999-11-21', '1999-11-22', 1017, 706)
INSERT INTO Orders
  VALUES (728, '1999-11-21', '1999-11-23', 1008, 706)
INSERT INTO Orders
  VALUES (729, '1999-11-21', '1999-11-23', 1021, 704)
INSERT INTO Orders
  VALUES (730, '1999-11-21', '1999-11-23', 1023, 706)
INSERT INTO Orders
  VALUES (731, '1999-11-21', '1999-11-25', 1014, 702)
INSERT INTO Orders
  VALUES (732, '1999-11-22', '1999-11-24', 1001, 707)
INSERT INTO Orders
  VALUES (733, '1999-11-22', '1999-11-23', 1011, 706)
INSERT INTO Orders
  VALUES (734, '1999-11-23', '1999-11-25', 1016, 706)
INSERT INTO Orders
  VALUES (735, '1999-11-23', '1999-11-23', 1027, 708)
INSERT INTO Orders
  VALUES (736, '1999-11-23', '1999-11-27', 1003, 708)
INSERT INTO Orders
  VALUES (737, '1999-11-23', '1999-11-26', 1020, 708)
INSERT INTO Orders
  VALUES (738, '1999-11-23', '1999-11-25', 1017, 704)
INSERT INTO Orders
  VALUES (739, '1999-11-23', '1999-11-24', 1022, 703)
INSERT INTO Orders
  VALUES (740, '1999-11-24', '1999-11-25', 1011, 708)
INSERT INTO Orders
  VALUES (741, '1999-11-24', '1999-11-24', 1024, 707)
INSERT INTO Orders
  VALUES (742, '1999-11-24', '1999-11-27', 1013, 706)
INSERT INTO Orders
  VALUES (743, '1999-11-24', '1999-11-26', 1008, 708)
INSERT INTO Orders
  VALUES (744, '1999-11-24', '1999-11-27', 1027, 703)
INSERT INTO Orders
  VALUES (745, '1999-11-24', '1999-11-28', 1027, 706)
INSERT INTO Orders
  VALUES (746, '1999-11-24', '1999-11-28', 1013, 702)
INSERT INTO Orders
  VALUES (747, '1999-11-24', '1999-11-27', 1016, 703)
INSERT INTO Orders
  VALUES (748, '1999-11-24', '1999-11-27', 1021, 703)
INSERT INTO Orders
  VALUES (749, '1999-11-24', '1999-11-28', 1021, 702)
INSERT INTO Orders
  VALUES (750, '1999-11-25', '1999-11-29', 1018, 708)
INSERT INTO Orders
  VALUES (751, '1999-11-25', '1999-11-29', 1025, 707)
INSERT INTO Orders
  VALUES (752, '1999-11-26', '1999-11-30', 1005, 702)
INSERT INTO Orders
  VALUES (753, '1999-11-26', '1999-11-28', 1013, 701)
INSERT INTO Orders
  VALUES (754, '1999-11-26', '1999-11-30', 1014, 708)
INSERT INTO Orders
  VALUES (755, '1999-11-27', '1999-11-30', 1010, 708)
INSERT INTO Orders
  VALUES (756, '1999-11-27', '1999-11-27', 1005, 706)
INSERT INTO Orders
  VALUES (757, '1999-11-27', '1999-11-29', 1014, 702)
INSERT INTO Orders
  VALUES (758, '1999-11-27', '1999-11-29', 1020, 708)
INSERT INTO Orders
  VALUES (759, '1999-11-27', '1999-11-27', 1016, 703)
INSERT INTO Orders
  VALUES (760, '1999-11-27', '1999-11-30', 1014, 707)
INSERT INTO Orders
  VALUES (761, '1999-11-28', '1999-11-29', 1016, 708)
INSERT INTO Orders
  VALUES (762, '1999-11-28', '1999-12-02', 1013, 705)
INSERT INTO Orders
  VALUES (763, '1999-11-28', '1999-12-01', 1009, 701)
INSERT INTO Orders
  VALUES (764, '1999-11-28', '1999-11-28', 1003, 702)
INSERT INTO Orders
  VALUES (765, '1999-11-28', '1999-11-30', 1016, 703)
INSERT INTO Orders
  VALUES (766, '1999-11-28', '1999-11-29', 1026, 707)
INSERT INTO Orders
  VALUES (767, '1999-11-29', '1999-11-30', 1017, 706)
INSERT INTO Orders
  VALUES (768, '1999-11-29', '1999-12-03', 1003, 706)
INSERT INTO Orders
  VALUES (769, '1999-11-29', '1999-12-01', 1020, 705)
INSERT INTO Orders
  VALUES (770, '1999-11-29', '1999-11-29', 1019, 702)
INSERT INTO Orders
  VALUES (771, '1999-11-29', '1999-12-01', 1017, 707)
INSERT INTO Orders
  VALUES (772, '1999-11-29', '1999-11-30', 1024, 704)
INSERT INTO Orders
  VALUES (773, '1999-11-29', '1999-12-02', 1019, 705)
INSERT INTO Orders
  VALUES (774, '1999-11-30', '1999-12-02', 1013, 704)
INSERT INTO Orders
  VALUES (775, '1999-11-30', '1999-11-30', 1010, 704)
INSERT INTO Orders
  VALUES (776, '1999-11-30', '1999-11-30', 1006, 708)
INSERT INTO Orders
  VALUES (777, '1999-11-30', '1999-12-02', 1026, 708)
INSERT INTO Orders
  VALUES (778, '1999-11-30', '1999-11-30', 1025, 707)
INSERT INTO Orders
  VALUES (779, '1999-11-30', '1999-11-30', 1004, 705)
INSERT INTO Orders
  VALUES (780, '1999-11-30', '1999-11-30', 1003, 701)
INSERT INTO Orders
  VALUES (781, '1999-11-30', '1999-12-04', 1021, 704)
INSERT INTO Orders
  VALUES (782, '1999-11-30', '1999-12-03', 1016, 702)
INSERT INTO Orders
  VALUES (783, '1999-11-30', '1999-12-04', 1013, 704)
INSERT INTO Orders
  VALUES (784, '1999-12-01', '1999-12-04', 1018, 707)
INSERT INTO Orders
  VALUES (785, '1999-12-01', '1999-12-05', 1027, 706)
INSERT INTO Orders
  VALUES (786, '1999-12-01', '1999-12-01', 1015, 704)
INSERT INTO Orders
  VALUES (787, '1999-12-01', '1999-12-03', 1009, 707)
INSERT INTO Orders
  VALUES (788, '1999-12-01', '1999-12-01', 1026, 704)
INSERT INTO Orders
  VALUES (789, '1999-12-01', '1999-12-05', 1021, 707)
INSERT INTO Orders
  VALUES (790, '1999-12-01', '1999-12-01', 1004, 707)
INSERT INTO Orders
  VALUES (791, '1999-12-01', '1999-12-02', 1017, 706)
INSERT INTO Orders
  VALUES (792, '1999-12-02', '1999-12-05', 1027, 707)
INSERT INTO Orders
  VALUES (793, '1999-12-02', '1999-12-03', 1026, 706)
INSERT INTO Orders
  VALUES (794, '1999-12-02', '1999-12-04', 1016, 703)
INSERT INTO Orders
  VALUES (795, '1999-12-03', '1999-12-05', 1024, 707)
INSERT INTO Orders
  VALUES (796, '1999-12-03', '1999-12-07', 1007, 703)
INSERT INTO Orders
  VALUES (797, '1999-12-03', '1999-12-06', 1018, 705)
INSERT INTO Orders
  VALUES (798, '1999-12-03', '1999-12-04', 1003, 702)
INSERT INTO Orders
  VALUES (799, '1999-12-04', '1999-12-05', 1010, 704)
INSERT INTO Orders
  VALUES (800, '1999-12-04', '1999-12-07', 1027, 707)
INSERT INTO Orders
  VALUES (801, '1999-12-04', '1999-12-08', 1002, 707)
INSERT INTO Orders
  VALUES (802, '1999-12-04', '1999-12-04', 1021, 707)
INSERT INTO Orders
  VALUES (803, '1999-12-05', '1999-12-08', 1004, 704)
INSERT INTO Orders
  VALUES (804, '1999-12-05', '1999-12-05', 1014, 708)
INSERT INTO Orders
  VALUES (805, '1999-12-05', '1999-12-05', 1009, 702)
INSERT INTO Orders
  VALUES (806, '1999-12-05', '1999-12-07', 1019, 707)
INSERT INTO Orders
  VALUES (807, '1999-12-06', '1999-12-07', 1016, 705)
INSERT INTO Orders
  VALUES (808, '1999-12-06', '1999-12-07', 1004, 704)
INSERT INTO Orders
  VALUES (809, '1999-12-07', '1999-12-11', 1004, 701)
INSERT INTO Orders
  VALUES (810, '1999-12-07', '1999-12-07', 1022, 705)
INSERT INTO Orders
  VALUES (811, '1999-12-07', '1999-12-11', 1008, 707)
INSERT INTO Orders
  VALUES (812, '1999-12-07', '1999-12-07', 1005, 707)
INSERT INTO Orders
  VALUES (813, '1999-12-08', '1999-12-08', 1013, 705)
INSERT INTO Orders
  VALUES (814, '1999-12-08', '1999-12-08', 1013, 706)
INSERT INTO Orders
  VALUES (815, '1999-12-08', '1999-12-12', 1007, 702)
INSERT INTO Orders
  VALUES (816, '1999-12-08', '1999-12-11', 1011, 701)
INSERT INTO Orders
  VALUES (817, '1999-12-08', '1999-12-08', 1001, 705)
INSERT INTO Orders
  VALUES (818, '1999-12-08', '1999-12-10', 1023, 704)
INSERT INTO Orders
  VALUES (819, '1999-12-08', '1999-12-12', 1013, 707)
INSERT INTO Orders
  VALUES (820, '1999-12-08', '1999-12-09', 1019, 704)
INSERT INTO Orders
  VALUES (821, '1999-12-08', '1999-12-12', 1023, 708)
INSERT INTO Orders
  VALUES (822, '1999-12-08', '1999-12-09', 1004, 701)
INSERT INTO Orders
  VALUES (823, '1999-12-09', '1999-12-10', 1003, 703)
INSERT INTO Orders
  VALUES (824, '1999-12-09', '1999-12-10', 1006, 701)
INSERT INTO Orders
  VALUES (825, '1999-12-09', '1999-12-09', 1025, 708)
INSERT INTO Orders
  VALUES (826, '1999-12-09', '1999-12-09', 1005, 707)
INSERT INTO Orders
  VALUES (827, '1999-12-10', '1999-12-14', 1013, 706)
INSERT INTO Orders
  VALUES (828, '1999-12-10', '1999-12-10', 1014, 701)
INSERT INTO Orders
  VALUES (829, '1999-12-10', '1999-12-11', 1027, 701)
INSERT INTO Orders
  VALUES (830, '1999-12-11', '1999-12-13', 1020, 703)
INSERT INTO Orders
  VALUES (831, '1999-12-11', '1999-12-14', 1012, 705)
INSERT INTO Orders
  VALUES (832, '1999-12-11', '1999-12-15', 1012, 707)
INSERT INTO Orders
  VALUES (833, '1999-12-11', '1999-12-15', 1007, 706)
INSERT INTO Orders
  VALUES (834, '1999-12-11', '1999-12-11', 1021, 704)
INSERT INTO Orders
  VALUES (835, '1999-12-11', '1999-12-13', 1012, 703)
INSERT INTO Orders
  VALUES (836, '1999-12-11', '1999-12-14', 1007, 708)
INSERT INTO Orders
  VALUES (837, '1999-12-11', '1999-12-13', 1012, 701)
INSERT INTO Orders
  VALUES (838, '1999-12-11', '1999-12-13', 1014, 706)
INSERT INTO Orders
  VALUES (839, '1999-12-12', '1999-12-12', 1012, 702)
INSERT INTO Orders
  VALUES (840, '1999-12-12', '1999-12-12', 1001, 701)
INSERT INTO Orders
  VALUES (841, '1999-12-12', '1999-12-16', 1017, 707)
INSERT INTO Orders
  VALUES (842, '1999-12-12', '1999-12-14', 1013, 707)
INSERT INTO Orders
  VALUES (843, '1999-12-12', '1999-12-14', 1008, 705)
INSERT INTO Orders
  VALUES (844, '1999-12-12', '1999-12-14', 1014, 708)
INSERT INTO Orders
  VALUES (845, '1999-12-12', '1999-12-15', 1020, 701)
INSERT INTO Orders
  VALUES (846, '1999-12-13', '1999-12-17', 1012, 704)
INSERT INTO Orders
  VALUES (847, '1999-12-13', '1999-12-15', 1027, 706)
INSERT INTO Orders
  VALUES (848, '1999-12-13', '1999-12-16', 1014, 706)
INSERT INTO Orders
  VALUES (849, '1999-12-13', '1999-12-15', 1026, 708)
INSERT INTO Orders
  VALUES (850, '1999-12-13', '1999-12-13', 1003, 701)
INSERT INTO Orders
  VALUES (851, '1999-12-13', '1999-12-13', 1001, 702)
INSERT INTO Orders
  VALUES (852, '1999-12-13', '1999-12-16', 1002, 707)
INSERT INTO Orders
  VALUES (853, '1999-12-13', '1999-12-16', 1023, 708)
INSERT INTO Orders
  VALUES (854, '1999-12-13', '1999-12-16', 1004, 706)
INSERT INTO Orders
  VALUES (855, '1999-12-14', '1999-12-15', 1001, 704)
INSERT INTO Orders
  VALUES (856, '1999-12-14', '1999-12-14', 1026, 703)
INSERT INTO Orders
  VALUES (857, '1999-12-14', '1999-12-14', 1017, 708)
INSERT INTO Orders
  VALUES (858, '1999-12-15', '1999-12-19', 1023, 701)
INSERT INTO Orders
  VALUES (859, '1999-12-16', '1999-12-16', 1016, 703)
INSERT INTO Orders
  VALUES (860, '1999-12-16', '1999-12-19', 1003, 703)
INSERT INTO Orders
  VALUES (861, '1999-12-16', '1999-12-16', 1026, 708)
INSERT INTO Orders
  VALUES (862, '1999-12-16', '1999-12-20', 1010, 702)
INSERT INTO Orders
  VALUES (863, '1999-12-16', '1999-12-17', 1025, 704)
INSERT INTO Orders
  VALUES (864, '1999-12-16', '1999-12-16', 1008, 707)
INSERT INTO Orders
  VALUES (865, '1999-12-16', '1999-12-20', 1024, 703)
INSERT INTO Orders
  VALUES (866, '1999-12-16', '1999-12-17', 1022, 706)
INSERT INTO Orders
  VALUES (867, '1999-12-16', '1999-12-20', 1017, 708)
INSERT INTO Orders
  VALUES (868, '1999-12-16', '1999-12-18', 1021, 702)
INSERT INTO Orders
  VALUES (869, '1999-12-17', '1999-12-19', 1024, 708)
INSERT INTO Orders
  VALUES (870, '1999-12-17', '1999-12-20', 1005, 704)
INSERT INTO Orders
  VALUES (871, '1999-12-17', '1999-12-19', 1021, 708)
INSERT INTO Orders
  VALUES (872, '1999-12-17', '1999-12-21', 1017, 702)
INSERT INTO Orders
  VALUES (873, '1999-12-17', '1999-12-18', 1020, 702)
INSERT INTO Orders
  VALUES (874, '1999-12-18', '1999-12-21', 1005, 702)
INSERT INTO Orders
  VALUES (875, '1999-12-18', '1999-12-22', 1017, 702)
INSERT INTO Orders
  VALUES (876, '1999-12-18', '1999-12-18', 1005, 708)
INSERT INTO Orders
  VALUES (877, '1999-12-18', '1999-12-18', 1017, 708)
INSERT INTO Orders
  VALUES (878, '1999-12-18', '1999-12-21', 1008, 706)
INSERT INTO Orders
  VALUES (879, '1999-12-18', '1999-12-19', 1013, 705)
INSERT INTO Orders
  VALUES (880, '1999-12-18', '1999-12-22', 1006, 704)
INSERT INTO Orders
  VALUES (881, '1999-12-18', '1999-12-20', 1016, 707)
INSERT INTO Orders
  VALUES (882, '1999-12-18', '1999-12-22', 1008, 707)
INSERT INTO Orders
  VALUES (883, '1999-12-19', '1999-12-22', 1011, 704)
INSERT INTO Orders
  VALUES (884, '1999-12-19', '1999-12-22', 1027, 704)
INSERT INTO Orders
  VALUES (885, '1999-12-20', '1999-12-23', 1009, 701)
INSERT INTO Orders
  VALUES (886, '1999-12-20', '1999-12-21', 1027, 708)
INSERT INTO Orders
  VALUES (887, '1999-12-20', '1999-12-23', 1001, 705)
INSERT INTO Orders
  VALUES (888, '1999-12-20', '1999-12-23', 1007, 707)
INSERT INTO Orders
  VALUES (889, '1999-12-20', '1999-12-24', 1023, 702)
INSERT INTO Orders
  VALUES (890, '1999-12-20', '1999-12-24', 1022, 705)
INSERT INTO Orders
  VALUES (891, '1999-12-20', '1999-12-21', 1006, 706)
INSERT INTO Orders
  VALUES (892, '1999-12-21', '1999-12-22', 1010, 703)
INSERT INTO Orders
  VALUES (893, '1999-12-21', '1999-12-25', 1022, 705)
INSERT INTO Orders
  VALUES (894, '1999-12-21', '1999-12-23', 1024, 704)
INSERT INTO Orders
  VALUES (895, '1999-12-21', '1999-12-21', 1011, 705)
INSERT INTO Orders
  VALUES (896, '1999-12-21', '1999-12-24', 1025, 702)
INSERT INTO Orders
  VALUES (897, '1999-12-21', '1999-12-24', 1027, 701)
INSERT INTO Orders
  VALUES (898, '1999-12-21', '1999-12-24', 1001, 708)
INSERT INTO Orders
  VALUES (899, '1999-12-21', '1999-12-25', 1009, 705)
INSERT INTO Orders
  VALUES (900, '1999-12-22', '1999-12-24', 1020, 701)
INSERT INTO Orders
  VALUES (901, '1999-12-22', '1999-12-24', 1013, 707)
INSERT INTO Orders
  VALUES (902, '1999-12-22', '1999-12-23', 1006, 702)
INSERT INTO Orders
  VALUES (903, '1999-12-22', '1999-12-23', 1021, 707)
INSERT INTO Orders
  VALUES (904, '1999-12-22', '1999-12-26', 1009, 708)
INSERT INTO Orders
  VALUES (905, '1999-12-22', '1999-12-24', 1024, 704)
INSERT INTO Orders
  VALUES (906, '1999-12-22', '1999-12-22', 1012, 707)
INSERT INTO Orders
  VALUES (907, '1999-12-23', '1999-12-23', 1014, 702)
INSERT INTO Orders
  VALUES (908, '1999-12-23', '1999-12-24', 1025, 705)
INSERT INTO Orders
  VALUES (909, '1999-12-24', '1999-12-24', 1024, 705)
INSERT INTO Orders
  VALUES (910, '1999-12-24', '1999-12-27', 1019, 702)
INSERT INTO Orders
  VALUES (911, '1999-12-24', '1999-12-26', 1023, 702)
INSERT INTO Orders
  VALUES (912, '1999-12-24', '1999-12-28', 1025, 706)
INSERT INTO Orders
  VALUES (913, '1999-12-24', '1999-12-25', 1025, 707)
INSERT INTO Orders
  VALUES (914, '1999-12-24', '1999-12-24', 1022, 707)
INSERT INTO Orders
  VALUES (915, '1999-12-24', '1999-12-25', 1016, 705)
INSERT INTO Orders
  VALUES (916, '1999-12-24', '1999-12-24', 1025, 705)
INSERT INTO Orders
  VALUES (917, '1999-12-24', '1999-12-26', 1013, 703)
INSERT INTO Orders
  VALUES (918, '1999-12-25', '1999-12-28', 1025, 703)
INSERT INTO Orders
  VALUES (919, '1999-12-25', '1999-12-27', 1014, 707)
INSERT INTO Orders
  VALUES (920, '1999-12-26', '1999-12-29', 1008, 708)
INSERT INTO Orders
  VALUES (921, '1999-12-26', '1999-12-26', 1018, 702)
INSERT INTO Orders
  VALUES (922, '1999-12-26', '1999-12-27', 1004, 706)
INSERT INTO Orders
  VALUES (923, '1999-12-26', '1999-12-29', 1009, 707)
INSERT INTO Orders
  VALUES (924, '1999-12-26', '1999-12-29', 1002, 704)
INSERT INTO Orders
  VALUES (925, '1999-12-26', '1999-12-26', 1025, 702)
INSERT INTO Orders
  VALUES (926, '1999-12-26', '1999-12-27', 1005, 701)
INSERT INTO Orders
  VALUES (927, '1999-12-27', '1999-12-28', 1007, 704)
INSERT INTO Orders
  VALUES (928, '1999-12-27', '1999-12-30', 1017, 706)
INSERT INTO Orders
  VALUES (929, '1999-12-27', '1999-12-27', 1020, 705)
INSERT INTO Orders
  VALUES (930, '1999-12-27', '1999-12-29', 1023, 701)
INSERT INTO Orders
  VALUES (931, '1999-12-27', '1999-12-27', 1001, 707)
INSERT INTO Orders
  VALUES (932, '1999-12-27', '1999-12-27', 1012, 704)
INSERT INTO Orders
  VALUES (933, '1999-12-27', '1999-12-27', 1026, 705)
INSERT INTO Orders
  VALUES (934, '1999-12-27', '1999-12-28', 1021, 705)
INSERT INTO Orders
  VALUES (935, '1999-12-27', '1999-12-30', 1020, 702)
INSERT INTO Orders
  VALUES (936, '1999-12-28', '1999-12-29', 1025, 704)
INSERT INTO Orders
  VALUES (937, '1999-12-28', '2000-01-01', 1014, 706)
INSERT INTO Orders
  VALUES (938, '1999-12-28', '1999-12-28', 1011, 705)
INSERT INTO Orders
  VALUES (939, '1999-12-28', '1999-12-28', 1021, 701)
INSERT INTO Orders
  VALUES (940, '1999-12-28', '2000-01-01', 1007, 702)
INSERT INTO Orders
  VALUES (941, '1999-12-28', '1999-12-28', 1019, 702)
INSERT INTO Orders
  VALUES (942, '1999-12-28', '1999-12-29', 1002, 706)
INSERT INTO Orders
  VALUES (943, '1999-12-28', '1999-12-29', 1026, 707)
INSERT INTO Orders
  VALUES (944, '1999-12-28', '1999-12-31', 1020, 702)

/*==============================================================*/
/* Index: CUSTOMERS_ORDERS_FK                                   */
/*==============================================================*/
create index CUSTOMERS_ORDERS_FK on ORDERS (
CUSTOMERID ASC
)
go

/*==============================================================*/
/* Index: EMPLOEEYS_ORDERS_FK                                   */
/*==============================================================*/
create index EMPLOEEYS_ORDERS_FK on ORDERS (
EMPLOYEEID ASC
)
go

/*==============================================================*/
/* Table: ORDER_DETAILS                                         */
/*==============================================================*/
create table ORDER_DETAILS (
   ORDERNUMBER          bigint               not null,
   PRODUCTNUMBER        bigint               not null,
   QUOTEDPRICE          float(8)             null,
   QUANTITYORDERED      bigint               null,
   constraint PK_ORDER_DETAILS primary key nonclustered (ORDERNUMBER, PRODUCTNUMBER)
)
go
INSERT INTO Order_Details
  VALUES (1, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (1, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (1, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (1, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (1, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (1, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (1, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (2, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (2, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (2, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (3, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (3, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (3, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (3, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (3, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (3, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (3, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (3, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (4, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (4, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (4, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (4, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (4, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (5, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (5, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (5, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (6, 2, 1746, 5)
INSERT INTO Order_Details
  VALUES (6, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (6, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (6, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (6, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (6, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (6, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (7, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (7, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (7, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (8, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (8, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (8, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (8, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (8, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (8, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (9, 4, 53.3, 5)
INSERT INTO Order_Details
  VALUES (9, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (10, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (10, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (11, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (11, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (11, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (11, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (11, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (11, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (11, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (11, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (12, 10, 36, 2)
INSERT INTO Order_Details
  VALUES (13, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (13, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (13, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (13, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (14, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (14, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (14, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (15, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (15, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (15, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (15, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (15, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (16, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (16, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (16, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (16, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (16, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (16, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (16, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (17, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (17, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (17, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (17, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (17, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (17, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (18, 4, 54.95, 1)
INSERT INTO Order_Details
  VALUES (18, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (18, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (18, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (18, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (19, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (19, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (19, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (19, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (19, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (19, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (19, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (19, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (20, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (20, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (21, 3, 75, 3)
INSERT INTO Order_Details
  VALUES (21, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (21, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (21, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (22, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (22, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (22, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (22, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (22, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (22, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (23, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (23, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (23, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (23, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (23, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (23, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (23, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (23, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (24, 4, 53.3, 5)
INSERT INTO Order_Details
  VALUES (24, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (24, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (24, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (24, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (24, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (24, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (25, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (25, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (25, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (25, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (25, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (25, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (26, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (26, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (26, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (26, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (26, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (26, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (27, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (27, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (27, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (27, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (27, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (27, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (28, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (28, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (29, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (29, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (30, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (30, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (30, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (30, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (30, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (31, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (32, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (32, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (32, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (32, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (32, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (32, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (33, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (33, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (33, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (33, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (33, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (33, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (34, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (34, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (35, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (35, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (35, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (36, 5, 7.45, 1)
INSERT INTO Order_Details
  VALUES (37, 8, 50, 3)
INSERT INTO Order_Details
  VALUES (37, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (37, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (37, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (38, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (39, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (39, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (39, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (39, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (39, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (39, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (39, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (39, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (40, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (40, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (40, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (41, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (41, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (41, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (41, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (41, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (41, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (42, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (42, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (42, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (42, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (42, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (43, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (43, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (43, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (43, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (43, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (43, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (43, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (44, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (44, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (44, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (44, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (44, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (44, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (45, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (45, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (45, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (45, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (45, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (45, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (45, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (45, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (46, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (47, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (47, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (48, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (48, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (48, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (49, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (49, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (49, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (49, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (49, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (49, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (50, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (50, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (50, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (50, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (51, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (51, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (52, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (52, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (53, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (53, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (53, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (53, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (53, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (53, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (53, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (54, 10, 36, 2)
INSERT INTO Order_Details
  VALUES (55, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (56, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (56, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (56, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (56, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (57, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (57, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (57, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (57, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (57, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (57, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (58, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (58, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (58, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (58, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (58, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (58, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (59, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (59, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (59, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (59, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (59, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (59, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (59, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (60, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (60, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (60, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (60, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (60, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (60, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (60, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (61, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (61, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (61, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (61, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (61, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (62, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (62, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (62, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (62, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (62, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (62, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (63, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (63, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (64, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (64, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (64, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (64, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (64, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (64, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (64, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (64, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (65, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (65, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (65, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (65, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (66, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (66, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (66, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (66, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (66, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (66, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (66, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (66, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (67, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (67, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (67, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (67, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (67, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (67, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (68, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (69, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (69, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (69, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (69, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (70, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (70, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (70, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (71, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (71, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (71, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (72, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (72, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (72, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (72, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (72, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (72, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (72, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (72, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (73, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (73, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (73, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (73, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (73, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (73, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (74, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (74, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (74, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (74, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (74, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (74, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (74, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (74, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (75, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (75, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (75, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (75, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (75, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (75, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (75, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (75, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (76, 18, 173.63, 5)
INSERT INTO Order_Details
  VALUES (77, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (77, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (77, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (77, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (77, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (77, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (78, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (78, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (78, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (78, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (79, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (79, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (79, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (79, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (79, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (79, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (80, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (80, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (80, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (80, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (80, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (80, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (80, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (81, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (82, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (82, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (82, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (82, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (82, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (82, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (82, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (83, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (83, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (83, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (84, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (84, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (84, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (84, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (84, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (84, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (84, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (85, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (85, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (85, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (85, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (85, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (85, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (85, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (85, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (86, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (86, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (86, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (86, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (86, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (86, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (86, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (86, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (87, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (87, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (87, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (88, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (89, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (89, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (89, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (89, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (89, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (90, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (91, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (91, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (91, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (91, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (91, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (91, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (91, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (92, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (92, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (92, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (93, 3, 75, 1)
INSERT INTO Order_Details
  VALUES (94, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (94, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (94, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (94, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (94, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (94, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (95, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (95, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (95, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (95, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (95, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (95, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (96, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (96, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (96, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (96, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (97, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (97, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (97, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (98, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (98, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (99, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (99, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (100, 3, 75, 3)
INSERT INTO Order_Details
  VALUES (100, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (100, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (100, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (100, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (101, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (101, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (101, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (101, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (101, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (102, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (102, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (102, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (102, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (102, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (103, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (103, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (103, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (103, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (103, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (103, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (103, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (104, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (104, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (105, 2, 1746, 5)
INSERT INTO Order_Details
  VALUES (105, 8, 50, 3)
INSERT INTO Order_Details
  VALUES (105, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (105, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (105, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (105, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (106, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (107, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (107, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (107, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (107, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (107, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (107, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (107, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (108, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (109, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (110, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (110, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (110, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (110, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (110, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (110, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (110, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (111, 2, 1746, 6)
INSERT INTO Order_Details
  VALUES (111, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (111, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (111, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (111, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (111, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (112, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (112, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (113, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (113, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (113, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (114, 4, 54.95, 3)
INSERT INTO Order_Details
  VALUES (114, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (114, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (115, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (115, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (115, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (115, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (115, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (116, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (116, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (116, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (116, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (116, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (117, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (117, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (117, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (117, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (117, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (117, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (117, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (118, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (119, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (119, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (119, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (119, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (119, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (119, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (119, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (120, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (120, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (120, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (120, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (120, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (121, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (121, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (121, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (122, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (122, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (122, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (122, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (122, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (123, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (123, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (123, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (123, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (123, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (123, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (124, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (124, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (125, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (125, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (125, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (126, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (126, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (126, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (126, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (126, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (126, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (126, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (126, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (127, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (127, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (127, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (127, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (127, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (127, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (128, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (128, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (128, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (128, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (129, 4, 54.95, 4)
INSERT INTO Order_Details
  VALUES (129, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (130, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (130, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (130, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (130, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (130, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (130, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (130, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (130, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (131, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (131, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (131, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (132, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (132, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (133, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (134, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (134, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (134, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (134, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (134, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (134, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (134, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (134, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (135, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (135, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (135, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (135, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (135, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (136, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (136, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (136, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (136, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (136, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (137, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (137, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (137, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (137, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (137, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (137, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (137, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (138, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (138, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (138, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (138, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (138, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (138, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (139, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (140, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (140, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (140, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (140, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (140, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (140, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (140, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (141, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (141, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (141, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (141, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (141, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (141, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (142, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (142, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (143, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (143, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (143, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (144, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (144, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (144, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (145, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (145, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (146, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (147, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (147, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (147, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (148, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (148, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (148, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (148, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (148, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (148, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (148, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (148, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (149, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (149, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (150, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (150, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (150, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (150, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (151, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (152, 2, 1800, 3)
INSERT INTO Order_Details
  VALUES (152, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (152, 12, 23.5, 4)
INSERT INTO Order_Details
  VALUES (152, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (152, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (152, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (152, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (153, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (153, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (153, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (153, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (153, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (153, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (154, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (154, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (154, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (155, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (155, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (155, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (155, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (156, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (156, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (156, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (156, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (156, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (156, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (156, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (157, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (157, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (157, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (157, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (158, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (159, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (159, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (159, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (159, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (160, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (160, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (160, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (160, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (160, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (160, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (160, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (160, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (161, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (161, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (161, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (161, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (162, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (162, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (163, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (163, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (163, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (163, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (163, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (163, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (164, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (164, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (165, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (165, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (165, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (165, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (165, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (165, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (165, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (165, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (166, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (166, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (166, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (166, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (166, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (166, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (167, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (167, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (167, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (167, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (167, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (168, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (168, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (168, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (168, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (168, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (168, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (169, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (169, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (169, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (169, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (169, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (169, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (169, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (170, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (170, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (170, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (170, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (170, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (170, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (171, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (172, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (172, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (172, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (172, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (173, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (173, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (173, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (174, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (174, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (174, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (175, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (175, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (175, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (175, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (175, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (175, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (175, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (175, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (176, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (176, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (176, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (176, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (177, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (177, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (177, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (177, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (177, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (178, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (178, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (178, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (178, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (178, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (178, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (178, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (179, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (179, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (179, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (179, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (179, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (179, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (179, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (179, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (180, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (180, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (180, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (180, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (181, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (181, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (181, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (181, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (182, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (182, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (182, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (182, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (182, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (182, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (182, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (183, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (183, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (183, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (183, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (183, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (183, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (183, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (183, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (184, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (184, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (184, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (184, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (184, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (184, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (184, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (184, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (185, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (185, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (185, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (185, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (186, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (186, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (187, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (187, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (187, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (188, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (188, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (189, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (189, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (189, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (189, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (190, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (191, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (191, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (191, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (191, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (191, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (191, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (191, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (191, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (192, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (192, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (192, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (192, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (192, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (192, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (192, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (192, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (193, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (193, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (193, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (193, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (193, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (193, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (193, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (194, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (194, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (194, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (195, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (196, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (196, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (196, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (196, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (196, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (196, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (197, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (198, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (199, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (199, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (199, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (199, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (199, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (199, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (200, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (200, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (200, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (200, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (200, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (200, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (201, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (202, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (203, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (203, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (203, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (203, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (203, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (203, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (203, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (204, 4, 54.95, 3)
INSERT INTO Order_Details
  VALUES (204, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (205, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (205, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (205, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (205, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (205, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (205, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (205, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (206, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (206, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (206, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (207, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (207, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (207, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (208, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (208, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (208, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (208, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (208, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (208, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (208, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (209, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (209, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (210, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (210, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (210, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (210, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (210, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (210, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (210, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (211, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (212, 3, 75, 2)
INSERT INTO Order_Details
  VALUES (213, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (213, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (214, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (214, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (214, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (215, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (215, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (215, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (215, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (215, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (215, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (215, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (216, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (217, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (217, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (217, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (217, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (218, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (218, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (218, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (218, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (218, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (218, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (219, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (219, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (219, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (219, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (219, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (219, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (220, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (220, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (220, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (220, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (220, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (220, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (220, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (221, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (221, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (221, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (221, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (221, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (222, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (222, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (222, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (222, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (223, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (223, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (223, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (223, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (224, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (224, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (224, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (224, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (224, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (225, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (225, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (225, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (225, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (225, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (225, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (226, 10, 36, 3)
INSERT INTO Order_Details
  VALUES (226, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (226, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (226, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (227, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (227, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (227, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (227, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (227, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (227, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (227, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (227, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (228, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (229, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (229, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (230, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (231, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (231, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (231, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (231, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (231, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (231, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (231, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (232, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (232, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (232, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (232, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (232, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (232, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (233, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (233, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (234, 10, 36, 2)
INSERT INTO Order_Details
  VALUES (234, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (234, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (235, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (235, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (235, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (235, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (235, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (236, 5, 7.45, 4)
INSERT INTO Order_Details
  VALUES (236, 10, 34.92, 6)
INSERT INTO Order_Details
  VALUES (236, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (236, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (236, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (236, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (236, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (236, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (237, 2, 1800, 2)
INSERT INTO Order_Details
  VALUES (237, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (237, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (237, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (237, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (237, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (237, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (238, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (238, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (238, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (239, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (239, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (239, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (239, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (239, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (239, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (239, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (240, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (240, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (240, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (241, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (241, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (241, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (242, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (242, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (242, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (242, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (242, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (242, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (242, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (242, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (243, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (243, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (243, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (243, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (243, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (243, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (243, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (244, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (245, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (245, 10, 34.92, 6)
INSERT INTO Order_Details
  VALUES (245, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (245, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (245, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (246, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (246, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (246, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (246, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (246, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (246, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (247, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (247, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (247, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (247, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (247, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (248, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (248, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (248, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (248, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (248, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (248, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (249, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (249, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (249, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (249, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (249, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (249, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (250, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (250, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (250, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (251, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (251, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (251, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (251, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (251, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (251, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (251, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (252, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (252, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (252, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (252, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (252, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (252, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (252, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (252, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (253, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (253, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (254, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (254, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (254, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (255, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (256, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (256, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (256, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (256, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (256, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (256, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (256, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (256, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (257, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (257, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (257, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (257, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (257, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (257, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (258, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (258, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (258, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (258, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (258, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (258, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (258, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (258, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (259, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (260, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (260, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (260, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (260, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (260, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (261, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (261, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (261, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (262, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (263, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (263, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (263, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (263, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (264, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (265, 2, 1800, 4)
INSERT INTO Order_Details
  VALUES (265, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (265, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (265, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (265, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (265, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (265, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (265, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (266, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (266, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (266, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (266, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (266, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (267, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (267, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (267, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (268, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (268, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (268, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (268, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (268, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (268, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (268, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (268, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (269, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (269, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (269, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (269, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (269, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (269, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (269, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (269, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (270, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (270, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (270, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (270, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (270, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (271, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (271, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (271, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (271, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (271, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (272, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (272, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (272, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (272, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (273, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (273, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (273, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (273, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (273, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (274, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (275, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (276, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (276, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (276, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (276, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (276, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (277, 4, 54.95, 3)
INSERT INTO Order_Details
  VALUES (277, 12, 23.5, 1)
INSERT INTO Order_Details
  VALUES (277, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (277, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (277, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (278, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (278, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (278, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (279, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (279, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (279, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (279, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (280, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (280, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (280, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (281, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (281, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (281, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (281, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (281, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (281, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (281, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (282, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (282, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (282, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (283, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (283, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (284, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (284, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (284, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (284, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (284, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (284, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (284, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (284, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (285, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (285, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (285, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (285, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (286, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (286, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (287, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (287, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (288, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (288, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (289, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (289, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (289, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (289, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (290, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (290, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (290, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (291, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (291, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (291, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (292, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (292, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (292, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (292, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (292, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (292, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (293, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (293, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (293, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (293, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (293, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (293, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (294, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (294, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (294, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (294, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (294, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (294, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (294, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (295, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (295, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (295, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (295, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (295, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (296, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (296, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (297, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (297, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (298, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (298, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (299, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (299, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (300, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (300, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (300, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (300, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (300, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (300, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (300, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (301, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (301, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (301, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (302, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (302, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (302, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (303, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (303, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (303, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (303, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (303, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (303, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (303, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (304, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (304, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (304, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (304, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (304, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (304, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (304, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (304, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (305, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (306, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (306, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (306, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (307, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (307, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (307, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (307, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (307, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (307, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (308, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (308, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (308, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (308, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (309, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (309, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (309, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (309, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (309, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (310, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (310, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (310, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (310, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (310, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (310, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (310, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (311, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (311, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (311, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (311, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (311, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (311, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (311, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (312, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (312, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (312, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (312, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (312, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (312, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (313, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (313, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (313, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (313, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (313, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (314, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (314, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (315, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (315, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (315, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (315, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (315, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (315, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (316, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (317, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (317, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (317, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (317, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (317, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (318, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (319, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (319, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (320, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (320, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (321, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (321, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (321, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (321, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (321, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (321, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (322, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (322, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (323, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (323, 12, 23.5, 4)
INSERT INTO Order_Details
  VALUES (323, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (323, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (323, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (323, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (323, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (324, 8, 50, 1)
INSERT INTO Order_Details
  VALUES (325, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (325, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (325, 12, 23.5, 1)
INSERT INTO Order_Details
  VALUES (325, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (325, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (325, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (325, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (325, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (326, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (327, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (327, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (327, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (327, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (327, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (328, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (329, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (329, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (329, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (329, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (329, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (329, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (329, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (329, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (330, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (330, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (330, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (330, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (331, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (331, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (331, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (331, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (331, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (331, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (331, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (331, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (332, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (332, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (332, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (332, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (333, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (333, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (333, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (333, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (333, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (333, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (334, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (334, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (334, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (334, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (334, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (334, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (335, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (335, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (335, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (335, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (336, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (336, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (336, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (336, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (336, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (336, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (336, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (336, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (337, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (337, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (337, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (337, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (338, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (338, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (338, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (338, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (338, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (339, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (339, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (339, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (339, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (339, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (339, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (339, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (340, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (340, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (340, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (341, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (342, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (342, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (342, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (343, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (343, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (343, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (344, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (344, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (344, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (344, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (344, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (344, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (345, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (345, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (345, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (345, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (345, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (346, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (346, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (346, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (346, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (346, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (346, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (346, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (347, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (347, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (347, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (348, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (348, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (348, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (348, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (348, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (348, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (349, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (349, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (349, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (350, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (351, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (351, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (351, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (351, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (351, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (351, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (352, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (352, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (352, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (353, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (353, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (353, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (353, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (353, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (353, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (353, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (353, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (354, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (354, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (354, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (354, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (354, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (354, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (355, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (355, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (355, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (355, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (355, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (356, 2, 1800, 1)
INSERT INTO Order_Details
  VALUES (356, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (356, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (356, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (357, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (357, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (357, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (357, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (357, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (357, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (357, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (357, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (358, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (358, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (358, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (358, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (358, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (358, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (358, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (358, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (359, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (359, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (359, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (359, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (359, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (359, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (359, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (360, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (360, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (360, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (360, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (360, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (360, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (360, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (361, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (362, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (362, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (362, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (362, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (362, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (362, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (362, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (363, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (363, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (363, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (363, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (363, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (363, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (363, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (363, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (364, 3, 75, 3)
INSERT INTO Order_Details
  VALUES (364, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (364, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (364, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (365, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (365, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (366, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (366, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (366, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (366, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (366, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (366, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (366, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (367, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (367, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (367, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (367, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (367, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (367, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (367, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (368, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (368, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (369, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (370, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (370, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (370, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (370, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (370, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (371, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (371, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (371, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (372, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (372, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (372, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (372, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (372, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (372, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (372, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (372, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (373, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (373, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (373, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (373, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (373, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (373, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (373, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (373, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (374, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (374, 12, 23.5, 4)
INSERT INTO Order_Details
  VALUES (374, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (374, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (375, 2, 1800, 2)
INSERT INTO Order_Details
  VALUES (375, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (375, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (375, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (375, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (375, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (376, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (376, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (376, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (376, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (376, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (376, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (376, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (376, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (377, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (377, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (377, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (377, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (377, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (377, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (378, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (378, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (378, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (378, 18, 173.63, 5)
INSERT INTO Order_Details
  VALUES (378, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (378, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (378, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (378, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (379, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (379, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (379, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (379, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (380, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (381, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (381, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (381, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (381, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (381, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (381, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (381, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (382, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (383, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (383, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (383, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (383, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (383, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (383, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (383, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (383, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (384, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (384, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (385, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (385, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (385, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (385, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (385, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (385, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (385, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (385, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (386, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (386, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (386, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (386, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (386, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (387, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (387, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (387, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (387, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (387, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (387, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (387, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (387, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (388, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (388, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (388, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (388, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (388, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (389, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (389, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (389, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (389, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (390, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (390, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (390, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (390, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (390, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (390, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (390, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (390, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (391, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (391, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (391, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (391, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (391, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (391, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (392, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (392, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (392, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (392, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (393, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (393, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (394, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (394, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (394, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (395, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (396, 5, 7.45, 4)
INSERT INTO Order_Details
  VALUES (396, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (396, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (396, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (397, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (398, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (398, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (398, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (398, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (398, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (398, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (398, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (398, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (399, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (399, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (399, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (399, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (399, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (399, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (399, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (399, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (400, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (400, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (400, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (400, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (400, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (400, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (401, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (401, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (401, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (401, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (401, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (401, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (401, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (402, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (402, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (402, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (402, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (402, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (403, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (403, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (403, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (403, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (403, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (403, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (403, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (403, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (404, 2, 1746, 5)
INSERT INTO Order_Details
  VALUES (405, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (405, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (405, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (405, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (406, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (406, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (406, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (406, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (406, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (407, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (407, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (408, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (408, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (409, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (409, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (409, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (410, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (410, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (410, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (411, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (411, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (412, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (412, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (412, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (412, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (412, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (412, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (413, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (413, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (413, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (414, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (414, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (414, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (414, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (414, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (414, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (414, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (414, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (415, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (415, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (415, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (416, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (416, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (416, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (416, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (416, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (416, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (417, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (418, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (418, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (418, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (418, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (419, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (420, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (420, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (420, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (420, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (420, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (421, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (421, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (421, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (421, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (422, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (422, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (423, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (423, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (423, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (423, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (423, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (423, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (424, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (425, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (425, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (425, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (425, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (425, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (425, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (426, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (426, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (426, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (426, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (426, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (427, 5, 7.45, 4)
INSERT INTO Order_Details
  VALUES (427, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (427, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (428, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (428, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (428, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (428, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (428, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (428, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (428, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (429, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (430, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (431, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (431, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (431, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (431, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (431, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (431, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (432, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (432, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (432, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (432, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (432, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (432, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (432, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (433, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (433, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (433, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (433, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (433, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (433, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (433, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (434, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (434, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (434, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (434, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (434, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (434, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (434, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (434, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (435, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (436, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (436, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (437, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (437, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (437, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (437, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (437, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (438, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (438, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (438, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (438, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (438, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (438, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (438, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (439, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (439, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (439, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (440, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (440, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (441, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (441, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (441, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (441, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (441, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (441, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (441, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (442, 4, 54.95, 2)
INSERT INTO Order_Details
  VALUES (442, 12, 23.5, 4)
INSERT INTO Order_Details
  VALUES (442, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (442, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (442, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (443, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (443, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (443, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (443, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (443, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (443, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (443, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (443, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (444, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (444, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (444, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (444, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (444, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (444, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (444, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (445, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (445, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (445, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (445, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (445, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (445, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (446, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (446, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (447, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (447, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (447, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (447, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (447, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (448, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (448, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (448, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (449, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (449, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (449, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (449, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (449, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (449, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (449, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (449, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (450, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (450, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (450, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (450, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (450, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (450, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (450, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (451, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (451, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (452, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (453, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (453, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (453, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (453, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (453, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (453, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (454, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (454, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (454, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (455, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (455, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (456, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (457, 2, 1800, 1)
INSERT INTO Order_Details
  VALUES (457, 10, 36, 2)
INSERT INTO Order_Details
  VALUES (457, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (457, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (457, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (458, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (458, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (458, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (458, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (458, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (459, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (459, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (459, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (459, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (460, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (461, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (461, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (461, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (461, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (461, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (462, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (462, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (463, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (463, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (463, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (463, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (464, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (464, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (464, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (465, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (465, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (465, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (465, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (465, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (465, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (465, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (465, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (466, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (466, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (466, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (466, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (466, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (466, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (467, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (467, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (467, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (467, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (468, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (468, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (468, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (468, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (468, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (469, 2, 1746, 5)
INSERT INTO Order_Details
  VALUES (469, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (469, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (470, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (470, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (470, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (470, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (470, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (471, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (472, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (472, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (472, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (473, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (473, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (473, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (473, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (473, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (473, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (473, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (474, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (474, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (474, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (474, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (474, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (474, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (475, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (475, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (475, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (475, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (475, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (475, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (475, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (475, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (476, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (476, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (477, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (477, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (477, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (477, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (477, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (477, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (478, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (478, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (478, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (478, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (478, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (478, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (478, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (479, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (479, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (479, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (479, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (479, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (479, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (480, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (480, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (480, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (480, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (480, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (481, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (481, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (481, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (481, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (481, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (482, 4, 54.95, 1)
INSERT INTO Order_Details
  VALUES (482, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (483, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (483, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (483, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (483, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (484, 4, 54.95, 4)
INSERT INTO Order_Details
  VALUES (485, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (485, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (485, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (485, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (485, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (485, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (485, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (486, 5, 7.45, 4)
INSERT INTO Order_Details
  VALUES (486, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (486, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (486, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (486, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (486, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (486, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (486, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (487, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (487, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (487, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (487, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (488, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (488, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (489, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (489, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (490, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (490, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (490, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (491, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (491, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (491, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (491, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (491, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (491, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (492, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (492, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (492, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (492, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (492, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (492, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (493, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (493, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (494, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (495, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (495, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (495, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (495, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (495, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (495, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (496, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (496, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (496, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (497, 4, 54.95, 3)
INSERT INTO Order_Details
  VALUES (497, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (497, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (497, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (497, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (497, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (497, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (497, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (498, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (498, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (498, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (498, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (498, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (498, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (498, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (499, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (499, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (499, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (499, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (500, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (500, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (500, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (500, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (501, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (501, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (501, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (501, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (501, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (502, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (502, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (502, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (502, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (503, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (503, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (503, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (503, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (503, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (504, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (505, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (505, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (505, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (505, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (505, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (505, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (505, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (506, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (506, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (507, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (507, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (507, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (507, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (508, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (508, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (508, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (508, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (509, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (509, 18, 173.63, 5)
INSERT INTO Order_Details
  VALUES (509, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (509, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (510, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (510, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (510, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (510, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (510, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (511, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (511, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (511, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (511, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (512, 8, 48.5, 6)
INSERT INTO Order_Details
  VALUES (513, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (513, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (513, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (513, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (513, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (513, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (513, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (513, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (514, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (514, 10, 36, 3)
INSERT INTO Order_Details
  VALUES (514, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (514, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (514, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (515, 2, 1800, 2)
INSERT INTO Order_Details
  VALUES (515, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (515, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (515, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (515, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (516, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (516, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (516, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (516, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (517, 5, 7.45, 1)
INSERT INTO Order_Details
  VALUES (517, 10, 36, 2)
INSERT INTO Order_Details
  VALUES (517, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (517, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (517, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (517, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (517, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (518, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (518, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (519, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (519, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (519, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (519, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (520, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (520, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (520, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (520, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (520, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (520, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (520, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (521, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (521, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (522, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (523, 4, 54.95, 1)
INSERT INTO Order_Details
  VALUES (524, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (525, 3, 75, 2)
INSERT INTO Order_Details
  VALUES (525, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (525, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (525, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (525, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (525, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (526, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (526, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (527, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (528, 2, 1800, 3)
INSERT INTO Order_Details
  VALUES (528, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (529, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (529, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (529, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (529, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (529, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (530, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (530, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (530, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (530, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (530, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (530, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (530, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (531, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (531, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (531, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (531, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (531, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (531, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (532, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (532, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (532, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (532, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (532, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (532, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (533, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (533, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (533, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (533, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (533, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (533, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (533, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (534, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (534, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (535, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (535, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (535, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (536, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (536, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (536, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (536, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (536, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (536, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (536, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (537, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (537, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (537, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (537, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (537, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (538, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (538, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (538, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (538, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (538, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (538, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (538, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (538, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (539, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (539, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (539, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (539, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (539, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (539, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (539, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (539, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (540, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (540, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (540, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (540, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (540, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (540, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (541, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (541, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (541, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (541, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (542, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (542, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (542, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (543, 4, 54.95, 4)
INSERT INTO Order_Details
  VALUES (543, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (544, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (544, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (544, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (544, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (544, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (544, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (544, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (545, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (545, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (545, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (545, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (545, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (545, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (545, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (546, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (546, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (547, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (547, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (547, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (547, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (547, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (548, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (548, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (548, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (548, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (548, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (548, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (549, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (550, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (550, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (550, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (550, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (550, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (550, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (551, 4, 54.95, 4)
INSERT INTO Order_Details
  VALUES (551, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (551, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (551, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (551, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (551, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (551, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (552, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (552, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (552, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (552, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (552, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (552, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (552, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (553, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (553, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (553, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (553, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (554, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (554, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (554, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (554, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (554, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (555, 3, 72.75, 5)
INSERT INTO Order_Details
  VALUES (555, 8, 50, 3)
INSERT INTO Order_Details
  VALUES (555, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (555, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (555, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (555, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (555, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (555, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (556, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (556, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (556, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (556, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (556, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (557, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (557, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (557, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (557, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (557, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (557, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (557, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (558, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (558, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (558, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (558, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (558, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (558, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (558, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (559, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (559, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (559, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (559, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (559, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (559, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (559, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (559, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (560, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (560, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (560, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (560, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (560, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (560, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (561, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (562, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (563, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (563, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (563, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (563, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (563, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (563, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (564, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (564, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (564, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (565, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (565, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (566, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (566, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (566, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (566, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (566, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (566, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (567, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (567, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (567, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (568, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (569, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (569, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (569, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (569, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (569, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (569, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (570, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (570, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (570, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (570, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (571, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (571, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (571, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (572, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (572, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (572, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (572, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (572, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (572, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (573, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (573, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (573, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (573, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (573, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (573, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (574, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (575, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (575, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (575, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (575, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (575, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (575, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (575, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (575, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (576, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (577, 4, 54.95, 2)
INSERT INTO Order_Details
  VALUES (577, 12, 23.5, 1)
INSERT INTO Order_Details
  VALUES (577, 20, 14.55, 5)
INSERT INTO Order_Details
  VALUES (577, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (577, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (578, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (578, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (578, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (578, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (579, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (579, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (579, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (579, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (579, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (579, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (579, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (580, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (580, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (581, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (581, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (581, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (581, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (581, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (581, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (581, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (581, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (582, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (582, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (582, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (582, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (582, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (582, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (582, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (582, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (583, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (583, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (583, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (583, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (583, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (583, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (584, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (584, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (584, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (584, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (585, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (585, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (585, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (586, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (586, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (587, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (587, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (587, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (587, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (588, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (588, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (588, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (588, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (588, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (589, 10, 34.92, 6)
INSERT INTO Order_Details
  VALUES (589, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (589, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (590, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (590, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (590, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (590, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (590, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (590, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (590, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (591, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (591, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (591, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (591, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (591, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (591, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (592, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (592, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (592, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (592, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (592, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (592, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (592, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (593, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (594, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (594, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (594, 18, 173.63, 5)
INSERT INTO Order_Details
  VALUES (594, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (594, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (595, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (596, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (596, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (596, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (596, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (596, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (596, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (596, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (596, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (597, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (597, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (597, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (597, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (597, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (597, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (597, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (597, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (598, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (598, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (598, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (598, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (598, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (598, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (598, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (599, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (599, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (599, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (599, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (600, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (600, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (600, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (600, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (600, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (600, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (600, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (600, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (601, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (602, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (603, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (603, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (603, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (603, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (603, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (604, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (604, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (604, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (605, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (605, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (605, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (605, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (605, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (605, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (606, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (606, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (606, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (607, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (607, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (608, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (608, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (608, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (608, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (609, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (609, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (609, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (609, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (609, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (610, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (610, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (610, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (610, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (610, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (610, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (610, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (611, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (611, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (611, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (611, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (611, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (611, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (611, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (612, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (612, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (612, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (612, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (612, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (612, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (612, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (613, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (613, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (614, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (614, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (614, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (615, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (615, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (615, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (615, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (615, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (615, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (615, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (615, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (616, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (616, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (617, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (617, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (617, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (617, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (617, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (617, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (617, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (617, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (618, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (618, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (618, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (618, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (619, 3, 75, 3)
INSERT INTO Order_Details
  VALUES (619, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (620, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (620, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (620, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (620, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (620, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (620, 28, 29, 3)
INSERT INTO Order_Details
  VALUES (620, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (620, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (621, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (622, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (622, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (622, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (622, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (622, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (623, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (623, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (624, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (624, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (624, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (624, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (624, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (625, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (625, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (625, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (625, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (625, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (625, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (626, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (626, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (626, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (627, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (627, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (628, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (629, 4, 54.95, 3)
INSERT INTO Order_Details
  VALUES (630, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (630, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (630, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (630, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (631, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (631, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (631, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (631, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (631, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (631, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (632, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (633, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (633, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (634, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (634, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (634, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (634, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (635, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (635, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (635, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (635, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (635, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (635, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (636, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (636, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (636, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (636, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (636, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (636, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (636, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (636, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (637, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (637, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (637, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (637, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (637, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (637, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (637, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (637, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (638, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (638, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (639, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (639, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (639, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (639, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (639, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (639, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (640, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (640, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (640, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (641, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (641, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (641, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (641, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (642, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (642, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (642, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (642, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (642, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (643, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (643, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (643, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (643, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (643, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (644, 3, 75, 2)
INSERT INTO Order_Details
  VALUES (644, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (644, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (645, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (645, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (645, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (646, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (647, 3, 75, 1)
INSERT INTO Order_Details
  VALUES (647, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (647, 23, 82.45, 6)
INSERT INTO Order_Details
  VALUES (647, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (648, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (649, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (649, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (649, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (649, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (649, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (649, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (650, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (650, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (650, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (651, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (651, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (651, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (651, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (651, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (651, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (652, 4, 54.95, 1)
INSERT INTO Order_Details
  VALUES (652, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (652, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (652, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (652, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (652, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (652, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (652, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (653, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (653, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (653, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (653, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (654, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (654, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (654, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (654, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (654, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (654, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (654, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (655, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (655, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (655, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (655, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (655, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (656, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (656, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (656, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (656, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (657, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (657, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (657, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (657, 30, 45, 1)
INSERT INTO Order_Details
  VALUES (657, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (658, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (658, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (658, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (658, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (658, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (659, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (659, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (659, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (660, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (660, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (660, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (660, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (660, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (660, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (661, 2, 1800, 3)
INSERT INTO Order_Details
  VALUES (661, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (661, 28, 29, 1)
INSERT INTO Order_Details
  VALUES (662, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (662, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (662, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (662, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (662, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (662, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (662, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (663, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (663, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (663, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (663, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (663, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (664, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (664, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (664, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (664, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (665, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (665, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (665, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (665, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (666, 2, 1800, 3)
INSERT INTO Order_Details
  VALUES (666, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (667, 4, 53.3, 6)
INSERT INTO Order_Details
  VALUES (667, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (667, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (667, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (667, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (667, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (667, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (668, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (668, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (668, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (668, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (668, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (669, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (669, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (669, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (669, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (669, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (669, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (670, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (670, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (670, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (671, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (671, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (671, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (671, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (671, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (671, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (671, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (672, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (672, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (672, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (672, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (672, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (673, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (673, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (673, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (674, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (674, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (675, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (675, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (675, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (675, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (675, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (676, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (676, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (676, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (676, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (676, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (676, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (676, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (677, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (677, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (677, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (677, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (677, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (677, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (678, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (678, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (678, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (678, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (678, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (678, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (678, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (679, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (679, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (679, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (679, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (679, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (679, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (679, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (679, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (680, 8, 48.5, 6)
INSERT INTO Order_Details
  VALUES (680, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (680, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (680, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (680, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (680, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (681, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (681, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (681, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (681, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (681, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (681, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (681, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (682, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (682, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (682, 12, 23.5, 3)
INSERT INTO Order_Details
  VALUES (682, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (682, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (682, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (682, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (682, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (683, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (684, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (684, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (684, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (684, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (684, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (684, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (684, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (684, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (685, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (685, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (685, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (685, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (685, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (685, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (685, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (686, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (686, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (686, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (686, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (686, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (686, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (687, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (687, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (687, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (687, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (687, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (687, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (688, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (688, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (688, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (688, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (688, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (689, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (689, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (690, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (690, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (690, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (690, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (691, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (691, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (691, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (691, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (691, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (691, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (691, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (691, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (692, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (692, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (693, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (693, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (693, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (693, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (694, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (694, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (694, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (694, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (694, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (694, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (695, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (695, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (696, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (696, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (696, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (696, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (696, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (696, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (696, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (696, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (697, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (697, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (697, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (698, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (698, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (698, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (698, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (698, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (699, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (699, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (699, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (699, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (700, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (700, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (701, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (701, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (701, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (701, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (702, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (702, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (702, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (702, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (702, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (702, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (702, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (703, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (703, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (704, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (704, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (705, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (705, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (705, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (705, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (706, 8, 50, 3)
INSERT INTO Order_Details
  VALUES (706, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (706, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (706, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (707, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (708, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (708, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (708, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (708, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (708, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (708, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (708, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (708, 38, 161.02, 6)
INSERT INTO Order_Details
  VALUES (709, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (709, 12, 23.5, 1)
INSERT INTO Order_Details
  VALUES (709, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (709, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (709, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (709, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (709, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (710, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (710, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (710, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (710, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (710, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (711, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (711, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (711, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (711, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (711, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (711, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (711, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (711, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (712, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (712, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (712, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (712, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (712, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (713, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (714, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (714, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (714, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (714, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (714, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (714, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (714, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (714, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (715, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (715, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (715, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (715, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (715, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (715, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (716, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (716, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (717, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (717, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (717, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (717, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (717, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (717, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (718, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (718, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (718, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (719, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (719, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (719, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (720, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (720, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (720, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (721, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (721, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (721, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (721, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (721, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (722, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (722, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (722, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (722, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (723, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (723, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (723, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (723, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (723, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (724, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (724, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (724, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (724, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (724, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (725, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (725, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (726, 3, 75, 2)
INSERT INTO Order_Details
  VALUES (726, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (726, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (726, 18, 179, 1)
INSERT INTO Order_Details
  VALUES (726, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (726, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (726, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (727, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (727, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (727, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (727, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (727, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (727, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (727, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (728, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (728, 22, 82, 1)
INSERT INTO Order_Details
  VALUES (728, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (729, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (729, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (729, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (730, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (730, 9, 32.01, 5)
INSERT INTO Order_Details
  VALUES (730, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (730, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (730, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (731, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (731, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (731, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (731, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (731, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (731, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (732, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (732, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (732, 18, 179, 2)
INSERT INTO Order_Details
  VALUES (732, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (732, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (732, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (732, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (733, 8, 50, 1)
INSERT INTO Order_Details
  VALUES (733, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (733, 24, 69, 1)
INSERT INTO Order_Details
  VALUES (733, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (733, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (734, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (734, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (735, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (735, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (735, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (735, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (735, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (735, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (736, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (736, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (736, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (736, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (737, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (738, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (738, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (738, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (738, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (739, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (739, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (740, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (740, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (740, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (740, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (740, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (740, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (740, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (741, 2, 1800, 4)
INSERT INTO Order_Details
  VALUES (741, 8, 48.5, 5)
INSERT INTO Order_Details
  VALUES (741, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (741, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (741, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (741, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (742, 5, 7.45, 1)
INSERT INTO Order_Details
  VALUES (742, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (742, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (742, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (742, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (743, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (743, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (743, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (743, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (744, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (744, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (744, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (744, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (744, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (744, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (744, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (744, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (745, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (745, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (745, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (745, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (745, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (745, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (745, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (745, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (746, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (746, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (746, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (746, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (746, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (746, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (747, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (747, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (747, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (747, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (747, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (747, 35, 39, 2)
INSERT INTO Order_Details
  VALUES (748, 5, 7.45, 4)
INSERT INTO Order_Details
  VALUES (748, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (748, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (748, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (748, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (749, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (750, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (750, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (750, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (750, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (750, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (750, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (750, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (750, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (751, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (751, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (751, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (751, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (751, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (752, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (752, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (752, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (752, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (752, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (752, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (752, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (752, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (753, 4, 54.95, 4)
INSERT INTO Order_Details
  VALUES (754, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (755, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (755, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (755, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (755, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (755, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (755, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (755, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (756, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (756, 26, 125, 2)
INSERT INTO Order_Details
  VALUES (756, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (757, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (757, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (757, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (757, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (757, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (757, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (757, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (758, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (759, 8, 50, 4)
INSERT INTO Order_Details
  VALUES (759, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (759, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (760, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (760, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (760, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (760, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (760, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (760, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (760, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (761, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (761, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (761, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (761, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (761, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (761, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (762, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (762, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (762, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (762, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (762, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (762, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (762, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (762, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (763, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (763, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (763, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (764, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (764, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (765, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (765, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (765, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (765, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (765, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (766, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (766, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (766, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (767, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (767, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (767, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (767, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (767, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (767, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (768, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (769, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (769, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (769, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (769, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (769, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (769, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (769, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (769, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (770, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (771, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (771, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (772, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (772, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (772, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (772, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (773, 4, 53.3, 5)
INSERT INTO Order_Details
  VALUES (773, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (774, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (774, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (774, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (774, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (774, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (775, 3, 75, 3)
INSERT INTO Order_Details
  VALUES (775, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (775, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (775, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (775, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (775, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (776, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (776, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (776, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (776, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (777, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (777, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (777, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (777, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (778, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (778, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (778, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (779, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (779, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (779, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (779, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (779, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (779, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (779, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (780, 5, 7.45, 1)
INSERT INTO Order_Details
  VALUES (780, 10, 34.92, 5)
INSERT INTO Order_Details
  VALUES (780, 15, 4.99, 1)
INSERT INTO Order_Details
  VALUES (780, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (780, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (780, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (780, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (780, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (781, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (781, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (781, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (781, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (781, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (782, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (783, 2, 1800, 3)
INSERT INTO Order_Details
  VALUES (783, 10, 34.92, 6)
INSERT INTO Order_Details
  VALUES (783, 18, 173.63, 5)
INSERT INTO Order_Details
  VALUES (783, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (783, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (784, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (784, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (784, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (785, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (785, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (785, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (786, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (786, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (786, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (786, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (786, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (786, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (786, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (787, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (787, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (787, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (787, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (787, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (787, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (787, 32, 31.04, 5)
INSERT INTO Order_Details
  VALUES (787, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (788, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (788, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (788, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (788, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (789, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (789, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (789, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (789, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (790, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (790, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (790, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (790, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (790, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (790, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (791, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (791, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (791, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (792, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (792, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (793, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (793, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (793, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (794, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (794, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (794, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (795, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (795, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (795, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (796, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (796, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (796, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (797, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (797, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (797, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (797, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (797, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (797, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (797, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (797, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (798, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (798, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (798, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (798, 23, 85, 1)
INSERT INTO Order_Details
  VALUES (798, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (798, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (799, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (799, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (799, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (799, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (799, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (799, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (800, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (800, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (800, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (800, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (801, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (801, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (801, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (801, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (801, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (801, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (802, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (802, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (803, 18, 179, 3)
INSERT INTO Order_Details
  VALUES (803, 38, 161.02, 5)
INSERT INTO Order_Details
  VALUES (804, 5, 7.45, 3)
INSERT INTO Order_Details
  VALUES (804, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (804, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (804, 23, 82.45, 5)
INSERT INTO Order_Details
  VALUES (804, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (804, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (805, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (805, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (805, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (806, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (806, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (806, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (806, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (806, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (807, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (807, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (807, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (807, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (808, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (808, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (808, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (809, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (809, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (809, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (809, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (809, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (809, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (810, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (810, 15, 4.99, 3)
INSERT INTO Order_Details
  VALUES (810, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (810, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (811, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (811, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (812, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (812, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (812, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (812, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (813, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (813, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (813, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (813, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (813, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (813, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (813, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (813, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (814, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (815, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (815, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (815, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (815, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (815, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (815, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (815, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (816, 25, 139, 3)
INSERT INTO Order_Details
  VALUES (817, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (817, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (817, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (817, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (817, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (817, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (817, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (817, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (818, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (818, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (818, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (818, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (818, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (819, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (819, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (819, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (819, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (819, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (819, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (819, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (820, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (821, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (821, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (822, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (822, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (822, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (822, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (822, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (823, 29, 34, 2)
INSERT INTO Order_Details
  VALUES (824, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (824, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (825, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (825, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (825, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (826, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (826, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (826, 13, 65.47, 6)
INSERT INTO Order_Details
  VALUES (826, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (826, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (826, 31, 21.34, 6)
INSERT INTO Order_Details
  VALUES (827, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (827, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (827, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (827, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (827, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (828, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (828, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (828, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (828, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (828, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (828, 40, 180, 2)
INSERT INTO Order_Details
  VALUES (829, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (829, 7, 47.53, 5)
INSERT INTO Order_Details
  VALUES (829, 13, 67.5, 3)
INSERT INTO Order_Details
  VALUES (829, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (829, 32, 32, 4)
INSERT INTO Order_Details
  VALUES (829, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (830, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (830, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (831, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (831, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (831, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (832, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (833, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (833, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (833, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (833, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (833, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (834, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (834, 12, 23.5, 3)
INSERT INTO Order_Details
  VALUES (834, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (834, 22, 82, 3)
INSERT INTO Order_Details
  VALUES (834, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (834, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (834, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (835, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (835, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (835, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (836, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (836, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (836, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (836, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (837, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (837, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (837, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (837, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (838, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (838, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (838, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (838, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (838, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (838, 33, 19, 1)
INSERT INTO Order_Details
  VALUES (838, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (839, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (839, 9, 33, 2)
INSERT INTO Order_Details
  VALUES (839, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (839, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (839, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (840, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (840, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (840, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (841, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (841, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (841, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (841, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (841, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (841, 27, 24, 3)
INSERT INTO Order_Details
  VALUES (841, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (841, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (842, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (842, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (843, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (843, 24, 69, 3)
INSERT INTO Order_Details
  VALUES (844, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (844, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (844, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (844, 34, 27, 4)
INSERT INTO Order_Details
  VALUES (845, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (846, 5, 7.23, 6)
INSERT INTO Order_Details
  VALUES (846, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (846, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (846, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (846, 37, 189, 4)
INSERT INTO Order_Details
  VALUES (847, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (847, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (847, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (847, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (847, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (847, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (847, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (848, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (848, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (848, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (848, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (848, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (849, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (849, 27, 23.28, 6)
INSERT INTO Order_Details
  VALUES (850, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (850, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (850, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (850, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (850, 21, 53.35, 5)
INSERT INTO Order_Details
  VALUES (850, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (850, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (851, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (851, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (851, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (851, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (851, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (851, 29, 32.98, 5)
INSERT INTO Order_Details
  VALUES (851, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (851, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (852, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (852, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (852, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (852, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (852, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (852, 26, 125, 3)
INSERT INTO Order_Details
  VALUES (852, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (853, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (853, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (853, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (853, 16, 28, 3)
INSERT INTO Order_Details
  VALUES (853, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (853, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (853, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (853, 36, 160.05, 5)
INSERT INTO Order_Details
  VALUES (854, 2, 1746, 5)
INSERT INTO Order_Details
  VALUES (855, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (856, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (856, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (856, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (856, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (856, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (856, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (857, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (858, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (858, 19, 47, 2)
INSERT INTO Order_Details
  VALUES (858, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (858, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (859, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (859, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (859, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (860, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (860, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (860, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (860, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (860, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (860, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (861, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (861, 12, 23.5, 4)
INSERT INTO Order_Details
  VALUES (861, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (861, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (861, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (861, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (861, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (862, 2, 1746, 6)
INSERT INTO Order_Details
  VALUES (862, 12, 22.8, 5)
INSERT INTO Order_Details
  VALUES (862, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (862, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (863, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (864, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (864, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (864, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (864, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (864, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (864, 26, 125, 4)
INSERT INTO Order_Details
  VALUES (864, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (864, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (865, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (865, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (865, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (865, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (865, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (865, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (865, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (865, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (866, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (866, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (867, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (867, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (867, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (867, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (867, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (868, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (868, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (868, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (868, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (869, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (869, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (870, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (870, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (870, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (870, 27, 24, 4)
INSERT INTO Order_Details
  VALUES (870, 35, 37.83, 6)
INSERT INTO Order_Details
  VALUES (871, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (871, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (871, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (871, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (871, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (872, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (872, 6, 635, 3)
INSERT INTO Order_Details
  VALUES (872, 11, 1600.5, 5)
INSERT INTO Order_Details
  VALUES (872, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (872, 21, 55, 4)
INSERT INTO Order_Details
  VALUES (872, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (872, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (872, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (873, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (873, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (873, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (873, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (874, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (874, 18, 173.63, 6)
INSERT INTO Order_Details
  VALUES (874, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (874, 38, 166, 3)
INSERT INTO Order_Details
  VALUES (875, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (875, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (876, 12, 23.5, 1)
INSERT INTO Order_Details
  VALUES (876, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (876, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (877, 24, 69, 2)
INSERT INTO Order_Details
  VALUES (878, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (878, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (878, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (879, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (879, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (879, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (879, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (880, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (880, 33, 19, 4)
INSERT INTO Order_Details
  VALUES (881, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (881, 14, 139.95, 3)
INSERT INTO Order_Details
  VALUES (881, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (881, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (881, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (881, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (881, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (882, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (882, 15, 4.84, 5)
INSERT INTO Order_Details
  VALUES (882, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (882, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (882, 39, 175, 3)
INSERT INTO Order_Details
  VALUES (883, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (883, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (883, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (883, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (883, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (883, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (884, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (885, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (885, 33, 19, 2)
INSERT INTO Order_Details
  VALUES (886, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (886, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (886, 19, 47, 3)
INSERT INTO Order_Details
  VALUES (886, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (886, 29, 32.98, 6)
INSERT INTO Order_Details
  VALUES (886, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (886, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (887, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (887, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (887, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (887, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (887, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (887, 26, 125, 1)
INSERT INTO Order_Details
  VALUES (887, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (887, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (888, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (888, 12, 23.5, 2)
INSERT INTO Order_Details
  VALUES (888, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (888, 28, 28.13, 6)
INSERT INTO Order_Details
  VALUES (888, 36, 165, 3)
INSERT INTO Order_Details
  VALUES (889, 29, 34, 4)
INSERT INTO Order_Details
  VALUES (890, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (891, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (891, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (891, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (891, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (891, 21, 55, 3)
INSERT INTO Order_Details
  VALUES (891, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (891, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (891, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (892, 35, 39, 4)
INSERT INTO Order_Details
  VALUES (893, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (893, 22, 82, 4)
INSERT INTO Order_Details
  VALUES (893, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (894, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (894, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (895, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (895, 6, 615.95, 6)
INSERT INTO Order_Details
  VALUES (895, 11, 1600.5, 6)
INSERT INTO Order_Details
  VALUES (895, 23, 85, 2)
INSERT INTO Order_Details
  VALUES (895, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (895, 33, 19, 3)
INSERT INTO Order_Details
  VALUES (895, 38, 166, 1)
INSERT INTO Order_Details
  VALUES (896, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (896, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (896, 17, 45, 4)
INSERT INTO Order_Details
  VALUES (896, 29, 34, 1)
INSERT INTO Order_Details
  VALUES (896, 37, 189, 3)
INSERT INTO Order_Details
  VALUES (897, 10, 36, 1)
INSERT INTO Order_Details
  VALUES (897, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (897, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (897, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (897, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (897, 40, 174.6, 6)
INSERT INTO Order_Details
  VALUES (898, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (898, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (899, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (899, 14, 139.95, 4)
INSERT INTO Order_Details
  VALUES (899, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (899, 24, 69, 4)
INSERT INTO Order_Details
  VALUES (899, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (899, 34, 26.19, 5)
INSERT INTO Order_Details
  VALUES (899, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (900, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (900, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (900, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (900, 31, 21.34, 5)
INSERT INTO Order_Details
  VALUES (901, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (901, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (901, 23, 85, 4)
INSERT INTO Order_Details
  VALUES (901, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (901, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (902, 2, 1800, 4)
INSERT INTO Order_Details
  VALUES (902, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (903, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (903, 9, 32.01, 6)
INSERT INTO Order_Details
  VALUES (903, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (903, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (903, 40, 180, 3)
INSERT INTO Order_Details
  VALUES (904, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (904, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (904, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (904, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (904, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (905, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (905, 10, 36, 4)
INSERT INTO Order_Details
  VALUES (905, 15, 4.99, 4)
INSERT INTO Order_Details
  VALUES (905, 20, 14.55, 6)
INSERT INTO Order_Details
  VALUES (905, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (905, 30, 45, 3)
INSERT INTO Order_Details
  VALUES (905, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (905, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (906, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (906, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (906, 13, 67.5, 4)
INSERT INTO Order_Details
  VALUES (906, 19, 47, 4)
INSERT INTO Order_Details
  VALUES (906, 25, 139, 1)
INSERT INTO Order_Details
  VALUES (906, 39, 175, 2)
INSERT INTO Order_Details
  VALUES (907, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (907, 22, 79.54, 6)
INSERT INTO Order_Details
  VALUES (907, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (908, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (908, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (908, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (909, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (909, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (909, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (909, 33, 18.43, 5)
INSERT INTO Order_Details
  VALUES (910, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (910, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (910, 11, 1650, 3)
INSERT INTO Order_Details
  VALUES (910, 16, 27.16, 5)
INSERT INTO Order_Details
  VALUES (910, 21, 53.35, 6)
INSERT INTO Order_Details
  VALUES (910, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (910, 31, 22, 2)
INSERT INTO Order_Details
  VALUES (910, 36, 165, 2)
INSERT INTO Order_Details
  VALUES (911, 14, 135.75, 5)
INSERT INTO Order_Details
  VALUES (911, 34, 27, 1)
INSERT INTO Order_Details
  VALUES (912, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (912, 7, 49, 4)
INSERT INTO Order_Details
  VALUES (912, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (912, 28, 29, 4)
INSERT INTO Order_Details
  VALUES (912, 34, 27, 3)
INSERT INTO Order_Details
  VALUES (912, 40, 180, 4)
INSERT INTO Order_Details
  VALUES (913, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (913, 28, 28.13, 5)
INSERT INTO Order_Details
  VALUES (914, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (914, 21, 55, 1)
INSERT INTO Order_Details
  VALUES (915, 16, 28, 1)
INSERT INTO Order_Details
  VALUES (916, 7, 49, 1)
INSERT INTO Order_Details
  VALUES (916, 13, 65.47, 5)
INSERT INTO Order_Details
  VALUES (916, 19, 45.59, 5)
INSERT INTO Order_Details
  VALUES (916, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (916, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (916, 37, 189, 2)
INSERT INTO Order_Details
  VALUES (917, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (917, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (917, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (917, 25, 134.83, 5)
INSERT INTO Order_Details
  VALUES (917, 35, 39, 1)
INSERT INTO Order_Details
  VALUES (918, 36, 165, 4)
INSERT INTO Order_Details
  VALUES (919, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (919, 6, 615.95, 5)
INSERT INTO Order_Details
  VALUES (919, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (919, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (919, 27, 23.28, 5)
INSERT INTO Order_Details
  VALUES (919, 32, 31.04, 6)
INSERT INTO Order_Details
  VALUES (919, 37, 183.33, 6)
INSERT INTO Order_Details
  VALUES (920, 5, 7.23, 5)
INSERT INTO Order_Details
  VALUES (921, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (921, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (921, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (921, 31, 22, 1)
INSERT INTO Order_Details
  VALUES (922, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (922, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (922, 17, 45, 3)
INSERT INTO Order_Details
  VALUES (922, 25, 139, 2)
INSERT INTO Order_Details
  VALUES (922, 33, 18.43, 6)
INSERT INTO Order_Details
  VALUES (923, 5, 7.45, 2)
INSERT INTO Order_Details
  VALUES (923, 10, 34.92, 6)
INSERT INTO Order_Details
  VALUES (923, 15, 4.99, 2)
INSERT INTO Order_Details
  VALUES (923, 20, 15, 4)
INSERT INTO Order_Details
  VALUES (923, 25, 139, 4)
INSERT INTO Order_Details
  VALUES (923, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (923, 35, 39, 3)
INSERT INTO Order_Details
  VALUES (924, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (924, 39, 175, 1)
INSERT INTO Order_Details
  VALUES (925, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (925, 12, 22.8, 6)
INSERT INTO Order_Details
  VALUES (925, 18, 179, 4)
INSERT INTO Order_Details
  VALUES (925, 24, 66.93, 6)
INSERT INTO Order_Details
  VALUES (925, 30, 43.65, 5)
INSERT INTO Order_Details
  VALUES (925, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (926, 1, 1200, 4)
INSERT INTO Order_Details
  VALUES (926, 6, 635, 4)
INSERT INTO Order_Details
  VALUES (926, 20, 15, 2)
INSERT INTO Order_Details
  VALUES (926, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (926, 30, 45, 2)
INSERT INTO Order_Details
  VALUES (926, 35, 37.83, 5)
INSERT INTO Order_Details
  VALUES (926, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (927, 8, 50, 1)
INSERT INTO Order_Details
  VALUES (927, 16, 27.16, 6)
INSERT INTO Order_Details
  VALUES (927, 24, 66.93, 5)
INSERT INTO Order_Details
  VALUES (927, 32, 32, 1)
INSERT INTO Order_Details
  VALUES (927, 40, 174.6, 5)
INSERT INTO Order_Details
  VALUES (928, 7, 47.53, 6)
INSERT INTO Order_Details
  VALUES (928, 17, 43.65, 5)
INSERT INTO Order_Details
  VALUES (928, 27, 24, 1)
INSERT INTO Order_Details
  VALUES (928, 37, 183.33, 5)
INSERT INTO Order_Details
  VALUES (929, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (929, 14, 139.95, 1)
INSERT INTO Order_Details
  VALUES (929, 36, 160.05, 6)
INSERT INTO Order_Details
  VALUES (930, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (931, 20, 15, 3)
INSERT INTO Order_Details
  VALUES (931, 40, 180, 1)
INSERT INTO Order_Details
  VALUES (932, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (932, 17, 45, 2)
INSERT INTO Order_Details
  VALUES (932, 30, 45, 4)
INSERT INTO Order_Details
  VALUES (933, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (933, 27, 24, 2)
INSERT INTO Order_Details
  VALUES (934, 7, 49, 2)
INSERT INTO Order_Details
  VALUES (934, 15, 4.84, 6)
INSERT INTO Order_Details
  VALUES (934, 23, 85, 3)
INSERT INTO Order_Details
  VALUES (934, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (934, 39, 175, 4)
INSERT INTO Order_Details
  VALUES (935, 1, 1200, 3)
INSERT INTO Order_Details
  VALUES (935, 11, 1650, 1)
INSERT INTO Order_Details
  VALUES (935, 22, 82, 2)
INSERT INTO Order_Details
  VALUES (935, 32, 32, 3)
INSERT INTO Order_Details
  VALUES (936, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (936, 9, 33, 4)
INSERT INTO Order_Details
  VALUES (936, 20, 15, 1)
INSERT INTO Order_Details
  VALUES (936, 28, 29, 2)
INSERT INTO Order_Details
  VALUES (936, 36, 165, 1)
INSERT INTO Order_Details
  VALUES (937, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (937, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (937, 13, 67.5, 1)
INSERT INTO Order_Details
  VALUES (937, 19, 47, 1)
INSERT INTO Order_Details
  VALUES (937, 31, 22, 3)
INSERT INTO Order_Details
  VALUES (937, 37, 189, 1)
INSERT INTO Order_Details
  VALUES (938, 1, 1164, 5)
INSERT INTO Order_Details
  VALUES (938, 7, 49, 3)
INSERT INTO Order_Details
  VALUES (938, 13, 67.5, 2)
INSERT INTO Order_Details
  VALUES (938, 19, 45.59, 6)
INSERT INTO Order_Details
  VALUES (938, 25, 134.83, 6)
INSERT INTO Order_Details
  VALUES (938, 31, 22, 4)
INSERT INTO Order_Details
  VALUES (939, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (939, 14, 139.95, 2)
INSERT INTO Order_Details
  VALUES (939, 22, 79.54, 5)
INSERT INTO Order_Details
  VALUES (939, 30, 43.65, 6)
INSERT INTO Order_Details
  VALUES (939, 38, 166, 2)
INSERT INTO Order_Details
  VALUES (940, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (940, 6, 635, 2)
INSERT INTO Order_Details
  VALUES (940, 11, 1650, 4)
INSERT INTO Order_Details
  VALUES (940, 16, 28, 4)
INSERT INTO Order_Details
  VALUES (940, 21, 55, 2)
INSERT INTO Order_Details
  VALUES (940, 26, 121.25, 5)
INSERT INTO Order_Details
  VALUES (940, 34, 26.19, 6)
INSERT INTO Order_Details
  VALUES (940, 39, 169.75, 6)
INSERT INTO Order_Details
  VALUES (941, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (941, 6, 635, 1)
INSERT INTO Order_Details
  VALUES (941, 11, 1650, 2)
INSERT INTO Order_Details
  VALUES (941, 16, 28, 2)
INSERT INTO Order_Details
  VALUES (941, 29, 34, 3)
INSERT INTO Order_Details
  VALUES (941, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (941, 39, 169.75, 5)
INSERT INTO Order_Details
  VALUES (942, 1, 1200, 2)
INSERT INTO Order_Details
  VALUES (942, 14, 135.75, 6)
INSERT INTO Order_Details
  VALUES (942, 38, 166, 4)
INSERT INTO Order_Details
  VALUES (943, 1, 1200, 1)
INSERT INTO Order_Details
  VALUES (943, 9, 33, 1)
INSERT INTO Order_Details
  VALUES (943, 17, 45, 1)
INSERT INTO Order_Details
  VALUES (943, 26, 121.25, 6)
INSERT INTO Order_Details
  VALUES (943, 34, 27, 2)
INSERT INTO Order_Details
  VALUES (944, 1, 1164, 6)
INSERT INTO Order_Details
  VALUES (944, 9, 33, 3)
INSERT INTO Order_Details
  VALUES (944, 17, 43.65, 6)
INSERT INTO Order_Details
  VALUES (944, 32, 32, 2)
INSERT INTO Order_Details
  VALUES (944, 40, 180, 2)

/*==============================================================*/
/* Index: ORDER_DETAILS_FK                                      */
/*==============================================================*/
create index ORDER_DETAILS_FK on ORDER_DETAILS (
ORDERNUMBER ASC
)
go

/*==============================================================*/
/* Index: DETAILS_PRODUCTS_FK                                   */
/*==============================================================*/
create index DETAILS_PRODUCTS_FK on ORDER_DETAILS (
PRODUCTNUMBER ASC
)
go

/*==============================================================*/
/* Table: PRODUCTS                                              */
/*==============================================================*/
create table PRODUCTS (
   PRODUCTNUMBER        bigint               not null,
   PRODUCTNAME          char(50)             null,
   PRODUCTDESCRIPTION   varchar(1024)        null,
   RETAILPRICE          float                null,
   QUANTITYONHAND       bigint               null,
   CATEGORYID           bigint               not null,
   constraint PK_PRODUCTS primary key nonclustered (PRODUCTNUMBER)
)
go
INSERT INTO Products
  VALUES (1, 'Trek 9000 Mountain Bike', NULL, 1200, 
   6, 2)
INSERT INTO Products
  VALUES (2, 'Eagle FS-3 Mountain Bike', NULL, 1800, 
   8, 2)
INSERT INTO Products
  VALUES (3, 'Dog Ear Cyclecomputer', NULL, 75, 20, 
   1)
INSERT INTO Products
  VALUES (4, 'Victoria Pro All Weather Tires', NULL, 
   54.95, 20, 4)
INSERT INTO Products
  VALUES (5, 'Dog Ear Helmet Mount Mirrors', NULL, 
   7.45, 12, 1)
INSERT INTO Products
  VALUES (6, 'Viscount Mountain Bike', NULL, 635, 5, 
   2)
INSERT INTO Products
  VALUES (7, 'Viscount C-500 Wireless Bike Computer', 
   NULL, 49, 30, 1)
INSERT INTO Products
  VALUES (8, 'Kryptonite Advanced 2000 U-Lock', NULL, 
   50, 20, 1)
INSERT INTO Products
  VALUES (9, 'Nikoma Lok-Tight U-Lock', NULL, 33, 12, 
   1)
INSERT INTO Products
  VALUES (10, 'Viscount Microshell Helmet', NULL, 36, 
   20, 1)
INSERT INTO Products
  VALUES (11, 'GT RTS-2 Mountain Bike', NULL, 1650, 
   5, 2)
INSERT INTO Products
  VALUES (12, 'Shinoman 105 SC Brakes', NULL, 23.5, 
   16, 4)
INSERT INTO Products
  VALUES (13, 'Shinoman Dura-Ace Headset', NULL, 67.5, 
   20, 4)
INSERT INTO Products
  VALUES (14, 'Eagle SA-120 Clipless Pedals', NULL, 
   139.95, 20, 4)
INSERT INTO Products
  VALUES (15, 'ProFormance Toe-Klips 2G', NULL, 4.99, 
   40, 4)
INSERT INTO Products
  VALUES (16, 'ProFormance ATB All-Terrain Pedal', 
   NULL, 28, 40, 4)
INSERT INTO Products
  VALUES (17, 'Shinoman Deluxe TX-30 Pedal', NULL, 
   45, 60, 4)
INSERT INTO Products
  VALUES (18, 'Viscount CardioSport Sport Watch', NULL, 
   179, 12, 1)
INSERT INTO Products
  VALUES (19, 'Viscount Tru-Beat Heart Transmitter', 
   NULL, 47, 20, 1)
INSERT INTO Products
  VALUES (20, 'Dog Ear Monster Grip Gloves', NULL, 
   15, 30, 1)
INSERT INTO Products
  VALUES (21, 'Dog Ear Aero-Flow Floor Pump', NULL, 
   55, 25, 1)
INSERT INTO Products
  VALUES (22, 'Pro-Sport ''Dillo Shades', NULL, 82, 
   18, 1)
INSERT INTO Products
  VALUES (23, 'Ultra-Pro Rain Jacket', NULL, 85, 30, 
   3)
INSERT INTO Products
  VALUES (24, 'StaDry Cycling Pants', NULL, 69, 22, 
   3)
INSERT INTO Products
  VALUES (25, 'King Cobra Helmet', NULL, 139, 30, 1)
INSERT INTO Products
  VALUES (26, 'Glide-O-Matic Cycling Helmet', NULL, 
   125, 24, 1)
INSERT INTO Products
  VALUES (27, 'X-Pro All Weather Tires', NULL, 24, 
   20, 6)
INSERT INTO Products
  VALUES (28, 'Turbo Twin Tires', NULL, 29, 18, 6)
INSERT INTO Products
  VALUES (29, 'Ultra-2K Competition Tire', NULL, 34, 
   22, 6)
INSERT INTO Products
  VALUES (30, 'Clear Shade 85-T Glasses', NULL, 45, 
   14, 1)
INSERT INTO Products
  VALUES (31, 'True Grip Competition Gloves', NULL, 
   22, 20, 1)
INSERT INTO Products
  VALUES (32, 'Kool-Breeze Rocket Top Jersey', NULL, 
   32, 12, 3)
INSERT INTO Products
  VALUES (33, 'Wonder Wool Cycle Socks', NULL, 19, 
   30, 3)
INSERT INTO Products
  VALUES (34, 'TransPort Bicycle Rack', NULL, 27, 14, 
   1)
INSERT INTO Products
  VALUES (35, 'HP Deluxe Panniers', NULL, 39, 10, 1)
INSERT INTO Products
  VALUES (36, 'Cosmic Elite Road Warrior Wheels', NULL, 
   165, 22, 4)
INSERT INTO Products
  VALUES (37, 'AeroFlo ATB Wheels', NULL, 189, 40, 
   4)
INSERT INTO Products
  VALUES (38, 'Cycle-Doc Pro Repair Stand', NULL, 166, 
   12, 1)
INSERT INTO Products
  VALUES (39, 'Road Warrior Hitch Pack', NULL, 175, 
   6, 5)
INSERT INTO Products
  VALUES (40, 'Ultimate Export 2G Car Rack', NULL, 
   180, 8, 5)

/*==============================================================*/
/* Index: CATEGORIES_PRODUCTS_FK                                */
/*==============================================================*/
create index CATEGORIES_PRODUCTS_FK on PRODUCTS (
CATEGORYID ASC
)
go

/*==============================================================*/
/* Table: PRODUCT_VENDORS                                       */
/*==============================================================*/
create table PRODUCT_VENDORS (
   PRODUCTNUMBER        bigint               not null,
   VENDORID             bigint               not null,
   WHOLESALEPRICE       float                null,
   DAYSTODELIVERY       int                  null,
   constraint PK_PRODUCT_VENDORS primary key nonclustered (PRODUCTNUMBER, VENDORID)
)
go

INSERT INTO Product_Vendors
  VALUES (1, 4, 804, 6)
INSERT INTO Product_Vendors
  VALUES (1, 9, 854.22, 7)
INSERT INTO Product_Vendors
  VALUES (2, 6, 1269, 9)
INSERT INTO Product_Vendors
  VALUES (2, 9, 1477.81, 7)
INSERT INTO Product_Vendors
  VALUES (3, 7, 54.19, 10)
INSERT INTO Product_Vendors
  VALUES (3, 9, 57.27, 6)
INSERT INTO Product_Vendors
  VALUES (4, 6, 44.22, 10)
INSERT INTO Product_Vendors
  VALUES (4, 9, 41.62, 14)
INSERT INTO Product_Vendors
  VALUES (5, 7, 5.38, 10)
INSERT INTO Product_Vendors
  VALUES (5, 9, 5.87, 9)
INSERT INTO Product_Vendors
  VALUES (6, 2, 403.22, 3)
INSERT INTO Product_Vendors
  VALUES (6, 9, 448.73, 7)
INSERT INTO Product_Vendors
  VALUES (7, 2, 31.12, 3)
INSERT INTO Product_Vendors
  VALUES (8, 8, 39.32, 10)
INSERT INTO Product_Vendors
  VALUES (8, 9, 37.88, 14)
INSERT INTO Product_Vendors
  VALUES (9, 3, 21.53, 4)
INSERT INTO Product_Vendors
  VALUES (10, 2, 22.86, 3)
INSERT INTO Product_Vendors
  VALUES (11, 3, 1076.62, 4)
INSERT INTO Product_Vendors
  VALUES (11, 9, 1178.65, 7)
INSERT INTO Product_Vendors
  VALUES (12, 1, 14.51, 2)
INSERT INTO Product_Vendors
  VALUES (12, 6, 15.44, 10)
INSERT INTO Product_Vendors
  VALUES (12, 9, 15.02, 14)
INSERT INTO Product_Vendors
  VALUES (13, 1, 41.68, 2)
INSERT INTO Product_Vendors
  VALUES (13, 6, 43.99, 10)
INSERT INTO Product_Vendors
  VALUES (13, 9, 43.77, 14)
INSERT INTO Product_Vendors
  VALUES (14, 6, 98.66, 9)
INSERT INTO Product_Vendors
  VALUES (14, 9, 101.22, 14)
INSERT INTO Product_Vendors
  VALUES (15, 4, 3.34, 6)
INSERT INTO Product_Vendors
  VALUES (15, 6, 3.79, 10)
INSERT INTO Product_Vendors
  VALUES (15, 9, 3.88, 14)
INSERT INTO Product_Vendors
  VALUES (16, 4, 18.76, 6)
INSERT INTO Product_Vendors
  VALUES (16, 6, 19.33, 10)
INSERT INTO Product_Vendors
  VALUES (16, 9, 19.33, 14)
INSERT INTO Product_Vendors
  VALUES (17, 1, 27.79, 2)
INSERT INTO Product_Vendors
  VALUES (17, 6, 28.55, 10)
INSERT INTO Product_Vendors
  VALUES (17, 9, 28.55, 14)
INSERT INTO Product_Vendors
  VALUES (18, 2, 113.66, 3)
INSERT INTO Product_Vendors
  VALUES (19, 2, 29.84, 3)
INSERT INTO Product_Vendors
  VALUES (20, 7, 10.84, 10)
INSERT INTO Product_Vendors
  VALUES (20, 9, 11.54, 6)
INSERT INTO Product_Vendors
  VALUES (21, 7, 39.74, 10)
INSERT INTO Product_Vendors
  VALUES (21, 9, 41.5, 9)
INSERT INTO Product_Vendors
  VALUES (22, 10, 63.55, 15)
INSERT INTO Product_Vendors
  VALUES (23, 6, 69.54, 15)
INSERT INTO Product_Vendors
  VALUES (23, 9, 64.39, 14)
INSERT INTO Product_Vendors
  VALUES (24, 6, 55.91, 15)
INSERT INTO Product_Vendors
  VALUES (24, 7, 53.88, 10)
INSERT INTO Product_Vendors
  VALUES (24, 9, 52.27, 14)
INSERT INTO Product_Vendors
  VALUES (25, 9, 105.29, 14)
INSERT INTO Product_Vendors
  VALUES (25, 10, 101.58, 15)
INSERT INTO Product_Vendors
  VALUES (26, 3, 81.56, 4)
INSERT INTO Product_Vendors
  VALUES (26, 6, 79.88, 15)
INSERT INTO Product_Vendors
  VALUES (27, 3, 15.66, 4)
INSERT INTO Product_Vendors
  VALUES (27, 6, 16.88, 10)
INSERT INTO Product_Vendors
  VALUES (27, 9, 15.88, 14)
INSERT INTO Product_Vendors
  VALUES (28, 3, 18.92, 4)
INSERT INTO Product_Vendors
  VALUES (28, 6, 20.56, 10)
INSERT INTO Product_Vendors
  VALUES (28, 9, 19.04, 14)
INSERT INTO Product_Vendors
  VALUES (29, 5, 23.38, 8)
INSERT INTO Product_Vendors
  VALUES (29, 6, 24.44, 10)
INSERT INTO Product_Vendors
  VALUES (29, 9, 23.99, 14)
INSERT INTO Product_Vendors
  VALUES (30, 8, 33.3, 12)
INSERT INTO Product_Vendors
  VALUES (30, 9, 35.32, 8)
INSERT INTO Product_Vendors
  VALUES (30, 10, 32.87, 15)
INSERT INTO Product_Vendors
  VALUES (31, 7, 15.85, 15)
INSERT INTO Product_Vendors
  VALUES (31, 8, 16.28, 12)
INSERT INTO Product_Vendors
  VALUES (31, 9, 16.93, 7)
INSERT INTO Product_Vendors
  VALUES (31, 10, 16.9, 9)
INSERT INTO Product_Vendors
  VALUES (32, 6, 24.77, 15)
INSERT INTO Product_Vendors
  VALUES (32, 7, 24.12, 10)
INSERT INTO Product_Vendors
  VALUES (32, 8, 23.68, 12)
INSERT INTO Product_Vendors
  VALUES (33, 6, 15.23, 15)
INSERT INTO Product_Vendors
  VALUES (33, 8, 14.06, 12)
INSERT INTO Product_Vendors
  VALUES (34, 6, 19.04, 9)
INSERT INTO Product_Vendors
  VALUES (34, 9, 23.86, 3)
INSERT INTO Product_Vendors
  VALUES (34, 10, 19.32, 10)
INSERT INTO Product_Vendors
  VALUES (35, 6, 27.49, 9)
INSERT INTO Product_Vendors
  VALUES (35, 9, 28.22, 6)
INSERT INTO Product_Vendors
  VALUES (36, 6, 122.88, 10)
INSERT INTO Product_Vendors
  VALUES (36, 7, 119.21, 10)
INSERT INTO Product_Vendors
  VALUES (36, 9, 122.78, 14)
INSERT INTO Product_Vendors
  VALUES (37, 2, 120.02, 3)
INSERT INTO Product_Vendors
  VALUES (37, 6, 125.99, 10)
INSERT INTO Product_Vendors
  VALUES (37, 9, 124.89, 14)
INSERT INTO Product_Vendors
  VALUES (38, 9, 136.98, 6)
INSERT INTO Product_Vendors
  VALUES (38, 10, 128.65, 15)
INSERT INTO Product_Vendors
  VALUES (39, 6, 137.55, 7)
INSERT INTO Product_Vendors
  VALUES (39, 7, 126.44, 10)
INSERT INTO Product_Vendors
  VALUES (40, 6, 154.87, 10)
INSERT INTO Product_Vendors
  VALUES (40, 9, 136.35, 14)


/*==============================================================*/
/* Index: PRODUCTS_VENDORS_FK                                   */
/*==============================================================*/
create index PRODUCTS_VENDORS_FK on PRODUCT_VENDORS (
PRODUCTNUMBER ASC
)
go

/*==============================================================*/
/* Index: VENDORS_PRODUCTS_FK                                   */
/*==============================================================*/
create index VENDORS_PRODUCTS_FK on PRODUCT_VENDORS (
VENDORID ASC
)
go

/*==============================================================*/
/* Table: VENDORS                                               */
/*==============================================================*/
create table VENDORS (
   VENDORID             bigint               not null,
   VENDNAME             char(50)             not null,
   VENDSTREETADDRESS    varchar(50)          null,
   VENDCITY             varchar(50)          null,
   VENDSTATE            char(50)             null,
   VENDZIPCODE          bigint               null,
   VENDPHONENUMBER      varchar(20)          null,
   VENDFAXNUMBER        varchar(20)          null,
   VENDWEBPAGE          varchar(50)          null,
   VENDEMAILADDRESS     varchar(30)          null,
   constraint PK_VENDORS primary key nonclustered (VENDORID)
)
go
INSERT INTO Vendors
  VALUES (1, 'Shinoman, Incorporated', '3042 19th Avenue South', 
   'Bellevue', 'WA', '98001', '(425) 888-1234', '(425) 888-1235', 
   '#http://www.shinoman.com/#', 'Sales@Shiniman.com')
INSERT INTO Vendors
  VALUES (2, 'Viscount', '1911 Commerce Way', 'St. Louis', 
   'MO', '63127', '(314) 777-1234', '(314) 777-1235', 
   '#http://www.viscountbikes.com/#', 'Orders@ViscountBikes.com')
INSERT INTO Vendors
  VALUES (3, 'Nikoma of America', '88 Old North Road Ave', 
   'Ballard', 'WA', '91324', '(206) 666-1234', '(314) 666-1235', 
   '#http://www.nikomabikes.com/#', 'BuyBikes@NikomaBikes.com')
INSERT INTO Vendors
  VALUES (4, 'ProFormance', '29 N. Quail St.', 'Albany', 
   'NY', '12012', '(518) 444-1234', '(518) 444-1235', 
   '#http://www.ProFormBikes.com/#', 'Sales@ProFormBikes.com')
INSERT INTO Vendors
  VALUES (5, 'Kona, Incorporated', 'PO Box 10429', 
   'Redmond', 'WA', '98052', '(425) 333-1234', '(425) 333-1235', 
   '#http://www.konabikes.com/#', 'Sales@KonaBikes.com')
INSERT INTO Vendors
  VALUES (6, 'Big Sky Mountain Bikes', 'Glacier Bay South', 
   'Anchorage', 'AK', '99209', '(907) 222-1234', '(907) 222-1235', 
   NULL, NULL)
INSERT INTO Vendors
  VALUES (7, 'Dog Ear', '575 Madison Ave.', 'New York', 
   'NY', '10003', '(212) 888-9876', '(212) 888-9877', 
   NULL, NULL)
INSERT INTO Vendors
  VALUES (8, 'Sun Sports Suppliers', 'PO Box 8082', 
   'Santa Monica', 'CA', '91003', '(310) 777-9876', 
   '(310) 777-9877', NULL, NULL)
INSERT INTO Vendors
  VALUES (9, 'Lone Star Bike Supply', '7402 Kingman Drive', 
   'El Paso', 'TX', '79915', '(915) 666-9876', '(915) 666-9877', 
   NULL, NULL)
INSERT INTO Vendors
  VALUES (10, 'Armadillo Brand', '12330 Side Road Lane', 
   'Dallas', 'TX', '75137', '(214) 444-9876', '(214) 444-9877', 
   '#http://www.DilloBikes.com/#', 'BikeProducts@DilloBikes.com')

alter table ORDERS
   add constraint FK_ORDERS_CUSTOMERS_CUSTOMER foreign key (CUSTOMERID)
      references CUSTOMERS (CUSTOMERID)
go

alter table ORDERS
   add constraint FK_ORDERS_EMPLOEEYS_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEES (EMPLOYEEID)
go

alter table ORDER_DETAILS
   add constraint FK_ORDER_DE_DETAILS_P_PRODUCTS foreign key (PRODUCTNUMBER)
      references PRODUCTS (PRODUCTNUMBER)
go

alter table ORDER_DETAILS
   add constraint FK_ORDER_DE_ORDER_DET_ORDERS foreign key (ORDERNUMBER)
      references ORDERS (ORDERNUMBER)
go

alter table PRODUCTS
   add constraint FK_PRODUCTS_CATEGORIE_CATEGORI foreign key (CATEGORYID)
      references CATEGORIES (CATEGORYID)
go

alter table PRODUCT_VENDORS
   add constraint FK_PRODUCT__PRODUCTS__PRODUCTS foreign key (PRODUCTNUMBER)
      references PRODUCTS (PRODUCTNUMBER)
go

alter table PRODUCT_VENDORS
   add constraint FK_PRODUCT__VENDORS_P_VENDORS foreign key (VENDORID)
      references VENDORS (VENDORID)
go




 

	   



