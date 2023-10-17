DESC employees;
SELECT *
FROM employees;

SELECT DISTINCT department_id "부서 코드"
FROM employees;

SELECT first_name || ' ' || last_name 이름, salary
FROM employees
WHERE commission_pct IS NOT NULL 
ORDER BY first_name DESC;

SELECT employee_id, first_name, hire_date, department_id
FROM employees
WHERE hire_date LIKE '02%'
MINUS
SELECT employee_id, first_name, hire_date, department_id
FROM employees
WHERE department_id = 100;

SELECT *
FROM dual;

SELECT sysdate
FROM dual;

SELECT LOWER('Ye Dam'), upper('ye dam'), initcap('ye dam')
FROM dual;

SELECT first_name
FROM employees
WHERE LOWER(first_name) LIKE '%a%';

SELECT first_name || ' 씨는 ' || job_id || '입니다'
FROM employees;

SELECT concat(job_id, concat(' : ', first_name))
FROM employees;

SELECT SUBSTR(job_id, 4)
FROM employees;

SELECT SUBSTR(job_id, 4, length(job_id)-3)
FROM employees;

SELECT SUBSTR(job_id, INSTR(job_id,'_')+1)
FROM employees;

SELECT INSTR(UPPER(first_name), 'I')
FROM employees;

SELECT LPAD(first_name, 10, '*'), RPAD(last_name,10, '#')
FROM employees;

SELECT TRIM('J' from first_name), first_name
FROM employees;

SELECT replace(job_id ,'_', '★')
FROM employees;

SELECT replace(job_id ,'_', '')
FROM employees;

SELECT trunc(months_between(sysdate, '22/03/31'))
FROM dual;

SELECT ADD_MONTHS('23/03/31', 6)
FROM dual;

SELECT NEXT_DAY(sysdate, '토')
from dual;

SELECT NEXT_DAY(sysdate, 7)
from dual;

SELECT LAST_DAY(sysdate)
from dual;

SELECT *
FROM NLS_SESSION_PARAMETERS;

ALTER SESSION
SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

ALTER SESSION
SET NLS_DATE_LANGUAGE = AMERICAN;

SELECT to_char(hire_date,'fmyyyy"년" mm dd hh : mi : ss')
FROM employees;

SELECT TO_CHAR(123.4567, 'L00,000.000')
FROM dual;

SELECT TO_CHAR(salary, '$999,999.99')
FROM employees;

SELECT hire_date, first_name
FROM employees
WHERE hire_date = TO_DATE('January 13, 2001','Month dd, yyyy');

--과제2
SELECT SYSDATE "Date"
FROM dual;

SELECT employee_id, first_name, salary, round(salary * 1.15) "New Salary"
FROM employees;

SELECT employee_id, first_name, salary, round(salary * 1.15) "New Salary",
    round(salary * 1.15)- salary "Increase"
FROM employees;

SELECT UPPER(first_name) "대문자 이름", length(first_name) "이름 길이"
FROM employees
WHERE SUBSTR(first_name,1,1) IN ('J','A','M')
ORDER BY first_name;

SELECT first_name, round(months_between(sysdate, hire_date)) "MONTHS_WORKED"
FROM employees
ORDER BY MONTHS_WORKED;

SELECT last_name, LPAD(salary, 15, '$') "SALARY"
FROM employees;

SELECT last_name, TRUNC((sysdate-hire_date)/7) "TENURE"
FROM employees
WHERE department_id = 90
ORDER BY "TENURE" DESC;

--4번
ALTER SESSION
SET NLS_DATE_LANGUAGE = KOREAN;

SELECT first_name, hire_date, TO_CHAR(hire_date,'day') "day"
FROM employees
ORDER BY TO_CHAR(hire_date-1,'d');


-- 커미션이 null이면 0표시
SELECT first_name, commission_pct, NVL(commission_pct, 0)
FROM employees;

--null이 아니면 comm, null이면 0
SELECT first_name, commission_pct, 
    LPAD(TO_CHAR(salary*12 + NVL2(commission_pct,commission_pct, 0), '999,999') , 15, '*')
FROM employees;

--NULLIF -> 같으면 null
SELECT first_name, last_name, nullif(length(first_name),length(last_name))
from employees;

SELECT first_name, salary,
    case when salary>20000 then salary * 1.1
         when salary>10000 then salary * 1.2
         when salary>5000 then salary * 1.3
         else salary
    end
    as "인상급여"
from employees;

SELECT first_name, salary, department_id,
    decode ( department_id, '10', 'AAA',
                            '20', 'bb',
                            '30', 'cc', 
                            '40', 'dd', 'fff') as dep
from employees;


SELECT job_id
FROM employees;

SELECT first_name, salary, job_id,
    decode( job_id, 'AC_MGR', salary * 1.3,
                    'FI_MGR', salary * 1.2,
                    'IP_PROG', salary * 1.1,
                    salary) as upsalary
FROM employees;
--case문으로 표현
SELECT first_name, salary, job_id, 
    case job_id when 'AC_MGR' then salary * 1.3
                when 'FI_MGR' then salary * 1.2
                when 'IP_PROG' then salary * 1.1
                else salary
    end as upsalary
FROM employees;


--1번
SELECT employee_id, first_name, salary
FROM employees;

SELECT *
FROM employees;

SELECT employee_id "사원번호" , first_name "사원이름", salary
FROM employees;

SELECT first_name || '의 월급은 ' || salary || ' 달러입니다.'
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT first_name, salary
FROM employees
ORDER BY salary;

SELECT first_name, salary, job_id
FROM employees
WHERE salary = 3000;

SELECT first_name, salary, job_id, hire_date, department_id
FROM employees
WHERE first_name = 'Steven';

SELECT first_name, (salary+salary*NVL(commission_pct, 0))*12 "연봉"
FROM employees
WHERE (salary+salary*NVL(commission_pct, 0))*12 >= 90000;

SELECT first_name, salary, job_id, department_id
FROM employees
WHERE salary <= 12000;