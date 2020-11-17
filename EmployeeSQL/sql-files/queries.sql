/* Order of csv files imported:
departments.csv 
titles.csv
employees.csv
dept_emp.csv
dept_manager.csv
salaries.csv
*/

-- Checking counts, records after csv-import
SELECT COUNT(*) FROM departments;
SELECT * FROM departments;

SELECT COUNT(*) FROM titles;
SELECT * FROM titles;

SELECT COUNT(*) FROM employees;
SELECT * FROM employees limit 100;

SELECT COUNT(*) FROM dept_emp;
SELECT * FROM dept_emp;

SELECT COUNT(*) FROM dept_manager;
SELECT * FROM dept_manager;

SELECT COUNT(*) FROM salaries;
SELECT * FROM salaries;

-- Data Analysis : Queries

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees e
INNER JOIN salaries s 
	ON s.emp_no = e.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986;


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
FROM dept_manager dm
INNER JOIN departments d
	ON d.dept_no = dm.dept_no
INNER JOIN employees e
	ON e.emp_no = dm.emp_no
WHERE e.emp_title_id in (
	SELECT t.title_id FROM titles t WHERE t.title = 'Manager'
	);
	
	
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON de.emp_no = e.emp_no
INNER JOIN departments d
	ON d.dept_no = de.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name, e.sex 
FROM employees e
WHERE e.first_name = 'Hercules' and e.last_name like 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON de.emp_no = e.emp_no
INNER JOIN departments d
	ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON de.emp_no = e.emp_no
INNER JOIN departments d
	ON d.dept_no = de.dept_no
WHERE d.dept_name in ('Sales', 'Development');


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT e.last_name, COUNT(e.last_name) AS last_name_count
FROM employees e
GROUP BY e.last_name
ORDER BY last_name_count DESC;