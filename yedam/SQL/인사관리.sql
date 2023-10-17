SELECT * FROM TAB;

SELECT *
FROM countries;

DESC employees;

SELECT DISTINCT first_name AS name, department_id dep_id
FROM employees;

SELECT last_name name, salary, salary * 1.1 upsal
FROM employees;

SELECT employee_id, first_name || ' ' || last_name "이름", salary, salary * 12 + commission_pct "연봉"
FROM employees;

SELECT DISTINCT department_id
FROM employees;

SELECT *
FROM employees
WHERE hire_date >= '07/01/01';

SELECT * 
FROM empLoyees
WHERE department_id NOT IN (30, 100, 80);

SELECT first_name || ' ' || last_name "NAME", salary
FROM employees
WHERE first_name LIKE 'J____';

DESC employees;

SELECT *
FROM departments
WHERE manager_id NOT IN (200, 100);

SELECT department_name
FROM departments
WHERE department_name LIKE 'A%';

SELECT *
FROM departments
WHERE location_id BETWEEN 1400 AND 1600;

SELECT employee_id, first_name || ' ' || last_name "이름", salary
FROM employees
WHERE salary + 200 >= 22000;

SELECT *
FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';

SELECT *
FROM employees
WHERE employee_id >= 150;

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

SELECT *
FROM employees
WHERE salary > 20000
    OR department_id = 80;
    
SELECT *
FROM employees
WHERE department_id =80
ORDER BY salary DESC;

SELECT *
FROM employees
WHERE department_id != 80
    AND salary BETWEEN 10000 AND 15000
ORDER BY salary;
/*주석*/
-- 1번
DESC departments;

SELECT *
FROM departments;

DESC employees;

SELECT employee_id, first_name, job_id, hire_date "startday"
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT job_id || ',' || first_name "employee and title"
FROM employees;

SELECT first_name, salary
FROM employees
WHERE salary >= 17000;

SELECT first_name, department_id
FROM employees
WHERE employee_id BETWEEN 100 AND 180;

SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 15000;

SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name In ('Lee', 'Gee')
ORDER BY hire_date;

SELECT last_name, department_id
FROM employees
WHERE department_id IN(20, 50)
ORDER BY last_name;

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 1000 AND 15000
    AND department_id IN(50, 80);
    
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '04/12/31';
-- WHERE hire_date LIKE '04%';

SELECT first_name, job_id
FROM employees
WHERE manager_id IS NULL;

SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

SELECT first_name
FROM employees
WHERE first_name LIKE '__a%';
 
SELECT first_name, job_id, salary
FROM employees
WHERE job_id IN('SA_REP','ST_CLERK')
    AND salary NOT IN (7000, 10000);