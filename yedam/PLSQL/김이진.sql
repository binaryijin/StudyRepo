-- 2)
DECLARE
    v_deptname departments.department_name%TYPE;
    v_jobid employees.job_id%TYPE;
    v_sal employees.salary%TYPE;
    v_annual employees.salary%TYPE;
BEGIN
    SELECT department_name, job_id, salary, NVL(salary, 0) * 12 + NVL(salary, 0) * NVL(commission_pct, 0) * 12
    INTO v_deptname, v_jobid, v_sal, v_annual
    FROM employees JOIN departments
        USING (department_id)
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT('부서이름 : ' || v_deptname);
    DBMS_OUTPUT.PUT(', JOB_ID : ' || v_jobid);
    DBMS_OUTPUT.PUT(', 급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE(', 연간 총수입 : ' || v_annual);
END;
/

-- 3)
DECLARE 
    v_hdate employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF v_hdate > TO_DATE('05-12-31', 'yy-MM-dd') THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
    END IF;    
    
END;
/

-- 4)
BEGIN
    FOR v_gugudan IN 1 .. 9 LOOP
        IF MOD(v_gugudan, 2) = 0 THEN
            CONTINUE;
        END IF;
        
        FOR v_num IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(v_gugudan || ' * ' || v_num || ' = '|| v_gugudan * v_num);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;
END;
/

-- 5)
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = &부서번호;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.first_name%TYPE;
    v_sal employees.salary%TYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_sal;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('사번 : ' || v_eid || ', 이름 : ' || v_ename || ', 급여 : ' || v_sal);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/

-- 6)
CREATE OR REPLACE PROCEDURE emp_sal
(p_eid IN employees.employee_id%TYPE,
 p_pct IN NUMBER)
IS
    e_no_emp EXCEPTION;
BEGIN
    UPDATE employees
    SET salary = salary * ( 1 + (p_pct / 100 ))
    WHERE employee_id = p_eid;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('No search employee!!');
END;
/

EXECUTE emp_sal(101, 10);

-- 7)
--CREATE OR REPLACE PROCEDURE age_gender
--(p_ssn IN VARCHAR2)
--IS
--    v_year NUMBER;
--    v_birth VARCHAR2(10);
--    v_gender VARCHAR2(10);
--BEGIN
--    v_year := SUBSTR(p_ssn, 1, 2);
--    v_birth := TO_DATE(SUBSTR(p_ssn, 3, 4), 'MM-dd');
--
--END;
--/
--EXECUTE age_gender('0211023234567');


-- 8)
CREATE OR REPLACE FUNCTION emp_year
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
    v_year NUMBER(10);
BEGIN
    SELECT TRUNC((months_between(sysdate, hire_date)) / 12)
    INTO v_year
    FROM employees
    WHERE employee_id = p_eid;
    
    RETURN v_year;
END;
/

SELECT emp_year(employee_id) "근무년수"
FROM employees;


--9)
CREATE OR REPLACE FUNCTION mgr_name
(p_deptname departments.department_name%TYPE)
RETURN VARCHAR2
IS
    v_mgrname employees.first_name%TYPE;
BEGIN
    SELECT first_name
    INTO v_mgrname
    FROM employees
    WHERE employee_id IN (SELECT manager_id
                            FROM departments
                            WHERE department_name = p_deptname);
    RETURN v_mgrname;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(mgr_name('Executive'));

-- 10)
SELECT name, text
FROM user_source
WHERE type IN ('PROCEDURE', 'FUNCTION', 'PACKAGE', 'PACKAGE BODY');


-- 11)
