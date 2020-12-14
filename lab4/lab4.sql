-----------------------------------------------
--Views
-----------------------------------------------
USE Sample

--1.	������� �������������, ��� ������ ��� ��� �����������, �� �������� � ���� d1.
GO
CREATE VIEW d1_employee (emp_no, emp_fname, emp_lname, dept_no)
    AS SELECT emp_no, emp_fname, emp_lname, dept_no
        FROM employee
        WHERE dept_no = 'd1'

GO
SELECT * FROM d1_employee

--2.	��� ������� project ������� �������������, ��� ���� ����������������� ���� �������������, ���� ��������� ����������� ��� � ���� ������� �� �������� ������� budget.
GO
CREATE VIEW projectV
AS SELECT project_no, project_name
	FROM project

GO
SELECT * FROM projectV


--3.	������� �������������, ��� ������ ����� �� ������� ��� �����������, �� ������ ��������� ��� ��������� � ����� ������� 2007 ����.
GO
CREATE VIEW empSecHalfV
	AS SELECT emp_fname, emp_lname FROM works_on w
		JOIN employee e
		ON e.emp_no = w.emp_no
		WHERE enter_date >= '2007-06-01'

GO
SELECT * FROM empSecHalfV


--4.	������ ��������� �������� 3 ���, ��� ��������� ������� f_name �� l_name �������� � ������������ ��� �����: first �� last ��������.
GO
ALTER VIEW empSecHalfV([first], [last])
	AS SELECT emp_fname, emp_lname FROM works_on w
		JOIN employee e
		ON e.emp_no = w.emp_no
		WHERE enter_date >= '2007-06-01'

GO
SELECT * FROM empSecHalfV

--5.	�������������� ������������� � ������ 1, ��������� �� ��� ������� �����������, �� ������� ���������� � ����� �.
SELECT * FROM d1_employee
WHERE emp_lname LIKE 'M%'

--6.	������� �������������, ��� ������ ���� ��� �� ��� ��������, ��� ����� ������ Smith.
GO
CREATE VIEW projectSmithV
AS SELECT p.project_no, project_name, budget
	FROM project p
	INNER JOIN works_on w
	ON p.project_no = w.project_no
	INNER JOIN employee e
	ON e.emp_no = w.emp_no
	WHERE emp_lname = 'Smith'

GO
SELECT * FROM projectSmithV

--7.	�������������� �������� ALTER VIEW, ����� ����� � ������������ � ������ 1. ������������ �������������  ������� ������ ��� ��� ��� �����������, �� �������� ��� � ���� d1, ��� � ���� d2, ��� � ����.
GO
ALTER VIEW d1_employee
    AS SELECT emp_no, emp_fname, emp_lname, dept_no
        FROM employee
        WHERE dept_no = 'd1'
		OR dept_no = 'd2'

GO
SELECT * FROM d1_employee


--8.	������� �������������, �������� � ����� 3. �� ���������� �� ��������������, ��������� � ����� 4?
DROP VIEW empSecHalfV

SELECT * FROM empSecHalfV

--9.	�������������� ������������� �� ������ 2, ������� ��� ��� ����� ������ � ������� ������� p2 �� ������ Moon. 
SELECT * FROM projectV

GO
INSERT INTO projectV
VALUES('p2', 'Moon');


--10.	������� ������������� (� ������ WITH CHECK OPTION), ��� ������ ����� �� ������� ��� �����������, � ���� ����� ����������� �����, �� 10000. ϳ��� ����� ����������� �� ������������� ���  ��������� ����� ��� ������ ����������� � �������� Kohn �� ������� 22123, ���� ������ � ���� d3.
GO
CREATE VIEW empCheckV
	AS SELECT emp_no,emp_fname, emp_lname, dept_no
		FROM employee
		WHERE emp_no < 10000
		WITH CHECK OPTION
GO
SELECT * FROM empCheckV

INSERT INTO empCheckV(emp_no,emp_fname, emp_lname, dept_no)
VALUES(22123,'John', 'Kohn', 'd3');

--11.	������������ ������������� � ������ 10 ��� ����� WITH CHECK OPTION �� ������� �������� � �������� �����.
GO
CREATE VIEW empNoCheckV
	AS SELECT emp_no,emp_fname, emp_lname, dept_no
		FROM employee
		WHERE emp_no < 10000
GO
SELECT * FROM empNoCheckV

