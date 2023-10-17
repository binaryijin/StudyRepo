select e.department_id, d.department_name, e.employee_id, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
    and salary > 13000;
    
select department_id, d.department_name, e.employee_id, e.first_name, e.salary
from employees e join departments d
    using(department_id)
where salary > 13000;

select e.department_id, d.department_name, e.employee_id, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id(+);

--natural join ����� join���� ��Ÿ����
select e.department_id, d.department_name, e.employee_id, e.first_name, e.salary
from employees e  join departments d
                    on (e.department_id = d.department_id)
where e.manager_id = d.manager_id;


select e.department_id, d.department_name, round(avg(salary)), max(salary), min(salary), count(employee_id)
from employees e, departments d
where e.department_id = d.department_id
group by e.department_id, d.department_name;

select department_id, d.department_name, round(avg(salary)), max(salary), min(salary), count(employee_id)
from employees e join departments d
    using(department_id)
group by department_id, d.department_name;

--����3
select e.department_id, department_name, employee_id, first_name, job_title, salary
from employees e, departments d , jobs j
where e.department_id = d.department_id(+)
    and e.job_id = j.job_id
order by department_id, first_name;

select department_id, department_name, employee_id, first_name, job_title, salary
from employees left join departments 
                using(department_id)
                join jobs 
                using(job_id)
order by department_id, first_name;

--����4
--select e.department_id, d.department_name, e.employee_id, e.first_name, e.manager_id,
--    e.salary, e.job_id, min_salary, max_salary, e2.employee_id, e2.first_name
--from employees e, departments d, jobs j, employees e2
--where e.job_id = j.job_id
--    and e.manager_id = e2.employee_id(+)
--    and e.department_id = d.department_id(+)
--order by e.department_id, e.employee_id;

select e.department_id, d.department_name, e.employee_id, e.first_name, e.manager_id,
    e.salary, e.job_id, min_salary, max_salary, e2.employee_id, e2.first_name
from employees e, departments d, jobs j, employees e2
where e.department_id(+) = d.department_id
    and e.salary between min_salary(+) and max_salary(+)
    and e.manager_id = e2.employee_id(+)
order by e.department_id, e.employee_id;

select e.department_id, d.department_name, e.employee_id, e.first_name, e.manager_id,
    e.salary, e.job_id, min_salary, max_salary, e2.employee_id, e2.first_name
from employees e right join departments d
                            on( e.department_id = d.department_id)
                left join jobs j
                            on(e.salary between min_salary and max_salary)
                left join employees e2
                            on(e.manager_id = e2.employee_id)
order by e.department_id, e.employee_id;

--pairwise ��� : Adam�� ���� �μ����� ���� ������ ���� �ִ� ��� ���
select employee_id, first_name, department_id, job_id
from employees
where (department_id, job_id) in (select department_id, job_id
                                  from employees
                                  where first_name = 'Adam')
        and first_name != 'Adam';

--�ζ��κ�
--�μ��� ��� �޿����� ���� ���
select e.first_name, e.salary, e.department_id, b.salavg
from employees e, (select department_id, round(avg(salary)) salavg
                    from employees
                    group by department_id) b
where e.department_id = b.department_id
    and e.salary > b.salavg
order by e.department_id;

with
b as(select department_id, round(avg(salary)) salavg
    from employees
    group by department_id)
select e.first_name, e.salary, e.department_id, b.salavg
from employees e, b
where e.department_id = b.department_id
    and e.salary > b.salavg
order by e.department_id;

--����1 ���������� �̿��Ͽ� ��ü ����� ��� �޿����� ���� �޿��� �ް� �ִ�
--30�� �μ��� ��� ������ ��� �� ������.
select employee_id, first_name, job_id, salary, e.department_id, department_name, location_id
from employees e, departments d
where e.department_id = d.department_id
    and e.department_id = 30
    and salary < (select avg(salary)
                    from employees);
                    
--����2 ���������� �̿��Ͽ� ��ü ��� �߿��� 
--10�� �μ��� ���� ��� ����麸�� ���� �Ի��� ������� ������ ����غ�����.
select employee_id, first_name, job_id, hire_date, salary
from employees
where hire_date < all (select hire_date
                        from employees
                        where department_id = 10);
                    
