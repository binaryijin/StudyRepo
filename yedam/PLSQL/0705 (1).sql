SET SERVEROUTPUT ON

-- 커서 FOR LOOP
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name
        FROM employees;
    CURSOR dept_emp_cursor IS
        SELECT employee_id, last_name
        FROM employees
        WHERE department_id = &부서번호;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ', ' || emp_record.last_name);
    END LOOP;
    --DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT); -- 종료된 커서이기 때문에 사용X
    
    DBMS_OUTPUT.PUT_LINE('특정 부서에 속한 사원');
    FOR emp_info IN dept_emp_cursor LOOP
        --DBMS_OUTPUT.PUT_LINE(dept_emp_cursor%NOTFOUND);
        DBMS_OUTPUT.PUT_LINE(dept_emp_cursor%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE(emp_info.employee_id || ', ' || emp_info.last_name);
    END LOOP;
END;
/

-- 1) 모든 사원의 사원번호, 이름, 부서이름 출력
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, department_name
        FROM employees e JOIN departments d
            ON e.department_id = d.department_id;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ', ' || emp_record.last_name || ', ' || emp_record.department_name);
    END LOOP;
END;
/

-- 2) 부서번호가 50이거나 80인 사원들의 사원이름, 급여, 연봉 출력
DECLARE
    CURSOR emp_cursor IS
        SELECT first_name, 
               salary,
               NVL(salary, 0) * 12 + NVL(salary, 0) * NVL(commission_pct, 0) * 12 AS annual
        FROM employees
        WHERE department_id IN ( 50, 80);
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.first_name || ', ' || emp_record.salary || ', ' || emp_record.annual);
    END LOOP;
END;
/

BEGIN
    FOR emp_info IN (SELECT last_name FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_info.last_name);
    END LOOP;
END;
/


-- 매개변수
DECLARE
    CURSOR emp_cursor
        (p_mgr employees.manager_id%TYPE) IS
            SELECT *
            FROM employees
            WHERE manager_id = p_mgr;
    
    emp_record emp_cursor%ROWTYPE;
BEGIN
    -- 기본
    OPEN emp_cursor(100);
    
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ', ' || emp_record.first_name);
    END LOOP;
    
    CLOSE emp_cursor;
    
    DBMS_OUTPUT.PUT_LINE('=============================');
    
    -- 커서 FOR LOOP
    FOR emp_info IN emp_cursor(149) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_info.employee_id || ', ' || emp_info.first_name);
    END LOOP;
END;
/

-- FOR UPDATE, WHERE CURRENT OF
DECLARE
    CURSOR sal_info_cursor IS
        SELECT salary, commission_pct
        FROM employees
        WHERE department_id = 30
        FOR UPDATE OF salary, commission_pct NOWAIT;
BEGIN
    FOR sal_info IN sal_info_cursor LOOP
        IF sal_info.commission_pct IS NULL THEN
            UPDATE employees
            SET salary = sal_info.salary * 1.1
            WHERE CURRENT OF sal_info_cursor;
        ELSE
            UPDATE employees
            SET salary = sal_info.salary + sal_info.salary * sal_info.commission_pct
            WHERE CURRENT OF sal_info_cursor;
        END IF;
    END LOOP;
END;
/

-- 커서를 사용 -> employees 테이블의 모든 정보를 한 변수에 담기
DECLARE
    CURSOR emp_cursor IS
        SELECT *
        FROM employees;
        
    emp_record emp_cursor%ROWTYPE;
    
    TYPE emp_table_type IS TABLE OF emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    emp_table emp_table_type;
BEGIN
    FOR emp_info IN emp_cursor LOOP
        emp_table(emp_info.employee_id) := emp_info;
    END LOOP;
END;
/

