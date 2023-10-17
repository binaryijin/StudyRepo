SET SERVEROUTPUT ON
/* 1.
주민등록번호를 입력하면 
다음과 같이 출력되도록 yedam_ju 프로시저를 작성하시오.

EXECUTE yedam_ju(9501011667777)
EXECUTE yedam_ju(1511013689977)
-> 950101-1******
*/
CREATE PROCEDURE yedam_ju
(p_ssn IN VARCHAR2)
IS
-- 선언부 : 내부에서 사용할 변수, 타입, 커서 등
    v_result VARCHAR2(100);
BEGIN
    --v_result := SUBSTR(p_ssn, 1, 6) || '-' || SUBSTR(p_ssn, 7, 1) || '******';
    v_result := SUBSTR(p_ssn, 1, 6) || '-' || RPAD(SUBSTR(p_ssn, 7, 1), 7, '*');  
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXECUTE yedam_ju('9501011667777');
EXECUTE yedam_ju('1511013689977');

/*2.
사원번호를 입력할 경우
삭제하는 TEST_PRO 프로시저를 생성하시오.
단, 해당사원이 없는 경우 "해당사원이 없습니다." 출력
예) EXECUTE TEST_PRO(176)
*/
CREATE OR REPLACE PROCEDURE test_pro
(p_eid employees.employee_id%TYPE)
IS

BEGIN
    DELETE FROM test_employees
    WHERE employee_id = p_eid;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 없습니다.');
    END IF;
END;
/
EXECUTE TEST_PRO(0);

/*
3.
다음과 같이 PL/SQL 블록을 실행할 경우 
사원번호를 입력할 경우 사원의 이름(last_name)의 첫번째 글자를 제외하고는
'*'가 출력되도록 yedam_emp 프로시저를 생성하시오.

실행) EXECUTE yedam_emp(176)
실행결과) TAYLOR -> T*****  <- 이름 크기만큼 별표(*) 출력

1) 입력 : 사원번호 -> 출력 : 사원이름 => SELECT
2) 사원이름 : 정해진 포맷으로 변환
*/
CREATE OR REPLACE PROCEDURE yedam_emp
(p_eid IN employees.employee_id%TYPE)
IS
    v_name employees.last_name%TYPE;
    v_result v_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_name
    FROM employees
    WHERE employee_id = p_eid;
    
    v_result := RPAD(SUBSTR(v_name, 1, 1), LENGTH(v_name) , '*');
    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXECUTE yedam_emp(176);

/*4.
부서번호를 입력할 경우 
해당부서에 근무하는 사원의 사원번호, 사원이름(last_name)을 출력하는 get_emp 프로시저를 생성하시오. 
(cursor 사용해야 함)
단, 사원이 없을 경우 "해당 부서에는 사원이 없습니다."라고 출력(exception 사용)
실행) EXECUTE get_emp(30)


*/
CREATE OR REPLACE PROCEDURE get_emp
(p_deptid IN employees.department_id%TYPE)
IS
    CURSOR emp_cursor IS
        SELECT employee_id, last_name
        FROM employees
        WHERE department_id = p_deptid;
    emp_info emp_cursor%ROWTYPE;
    e_no_emp EXCEPTION;
BEGIN
    -- 커서 FOR LOOP 사용X -> 데이터가 없는걸 확인 할 수 없음
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_info.employee_id || ', ' || emp_info.last_name);
    END LOOP;
    
    -- LOOP를 벗어난 후에 ROWCOUNT확인
    IF emp_cursor%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
        
    CLOSE emp_cursor;
    
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 없습니다.');
END;
/
EXECUTE get_emp(0);

/*5.
직원들의 사번, 급여 증가치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신할 수 있는 y_update 프로시저를 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.(예외처리)
실행) EXECUTE y_update(200, 10)
*/
CREATE OR REPLACE PROCEDURE y_update
(p_eid IN employees.employee_id%TYPE,
 p_raise IN NUMBER)
IS
    e_no_emp EXCEPTION;
BEGIN
    UPDATE employees
    SET salary = salary * (1+(p_raise/100))
    WHERE employee_id = p_eid;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('No search employee!!');
END;
/
EXECUTE y_update(0, 10);