INSERT INTO empNoCheckV(emp_no,emp_fname, emp_lname, dept_no)
VALUES(22123,'John', 'Kohn', 'd3');

SELECT * FROM employee


--12.	������� ������������� (� ������ WITH CHECK OPTION) � ���� ����������� � ������� works_on ��� ��� ��� �����������, �� ������ ��������� ��� ��������� � ����� �  2007 �� 2008 ����. ϳ��� ����� ����� ���� ������� ������ ��� �������� � ����������� � ������� 29346. ���� ���� �� ���� 06/01/2006.
GO
CREATE VIEW worksCheckV
	AS SELECT emp_no, project_no, job, enter_date
		FROM works_on
		WHERE enter_date
		BETWEEN '01.01.2007' AND '12.31.2008'
		WITH CHECK OPTION
GO
SELECT * FROM worksCheckV

UPDATE worksCheckV
	SET enter_date = '06.01.2006'
	WHERE emp_no = 29346

--13.	������������ ������������� � ������ 12 ��� ��� ����� WITH CHECK OPTION �� ������� �������� � �������� �����.
GO
CREATE VIEW worksNoCheckV
	AS SELECT emp_no, project_no, job, enter_date
		FROM works_on
		WHERE enter_date
		BETWEEN '01.01.2007' AND '12.31.2008'

GO
SELECT * FROM worksNoCheckV

UPDATE worksNoCheckV
	SET enter_date = '06.01.2006'
	WHERE emp_no = 29346

SELECT * FROM works_on




-----------------------------------------------
--Trigers
-----------------------------------------------

--1.	�������������� �������, ��������� �������� �������� ����� ��� ���������� ����� ������� department, ������� dept_no, ���� � ������� ������ ������� works_on.
GO
CREATE TRIGGER departmentTR
	ON department AFTER INSERT, UPDATE
	AS IF UPDATE(dept_no)
		BEGIN
		IF (SELECT w.emp_no FROM works_on w, inserted
			WHERE w.emp_no = inserted.dept_no) IS NULL
		BEGIN
		ROLLBACK TRANSACTION
		PRINT 'No insertion/modification of the row'
		END
	ELSE PRINT 'The row inserted/modified'
	END

--2.	�� ��������� ������� ������ �������� �������� ����� ��� ���������� ����� ������� project, ������� project_no, ���� � ������� ������ ������� works_on.
GO
CREATE TRIGGER projectTR
	ON project AFTER INSERT, UPDATE
	AS IF UPDATE(project_no)
		BEGIN
		IF (SELECT w.project_no FROM works_on w, inserted
			WHERE w.project_no = inserted.project_no) IS NULL
		BEGIN
		ROLLBACK TRANSACTION
		PRINT 'No insertion/modification of the row'
		END
	ELSE PRINT 'The row inserted/modified'
	END

--3.	�������� DDL ������, ���� ���� ������������� ����� ���, ���� � �� ���������� ���������� DROP_TABLE ��� ALTER_TABLE � ���������� �����������, �� ����� 
GO
CREATE TRIGGER [safeTR]
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
	PRINT 'error by safeTR'
	ROLLBACK

ALTER TABLE department
ADD TEST varchar(255);


--4.	�������� ������ �� ������������ �������� sys.triggers �� sys.trigger_events � ����� ����������, �� ��䳿 ���� Transact-SQL �������� �� ����������� ������� � �������� 3.
SELECT * FROM sys.triggers
SELECT * FROM sys.trigger_events

--5.	�������� DDL ������, ���� �������� �����������, ���� � ��������� ��������� ������� ���������� ���� CREATE_DATABASE.
GO
CREATE TRIGGER createDbTR
ON ALL SERVER
FOR CREATE_DATABASE
AS
	PRINT 'error by createDbTR'
	ROLLBACK

CREATE DATABASE test




-----------------------------------------------
--AdventoreWorks
-----------------------------------------------
USE AdventureWorks2012

--6.	�������� ������ D�L, ���� ��������� �볺��� �����������, ���� ����� ���������� ������ �� ������ ��� � ������� Customer.
SELECT * FROM Sales.Customer

GO
CREATE TRIGGER CustomerInsertTR
ON Sales.Customer
AFTER INSERT, UPDATE
AS
BEGIN
	PRINT 'Table Sales.Customer was UPDATED/INSERTED'
END

UPDATE Sales.Customer
SET PersonID = 1--NULL
WHERE CustomerID = 1




