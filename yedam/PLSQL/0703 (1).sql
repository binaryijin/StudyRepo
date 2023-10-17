SET SERVEROUTPUT ON

DECLARE
    v_sal NUMBER(7,2) := 60000;
    v_comm v_sal%TYPE := v_sal * .20;
    v_message VARCHAR2(255) := ' eligible for commission';
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);
    DBMS_OUTPUT.PUT_LINE('===============================');
    DECLARE
        v_sal NUMBER(7,2) := 50000;
        v_comm v_sal%TYPE := 0;
        v_total_comp NUMBER(7,2) := v_sal + v_comm;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);
        DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);
        DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);
        DBMS_OUTPUT.PUT_LINE('v_total_comp ' || v_total_comp);
        DBMS_OUTPUT.PUT_LINE('===============================');
        v_message := 'CLERK not ' || v_message;
        v_comm := v_sal * .30;
    END;
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);
    DBMS_OUTPUT.PUT_LINE('===============================');
    v_message := 'SALESMAN ' || v_message;
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);
END;
/


DECLARE
    v_empid employees.employee_id%TYPE;
    v_ename VARCHAR2(100);
BEGIN
    
    SELECT employee_id, first_name || ', ' || last_name
    INTO v_empid, v_ename
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원 번호 : ' || v_empid);
    DBMS_OUTPUT.PUT_LINE('사원 이름 : ' || v_ename);
    
END;
/


DECLARE
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := 0.1;
BEGIN
    SELECT department_id
    INTO v_deptno
    FROM employees
    WHERE employee_id = &사원번호;
    
    INSERT INTO employees (employee_id, last_name, email, hire_date, job_id, department_id)
    VALUES (1000, 'Hong', 'hkd@google.com', sysdate, 'IT_PROG', v_deptno);
    
    UPDATE employees
    SET salary = (NVL(salary, 0) + 10000) * v_comm
    WHERE employee_id = 1000;
       
END;
/

SELECT * FROM employees WHERE employee_id = 1000;

DECLARE
    v_empid employees.employee_id%TYPE;
BEGIN
    SELECT employee_id
    INTO v_empid
    FROM employees
    WHERE salary IS NULL;
    
    DELETE FROM employees
    WHERE employee_id = v_empid;
END;
/


CREATE TABLE test_employees
AS
    SELECT * FROM employees;


BEGIN
    DELETE FROM test_employees
    WHERE employee_id = 0;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지 않습니다.');
    END IF;
    
    UPDATE test_employees
    SET salary = salary * 1.1
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지 않습니다.');
    END IF;
    --DBMS_OUTPUT.PUT_LINE('실행결과, ' || SQL%ROWCOUNT || '건이 삭제되었습니다.');
END;
/


--1. 사원번호를 입력(치환변수사용&)할 경우 사원번호, 사원이름, 부서이름을 출력하는 PL/SQL을 작성하시오.
DECLARE
    v_empno employees.employee_id%TYPE;
    v_empname employees.first_name%TYPE;
    v_deptname departments.department_name%TYPE;
BEGIN
    SELECT e.employee_id, e.first_name, d.department_name
    INTO v_empno, v_empname, v_deptname
    FROM employees e JOIN departments d on e.department_id = d.department_id
    WHERE e.employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_empno || ' 사원이름 : ' || v_empname || ' 부서이름 : ' || v_deptname);
END;
/

-- 1.(2) 두개의 select
DECLARE
    v_empno employees.employee_id%TYPE;
    v_empname employees.first_name%TYPE;
    v_deptid employees.department_id%TYPE;
    v_deptname departments.department_name%TYPE;
BEGIN
    SELECT employee_id, first_name, department_id
    INTO v_empno, v_empname, v_deptid
    FROM employees
    WHERE employee_id = &사원번호;
    
    SELECT department_name
    INTO v_deptname
    FROM departments
    WHERE department_id = v_deptid;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_empno || ' 사원이름 : ' || v_empname || ' 부서이름 : ' || v_deptname);
END;
/

