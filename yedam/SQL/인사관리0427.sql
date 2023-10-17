--60번
SELECT first_name, job_id,
    case job_id when 'SA_MAN' then 500
                when 'PU_CLERK' then 500
                when 'ST_CLERK' then 400
                when 'FI_ACCOUNT' then 400
                else 0
    end as 보너스
from employees;

SELECT first_name, job_id,
    case when job_id in('SA_MAN','PU_CLERK') then 500
         when job_id in('ST_CLERK','FI_ACCOUNT') then 400
         else 0
    end as 보너스
from employees;
--59번
SELECT first_name, job_id, commission_pct, 
    decode(commission_pct, null, 500, 0) as 보너스
FROM employees;

--11번
SELECT first_name, department_id, job_id
FROM employees
where job_id != 'SA_MAN';
--12
SELECT first_name, salary
FROM employees
where salary between 1000 and 3000;
--13
SELECT first_name, salary
FROM employees
where salary not between 1000 and 3000;
--14
select first_name, hire_date
FROM employees
where hire_date like '06%';
--15
select first_name, salary
FROM employees
where first_name like 'S%';
--16
select first_name, salary
FROM employees
where first_name like '%t';
--17
select first_name, salary
FROM employees
where first_name like '_m%';
--18
select first_name, salary
from employees
where upper(first_name) like '%A%';
--19
select first_name, commission_pct
from employees
where commission_pct is null;
--20
select first_name, salary, job_id
from employees
where job_id in('SA_MAN','PU_CLERK', 'IT_PROG');
--21
select first_name, salary, job_id
from employees
where job_id not in('SA_MAN','PU_CLERK', 'IT_PROG');
--22
select first_name, salary, job_id
from employees
where job_id = 'SA_MAN'
    and salary >=1200;
--23
select upper(first_name), lower(first_name), initcap(first_name)
from employees;
--24
select first_name, salary
from employees
where lower(first_name) = 'alexander';
--25
select substr('SMITH',1,3)
from dual;
--26
select first_name, length(first_name) "철자 개수"
from employees;
--27
select first_name, instr(first_name, 'a')
from employees;
--28
select first_name, lpad(salary, 10, '*')
from employees;
--29
select first_name, salary, lpad(' ', salary/1000+1, '■')
from employees;
-- 30번
select round(876.567, 1)
from dual;
--31
select trunc(876.567, 1)
from dual;
--32
select mod(10, 3)
from dual;
--33
select employee_id, mod(employee_id, 2)
from employees;
--34
select employee_id, first_name
from employees
where mod(employee_id, 2) = 0;
--35
select first_name, round(months_between(sysdate, hire_date)) || '개월'
from employees;
--36
select to_date('2019-6-1')-to_date('2018-10-1') "총일수"
from dual;
--37
select trunc((to_date('2019-6-1')-to_date('2018-10-1'))/7) "총주수"
from dual;
--38
SELECT ADD_MONTHS('2019-5-1',100)
from dual;
--39
SELECT TO_DATE('2019-5-1') + 100
from dual;
--40
SELECT NEXT_DAY('2021-6-30', '화')
from dual;
--41
SELECT NEXT_DAY('2019-5-22', '월요일')
from dual;
--42
SELECT NEXT_DAY(SYSDATE, 3)
FROM DUAL;
--43
SELECT NEXT_DAY(ADD_MONTHS('2019-5-22', 100),3)
from dual;
--44
SELECT NEXT_DAY(ADD_MONTHS(sysdate, 100),2)
from dual;
--45
SELECT LAST_DAY('2019-5-22')
FROM dual;
--46
SELECT LAST_DAY(SYSDATE)-SYSDATE
FROM dual;
--47
select first_name, hire_date, last_day(hire_date)
from employees
where upper(first_name) = 'SUSAN';
--48
select first_name, to_char(hire_date, 'day'), to_char(salary, '9,999')
from employees
where upper(first_name) = 'DAVID';
--50
select first_name, hire_date
from employees
where hire_date like '08%';
--51
select first_name, to_char(salary, '$999,999')
from employees
where salary >= 1500;
--52
select first_name, hire_date
from employees
where hire_date = '05/06/14';
--53
select first_name, nvl(commission_pct,0)
from employees;
--54
select salary, nvl(commission_pct,0), salary+ salary*nvl(commission_pct, 0)
from employees
where job_id in ('SA_MAN', 'IT_PROG');
--55
select first_name, department_id,
    case department_id when 10 then 300
                       when 20 then 400
                       else 0
    end as "보너스"
from employees;

select first_name, department_id,
    decode (department_id , 10 , 300,
                            20 , 400,
                            0) as "보너스"
from employees;
--56
select employee_id,
    case mod(employee_id, 2) when 1 then '홀수'
        else '짝수'
    end as "짝수, 홀수"
from employees;
--57
select first_name, job_id, 
    decode (job_id, 'SA_MAN', 5000, 2000) 보너스
from employees;
--58
select first_name, job_id, salary,
    case when salary >= 5000 then 500
         when salary >= 3000 then 300
         when salary >= 2000 then 200
         else 0
    end as "보너스"
from employees;
--59
select first_name, job_id, commission_pct, 
    decode ( commission_pct, null, 500, 0) as "보너스"
from employees;
--60
SELECT first_name, job_id,
    case when job_id in('SA_MAN','PU_CLERK') then 500
         when job_id in('ST_CLERK','FI_ACCOUNT') then 400
         else 0
    end as 보너스
from employees;



--모의고사
--1
DESC departments;

SELECT *
FROM departments;
--2
SELECT employee_id, first_name, salary, hire_date, department_id
from employees
order by department_id, salary desc;
--3
select *
from employees
where commission_pct is not null;
--4
select first_name, salary
from employees
where salary not between 5000 and 12000;
--5
select first_name, hire_date, job_id
from employees
where substr(hire_date, 1,2) in('02','05','07');
--6
select first_name, job_id, salary, department_id
from employees
where job_id like '%SA%'
    or job_id like '%MK%';
--7
select lpad(last_name,10,'*')
from employees;
--8
select employee_id, first_name, salary, round(salary * 1.15) "New Salary"
from employees
order by "New Salary" desc;
--9
select employee_id, last_name, hire_date, add_months(hire_date, 6)
from employees;
--10
select first_name, department_id, job_id, hire_date, salary
from employees
where job_id in('IT_PROG','FI_MGR')
    and salary not between 10000 and 15000
order by department_id, hire_date;
--11
select employee_id, first_name, department_id,
    case department_id when 40 then 'seoul'
                    when 50 then 'pusan'
                    else 'daegu'
            end as "근무지역"
from employees;

select employee_id, first_name, department_id,
    decode (department_id, 40, 'seoul',
                            50, 'pusan',
                            'daegu') as "근무지역"
from employees;