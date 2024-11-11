CREATE TABLE Employee(
    empid INT PRIMARY KEY,
    empname VARCHAR2(50),
    joindate DATE,
    reldate DATE,
    salary NUMBER(10,2)
);

INSERT ALL
    INTO Employee(empid, empname, joindate, reldate, salary) VALUES
        (101, 'Adam Abraham', TO_DATE('2019-10-22', 'YYYY-MM-DD'), TO_DATE('2024-10-22', 'YYYY-MM-DD'), 100000)
    INTO Employee(empid, empname, joindate, reldate, salary) VALUES
        (102, 'Raghav K P', TO_DATE('2018-04-04', 'YYYY-MM-DD'), TO_DATE('2024-05-30', 'YYYY-MM-DD'), 50000)
    INTO Employee(empid, empname, joindate, reldate, salary) VALUES
        (103, 'Kiran Kumar', TO_DATE('2020-06-06', 'YYYY-MM-DD'), NULL, 200000)
    INTO Employee(empid, empname, joindate, reldate, salary) VALUES
        (104, 'Litty Susan', TO_DATE('2022-02-02', 'YYYY-MM-DD'), NULL, 100000)
    INTO Employee(empid, empname, joindate, reldate, salary) VALUES
        (105, 'Sheetal Saji', TO_DATE('2021-07-03', 'YYYY-MM-DD'), TO_DATE('2024-06-22', 'YYYY-MM-DD'), 55000)
SELECT * FROM dual;

DECLARE
    CURSOR EMPL IS 
        SELECT EMPID, EMPNAME, JOINDATE, RELDATE, SALARY FROM EMPLOYEE;

    ID EMPLOYEE.EMPID%TYPE;
    NAME EMPLOYEE.EMPNAME%TYPE;
    JOIN EMPLOYEE.JOINDATE%TYPE;
    RELIEVE EMPLOYEE.RELDATE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    SERVICE NUMBER(5,2) := 0;  
    PENSION NUMBER(10,2) := 0; 

BEGIN
    OPEN EMPL;

    LOOP
        FETCH EMPL INTO ID, NAME, JOIN, RELIEVE, SAL;
        EXIT WHEN EMPL%NOTFOUND;

        IF RELIEVE IS NOT NULL THEN
            SERVICE := MONTHS_BETWEEN(RELIEVE, JOIN) / 12;
            PENSION := (SERVICE * SAL) / 100;
            
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || ID || ', Name: ' || NAME || ', Service: ' || SERVICE || ', Pension: ' || PENSION);
        END IF;
    END LOOP;

    CLOSE EMPL;
END;
/