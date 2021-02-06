-- Create table representing number of retiring employees ret_titles table
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
	t.title, 
	t.from_date, 
	t.to_date
INTO ret_titles
FROM employee AS e
    LEFT JOIN titles as t
    ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM ret_titles;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM ret_titles as rt
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

-- Retreive # of retiring employees by recent job title. 
SELECT COUNT(emp_no) emp_no, 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY emp_no DESC;

SELECT * FROM retiring_titles;

-- Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name, 
    e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship
FROM employee AS e
    LEFT JOIN dept_emp as de
    ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	ON(e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship;