SELECT *
FROM employees;
--COUNT
SELECT COUNT(employee_id) as �����
FROM employees;

SELECT COUNT(commission_pct) as  �߰������ο�,
       COUNT(DISTINCT department_id) as �μ���,
       COUNT(DISTINCT manager_id) as �����ڼ�
FROM employees;

SELECT department_id, 
       TO_CHAR(SUM(salary),'L999,999') as sumsalary , 
       ROUND(AVG(salary),2) as avgsalary,
       MAX(salary) as max,
       min(salary) as min
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- ���� �ڵ庰 �޿� �հ�, ���, �ִ�, �ּ�, �ο����� ǥ���ϼ���.
-- ���� �ڵ庰�� �������� ����
SELECT job_id, 
    sum(salary) as �հ�, 
    avg(salary) as ���, 
    max(salary) as �ִ�,
    min(salary) as �ּ�,
    count(employee_id) as �ο���
FROM employees
GROUP BY job_id
ORDER BY job_id desc;

--HAVING
SELECT department_id, 
       TO_CHAR(SUM(salary),'L999,999') as sumsalary , 
       ROUND(AVG(salary)) as avgsalary,
       MAX(salary) as max,
       min(salary) as min
FROM employees
WHERE department_id != 70 --���ǿ� ���� ���� ����
GROUP BY department_id
--HAVING AVG(salary) > 8000
HAVING MAX(salary) > 10000 --����� �Ϳ� ���� ����
ORDER BY department_id DESC;

--���� : �׷��Լ�
--1. true
--2. false (count(*))
--3. true
--4
SELECT max(salary) "Maximum", min(salary) "Minimum", sum(salary) "Sum", 
    round(avg(salary)) "Average"
FROM employees;
--5
SELECT job_id,
    max(salary) "Maximum", min(salary) "Minimum", sum(salary) "Sum", 
    round(avg(salary)) "Average"
FROM employees
group by job_id;
--6
SELECT job_id, COUNT(job_id)
FROM employees
group by job_id;
--7
SELECT count(DISTINCT manager_id) "Number of Managers"
FROM employees;
--8
SELECT max(salary)-min(salary) "DIFFERENCE"
FROM employees;
--9
SELECT manager_id, min(salary)
FROM employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000
order by min(salary) desc;
--10
SELECT job_id,
    sum(decode(department_id, 20, salary, 0)) "�μ� 20",
    sum(decode(department_id, 50, salary, 0)) "�μ� 50",
    sum(decode(department_id, 80, salary, 0)) "�μ� 80",
    sum(decode(department_id, 90, salary, 0)) "�μ� 90",
    sum(salary) "�޿� �Ѿ�"
--    sum(decode(department_id, 20, salary,
--                              50, salary,
--                              80, salary,
--                              90, salary, 0))
FROM employees
GROUP BY job_id;


--join
SELECT count(*)
from departments;

--left�ܺ�����, ������ �������� �������� �߰�(+)
select *
from employees e, departments d
where e.department_id = d.department_id(+);

--right�ܺ�����,
select e.first_name, e.department_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

select *
from jobs;

select e.first_name, e.salary, j.job_id, j.min_salary, j.max_salary
from employees e, jobs j
where e.salary between min_salary and max_salary;

select e2.employee_id, e2.first_name, e.employee_id, e.first_name
from employees e, employees e2
where e.manager_id = e2.employee_id;



select e.first_name, department_id, d.department_name
from employees e join departments d
using (department_id);

select e.first_name, department_id, d.department_name
from employees e left outer join departments d
using (department_id);

select e.first_name, department_id, d.department_name
from employees e full outer join departments d
using (department_id);

--on��
select e.first_name, e.department_id, d.department_name
from employees e join departments d
    on e.department_id = d.department_id
    and e.department_id = 80;



--���� : ����
--1
select *
from locations;

select *
from countries;

select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from locations l natural join countries c;

--1 ���
select location_id, street_address, city, state_province, country_name
from locations natural join countries;

--2
select e.last_name, department_id, d.department_name
from employees e left outer join departments d
    using (department_id);
    
--2 ���
select last_name, department_id, department_name
from employees join departments
    using (department_id);

--3
select e.last_name, e.job_id, d.department_id, d.department_name
from departments d
    join locations l
        on d.location_id = l.location_id
    join employees e 
        on d.department_id = e.department_id
where l.city = 'Toronto';

--3 ���
select e.last_name, e.job_id, d.department_id, d.department_name
from employees e
    join departments d
        on d.department_id = e.department_id
    join locations l 
        on d.location_id = l.location_id
where l.city = 'Toronto';

--4
select e.last_name, e.employee_id, e2.last_name, e2.employee_id
from employees e, employees e2
where e.manager_id = e2.employee_id;

--select e.last_name, e.employee_id, e2.last_name, e2.employee_id
--from employees e join employees e2
--    on e.manager_id = e2.employee_id;

--4 ���
select e1.last_name, e1.employee_id, e2.last_name, e2.employee_id
from employees e1 
    join employees e2
        on (e1.manager_id = e2.employee_id);

--5
select e.last_name "Employee", e.employee_id "Emp#",
        e2.last_name "Manager" , e2.employee_id "Mgr#"
from employees e, employees e2
where e.manager_id = e2.employee_id(+)
order by e.employee_id;

--5 ���
select e1.last_name, e1.employee_id, e2.last_name, e2.employee_id
from employees e1 
    left outer join employees e2
        on (e.manager_id = e2.employee_id)
order by e1.employee_id;

--6
select e.last_name "���" , department_id "�μ���ȣ", e2.first_name "���� �μ����"
from employees e right outer join employees e2
    using(department_id);
    

--6 ���
select e.last_name, e.department_id, e2.last_name, e2.employee_id
from employees e
    join employees e2
        on (e.department_id = e2.department_id)
where e.employee_id != e2.employee_id --�ڽ� ����X
order by e.department_id;
--7
select *
from jobs;

select e.first_name, e.job_id, d.department_name, e.salary
from employees e left outer join departments d
    using(department_id);
    
--7 ���
select e.last_name, e.job_id, d.department_name, e.salary
from employees e 
    left outer join departments d
        on (e.department_id = d.department_id);
        
        
        
        
--��������
select first_name, job_id
from employees
where job_id = (select job_id
                from employees
                where employee_id = 147);
select job_id
from employees
where employee_id = 147;

select first_name, job_id
from employees
where job_id = 'SA_MAN';

select *
from employees;

select department_id
from employees
where first_name = 'David';

select first_name, department_id, salary
from employees
where department_id in (select department_id
                        from employees
                        where first_name = 'David');
                        
select first_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees);
                
-- in �� ���� ��հ��� ��ġ�ϴ� ���� ���                
select first_name, job_id, salary
from employees
where salary in (select avg(salary)
                   from employees
                   where employee_id != 100
                   group by job_id);
                   
select first_name, job_id, salary
from employees
where salary < (select min(avg(salary))
                from employees
                where employee_id != 100
                group by job_id);
                
select first_name, job_id, salary
from employees
where salary > all (select avg(salary)
                    from employees
                    group by department_id);

