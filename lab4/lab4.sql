USE Sample

--Views
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


--Trigers
-----------------------------------------------------------
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