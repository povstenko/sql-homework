USE Sample

SELECT * FROM dbo.department
SELECT * FROM dbo.employee
SELECT * FROM dbo.project
SELECT * FROM dbo.works_on




/* 1
	Напишіть запит для отримання назв та номерів всіх відділень, що знаходяться у Далласі.
*/
SELECT dept_name, dept_no
FROM department
WHERE location = 'Dallas'

/* 2
	Напишіть запит для отримання повних даних про всі відділи.
*/
SELECT * FROM department

/* 3
	Напишіть запит для отримання номерів працівників, номерів проектів і назв робіт для працівників,
	які витратили НЕ найбільше часу для роботи над одним з цих проектів
*/
SELECT emp_no, project_no, job
FROM works_on
WHERE emp_no != (SELECT TOP 1 emp_no
				FROM works_on
				ORDER BY enter_date)

/* 4
	Напишіть запит для отримання імен, прізвищ та номерів всіх працівників, у яких друга буква імені «а».
*/
SELECT emp_fname AS [name], emp_lname AS surname, emp_no AS number
FROM employee
WHERE emp_fname LIKE '_a%'

/* 5
	Напишіть запит який видає список номерів проектів та робіт, що виконуються на цьому проекті. При цьому невідомі роботи виводити не потрібно.
*/
SELECT DISTINCT project_no, job
FROM works_on
WHERE job IS NOT NULL
ORDER BY project_no

/* 6
	Напишіть запит для обчислення кількості різних робіт у кожному проекті
*/
SELECT project_no, COUNT(DISTINCT job) AS 'jobs_num'
FROM works_on
GROUP BY project_no

/* 7
	Напишіть запит для отримання всіх даних про всі підрозділи, чиє місце розташування починається з символу в діапазоні від C до F
*/
SELECT * FROM department
WHERE location LIKE '[C-F]%'

/* 8
	Напишіть запит для отримання повних даних про працівників, чиї номери не рівні ні 10102, ні 9031
*/
SELECT * FROM employee
WHERE emp_no NOT IN (10102, 9031)

/* 9
	Напишіть запит для обчислення суми всіх бюджетів всіх проектів
*/
SELECT SUM(budget) AS total_budget
FROM project

/* 10
	Напишіть запит для отримання номерів працівників, які працюють над проектом p1 і/або проектом p2
*/
SELECT emp_no FROM works_on
WHERE project_no IN ('p1', 'p2')

/* 11
	Напишіть запит для отримання повних даних про працівників, чиї номери рівні 29346, 28559 або 25348
*/
SELECT * FROM employee
WHERE emp_no IN (29346, 28559, 25348)

/* 12
	Напишіть запит для виведення (по одному разу) тих робіт з таблиці works_on, які починаються з букви M.
*/
SELECT DISTINCT job
FROM works_on
WHERE job LIKE 'M%'

/* 13
	Напишіть запит для отримання списку всіх різних робіт по кожному проекту
*/
SELECT DISTINCT project_no, job
FROM works_on
ORDER BY project_no

/* 14
	Напишіть запит для обчислення кількості робіт у всіх проектах (наприклад, скільки у всіх проектах є менеджерів, клерків і т.д.)
*/
SELECT job, COUNT(job) AS quantity 
FROM works_on
WHERE job IS NOT NULL
GROUP BY job

/* 15
	Напишіть запит для отримання номерів і прізвищ всіх працівників, що не працюють у відділі d2
*/
SELECT * FROM employee 
WHERE dept_no != 'd2'

/* 16
	Напишіть запит для отримання назв всіх проектів з бюджетом, меншим ніж $100 000 і більшим, ніж $150 000
*/
SELECT project_name FROM project 
WHERE budget < 100000
AND budget > 150000

/* 17
	Напишіть запит для отримання імен і прізвищ працівників, що працюють у відділі Research
*/
SELECT emp_fname, emp_lname
FROM employee 
WHERE EXISTS (SELECT *
			FROM department 
			WHERE employee.dept_no = department.dept_no
			AND dept_name = 'research')

/* 18
	Напишіть запит для отримання всіх даних про працівника на посаді менеджера, який останнім отримав цю посаду
*/
--запит для отримання всіх даних про працівника на посаді менеджера
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
	Напишіть запит для отримання назв і бюджетів всіх проектів з бюджетом в діапазоні від $95 000 до $120 000 включно
