SET SERVEROUTPUT ON

-- 기본 LOOP
DECLARE
    v_num NUMBER(2,0) := 1;
    v_result NUMBER(2,0) := 0;
BEGIN
    
    LOOP
        v_result := v_result + v_num;
        v_num := v_num + 1;
        EXIT WHEN v_num > 10;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

DECLARE
    v_num NUMBER(2,0) := 0;
    v_result NUMBER(2,0) := 0;
BEGIN
    
    LOOP
        v_num := v_num + 1;
        v_result := v_result + v_num;
        EXIT WHEN v_num >= 10;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/


-- FOR LOOP
BEGIN
    
    FOR num IN REVERSE -5..-1 LOOP
        DBMS_OUTPUT.PUT_LINE(num);
    END LOOP;
END;
/

DECLARE
    v_result NUMBER(2,0) := 0;
BEGIN
    FOR num IN 1..10 LOOP
        v_result := v_result + num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/


-- WHILE LOOP
DECLARE
    v_num NUMBER(2,0) := 0;
    v_result NUMBER(2,0) := 0;
BEGIN
    WHILE v_num <= 10 LOOP
        v_result := v_result + v_num;
        v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_result);
    
    v_num := 0;
    v_result := 0;
    WHILE v_num < 10 LOOP
        v_num := v_num + 1;
        v_result := v_result + v_num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

/*
1. 다음과 같이 출력되도록 하시오.
*
**
***
****
*****

*/
-- LOOP
DECLARE
    v_tree VARCHAR2(5 char) := ''; -- 각 줄에 출력할 *
    v_count NUMBER(1,0) := 1;      -- loop문 종료 조건에 사용할 변수
BEGIN
    LOOP
        v_tree := v_tree || '*';
        DBMS_OUTPUT.PUT_LINE(v_tree);
        
        v_count := v_count + 1;
        EXIT WHEN v_count > 5;
    END LOOP;
END;
/
-- FOR LOOP
BEGIN
    FOR counter IN 1..5 LOOP
        FOR i IN 1..counter LOOP
            DBMS_OUTPUT.PUT('*');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
-- WHILE LOOP
DECLARE
    v_tree VARCHAR2(6 char) := ''; -- 각 줄에 출력할 *
    v_count NUMBER(1,0) := 0;      -- loop문 종료 조건에 사용할 변수
BEGIN
    WHILE v_count < 5 LOOP
        v_tree := v_tree || '*';
        DBMS_OUTPUT.PUT_LINE(v_tree);     
        v_count := v_count + 1;
    END LOOP;
END;
/




--
DECLARE
    v_star VARCHAR2(5) := '*';
    v_result VARCHAR2(5) := '';
BEGIN
    LOOP
        v_result := v_result || v_star;
        DBMS_OUTPUT.PUT_LINE(v_result);
        EXIT WHEN v_result = '*****'; 
    END LOOP;
END;
/

--
DECLARE
    v_star VARCHAR2(5) := '';
BEGIN
    FOR num IN 1..5 LOOP
        v_star := v_star || '*';
        DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;
END;
/

--
DECLARE
    v_num NUMBER(1,0) := 1;
    v_star VARCHAR2(5) := '';
BEGIN
    WHILE v_num <= 5 LOOP
        v_star := v_star || '*';
        v_num := v_num + 1;
        DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;
END;
/

/*
 2. 치환변수(&)를 사용하면 숫자를 입력하면 해당 구구단이 출력되도록 하시오.
예) 2 입력시
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
*/
DECLARE
    v_gugudan NUMBER(1,0) := &구구단;
    v_num NUMBER(2,0) := 1;
BEGIN
     LOOP
        DBMS_OUTPUT.PUT_LINE(v_gugudan || ' * ' || v_num || ' = '|| v_gugudan*v_num);  
        v_num := v_num + 1;
        EXIT WHEN v_num >= 10;
     END LOOP;
END;
/

DECLARE
    v_gugudan NUMBER(1,0) := &구구단;
BEGIN
    FOR num IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_gugudan || ' * ' || num || ' = '|| v_gugudan*num);
    END LOOP;
END;
/

DECLARE
    v_gugudan NUMBER(1,0) := &구구단;
    v_num NUMBER(2,0) := 1;
BEGIN
     WHILE v_num < 10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_gugudan || ' * ' || v_num || ' = '|| v_gugudan*v_num);  
        v_num := v_num + 1;
     END LOOP;
END;
/

/*
3. 구구단 2~9단까지 출력되도록 하시오.
*/

BEGIN
    FOR gugudan IN 2..9 LOOP
        FOR number IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(gugudan || ' * ' || number || ' = '|| gugudan*number);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