/*6.
다음과 같이 테이블을 생성하시오.
create table yedam01
(y_id number(10),
 y_name varchar2(20));

create table yedam02
(y_id number(10),
 y_name varchar2(20));
6-1.
부서번호를 입력하면 사원들 중에서 입사년도가 2005년 이전 입사한 사원은 yedam01 테이블에 입력하고,
입사년도가 2005년(포함) 이후 입사한 사원은 yedam02 테이블에 입력하는 y_proc 프로시저를 생성하시오.

6-2.
1. 단, 부서번호가 없을 경우 "해당부서가 없습니다" 예외처리
 2. 단, 해당하는 부서에 사원이 없을 경우 "해당부서에 사원이 없습니다" 예외처리
*/
create table yedam01
(y_id number(10),
 y_name varchar2(20));

create table yedam02
(y_id number(10),
 y_name varchar2(20));
 
CREATE OR REPLACE PROCEDURE y_proc
(p_deptno IN employees.department_id%TYPE)
IS
    CURSOR dept_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = p_deptno;
        
    emp_info dept_cursor%ROWTYPE;
    v_deptno departments.department_id%TYPE;
    
    e_no_emp EXCEPTION;
BEGIN
    SELECT department_id
    INTO v_deptno
    FROM departments
    WHERE department_id = p_deptno;
    
    OPEN dept_cursor;
    
    LOOP
        FETCH dept_cursor INTO emp_info;
        EXIT WHEN dept_cursor%NOTFOUND;
        
        IF emp_info.hire_date < TO_DATE('05/01/01', 'rr/MM/dd') THEN
             INSERT INTO yedam01
             values (emp_info.employee_id, emp_info.last_name);
             
        ELSE
            INSERT INTO yedam02
            values (emp_info.employee_id, emp_info.last_name);
        END IF;
        
    END LOOP;
    
    IF dept_cursor%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
        
    CLOSE dept_cursor;
EXCEPTION
    WHEN e_no_emp  THEN
        DBMS_OUTPUT.PUT_LINE('해당부서에 사원이 없습니다.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 존재하지 않습니다.');
       
END;
/

-- FUNCTION
CREATE FUNCTION y_sum
(p_x IN NUMBER,
 p_y NUMBER) --IN만 가능
RETURN NUMBER
IS
    v_result NUMBER;
BEGIN
    v_result := p_x + p_y;
    RETURN v_result;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(y_sum(10,20));

VARIABLE g_result NUMBER;
EXECUTE :g_result := y_sum(10,20);
PRINT g_result;

DECLARE
    v_result NUMBER;
BEGIN
    v_result := y_sum(10,20);
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

SELECT y_sum(10,20) FROM dual;

-- 사원번호를 기준으로 직속상사 이름을 출력
CREATE OR REPLACE FUNCTION get_mgr
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_mgr_name employees.first_name%TYPE;
BEGIN
    SELECT m.first_name
    INTO v_mgr_name
    FROM employees e JOIN employees m
        ON e.manager_id = m.employee_id
    WHERE e.employee_id = p_eid;
    
    RETURN v_mgr_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('예외발생!');
        RETURN '상사가 존재하지 않습니다.'; --위에 RETURN 값이 VARCHAR2라서 문장 리턴 가능
END;
/

SELECT employee_id, first_name, get_mgr(employee_id) as manager
FROM employees;

-- 팩토리얼
CREATE OR REPLACE FUNCTION y_factorial
(p_num NUMBER)
RETURN NUMBER
IS
    v_sum NUMBER := 0;
    
    e_num_null EXCEPTION;
BEGIN
    IF p_num IS NULL THEN
        RAISE e_num_null;
    END IF;
    
    FOR idx IN 0 .. p_num LOOP
        v_sum := v_sum + idx;
    END LOOP;
    IF v_sum > 0 THEN
        RETURN v_sum;
    END IF;
EXCEPTION
    WHEN e_num_null THEN
        RETURN 0;
END;
/

SELECT y_factorial(10) FROM dual;

/*1.
사원번호를 입력하면
last_name + first_name 이 출력되는 
y_yedam 함수를 생성하시오.

실행) EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174))
출력 예)  Abel Ellen

SELECT employee_id, y_yedam(employee_id)
FROM   employees;
*/
CREATE OR REPLACE FUNCTION y_yedam
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_name employees.first_name%TYPE;
BEGIN
    SELECT last_name || ' ' || first_name
    INTO v_name
    FROM employees
    WHERE employee_id = p_eid;
    
    RETURN v_name;
END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174));