-- 커서를 사용 -> employees 테이블의 모든 정보를 한 변수에 담기
DECLARE
    CURSOR emp_cursor IS
        SELECT *
        FROM employees;
        
    emp_record emp_cursor%ROWTYPE;
    
    TYPE emp_table_type IS TABLE OF emp_cursor%ROWTYPE
        INDEX BY PLS_INTEGER;
     emp_table_info emp_table_type;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        emp_table_info(emp_record.employee_id) := emp_record;
        
    END LOOP;
    
    CLOSE emp_cursor;
    DBMS_OUTPUT.PUT_LINE(emp_table_info.COUNT);
    FOR idx IN emp_table_info.FIRST .. emp_table_info.LAST LOOP
        IF NOT emp_table_info.EXISTS(idx) THEN
            CONTINUE;
        END IF;
        
        emp_record := emp_table_info(idx);
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ', ' || emp_record.first_name);
    END LOOP;
END;
/

/*
1.
사원(employees) 테이블에서
사원의 사원번호, 사원이름, 입사연도를 
다음 기준에 맞게 각각 test01, test02에 입력하시오.
입사년도가 2005년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2005년 이후 입사한 사원은 test02 테이블에 입력
1-1) 명시적 커서 + 기본 LOOP 사용
1-2) 커서 FOR LOOP 사용
*/

CREATE TABLE test01
AS
	SELECT employee_id, first_name, hire_date
	FROM employees
	WHERE employee_id = 0;
	
CREATE TABLE test02
AS
	SELECT employee_id, first_name, hire_date
	FROM employees
	WHERE employee_id = 0;
    
--
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, hire_date
        FROM employees;
    emp_info emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        IF (TO_CHAR(emp_info.hire_date, 'yyyy') > '2005') THEN
            INSERT INTO test02 VALUES(emp_info.employee_id, emp_info.first_name, emp_info.hire_date);
        ELSE
            INSERT INTO test01 VALUES(emp_info.employee_id, emp_info.first_name, emp_info.hire_date);
        END IF;
    END LOOP;
    
    CLOSE emp_cursor;
END;
/

DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, hire_date
        FROM employees;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        IF (TO_CHAR(emp_record.hire_date, 'yyyy') > '2005') THEN
            INSERT INTO test02 VALUES(emp_record.employee_id, emp_record.first_name, emp_record.hire_date);
        ELSE
            INSERT INTO test01 VALUES(emp_record.employee_id, emp_record.first_name, emp_record.hire_date);
        END IF;
    END LOOP;
END;
/

/*
2.
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오.
(단, cursor 사용)
*/

DECLARE
    CURSOR emp_cursor IS
        SELECT first_name, hire_date, department_name
        FROM employees JOIN departments
            USING (department_id)
        WHERE department_id = &부서번호;
        
    emp_record emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_record.first_name || ', ' || emp_record.hire_date || ', ' || emp_record.department_name);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/


-- 이미 정의되어있고 이름도 존재하는 예외사항
DECLARE
    v_ename employees.first_name%TYPE;
BEGIN
    SELECT first_name
    INTO v_ename
    FROM employees
    WHERE department_id = &부서번호;
    
    DBMS_OUTPUT.PUT_LINE(v_ename);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 존재하지 않습니다.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 여러명의 사원이 존재합니다.');
    DBMS_OUTPUT.PUT_LINE('블록이 종료되었습니다.'); --TOO_MANY_ROWS에서 동작함
END;
/

-- 이미 정의는 되어있지만 이름이 존재하지 않는 예외
DECLARE
    e_emps_remaining EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292);
BEGIN
    DELETE FROM departments
    WHERE department_id = &부서번호; -- ORA-02292
EXCEPTION
    WHEN e_emps_remaining THEN
        DBMS_OUTPUT.PUT_LINE('다른 테이블에서 사용하고 있습니다.');
END;
/

-- 사용자 정의 예외
DECLARE
    e_dept_del_fail EXCEPTION;
BEGIN
    DELETE FROM departments
    WHERE department_id = &부서번호; -- 존재하지 않는 부서번호도 오류 발생하지 않음
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_dept_del_fail;
    END IF;
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 존재하지 않습니다. 부서번호를 확인해주세요.');
END;
/