DECLARE
    v_gugudan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_gugudan < 10 LOOP
        v_num := 1;
        WHILE v_num < 10 LOOP
            DBMS_OUTPUT.PUT_LINE(v_gugudan || ' * ' || v_num || ' = '|| v_gugudan*v_num);
            v_num := v_num + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        v_gugudan := v_gugudan + 1;
    END LOOP;
END;
/

-- 구구단을 옆으로 출력
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_num < 10 LOOP -- 특정 단의 1~9까지 곱하는 LOOP
        v_dan := 2;
        WHILE v_dan < 10 LOOP -- 특정 단을 2~9까지 반복하는 LOOP
            DBMS_OUTPUT.PUT(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num) || '  ');
            v_dan := v_dan + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        v_num := v_num + 1;
    END LOOP;
END;
/

--기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        v_num := 1;
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
            v_num := v_num + 1;
            EXIT WHEN v_num > 9;
        END LOOP;
        v_dan := v_dan + 1;
        EXIT WHEN v_dan > 9;
    END LOOP;
END;
/
/*
4. 구구단 1~9단까지 출력되도록 하시오.
   (단, 홀수단 출력)
*/

-- FOR LOOP, IF
BEGIN
    FOR v_dan IN 2..9 LOOP
        IF MOD(v_dan, 2) <> 0 THEN -- <>, !=
            FOR v_num IN 1..9 LOOP
                DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = '|| v_dan*v_num);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/

-- 
BEGIN
    FOR v_dan IN 1..9 LOOP
        IF MOD(v_dan, 2) = 0 THEN
            CONTINUE;
        END IF;
        
        FOR v_num IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = '|| v_dan*v_num);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- 기본 LOOP문
DECLARE
    v_dan NUMBER(2,0) := 1;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        v_num := 1;
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
            v_num := v_num + 1;
            EXIT WHEN v_num > 9;
        END LOOP;
        v_dan := v_dan + 2;
        EXIT WHEN v_dan > 9;
    END LOOP;
END;
/


-- RECORD
DECLARE
    TYPE emp_record_type IS RECORD
        (empno NUMBER(6,0) NOT NULL := 100,
         ename employees.first_name%TYPE,
         sal employees.salary%TYPE);
    
    emp_info emp_record_type;
    emp_record emp_record_type;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || emp_info.empno);
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || emp_record.empno);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || emp_info.sal); --null
    DBMS_OUTPUT.PUT_LINE('');
    SELECT employee_id, first_name, salary
    INTO emp_info
    FROM employees
    WHERE employee_id = &사원번호;
    DBMS_OUTPUT.PUT('사원번호 : ' || emp_info.empno);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', 급여 : ' || emp_info.sal);
    
    SELECT department_id, job_id, salary
    INTO emp_info
    FROM employees
    WHERE employee_id = &사원번호;
    DBMS_OUTPUT.PUT('사원번호 : ' || emp_info.empno);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', 급여 : ' || emp_info.sal);
END;
/


DECLARE
    emp_record employees%ROWTYPE;
BEGIN
    SELECT *
    INTO emp_record
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE(emp_record.employee_id);
    DBMS_OUTPUT.PUT_LINE(emp_record.last_name);
    DBMS_OUTPUT.PUT_LINE(emp_record.job_id);
END;
/


-- TABLE
DECLARE
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    
    num_info num_table_type;
BEGIN
    num_info(10) := 1000;
    -- 0부터 시작하지 않음
    DBMS_OUTPUT.PUT_LINE(num_info(10));
    
    FOR idx IN 1..10 LOOP
        num_info(TRUNC(idx/2)) := idx;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(num_info(0));
    DBMS_OUTPUT.PUT_LINE(num_info(1));
END;
/


DECLARE
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY BINARY_INTEGER;
        
    num_table num_table_type;
    v_total NUMBER(2,0);
    v_table_value NUMBER;
BEGIN
-- 정수 1 ~ 50 사이에 존재하는 2의 배수를 따로 num_table에 담고
-- 1) 총 몇개인지 출력
    
    FOR idx IN 1..50 LOOP
        IF MOD(idx, 2) <> 0 THEN
            CONTINUE;
        END IF;
        
        num_table(idx) := idx;
    END LOOP;
    
    v_total := num_table.COUNT;
    DBMS_OUTPUT.PUT_LINE(v_total);
    
-- 2) 실제로 num_table 내에 존재하는 모든 숫자를 출력
    FOR idx IN num_table.FIRST .. num_table.LAST LOOP
        IF num_table.EXISTS(idx) THEN
            DBMS_OUTPUT.PUT_LINE(num_table(idx));
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
-- 3) 3의 배수 삭제
    FOR idx IN num_table.FIRST .. num_table.LAST LOOP
        IF num_table.EXISTS(idx) THEN
            v_table_value := num_table(idx);
            IF MOD(v_table_value, 3) = 0 THEN
                num_table.DELETE(idx);
            END IF;
        END IF;
    END LOOP;