SELECT employee_id, y_yedam(employee_id)
FROM   employees;

/*2.
사원번호를 입력할 경우 다음 조건을 만족하는 결과가 출력되는 ydinc 함수를 생성하시오.
- 급여가 5000 이하이면 20% 인상된 급여 출력
- 급여가 10000 이하이면 15% 인상된 급여 출력
- 급여가 20000 이하이면 10% 인상된 급여 출력
- 급여가 20000 이상이면 급여 그대로 출력
실행) SELECT last_name, salary, YDINC(employee_id)
     FROM   employees;
*/
CREATE OR REPLACE FUNCTION ydinc
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
    v_sal employees.salary%TYPE;
BEGIN
    SELECT salary
    INTO v_sal
    FROM employees
    WHERE employee_id = p_eid;
    
    IF v_sal <= 5000 THEN
        v_sal := v_sal * 1.2;
    ELSIF v_sal <= 10000 THEN
        v_sal := v_sal * 1.15;
    ELSIF v_sal <= 20000 THEN
        v_sal := v_sal * 1.1;
    END IF;
    
    RETURN v_sal;
END;
/
SELECT last_name, salary, YDINC(employee_id)
     FROM   employees;
     
/*3.
사원번호를 입력하면 해당 사원의 연봉이 출력되는 yd_func 함수를 생성하시오.
->연봉계산 : (급여+(급여*인센티브퍼센트))*12
실행) SELECT last_name, salary, YD_FUNC(employee_id)
     FROM   employees;
*/
CREATE OR REPLACE FUNCTION yd_func
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
    v_annual employees.salary%TYPE;
BEGIN    
    SELECT (salary + (salary * NVL(commission_pct, 0))) * 12
    INTO v_annual
    FROM employees
    WHERE employee_id = p_eid;

    RETURN v_annual;
END;
/
SELECT last_name, salary, YD_FUNC(employee_id)
FROM   employees;

/*SELECT last_name, subname(last_name)
FROM   employees;

LAST_NAME     SUBNAME(LA
------------ ------------
King         K***
Smith        S****
...
예제와 같이 출력되는 subname 함수를 작성하시오.
*/

CREATE OR REPLACE FUNCTION subname
(p_name VARCHAR2)
RETURN VARCHAR2
IS

BEGIN    

    RETURN RPAD(SUBSTR(p_name, 1, 1), LENGTH(p_name) , '*');
END;
/

SELECT last_name, subname(last_name)
FROM   employees;

/*5. 
사원번호를 입력하면 소속 부서명를 출력하는 y_dept 함수를 생성하시오.
(단, 다음과 같은 경우 예외처리(exception)
 입력된 사원이 없거나 소속 부서가 없는 경우 -> 사원이 아니거나 소속 부서가 없습니다.)

    입력된 사원이 없는 경우 -> 사원이 아닙니다.
    소속 부서가 없는 경우 -> 소속 부서가 없습니다. )

실행) EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept(178))
출력) Executive
SELECT employee_id, y_dept(employee_id)
FROM   employees;
*/
--SELECT문 2개
CREATE OR REPLACE FUNCTION y_dept
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_deptno departments.department_id%TYPE;
    v_deptname departments.department_name%TYPE;
    
    e_no_dept EXCEPTION;
BEGIN
    SELECT department_id
    INTO v_deptno
    FROM employees
    WHERE employee_id = p_eid;
    
    IF v_deptno IS NULL THEN
        RAISE e_no_dept;
    END IF;
    
    SELECT department_name
    INTO v_deptname
    FROM departments
    WHERE department_id = v_deptno;
    
    RETURN v_deptname;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '사원이 아닙니다.';
    WHEN e_no_dept THEN
        RETURN '소속 부서가 없습니다.';
END;
/

--JOIN
CREATE OR REPLACE FUNCTION y_dept
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_deptno departments.department_id%TYPE;
    v_deptname departments.department_name%TYPE;
    
    e_no_dept EXCEPTION;
BEGIN
    SELECT department_name
    INTO v_deptname
    FROM employees LEFT OUTER JOIN departments
        USING (department_id)
    WHERE employee_id = p_eid;
    
    IF v_deptname IS NULL THEN
        RAISE e_no_dept;
    END IF;
    
    RETURN v_deptname;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '사원이 아닙니다.';
    WHEN e_no_dept THEN
        RETURN '소속 부서가 없습니다.';
END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept(178));
