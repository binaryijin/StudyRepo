SELECT *
FROM (
    SELECT ROWNUM rn, e.*
    FROM ( SELECT *
            FROM employees
            ORDER BY last_name ASC) e)
WHERE rn BETWEEN 1 AND 10;
--

-- 1.
select *
from employees
where hire_date > '02-01-01' and upper(job_id) = 'ST_CLERK';
-- hire_date > to_date('2002/12/31', 'YYYY/MM/DD')
-- to_char(hire_date, 'YYYY') > '2002'

-- 2.
select last_name, job_id, salary, commission_pct
FROM employees
WHERE commission_pct is not null
order by salary desc;

-- 3.
select 'The salary of ' || last_name || 'after a 10% raise is ' || round(salary*1.10) as "New salary"
FROM employees
WHERE commission_pct is null;

-- 4.
SELECT last_name, trunc((months_between(sysdate,hire_date))/12) "YEARS", 
        trunc(mod(months_between(sysdate, hire_date), 12)) "MONTHS" 
from employees;

-- 5.
select last_name
from employees
where upper(last_name) like 'J%' 
    or upper(last_name) like 'K%' 
    or upper(last_name) like 'L%' 
    or upper(last_name) like 'M%';
    
select last_name
from employees
where upper(substr(last_name, 1, 1)) in ('J', 'K', 'L', 'M');


-- 6.
select last_name, salary,  NVL2( commission_pct, 'YES', 'NO') "COM"
from employees;

-- 6. case문
select last_name, salary,
    case
      when commission_pct is null 
        then 'No'
      else 'Yes'
    end as COM
from employees;

-- 6. decode 함수 (오라클만 가능)
select last_name, salary,
    decode(commission_pct, null, 'No', 
                                 'Yes') COM
from employees;

-- 7.
select d.department_name, d.location_id, e.last_name, e.job_id, e.salary
from employees e join departments d
                on(e.department_id = d.department_id)
where d.location_id = 1800;

-- 8.
select count(*)
from employees
where lower(last_name) like '%n';

-- 8. substr
select count(*)
from employees
where lower(substr(last_name, -1)) = 'n';

-- 9.
select d.department_id, d.department_name, d.location_id, count(e.employee_id)
from departments d left outer join employees e
                    on d.department_id = e.department_id
group by d.department_id, d.department_name, d.location_id;

-- 10.
select distinct job_id
from employees
where department_id = 10 or department_id = 20;
-- department_id IN (10,20)

-- 11.
select e.job_id, count(e.job_id) "FREQUENCY"
from departments d join employees e on d.department_id = e.department_id
where lower(d.department_name) IN ('administraion' , 'executive')
group by e.job_id
ORDER by FREQUENCY desc; --ORDER by 2 desc

-- 11. 서브쿼리
select job_id, count(job_id) "FREQUENCY"
from employees
where department_id in
        (select department_id
        from departments
        where lower(department_name) IN ('administraion' , 'executive'))
group by job_id
ORDER by FREQUENCY desc;

-- 12.
select last_name, hire_date
from employees
where to_char(hire_date, 'DD') < '16';

-- 13.
select last_name, salary, trunc(salary/1000) "THOUSANDS"
from employees;

-- 13.
select last_name, salary, trunc(salary, -3)/1000 "THOUSANDS"
from employees;

-- 14.
select w.last_name, m.last_name manager, m.salary, j.max_salary
from employees w join employees m
                    on (w.manager_id = m.employee_id)
                    join jobs j
                    on (m.job_id = j.job_id)
where m.salary > 15000;

-- 15.
select department_id, min(salary)
from employees
group by department_id
having avg(salary) = (select max(avg(salary))
                        from employees
                        group by department_id);


