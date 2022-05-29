-- Deliverable 1, quary 1
SELECT emp.emp_no,
       emp.first_name,
	   emp.last_name,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO employee_by_Title
FROM employees as emp
LEFT JOIN titles as ti
ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no ASC;	

COPY (SELECT * FROM employee_by_Title) TO 'C:\Module_7\Data\retirement_titles.csv'
DELIMITER ',' CSV HEADER;

-- Deliverable 1, quary 2
SELECT DISTINCT ON (empT.emp_no)
	   empT.emp_no, 	
       empT.first_name,
	   empT.last_name,
       empT.Title
INTO employee_by_Title_Latest
FROM employee_by_Title as empT
WHERE empT.to_date = ('9999-01-01')
ORDER BY empT.emp_no, empT.to_date DESC;

COPY (SELECT * FROM employee_by_Title_Latest) TO 'C:\Module_7\Data\unique_titles.csv'
DELIMITER ',' CSV HEADER;

-- Deliverable 1, quary 3
SELECT COUNT(empTL.emp_no),
		    empTL.title
INTO retiring_titles
FROM employee_by_Title_Latest as empTL
GROUP BY empTL.title
ORDER BY count DESC;

COPY (SELECT * FROM retiring_titles) TO 'C:\Module_7\Data\retiring_titles.csv'
DELIMITER ',' CSV HEADER;


-- Deliverable 2, quary 1

SELECT DISTINCT ON (emp.emp_no)
       emp.emp_no,
	   emp.first_name,
	   emp.last_name,
	   emp.birth_date,
	   demp.from_date,
	   demp.to_date,
	   ti.title
INTO mentorship_eligibilty
FROM employees as emp  
INNER JOIN department_employees as demp
ON (emp.emp_no=demp.emp_no)
INNER JOIN titles as ti
ON (emp.emp_no=ti.emp_no)
WHERE (demp.to_date = '9999-01-01')
	AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')	   
ORDER BY emp.emp_no;	

COPY (SELECT * FROM mentorship_eligibilty) TO 'C:\Module_7\Data\mentorship_eligibilty.csv'
DELIMITER ',' CSV HEADER;