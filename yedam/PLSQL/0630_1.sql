create table department(
    deptid number(10) not null,
    deptname VARCHAR2(10),
    location VARCHAR2(10),
    tel VARCHAR2(15));
    
create table employee(
    empid number(10) not null,
    empname VARCHAR2(10),
    hiredate date,
    addr VARCHAR2(12),
    tel VARCHAR2(15),
    deptid number(10));
    
/* deptid number(10) references department(deptid)*/
/* foreign key(deptid) references department(deptid)*/
    
alter table employee
add (birthday date);

insert into department values ( 1003, '¿µ¾÷ÆÀ', 'º»103È£', '053-222-3333');

select *
from department;

insert into employee values ( 20121646, 'ÀÌÀ¶Èñ', '20120901', 'ºÎ»ê', '010-1234-2222', 1003, null);
insert into employee (empid, empname, hiredate, addr, tel, deptid) values ( 20121646, 'ÀÌÀ¶Èñ', '20120901', 'ºÎ»ê', '010-1234-2222', 1003);
insert into employee values ( 20121646, 'ÀÌÀ¶Èñ', to_date('12/09/01', 'YY/MM/DD'), 'ºÎ»ê', '010-1234-2222', 1003, null);

select *
from employee;

alter table employee modify empname not null;
/* Á¦¾àÁ¶°ÇÀº not null¸¸ ¼öÁ¤°¡´É, ³ª¸ÓÁö´Â Ãß°¡, »èÁ¦¸¸ °¡´É */

select e.empname, e.hiredate, d.deptname
from employee e join department d on e.deptid=d.deptid
where d.deptname = 'ÃÑ¹«ÆÀ';
/*
select e.empname, e.hiredate, d.deptname
from employee e, department d
where e.deptid = d.deptid
and d.deptname = 'ÃÑ¹«ÆÀ';
*/

delete employee
where addr = '´ë±¸';

update employee
set deptid = (select deptid from department where deptname = 'È¸°èÆÀ')
where deptid = (select deptid from department where deptname = '¿µ¾÷ÆÀ');

select e.empid, e.empname, e.birthday, d.deptname
from employee e join department d on e.deptid=d.deptid
where e.hiredate > (select hiredate from employee where empid=20121729);

create view v_emp
as select e.empname, e.addr, d.deptname
    from  employee e join department d on e.deptid=d.deptid
    where d.deptname = 'ÃÑ¹«ÆÀ';
    
select * from v_emp;