-- 예외 트랩 함수
DECLARE
    e_too_many EXCEPTION;
    
    v_ex_code NUMBER;
    v_ex_msg VARCHAR2(100);
    emp_info employees%ROWTYPE;
BEGIN
    SELECT *
    INTO emp_info
    FROM employees
    WHERE department_id = &부서번호;
    
    IF emp_info.salary < (emp_info.salary * emp_info.commission_pct + 10000) THEN
        RAISE e_too_many;
    END IF;
EXCEPTION
    WHEN e_too_many THEN
        DBMS_OUTPUT.PUT_LINE('사용자 정의 예외 발생!');
    WHEN OTHERS THEN
        v_ex_code := SQLCODE;
        v_ex_msg := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('ORA' || v_ex_code);
        DBMS_OUTPUT.PUT_LINE(' - ' || v_ex_msg);
END;
/

-- 1) test_employees 테이블을 사용하여 선택된 사원을 삭제하는 PL/SQL 작성
-- 조건1) 치환변수 사용
-- 조건2) 사원이 없는 경우 '해당사원이 없습니다.' 메세지 출력 => 사용자 정의 예외사항
DECLARE
    e_emp_no_found EXCEPTION;
BEGIN
    DELETE FROM test_employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_emp_no_found;
    END IF;
EXCEPTION
    WHEN e_emp_no_found THEN
        DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
END;
/


-- IN (프로시저는 별도로 저장됨)
CREATE PROCEDURE raise_salary
(p_eid IN employees.employee_id%TYPE)
IS
-- 선언부 : 내부에서 사용하는 변수, 커서, 타입, 예외

BEGIN
    UPDATE employees
    SET salary = salary * 1.1
    WHERE employee_id = p_eid;
END;
/

BEGIN
    raise_salary(100);
END;
/

SELECT * FROM employees WHERE employee_id = 100;


CREATE OR REPLACE PROCEDURE test_pro
(p_num IN NUMBER,
 p_result OUT NUMBER)
IS
    v_sum NUMBER;
BEGIN
    v_sum := p_num + p_result; -- p_num(IN) -> 1000 + NULL
    p_result := v_sum;
    
    --p_num := 9876; -- IN모드라 값 변경 X -> 컴파일 에러
END;
/

DECLARE
    v_result NUMBER := 1234;
BEGIN
    test_pro(1000, v_result);
    DBMS_OUTPUT.PUT_LINE('result : ' || v_result);
END;
/

-- OUT 매개변수
CREATE PROCEDURE select_emp
(p_eid IN employees.employee_id%TYPE,
 p_ename OUT employees.first_name%TYPE,
 p_sal OUT employees.salary%TYPE,
 p_comm OUT employees.commission_pct%TYPE)
IS

BEGIN
    SELECT first_name, salary, commission_pct
    INTO p_ename, p_sal, p_comm
    FROM employees
    WHERE employee_id = p_eid;
END;
/

DECLARE
    v_name VARCHAR2(100 char);
    v_sal NUMBER;
    v_comm NUMBER;
    
    v_eid NUMBER := &사원번호;
BEGIN
    select_emp(v_eid, v_name, v_sal, v_comm);
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT(', 사원 이름 : ' || v_name);
    DBMS_OUTPUT.PUT(', 급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE(', 커미션 : ' || v_comm);
END;
/

-- IN OUT 매개변수
-- '0539405000' -> (053)940-5000
CREATE PROCEDURE format_phone
(p_phone_no IN OUT VARCHAR2)
IS

BEGIN
    p_phone_no := '(' || SUBSTR(p_phone_no, 1, 3) ||
                  ')' || SUBSTR(p_phone_no, 4, 3) ||
                  '-' || SUBSTR(p_phone_no, 7);
END;
/

VARIABLE g_phone_no VARCHAR2(100);
EXECUTE :g_phone_no := '0539405000';
PRINT g_phone_no;

EXECUTE format_phone(:g_phone_no);
PRINT g_phone_no;

DROP PROCEDURE test_pro;