-- 3) 문제 확인
    FOR idx IN num_table.FIRST .. num_table.LAST LOOP
        IF num_table.EXISTS(idx) THEN
            -- 실제 연산 관련 코드
            DBMS_OUTPUT.PUT_LINE(num_table(idx));
        END IF;
    END LOOP;
END;
/


DECLARE
    v_min employees.employee_id%TYPE; -- 최소 사원번호
    v_MAX employees.employee_id%TYPE; -- 최대 사원번호
    v_result NUMBER(1,0);             -- 사원의 존재 유무를 확인
    emp_record employees%ROWTYPE;     -- employees 테이블의 한 행에 대응
    
    TYPE emp_table_type IS TABLE OF emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    emp_table emp_table_type;
BEGIN
    -- 최소 사원번호, 최대 사원번호
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    FOR eid IN v_min .. v_max LOOP
        SELECT COUNT(*)
        INTO v_result
        FROM employees
        WHERE employee_id = eid;
        
        IF v_result = 0 THEN
            CONTINUE;
        END IF;
        
        SELECT *
        INTO emp_record
        FROM employees
        WHERE employee_id = eid;
        
        emp_table(eid) := emp_record;
    END LOOP;
    
    FOR eid IN emp_table.FIRST .. emp_table.LAST LOOP
        IF emp_table.EXISTS(eid) THEN
            DBMS_OUTPUT.PUT(emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT(emp_table(eid).first_name || ', ');
            DBMS_OUTPUT.PUT_LINE(emp_table(eid).hire_date);
        END IF;
    END LOOP;
    
END;
/


-- CURSOR
DECLARE
    CURSOR emp_cursor IS
    -- INTO절 X
        SELECT employee_id, last_name
        FROM employees;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    OPEN emp_cursor;
    
    FETCH emp_cursor INTO v_eid, v_ename; -- 변수에 담음
    
    DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename);
    
    CLOSE emp_cursor;
END;
/


DECLARE
    CURSOR emp_cursor IS
    -- INTO절 X
        SELECT employee_id, last_name
        FROM employees;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename; -- 변수에 담음
        EXIT WHEN emp_cursor%NOTFOUND;  -- 종료조건은 FETCH 다음에 작성
        --EXIT WHEN emp_cursor%ROWCOUNT > 10;
        DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename);
    END LOOP;
    
    -- 마지막행 반복됨
    FETCH emp_cursor INTO v_eid, v_ename;
    DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename);
    
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT); -- FETCH가 실행된 횟수가 아니라, 반환된 행 수 반환
    CLOSE emp_cursor;
    -- DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT); -- CLOSE이후 사용X
END;
/

-- 1) 모든 사원의 사원번호, 이름, 부서이름 출력
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, department_name
        FROM employees e JOIN departments d
            ON e.department_id = d.department_id;
            
    v_eid employees.employee_id%TYPE;
    v_ename employees.first_name%TYPE;
    v_dept_name departments.department_name%TYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_dept_name;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename || ', ' || v_dept_name);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/

-- 2) 부서번호가 50이거나 80인 사원들의 사원이름, 급여, 연봉 출력
-- 2-1) 
DECLARE
    CURSOR emp_cursor IS
        SELECT first_name, 
               salary,
               NVL(salary, 0) * 12 + NVL(salary, 0) * NVL(commission_pct, 0) * 12 AS annual
        FROM employees
        WHERE department_id IN ( 50, 80);
    
    emp_info emp_cursor%ROWTYPE; --레코드 타입 사용
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(emp_info.first_name || ', ' || emp_info.salary || ', ' || emp_info.annual);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/

-- 2-2) cursor : 사원이름, 급여, 커미션으로 제한
DECLARE
    CURSOR emp_cursor IS
        SELECT first_name, salary, commission_pct
        FROM employees
        WHERE department_id IN ( 50, 80 );

    v_ename employees.first_name%TYPE;
    v_sal employees.salary%TYPE;
    v_comm employees.commission_pct%TYPE;
    v_annual v_sal%TYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_ename, v_sal, v_comm;
        EXIT WHEN emp_cursor%NOTFOUND;
        v_annual := NVL(v_sal, 0) * 12 + NVL(v_sal, 0) * NVL(v_comm, 0) * 12;
        DBMS_OUTPUT.PUT_LINE('사원이름: ' || v_ename || ', 급여: ' || v_sal || ', 연봉: ' || v_annual);
    END LOOP;
    CLOSE emp_cursor;
END;
/