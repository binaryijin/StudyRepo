SET SERVEROUTPUT ON
/* 1.
�ֹε�Ϲ�ȣ�� �Է��ϸ� 
������ ���� ��µǵ��� yedam_ju ���ν����� �ۼ��Ͻÿ�.

EXECUTE yedam_ju(9501011667777)
EXECUTE yedam_ju(1511013689977)
-> 950101-1******
*/
CREATE PROCEDURE yedam_ju
(p_ssn IN VARCHAR2)
IS
-- ����� : ���ο��� ����� ����, Ÿ��, Ŀ�� ��
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
�����ȣ�� �Է��� ���
�����ϴ� TEST_PRO ���ν����� �����Ͻÿ�.
��, �ش����� ���� ��� "�ش����� �����ϴ�." ���
��) EXECUTE TEST_PRO(176)
*/
CREATE OR REPLACE PROCEDURE test_pro
(p_eid employees.employee_id%TYPE)
IS

BEGIN
    DELETE FROM test_employees
    WHERE employee_id = p_eid;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�ش� ����� �����ϴ�.');
    END IF;
END;
/
EXECUTE TEST_PRO(0);

/*
3.
������ ���� PL/SQL ����� ������ ��� 
�����ȣ�� �Է��� ��� ����� �̸�(last_name)�� ù��° ���ڸ� �����ϰ��
'*'�� ��µǵ��� yedam_emp ���ν����� �����Ͻÿ�.

����) EXECUTE yedam_emp(176)
������) TAYLOR -> T*****  <- �̸� ũ�⸸ŭ ��ǥ(*) ���

1) �Է� : �����ȣ -> ��� : ����̸� => SELECT
2) ����̸� : ������ �������� ��ȯ
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
�μ���ȣ�� �Է��� ��� 
�ش�μ��� �ٹ��ϴ� ����� �����ȣ, ����̸�(last_name)�� ����ϴ� get_emp ���ν����� �����Ͻÿ�. 
(cursor ����ؾ� ��)
��, ����� ���� ��� "�ش� �μ����� ����� �����ϴ�."��� ���(exception ���)
����) EXECUTE get_emp(30)


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
    -- Ŀ�� FOR LOOP ���X -> �����Ͱ� ���°� Ȯ�� �� �� ����
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_info.employee_id || ', ' || emp_info.last_name);
    END LOOP;
    
    -- LOOP�� ��� �Ŀ� ROWCOUNTȮ��
    IF emp_cursor%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
        
    CLOSE emp_cursor;
    
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ����� ����� �����ϴ�.');
END;
/
EXECUTE get_emp(0);

/*5.
�������� ���, �޿� ����ġ�� �Է��ϸ� Employees���̺� ���� ����� �޿��� ������ �� �ִ� y_update ���ν����� �ۼ��ϼ���. 
���� �Է��� ����� ���� ��쿡�� ��No search employee!!����� �޽����� ����ϼ���.(����ó��)
����) EXECUTE y_update(200, 10)
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
������ ���� ���̺��� �����Ͻÿ�.
create table yedam01
(y_id number(10),
 y_name varchar2(20));

create table yedam02
(y_id number(10),
 y_name varchar2(20));
6-1.
�μ���ȣ�� �Է��ϸ� ����� �߿��� �Ի�⵵�� 2005�� ���� �Ի��� ����� yedam01 ���̺� �Է��ϰ�,
�Ի�⵵�� 2005��(����) ���� �Ի��� ����� yedam02 ���̺� �Է��ϴ� y_proc ���ν����� �����Ͻÿ�.

6-2.
1. ��, �μ���ȣ�� ���� ��� "�ش�μ��� �����ϴ�" ����ó��
 2. ��, �ش��ϴ� �μ��� ����� ���� ��� "�ش�μ��� ����� �����ϴ�" ����ó��
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
        DBMS_OUTPUT.PUT_LINE('�ش�μ��� ����� �����ϴ�.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �������� �ʽ��ϴ�.');
       
END;
/

-- FUNCTION
CREATE FUNCTION y_sum
(p_x IN NUMBER,
 p_y NUMBER) --IN�� ����
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

-- �����ȣ�� �������� ���ӻ�� �̸��� ���
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
        DBMS_OUTPUT.PUT_LINE('���ܹ߻�!');
        RETURN '��簡 �������� �ʽ��ϴ�.'; --���� RETURN ���� VARCHAR2�� ���� ���� ����
END;
/

SELECT employee_id, first_name, get_mgr(employee_id) as manager
FROM employees;

-- ���丮��
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
�����ȣ�� �Է��ϸ�
last_name + first_name �� ��µǴ� 
y_yedam �Լ��� �����Ͻÿ�.

����) EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174))
��� ��)  Abel Ellen

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
�����ȣ�� �Է��� ��� ���� ������ �����ϴ� ����� ��µǴ� ydinc �Լ��� �����Ͻÿ�.
- �޿��� 5000 �����̸� 20% �λ�� �޿� ���
- �޿��� 10000 �����̸� 15% �λ�� �޿� ���
- �޿��� 20000 �����̸� 10% �λ�� �޿� ���
- �޿��� 20000 �̻��̸� �޿� �״�� ���
����) SELECT last_name, salary, YDINC(employee_id)
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
�����ȣ�� �Է��ϸ� �ش� ����� ������ ��µǴ� yd_func �Լ��� �����Ͻÿ�.
->������� : (�޿�+(�޿�*�μ�Ƽ���ۼ�Ʈ))*12
����) SELECT last_name, salary, YD_FUNC(employee_id)
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
������ ���� ��µǴ� subname �Լ��� �ۼ��Ͻÿ�.
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
�����ȣ�� �Է��ϸ� �Ҽ� �μ��� ����ϴ� y_dept �Լ��� �����Ͻÿ�.
(��, ������ ���� ��� ����ó��(exception)
 �Էµ� ����� ���ų� �Ҽ� �μ��� ���� ��� -> ����� �ƴϰų� �Ҽ� �μ��� �����ϴ�.)

    �Էµ� ����� ���� ��� -> ����� �ƴմϴ�.
    �Ҽ� �μ��� ���� ��� -> �Ҽ� �μ��� �����ϴ�. )

����) EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept(178))
���) Executive
SELECT employee_id, y_dept(employee_id)
FROM   employees;
*/
--SELECT�� 2��
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
        RETURN '����� �ƴմϴ�.';
    WHEN e_no_dept THEN
        RETURN '�Ҽ� �μ��� �����ϴ�.';
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
        RETURN '����� �ƴմϴ�.';
    WHEN e_no_dept THEN
        RETURN '�Ҽ� �μ��� �����ϴ�.';
END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept(178));
