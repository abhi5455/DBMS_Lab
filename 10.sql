CREATE TABLE Employee (
        empid INT PRIMARY KEY,
        empname VARCHAR2(10),
        join_date DATE,
        relieve_date DATE,
        salary NUMBER(10,2)
    );
    
    INSERT INTO Employee VALUES (112, 'Akhil', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 
    TO_DATE('2022-01-15', 'YYYY-MM-DD'), 45000.00);
    INSERT INTO Employee VALUES (222, 'Lakshmi', TO_DATE('2021-03-10', 'YYYY-MM-DD'), 
    TO_DATE('2023-05-20', 'YYYY-MM-DD'), 38000.00);
    INSERT INTO Employee VALUES (453, 'Manoj', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 
    TO_DATE('2023-02-28', 'YYYY-MM-DD'), 50000.00);
    INSERT INTO Employee VALUES (784, 'Revathy', TO_DATE('2020-10-01', 'YYYY-MM-DD'), 
    TO_DATE('2022-11-30', 'YYYY-MM-DD'), 42000.00);
    INSERT INTO Employee VALUES (501, 'Hari', TO_DATE('2022-06-12', 'YYYY-MM-DD'), 
    TO_DATE('2023-09-01', 'YYYY-MM-DD'), 47000.00);
    INSERT INTO Employee VALUES (600, 'Meera', TO_DATE('2021-01-05', 'YYYY-MM-DD'), 
    TO_DATE('2023-07-15', 'YYYY-MM-DD'), 52000.00);
    INSERT INTO Employee VALUES (110, 'Nandini', TO_DATE('2020-04-08', 'YYYY-MM-DD'), 
    TO_DATE('2023-03-25', 'YYYY-MM-DD'), 45000.00);

    
    DECLARE
        CURSOR C1 IS SELECT empid, empname, join_date, relieve_date, salary FROM Employee;
        
        id Employee.empid%TYPE;
        name Employee.empname%TYPE;
        join Employee.join_date%TYPE;
        relieve Employee.relieve_date%TYPE;
        salary Employee.salary%TYPE;
        service NUMBER(3,2) := 0;
        pension NUMBER(10,2) := 0;
    BEGIN
        OPEN C1;
        
        LOOP
            FETCH C1 INTO id, name, join, relieve, salary;
            EXIT WHEN C1%NOTFOUND;
            
            IF relieve IS NOT NULL THEN
                service := MONTHS_BETWEEN(relieve, join) / 12;
                pension := (service * salary) / 100;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || id || ', Name: ' || name || ', 
            SERVICE: ' 
                || service || ', PENSION: ' || pension);
        END LOOP;
        
        CLOSE C1;
    END;
    /