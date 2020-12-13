USE Sample

--Views
--1.	Створіть представлення, яке містить дані всіх співробітників, які працюють у відділі d1.
GO
CREATE VIEW d1_employee (emp_no, emp_fname, emp_lname, dept_no)
    AS SELECT emp_no, emp_fname, emp_lname, dept_no
        FROM employee
        WHERE dept_no = 'd1'

GO
SELECT * FROM d1_employee

--2.	Для таблиці project створіть представлення, яке може використовуватись тими співробітниками, яким дозволено переглядати дані з цієї таблиці за винятком стовпця budget.
GO
CREATE VIEW projectV
AS SELECT project_no, project_name
	FROM project

GO
SELECT * FROM projectV


--3.	Створіть представлення, яке містить імена та прізвища всіх співробітників, які почали працювати над проектами в другій половині 2007 року.
GO
CREATE VIEW empSecHalfV
	AS SELECT emp_fname, emp_lname FROM works_on w
		JOIN employee e
		ON e.emp_no = w.emp_no
		WHERE enter_date >= '2007-06-01'

GO
SELECT * FROM empSecHalfV


--4.	Змінити результат завдання 3 так, щоб оригінальні стовпці f_name та l_name отримали в представленні нові імена: first та last відповідно.
GO
ALTER VIEW empSecHalfV([first], [last])
	AS SELECT emp_fname, emp_lname FROM works_on w
		JOIN employee e
		ON e.emp_no = w.emp_no
		WHERE enter_date >= '2007-06-01'

GO
SELECT * FROM empSecHalfV

--5.	Використовуючи представлення з вправи 1, відобразіть всі дані кожного співробітника, чиє прізвище починається з літери М.
SELECT * FROM d1_employee
WHERE emp_lname LIKE 'M%'

--6.	Створіть представлення, яке містить повні дані по всіх проектах, над якими працює Smith.
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

--7.	Використовуючи оператор ALTER VIEW, змініть умову в представленні з вправи 1. Модифіковане представлення  повинно містити дані про всіх співробітників, які працюють або у відділі d1, або у відділі d2, або в обох.
GO
ALTER VIEW d1_employee
    AS SELECT emp_no, emp_fname, emp_lname, dept_no
        FROM employee
        WHERE dept_no = 'd1'
		OR dept_no = 'd2'

GO
SELECT * FROM d1_employee


--8.	Знищіть представлення, створене у вправі 3. Що відбудеться із представленням, створеним у вправі 4?
DROP VIEW empSecHalfV

SELECT * FROM empSecHalfV

--9.	Використовуючи представлення із вправи 2, додайте дані про новий проект з номером проекту p2 та назвою Moon. 
SELECT * FROM projectV

GO
INSERT INTO projectV
VALUES('p2', 'Moon');


--10.	Створіть представлення (з опцією WITH CHECK OPTION), яке містить імена та прізвища всіх співробітників, у яких номер співробітника менше, ніж 10000. Після цього використати це представлення для  додавання даних про нового співробітника з прізвищем Kohn та номером 22123, який працює у відділі d3.
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

--11.	Використайте представлення з вправи 10 без опції WITH CHECK OPTION та знайдіть відмінність у додаванні даних.
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


--12.	Створіть представлення (з опцією WITH CHECK OPTION) з усіма подробицями з таблиці works_on для всіх всіх співробітників, які почали працювати над проектами в період з  2007 до 2008 року. Після цього змініть дату початку роботи над проектом у співробітника з номером 29346. Нова дата має бути 06/01/2006.
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

--13.	Використайте представлення з вправи 12 без без опції WITH CHECK OPTION та знайдіть відмінність у додаванні даних.
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