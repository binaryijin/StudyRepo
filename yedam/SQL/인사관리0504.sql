select *
from user_ind_columns
where table_name = 'EMPLOYEES';

create index emp_hire_date_ind
on employees (hire_date);

drop index emp_hire_date_ind;


select *
from user_sequences;

create table dept
as select department_id no, department_name name
    from departments
    where 1<>1; --데이터X, 테이블의 구조만 가져오기
    
create sequence dept_seq
    increment by 10
    start with 20
    maxvalue 70
    nocache;

alter table dept
drop primary key cascade;

drop table dept;
    
insert into dept
values(dept_seq.nextval, 'AAA');

select *
from dept;

drop sequence dept_seq;

alter sequence dept_seq
    increment by 2
    maxvalue 700
    nocache;

--synonym
create synonym E
for employees;

select *
from E;

select * from user_synonyms;

drop synonym E;


--시스템 권한 확인
select *
from system_privilege_map;

create user c##AAA
identified  by AAA;


select *
from user_role_privs;

select *
from user_sys_privs;

select *
from user_tab_privs_made;

select *
from user_tab_privs_recd;

select *
from user_col_privs_made;


--문제1
--GRANT create view, create synonym to hr;

create view employees_vu(employee_id, employee, department_id)
as select employee_id, first_name, department_id
from employees;

--create view employees_vu
--as select employee_id, first_name "employee", department_id
--from employees;

select *
from employees_vu;



--문제2 employees_vu뷰를 사용하여 모든 사원의 이름 및 부서 번호를 표시하는 질의를 작성
select employee, department_id
from employees_vu;

--문제3
create view dept50
as select employee_id "EMPNO", first_name "EMPLOYEE", department_id "DEPTNO"
    from employees
    where department_id = 50;

select *
from dept50;

--문제4
desc dept50;

select *
from dept50;

--문제5
create or replace view salary_vu
as select e.first_name "Employee", d.department_name "Department", e.salary, j.job_id "Grade"
    from employees e left join departments d
                    using(department_id)
                    join jobs j
                    on(e.salary between j.min_salary and j.max_salary);

select *
from salary_vu;

--문제6 dept테이블의 기본 키 열에 사용할 시퀀스를 생성하시오
--drop sequence dept_id_seq

create sequence dept_id_seq
    increment by 10
    start with 300
    maxvalue 1000;
    
select *
from user_sequences;

--문제7 dept 테이블에 두 행을 insert, id열은 시퀀스 사용
insert into dept
values (dept_id_seq.nextval , 'Education');
insert into dept
values (dept_id_seq.nextval , 'Administration');

select *
from dept;

drop sequence dept_id_seq;

delete
from dept
where no >= 300;

--문제8 dept테이블의 name column에 비고유 인덱스를 생성하시오
create index dept_name_idx
on dept(name);

select *
from user_indexes;

select *
from user_ind_columns
where table_name = 'DEPT';

--employees 테이블에 대해 E라는 동의어를 생성하시오
create synonym e
for employees;

select *
from user_synonyms;


--문제9
create table prof
    (profno   number(4) primary key,
     name     varchar2(15) not null,
     id       varchar2(15) not null,
     hiredate date,
     pay      number(4));
     
desc prof;

--문제10 prof테이블에 dml명령문 작성
--(1)
insert into prof
values(1001, 'Mark', 'm1001', '07/03/01', 800);
insert into prof
values(1003, 'Adam', 'a1003', '11/03/02', null);
insert into prof
values(1004, 'Tom', 't1004', to_date('20/02/25','RR/MM/DD'), 900);

select *
from prof;

commit;
--(2)
update prof
set pay = 1200
where profno = 1001;

--(3)
delete prof
where profno = 1004;

commit; 

--문제11
--(1)
CREATE index prof_name_idx
on prof(name);

--(2)'
alter table prof
drop primary key;

alter table prof
add constraint prof_no_pk primary key(profno);

--(3)
alter table prof
add (gender char(3));

--(4)
alter table prof
modify (name varchar2(20));

--문제13
--테이블이 삭제되면 인덱스와, 뷰, 동의어는 어떻게 처리될까요?
--인덱스는 테이블과 함께 (삭제)되고,
--뷰와 동의어는 (삭제되지 않지만 사용 불가)