--2. 사원번호를 입력(치환변수사용&)할 경우 사원이름, 급여, 연봉 -> (급여*12 +(NVL(급여,0)*NVL(커미션퍼센트,0)*12))을 출력
DECLARE
    v_empname employees.first_name%TYPE;
    v_empsal employees.salary%TYPE;
    v_annual employees.salary%TYPE;
BEGIN
    SELECT first_name, salary, salary*12 + (NVL(salary,0)*NVL(commission_pct,0)*12)
    INTO v_empname, v_empsal, v_annual
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_empname || ' 급여 : ' || v_empsal || ' 연봉 : ' || v_annual);
END;
/

--2.(2) 별도 연산
DECLARE
    v_empname employees.first_name%TYPE;
    v_empsal employees.salary%TYPE;
    v_empcomm employees.commission_pct%TYPE;
    v_annual v_empsal%TYPE;
BEGIN
    SELECT first_name, salary, commission_pct
    INTO v_empname, v_empsal, v_empcomm
    FROM employees
    WHERE employee_id = &사원번호;
    
    v_annual := v_empsal * 12 + (NVL(v_empsal,0) * NVL(v_empcomm,0)*12);
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_empname || ' 급여 : ' || v_empsal || ' 연봉 : ' || v_annual);
END;
/


-- 기본 IF 문
BEGIN
    DELETE FROM test_employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지 않습니다.');
    END IF;
END;
/


-- IF ~ ELSE 문 : 팀장급인지 확인
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(employee_id)
    INTO v_count
    FROM employees
    WHERE manager_id = &사원번호;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('일반 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('팀장입니다.');
    END IF;
END;
/

-- IF ~ ELSIF ~ ELSE 문 : 연차
DECLARE
    v_hdate NUMBER;
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12)
    INTO v_hdate
    FROM employees
    WHERE employee_id = &사원번호;
    
    -- 각 조건에서 가질 수 있는 최소값과 최대값의 범위 산출
    IF v_hdate < 1 THEN -- 1보다 작은 실수값
        DBMS_OUTPUT.PUT_LINE('입사한 지 1년 미만입니다.');
    ELSIF v_hdate < 3 THEN -- 1보다 크거나 같고 3보다 작은 실수값
        DBMS_OUTPUT.PUT_LINE('입사한 지 3년 미만입니다.');
    ELSIF v_hdate < 5 THEN -- 3보다 크거나 같고 5보다 작은 실수값
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 미만입니다.');
    ELSE -- 5보다 크거나 같은 실수값
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 이상입니다.');
    END IF;
END;
/


-- 3-1. 사원번호를 입력(치환변수사용&)할 경우
-- 입사일이 2005년 이후(2005년 포함)이면 'New employee' 출력, 2005년 이전이면 'Career employee'출력
DECLARE
    v_hire employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hire
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF v_hire >= '2005-01-01' THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
    END IF;
END;
/

DECLARE
    v_empid employees.employee_id%TYPE := &사원번호;
    v_hdate employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = v_empid;
    --rr, yy 구분
    IF v_hdate >= TO_DATE('05-01-01', 'yy-MM-dd') THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
    END IF;
END;
/

-- 3-2. 사원번호를 입력(치환변수사용&)할 경우
-- 입사일이 2005년 이후(2005년 포함)이면 'New employee' 출력, 2005년 이전이면 'Career employee'출력
-- 단, DBMS_OUTPUT.PUT_LINE ~ 은 한번만 사용
DECLARE
    v_hire employees.hire_date%TYPE;
    v_msg VARCHAR2(20);
BEGIN
    SELECT hire_date
    INTO v_hire
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF v_hire >= '2005-01-01' THEN
        v_msg := 'New employee';
    ELSE
        v_msg := 'Career employee';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/

DECLARE
    v_empid employees.employee_id%TYPE := &사원번호;
    v_hdate employees.hire_date%TYPE;
    v_message VARCHAR2(100);
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = v_empid;

    IF TO_CHAR(v_hdate, 'yyyy') > '2004' THEN
        v_message := 'New employee';
    ELSE
        v_message := 'Career employee';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/


