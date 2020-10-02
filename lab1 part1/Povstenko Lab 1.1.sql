USE Sample

SELECT * FROM dbo.department
SELECT * FROM dbo.employee
SELECT * FROM dbo.project
SELECT * FROM dbo.works_on




/* 1
	�������� ����� ��� ��������� ���� �� ������ ��� �������, �� ����������� � ������.
*/
SELECT dept_name, dept_no
FROM department
WHERE location = 'Dallas'

/* 2
	�������� ����� ��� ��������� ������ ����� ��� �� �����.
*/
SELECT * FROM department

/* 3
	�������� ����� ��� ��������� ������ ����������, ������ ������� � ���� ���� ��� ����������,
	�� ��������� �� �������� ���� ��� ������ ��� ����� � ��� �������
*/
SELECT emp_no, project_no, job
FROM works_on
WHERE emp_no != (SELECT TOP 1 emp_no
				FROM works_on
				ORDER BY enter_date)

/* 4
	�������� ����� ��� ��������� ����, ������ �� ������ ��� ����������, � ���� ����� ����� ���� ��.
*/
SELECT emp_fname AS [name], emp_lname AS surname, emp_no AS number
FROM employee
WHERE emp_fname LIKE '_a%'

/* 5
	�������� ����� ���� ���� ������ ������ ������� �� ����, �� ����������� �� ����� ������. ��� ����� ������ ������ �������� �� �������.
*/
SELECT DISTINCT project_no, job
FROM works_on
WHERE job IS NOT NULL
ORDER BY project_no

/* 6
	�������� ����� ��� ���������� ������� ����� ���� � ������� ������
*/
SELECT project_no, COUNT(DISTINCT job) AS 'jobs_num'
FROM works_on
GROUP BY project_no

/* 7
	�������� ����� ��� ��������� ��� ����� ��� �� ��������, �� ���� ������������ ���������� � ������� � ������� �� C �� F
*/
SELECT * FROM department
WHERE location LIKE '[C-F]%'

/* 8
	�������� ����� ��� ��������� ������ ����� ��� ����������, �� ������ �� ��� � 10102, � 9031
*/
SELECT * FROM employee
WHERE emp_no NOT IN (10102, 9031)

/* 9
	�������� ����� ��� ���������� ���� ��� ������� ��� �������
*/
SELECT SUM(budget) AS total_budget
FROM project

/* 10
	�������� ����� ��� ��������� ������ ����������, �� �������� ��� �������� p1 �/��� �������� p2
*/
SELECT emp_no FROM works_on
WHERE project_no IN ('p1', 'p2')

/* 11
	�������� ����� ��� ��������� ������ ����� ��� ����������, �� ������ ��� 29346, 28559 ��� 25348
*/
SELECT * FROM employee
WHERE emp_no IN (29346, 28559, 25348)

/* 12
	�������� ����� ��� ��������� (�� ������ ����) ��� ���� � ������� works_on, �� ����������� � ����� M.
*/
SELECT DISTINCT job
FROM works_on
WHERE job LIKE 'M%'

/* 13
	�������� ����� ��� ��������� ������ ��� ����� ���� �� ������� �������
*/
SELECT DISTINCT project_no, job
FROM works_on
ORDER BY project_no

/* 14
	�������� ����� ��� ���������� ������� ���� � ��� �������� (���������, ������ � ��� �������� � ���������, ������ � �.�.)
*/
SELECT job, COUNT(job) AS quantity 
FROM works_on
WHERE job IS NOT NULL
GROUP BY job

/* 15
	�������� ����� ��� ��������� ������ � ������ ��� ����������, �� �� �������� � ���� d2
*/
SELECT * FROM employee 
WHERE dept_no != 'd2'

/* 16
	�������� ����� ��� ��������� ���� ��� ������� � ��������, ������ �� $100�000 � ������, �� $150�000
*/
SELECT project_name FROM project 
WHERE budget < 100000
AND budget > 150000

/* 17
	�������� ����� ��� ��������� ���� � ������ ����������, �� �������� � ���� Research
*/
SELECT emp_fname, emp_lname
FROM employee 
WHERE EXISTS (SELECT *
			FROM department 
			WHERE employee.dept_no = department.dept_no
			AND dept_name = 'research')

/* 18
	�������� ����� ��� ��������� ��� ����� ��� ���������� �� ����� ���������, ���� ������� ������� �� ������
*/
--����� ��� ��������� ��� ����� ��� ���������� �� ����� ���������
SELECT * FROM employee
WHERE EXISTS (SELECT *
			FROM works_on
			WHERE employee.emp_no = works_on.emp_no
			AND job = 'manager')