--����3 ��ü ��� �� 'ALLAN'�� ���� ����(job_id)�� ������� ��� ������ �μ� ������ ��� �� ������
select employee_id, first_name, job_id, salary, department_id, department_name
from employees join departments using(department_id)
where job_id = (select job_id
                from employees
                where upper(first_name) = 'ALLAN');

--����4 ��ü ����� ��� �޿� ���� ���� �޿��� �޴� ������� ������ ����غ�����
--�޿��� ���� ������ ����ϵ� �޿��� ���� ��� ��� ��ȣ �������� ����ϼ���
select employee_id, first_name, job_id, salary, department_id, department_name
from employees join departments using(department_id)
where salary > (select avg(salary)
                from employees)
order by salary desc, employee_id;

--����5 20�� �μ��� �ٹ��ϴ� ��� �߿�
--30�� �μ����� �������� �ʴ� ����(job_id)�� ���� ����� ������ ����ϼ���
select employee_id, first_name, job_id, department_id, department_name
from employees join departments 
                using(department_id)
where job_id not in (select distinct job_id
                     from employees
                     where department_id = 30)
        and department_id = 20;
        
--����6 job_id�� SA_MAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ������ ����� ������
--��� ��ȣ�� �������� �����ϼ���
select employee_id, first_name, job_id, salary
from employees
where salary > (select max(salary)  --salary > all (select distinct salary
                from employees
                where job_id = 'SA_MAN')
order by employee_id;




--������ ���۾�
CREATE TABLE dept
    (deptno     number(4) primary key,  --primary key -> not null
     dname      varchar2(30) not null,
     loc        number(4));

INSERT INTO dept (deptno, dname, loc)
values (10, 'accounting', 1700);

insert into dept (deptno, dname, loc)
values (30, 'sales', 2000);

insert into dept (deptno, dname)
values (40, 'sales');

insert into dept (deptno, dname, loc)
values (50, 'sales', null);

insert into dept (deptno, dname, loc)
values (60, 'sales', '');


insert into dept
    select department_id, department_name, location_id
    from departments
    where department_id > 100;
    
delete dept
where deptno = 50;

delete dept;

select *
from dept;

rollback;

select *
from dept;

delete dept
where deptno = 150;

rollback;

--commit, delete, rollback
insert into dept
    select department_id, department_name, location_id
    from departments
    where department_id > 100;

select *
from dept;

commit;

delete dept
where deptno = 130;

select *
from dept;

rollback;

select *
from dept;

--update
update dept
set loc = 2000
where deptno = 170;

commit;
delete dept;

select *
from dept;

rollback;

drop table dept; --rollback���� �ǵ��� �� ����

rollback;

select*
from dept;

--1. table ���� : s_emp
--2. �ʵ屸�� : empid ����6, empname ���� 20, mgr ����6, sal ����(8,2), deptid ����4
--3. ������ ���� : employees ���̺��� �μ���ȣ 30�� ������ ����
--4. �۾��Ϸ�
--5. �����ȣ 117���� �޿��� 5000���� �����ϼ���
--6. �����ȣ 118���� �̸��� yedam���� �����ϼ���
--7. �����ȣ 117���� �μ���ȣ�� employees ���̺��� first_name = 'Lex'�� �μ���ȣ�� �����ϼ���
--8. �����ȣ 115���� �̸��� employees ���̺��� �����ȣ = 125 �� first_name���� �����ϼ���
--9. ��� : 111, �̸� : 'hong gil ddong' mgr : null, �޿� : 3320
--      �μ��ڵ� : 100 ���� �Է��ϼ���
--10. 111���� �����ϼ���.

create table s_emp
    (empid number(6),
     empname varchar2(20),
     mgr number(6),
     sal number(8,2),
     deptid number(4));
     
insert into s_emp
    select employee_id, first_name, manager_id, salary, department_id
    from employees
    where department_id = 30;
    
select *
from s_emp;

commit;

update s_emp
set sal = 5000
where empid = 117;

update s_emp
set empname = 'yedam'
where empid = 118;

update s_emp
set deptid = (select department_id
                from employees
                where first_name = 'Lex')
where empid = 117;

update s_emp
set empname = (select first_name
                from employees
                where employee_id = 125)
where empid = 115;

insert into s_emp(empid, empname, mgr, sal, deptid)
values (111, 'hong gil ddong', null, 3320, 100);

delete s_emp
where empid = 111;