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

--natural join 결과를 join으로 나타내기
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

--문제3
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

--문제4
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

--pairwise 방식 : Adam과 같은 부서에서 같은 업무를 보고 있는 사람 출력
select employee_id, first_name, department_id, job_id
from employees
where (department_id, job_id) in (select department_id, job_id
                                  from employees
                                  where first_name = 'Adam')
        and first_name != 'Adam';

--인라인뷰
--부서별 평균 급여보다 높은 사람
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

--문제1 서브쿼리를 이용하여 전체 사원의 평균 급여보다 작은 급여를 받고 있는
--30번 부서의 사원 정보를 출력 해 보세요.
select employee_id, first_name, job_id, salary, e.department_id, department_name, location_id
from employees e, departments d
where e.department_id = d.department_id
    and e.department_id = 30
    and salary < (select avg(salary)
                    from employees);
                    
--문제2 서브쿼리를 이용하여 전체 사원 중에서 
--10번 부서에 속한 모든 사원들보다 일찍 입사한 사원들의 정보를 출력해보세요.
select employee_id, first_name, job_id, hire_date, salary
from employees
where hire_date < all (select hire_date
                        from employees
                        where department_id = 10);
                    
--문제3 전체 사원 중 'ALLAN'과 같은 직무(job_id)인 사원들의 사원 정보와 부서 정보를 출력 해 보세요
select employee_id, first_name, job_id, salary, department_id, department_name
from employees join departments using(department_id)
where job_id = (select job_id
                from employees
                where upper(first_name) = 'ALLAN');

--문제4 전체 사원의 평균 급여 보다 높은 급여를 받는 사원들의 정보를 출력해보세요
--급여가 많은 순으로 출력하되 급여가 같은 경우 사원 번호 기준으로 출력하세요
select employee_id, first_name, job_id, salary, department_id, department_name
from employees join departments using(department_id)
where salary > (select avg(salary)
                from employees)
order by salary desc, employee_id;

--문제5 20번 부서에 근무하는 사원 중에
--30번 부서에는 존재하지 않는 직무(job_id)를 가진 사원의 정보를 출력하세요
select employee_id, first_name, job_id, department_id, department_name
from employees join departments 
                using(department_id)
where job_id not in (select distinct job_id
                     from employees
                     where department_id = 30)
        and department_id = 20;
        
--문제6 job_id가 SA_MAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 정보를 출력해 보세요
--사원 번호를 기준으로 정렬하세요
select employee_id, first_name, job_id, salary
from employees
where salary > (select max(salary)  --salary > all (select distinct salary
                from employees
                where job_id = 'SA_MAN')
order by employee_id;




--데이터 조작어
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

drop table dept; --rollback으로 되돌릴 수 없음

rollback;

select*
from dept;

--1. table 생성 : s_emp
--2. 필드구성 : empid 숫자6, empname 문자 20, mgr 숫자6, sal 숫자(8,2), deptid 숫자4
--3. 데이터 삽입 : employees 테이블의 부서번호 30인 데이터 삽입
--4. 작업완료
--5. 사원번호 117번의 급여를 5000으로 변경하세요
--6. 사원번호 118번의 이름을 yedam으로 변경하세요
--7. 사원번호 117번의 부서번호를 employees 테이블의 first_name = 'Lex'의 부서번호로 변경하세요
--8. 사원번호 115번의 이름을 employees 테이블의 사원번호 = 125 의 first_name으로 변경하세요
--9. 사번 : 111, 이름 : 'hong gil ddong' mgr : null, 급여 : 3320
--      부서코드 : 100 값을 입력하세요
--10. 111번을 삭제하세요.

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