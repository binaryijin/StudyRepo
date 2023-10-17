select *
from dict;

select table_name from user_tables;
select distinct object_type from user_objects;
select * from user_catalog;

select * from all_tables;
comment on column regions.region_id
is '';

select * from user_col_comments;

select *
from user_constraints;

select * from user_cons_columns;

create view v10 (empno, ename, ann_sal)
as select employee_id, first_name, salary*12
    from employees
    where department_id = 30;
    
select *
from v10;

create or replace view v10 (id_number, name, sal, department_id)
as select employee_id, first_name, salary, department_id
    from employees
    where department_id = 20;
    
    
commit;

--����1 ���̺� ����
create table my_employee
    (id NUMBER(4) CONSTRAINT my_employee_id_nn NOT NULL,
     last_name varchar2(25),
     first_name varchar2(25),
     userid varchar2(8),
     salary number(9,2));
     
--����2 ���̺� ���� ǥ��
desc my_employee;

--����3 ������ �Է�
insert into my_employee (id, last_name, first_name, userid, salary)
values (1, 'Patel', 'Ralph', 'Rpatel', 895);

insert into my_employee (id, last_name, first_name, userid, salary)
values (2, 'Dancs', 'Betty', 'Bdancs', 860);

insert into my_employee (id, last_name, first_name, userid, salary)
values (3, 'Biri', 'Ben', 'Bbiri', 1100);

insert into my_employee (id, last_name, first_name, userid, salary)
values (4, 'Newman', 'Chad', 'Cnewman', 750);

insert into my_employee
values (5, 'Ropeburn', 'Audery', 'Aropebur', 1550);

select *
from my_employee;
--���� �� �۾� ������
commit;

--����5 ����
update my_employee
set last_name = 'Drexler'
where id = 3;

--����6 �޿� ���� �� ���� Ȯ��
update my_employee
set salary = 1000
where salary < 900;

select *
from my_employee;

--7�� ����
delete my_employee
where first_name = 'Betty';

select *
from my_employee;

--8�� Ʈ����� ���� �߿� Savepoint�� ǥ���Ͻÿ�. -> DCL
savepoint step_16;
-- ���̺��� ������ ��� �����ϰ� ���̺� ������ ��� �ִ��� Ȯ��
delete my_employee;
select *
from my_employee;
--������ insert�۾��� ������ ���� �ֱ��� delete �۾��� �����ÿ�.
rollback to step_16;
select *
from my_employee;
commit;

--9�� 
drop table dept;

CREATE table dept
    (id number(7) constraint department_id_pk primary key,
     name varchar(25));
desc dept;

--10�� ��������
insert into dept
select department_id, department_name
from departments;
    
select *
from dept;

--11�� 
create table emp
    (id number(7),
     last_name varchar2(25),
     first_name varchar2(25),
     dept_id number(7) constraint emp_dept_id_fk references dept(id));
desc emp;

--12��
create table employees2
as select employee_id id, first_name, last_name, salary, department_id dept_id
from employees;

select *
from employees2;

--13��
alter table employees2 read only;

insert into employees2
values (34, 'Grant', 'Marcie', 5678, 10);

--14��
alter table employees2 read write;

insert into employees2
values (34, 'Grant', 'Marcie', 5678, 10);

drop table employees2;







--1��
select *
from employees
where commission_pct is not null;

--2��
select employee_id, first_name, salary, hire_date, department_id
from employees
order by salary;

--3��
select employee_id, last_name, to_char(hire_date, 'yyyy-mm-dd') �Ի���, salary
from employees;

--4��
select employee_id, first_name, department_id, department_name
from employees left join departments using (department_id);

--5��
select department_id, round(avg(salary))
from employees
group by department_id;

--6��
select employee_id, first_name, salary, job_id, department_id
from employees
where department_id = (select department_id
                        from employees
                        where employee_id = 142);
                        
--7��
select employee_id, last_name, hire_date, add_months(hire_date, 6) "�Ի� 6���� ��"
from employees;

--8��
create table sawon
    (s_no number(4),
     name varchar2(15) NOT NULL,
     id varchar(15) not null,
     hiredate date,
     pay number(4));
     
--9��(1)
insert into sawon
values (101, 'Jason', 'ja101', '17/09/01', 800);

insert into sawon
values (104, 'Min', 'm104', '14/07/02', null);

commit;

--9��(2)
update sawon
set pay = 700
where s_no = 104;

--10��
drop table sawon;


--�׷��Լ�
--1. true
--2. false
--3. true
--4
select max(salary) "Maximum", min(salary) "Minimum",
    sum(salary) "Sum", round(avg(salary)) "Average"
from employees;

--5
select job_id, max(salary) "Maximum", min(salary) "Minimum",
    sum(salary) "Sum", round(avg(salary)) "Average"
from employees
group by job_id;

--6
select job_id, count(employee_id)
from employees
group by job_id;

--7
select count(distinct manager_id) "Number of Managers"
from employees;

--8
select max(salary) - min(salary) "DIFFERENCE"
from employees;

--9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000
order by min(salary);

--10
select job_id,
    sum(decode(department_id, 20, salary,0)) "�μ�20",
    sum(decode(department_id, 50, salary,0)) "�μ�50",
    sum(decode(department_id, 80, salary,0)) "�μ�80",
    sum(decode(department_id, 90, salary,0)) "�μ�90",
    sum(salary) "�޿� �Ѿ�"
from employees
group by job_id;

--����
--1
select location_id, street_address, city, state_province, country_name
from locations natural join countries;

--2
select last_name, department_id, department_name
from employees left join departments
                using(department_id);
                
--3
select e.last_name, e.job_id, e.department_id, d.department_name
from departments d
                join locations l
                    on l.location_id = d.location_id
                join employees e
                    on e.department_id = d.department_id               
where city = 'Toronto';

--4
select e.last_name "Employee", e.employee_id "Emp#", 
        e2.last_name "Manager" , e2.employee_id "Mgr#"
from employees e join employees e2
    on e.manager_id = e2.employee_id;
    
--5
select e.last_name "Employee", e.employee_id "Emp#", 
        e2.last_name "Manager" , e2.employee_id "Mgr#"
from employees e left join employees e2
    on e.manager_id = e2.employee_id
order by e.employee_id;

--6
select e.last_name, e.department_id, e2.last_name
from employees e left join employees e2
        on e.department_id = e2.department_id
where e.employee_id != e2.employee_id
order by e.last_name;


--7
select *
from jobs;

select first_name, job_id, department_name, salary
from employees left join departments using(department_id);


--��������
--1
select first_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Zlotkey');
--2
select employee_id, first_name
from employees
where salary > (select avg(salary)
                from employees)
order by salary;

--3
select employee_id, first_name
from employees
where department_id in (select department_id
                        from employees
                        where first_name like '%u%');
                        
--4
select first_name, department_id, job_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);

--5
select first_name, salary
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'King');

--6
select department_id, first_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'Executive');