*/
SELECT project_name, budget
FROM project
WHERE budget BETWEEN 95000 AND 120000

/* 20
	Напишіть запит для отримання переліку всіх різних робіт для всіх працівників
*/
SELECT DISTINCT job
FROM works_on

/* 21
	Напишіть запит для отримання списку працівників, що працюють над проектом p1 і відповідних робіт, які вони виконують.
	Якщо робота для певного з працівників невідома, то у відповідній колонці вивести запис «Job unknown»
*/
SELECT emp_no, (CASE
					WHEN job IS NULL THEN 'Job unknown'
					ELSE job END) AS job
FROM works_on
WHERE project_no = 'p1'

/* 22
	Напишіть запит для отримання назв всіх проектів з бюджетом, більшим ніж 60 000 фунтів стерлінгів (при поточному курсі за 1 долар 0,51 фунт стерлінгів)
*/
SELECT * FROM project
WHERE budget*0.51 > 60000

/* 23
	Напишіть запит для отримання номерів працівників і відповідних номерів проектів для невідомих робіт, пов’язаних з проектом p2
*/
SELECT emp_no, project_no
FROM works_on
WHERE job IS NULL AND project_no = 'p2'

/* 24
	Напишіть запит для обчислення середнього значення всіх бюджетів, більших за $100 000
*/
SELECT AVG(budget)
FROM project
WHERE budget > 100000

/* 25
	Напишіть запит для отримання номера та прізвища працівника з найменшим номером
*/
SELECT TOP 1 emp_no AS num, emp_fname AS surname
FROM employee
ORDER BY emp_no

/* 26
	Напишіть запит для отримання прізвищ всіх працівників, що працюють над проектом Apollo
*/
SELECT emp_fname FROM employee
WHERE EXISTS (SELECT * FROM works_on
			WHERE employee.emp_no = works_on.emp_no
			AND EXISTS (SELECT * FROM project
						WHERE works_on.project_no = project.project_no
						AND project_name = 'Appolo'))

/* 27
	Напишіть запит для отримання номерів відділів, імен та прізвищ тих працівників, у яких номери менші, ніж 20 000,
	впорядкувавши результат за зростанням спершу по прізвищах, потім по іменах.
*/
SELECT dept_no, emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_no < 20000
ORDER BY emp_lname, emp_fname

/* 28
	Напишіть запит для отримання прізвищ та імен всіх працівників, з номером працівника, більшим або рівним 15 000
*/
SELECT emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_no >= 15000

/* 29
	Напишіть запит для отримання номерів всіх проектів та кількості працівників, які працюють над цими проектами, у порядку спадання кількості працівників.
*/
SELECT project_no, COUNT(emp_no) AS emp_quantity
FROM works_on
GROUP BY project_no
ORDER BY emp_quantity DESC

/* 30
	Напишіть запит для отримання повних даних про всіх працівників, чиє відділення знаходиться у Далласі
*/
SELECT * FROM employee
WHERE EXISTS (SELECT * FROM department
			WHERE employee.dept_no = department.dept_no
			AND location = 'Dallas')

/* 31
	Напишіть запит для отримання номерів, імен та прізвищ всіх працівників,
	чиї прізвища не починаються з букв J, K, L, M, N або О, і чиї імена не починаються з букв E або Z.
*/
SELECT emp_no AS number, emp_fname AS [name], emp_lname AS surname
FROM employee
WHERE emp_lname NOT LIKE '[JKLMNO]%' AND emp_fname NOT LIKE '[EZ]%'

/* 32
	Напишіть запит для отримання повних відомостей про працівників, чиї імена не закінчуються символом «n»
*/
SELECT * FROM dbo.employee 
WHERE emp_fname NOT LIKE '%n'

/* 33
	Напишіть запит для отримання номерів проектів, над якими працює менше ніж чотири працівники
*/
SELECT project_no FROM works_on
GROUP BY project_no
HAVING COUNT(DISTINCT emp_no) < 4

/* 34
	Напишіть запит для отримання всіх даних про роботи, які почалися у 2007 році
*/
SELECT * FROM works_on
WHERE YEAR(enter_date) = 2007