SELECT * FROM employee
WHERE emp_no IN (SELECT TOP 1 emp_no
			FROM works_on
			WHERE job = 'manager'
			ORDER BY enter_date)

/* 19
	�������� ����� ��� ��������� ���� � ������� ��� ������� � �������� � ������� �� $95�000 �� $120�000 �������
*/
SELECT project_name, budget
FROM project
WHERE budget BETWEEN 95000 AND 120000

/* 20
	�������� ����� ��� ��������� ������� ��� ����� ���� ��� ��� ����������
*/
SELECT DISTINCT job
FROM works_on

/* 21
	�������� ����� ��� ��������� ������ ����������, �� �������� ��� �������� p1 � ��������� ����, �� ���� ���������.
	���� ������ ��� ������� � ���������� �������, �� � �������� ������� ������� ����� �Job unknown�
*/
SELECT emp_no, (CASE
					WHEN job IS NULL THEN 'Job unknown'
					ELSE job END) AS job
FROM works_on
WHERE project_no = 'p1'

/* 22
	�������� ����� ��� ��������� ���� ��� ������� � ��������, ������ �� 60�000 ����� �������� (��� ��������� ���� �� 1 ����� 0,51 ���� ��������)
*/
SELECT * FROM project
WHERE budget*0.51 > 60000

/* 23
	�������� ����� ��� ��������� ������ ���������� � ��������� ������ ������� ��� �������� ����, ��������� � �������� p2
*/
SELECT emp_no, project_no
FROM works_on
WHERE job IS NULL AND project_no = 'p2'

/* 24
	�������� ����� ��� ���������� ���������� �������� ��� �������, ������ �� $100�000
*/
SELECT AVG(budget)
FROM project
WHERE budget > 100000

/* 25
	�������� ����� ��� ��������� ������ �� ������� ���������� � ��������� �������
*/
SELECT TOP 1 emp_no AS num, emp_fname AS surname
FROM employee
ORDER BY emp_no

/* 26
	�������� ����� ��� ��������� ������ ��� ����������, �� �������� ��� �������� Apollo
*/
SELECT emp_fname FROM employee
WHERE EXISTS (SELECT * FROM works_on
			WHERE employee.emp_no = works_on.emp_no
			AND EXISTS (SELECT * FROM project
						WHERE works_on.project_no = project.project_no
						AND project_name = 'Appolo'))

/* 27
	�������� ����� ��� ��������� ������ �����, ���� �� ������ ��� ����������, � ���� ������ �����, �� 20�000,
	������������� ��������� �� ���������� ������ �� ��������, ���� �� ������.
*/
SELECT dept_no, emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_no < 20000
ORDER BY emp_lname, emp_fname

/* 28
	�������� ����� ��� ��������� ������ �� ���� ��� ����������, � ������� ����������, ������ ��� ����� 15 000
*/
SELECT emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_no >= 15000

/* 29
	�������� ����� ��� ��������� ������ ��� ������� �� ������� ����������, �� �������� ��� ���� ���������, � ������� �������� ������� ����������.
*/
SELECT project_no, COUNT(emp_no) AS emp_quantity
FROM works_on
GROUP BY project_no
ORDER BY emp_quantity DESC

/* 30
	�������� ����� ��� ��������� ������ ����� ��� ��� ����������, �� �������� ����������� � ������
*/
SELECT * FROM employee
WHERE EXISTS (SELECT * FROM department
			WHERE employee.dept_no = department.dept_no
			AND location = 'Dallas')

/* 31
	�������� ����� ��� ��������� ������, ���� �� ������ ��� ����������,
	�� ������� �� ����������� � ���� J, K, L, M, N ��� �, � �� ����� �� ����������� � ���� E ��� Z.
*/
SELECT emp_no AS number, emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_lname NOT LIKE '[JKLMNO]%' AND emp_fname NOT LIKE '[EZ]%'

/* 32
	�������� ����� ��� ��������� ������ ��������� ��� ����������, �� ����� �� ����������� �������� �n�
*/
SELECT * FROM dbo.employee 
WHERE emp_fname NOT LIKE '%n'

/* 33
	�������� ����� ��� ��������� ������ �������, ��� ����� ������ ����� �� ������ ����������
*/
SELECT project_no FROM works_on
GROUP BY project_no
HAVING COUNT(DISTINCT emp_no) < 4

/* 34
	�������� ����� ��� ��������� ��� ����� ��� ������, �� �������� � 2007 ����
*/
SELECT * FROM works_on
WHERE YEAR(enter_date) = 2007