--7.	�������� ������ D�L, ���� ��������� ��������� ������������ (MaryM) ����������� �� ���������� �����, ���� ����� ���������� ������ ��� � ������� Customer.
GO
CREATE VIEW MaryEmailV
AS SELECT FirstName, MiddleName, LastName, EmailAddress Email FROM Person.Person p
	INNER JOIN Person.EmailAddress e
	ON p.BusinessEntityID = e.BusinessEntityID
	WHERE FirstName = 'Mary' AND MiddleName = 'M'

GO
SELECT * FROM MaryEmailV

GO
CREATE TRIGGER CustomerUpdateNotifyTR
ON Sales.Customer AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	declare @email NVARCHAR(255)
	SELECT @email = Email
	FROM MaryEmailV

	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'AdventureWorks2012 Admin',
		@recipients = @email,
		@subject = 'DB Update',
		@body = 'Table Sales.Customer was UPDATED',
		@importance = 'HIGH'
END

--DROP TRIGGER CustomerAlterNotifyTR


UPDATE Sales.Customer
SET PersonID = 1--NULL
WHERE CustomerID = 1

--8.	�������� ������ D�L, ���� �������� ����� ������������������ ������������� �� ��� ������ ������ ���� ���������� �� ������� � ������� PurchaseOrderHeader. ��� ��������� ��������� ��� ������������������ ������������� ��������� ��������� �� ������� Vendor. ���� ������������������ � ������� ������� � ���������� �������� ����������� �� ������� �� ����������.
GO
SELECT *
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.Vendor v
ON poh.VendorID = v.BusinessEntityID

GO
CREATE VIEW GoodCreditRateV
AS SELECT VendorID, CreditRating
	FROM Purchasing.PurchaseOrderHeader poh
	INNER JOIN Purchasing.Vendor v
	ON poh.VendorID = v.BusinessEntityID
	WHERE CreditRating > 2

SELECT * FROM GoodCreditRateV

GO
CREATE TRIGGER CheckCreditRateTR
ON Purchasing.PurchaseOrderHeader
FOR INSERT
AS
BEGIN
	IF(SELECT i.VendorID FROM INSERTED i
		INNER JOIN GoodCreditRateV gcr
		ON i.VendorID = gcr.VendorID) IS NULL
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Vendor`s Credit Rate is low!'
		END
END

GO
INSERT INTO [Purchasing].[PurchaseOrderHeader]
           ([RevisionNumber]
           ,[Status]
           ,[EmployeeID]
           ,[VendorID]
           ,[ShipMethodID]
           ,[OrderDate]
           ,[ShipDate]
           ,[SubTotal]
           ,[TaxAmt]
           ,[Freight]
           ,[ModifiedDate])
     VALUES
           (4
           ,4
           ,250
           ,1580
           ,3
           ,'2020-04-16 00:00:00.000'
           ,'2020-04-25 00:00:00.000'
           ,0
           ,0
           ,0
           ,'2011-04-25 00:00:00.000')

GO
SELECT *
FROM Purchasing.PurchaseOrderHeader
ORDER BY [ShipDate] DESC


--9.	�������� ������, ���� ��������� ���������� ���������� ��� ������ (��������), ������ ���� �������� (���� Discontinued Date)
SELECT * FROM Production.Product
WHERE DiscontinuedDate IS NOT NULL

SELECT *
FROM Production.WorkOrder wo
LEFT JOIN Production.Product p
ON wo.ProductID = p.ProductID



GO
CREATE TRIGGER ProductDiscontinuedCheckV
ON Production.WorkOrder
FOR INSERT
AS
BEGIN
	IF(SELECT i.ProductID FROM INSERTED i
		INNER JOIN Production.Product p
		ON i.ProductID = p.ProductID
		WHERE DiscontinuedDate IS NULL) IS NULL
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Discontinued Date of this product exists'
		END
END


INSERT INTO [Production].[WorkOrder]
           ([ProductID]
           ,[OrderQty]
           ,[ScrappedQty]
           ,[StartDate]
           ,[EndDate]
           ,[DueDate]
           ,[ScrapReasonID]
           ,[ModifiedDate])
     VALUES
           (722
           ,1
           ,0
           ,'2020-06-03 00:00:00.000'
           ,'2020-06-13 00:00:00.000'
           ,'2020-06-14 00:00:00.000'
           ,NULL
           ,'2020-06-13 00:00:00.000')
GO