/*4. 
사원번호를 입력(치환변수& 사용)할 경우
부서별로 구분하여 각각의 테이블에 입력하는 PL/SQL 블록을 작성하시오.
단, 해당 부서가 없는 사원은 emp00 테이블에 입력하시오.
   : 부서번호10->emp10, 부서번호20->emp20 ....

create table emp10(empid, ename, hiredate)
as
  select employee_id, first_name, hire_date
  from   employees
  where  employee_id = 0;

emp20
emp30
emp40
emp50
emp00
*/

--테이블 구조 복사
create table emp00(empid, ename, hiredate)
as
  select employee_id, first_name, hire_date
  from   employees
  where  employee_id = 0;


DECLARE
    v_empid employees.employee_id%TYPE := &사원번호;
    v_name employees.first_name%TYPE;
    v_hdate employees.hire_date%TYPE;
    v_deptid employees.department_id%TYPE;
BEGIN
    SELECT first_name, hire_date, department_id
    INTO v_name, v_hdate, v_deptid
    FROM employees
    WHERE employee_id = v_empid;
    
    IF v_deptid = 10 THEN
        INSERT INTO emp10 VALUES(v_empid, v_name, v_hdate);
    ELSIF v_deptid = 20 THEN
        INSERT INTO emp20 VALUES(v_empid, v_name, v_hdate);
    ELSIF v_deptid = 30 THEN
        INSERT INTO emp30 VALUES(v_empid, v_name, v_hdate);
    ELSIF v_deptid = 40 THEN
        INSERT INTO emp40 VALUES(v_empid, v_name, v_hdate);
    ELSIF v_deptid = 50 THEN
        INSERT INTO emp50 VALUES(v_empid, v_name, v_hdate);
    ELSE
        INSERT INTO emp00 VALUES(v_empid, v_name, v_hdate);
    END IF;
END;
/

-- 4.(2) 동적 쿼리
DECLARE
    v_empid employees.employee_id%TYPE := &사원번호;
    v_name employees.first_name%TYPE;
    v_hdate employees.hire_date%TYPE;
    v_deptid employees.department_id%TYPE;
    v_sql VARCHAR2(100);
BEGIN
    SELECT first_name, hire_date, TRUNC(department_id/10)
    INTO v_name, v_hdate, v_deptid
    FROM employees
    WHERE employee_id = v_empid;
    
    IF v_deptid BETWEEN 1 AND 5 THEN
        v_sql := 'INSERT INTO emp' || (v_deptid * 10);
        v_sql := v_sql || ' VALUES (' || v_empid || ', ''' || v_name || ''', ''' || v_hdate || ''')';
        DBMS_OUTPUT.PUT_LINE(v_sql);
        EXECUTE IMMEDIATE v_sql;    
    ELSE
        INSERT INTO emp00 VALUES(v_empid, v_name, v_hdate);
    END IF;
END;
/

/*
5.
급여가  5000이하이면 20% 인상된 급여
급여가 10000이하이면 15% 인상된 급여
급여가 15000이하이면 10% 인상된 급여
급여가 15001이상이면 급여 인상없음

사원번호를 입력(치환변수)하면 사원이름, 급여, 인상된 급여가 출력되도록 PL/SQL 블록을 생성하시오.
*/
DECLARE
    v_name employees.first_name%TYPE;
    v_empsal employees.salary%TYPE;
    v_raise NUMBER;
BEGIN
    SELECT first_name, salary
    INTO v_name, v_empsal
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF v_empsal <= 5000 THEN
        v_raise := v_empsal * 1.2; -- v_raise := 20;
    ELSIF v_empsal <= 10000 THEN
        v_raise := v_empsal * 1.15;
    ELSIF v_empsal <= 15000 THEN
        v_raise := v_empsal * 1.1;
    ELSE 
        v_raise := v_empsal;
    END IF;
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_name || ', 급여 : ' || v_empsal || ', 인상된 급여 : ' || v_raise);
    /* DBMS_OUTPUT.PUT_LINE(v_empsal * (1 + v_raise/100)); */
END;
/


