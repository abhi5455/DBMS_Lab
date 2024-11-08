SET SERVEROUTPUT ON;
    
    CREATE TABLE EmployeeRecords (
        EmployeeID NUMBER(4) PRIMARY KEY,
        EmployeeName VARCHAR2(30),
        SalaryAmount NUMBER(10, 2)
    );
    
    INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, SalaryAmount) VALUES 
    (301, 'SAMEER KHAN', 52000.00);
    INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, SalaryAmount) VALUES 
    (302, 'MEERA T', 67000.00);
    INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, SalaryAmount) VALUES 
    (303, 'VIKAS SINGH', 49500.75);
    INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, SalaryAmount) VALUES 
    (304, 'NEHA DESAI', 74000.50);
    INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, SalaryAmount) VALUES 
    (305, 'ANIL KUMAR', 58000.00);
    
    CREATE TABLE SalaryIncrements (
        EmployeeID NUMBER(4),
        IncrementAmount NUMBER(10, 2)
    );
    SalaryIncrements table
    CREATE OR REPLACE TRIGGER RecordSalaryIncrement 
    AFTER UPDATE ON EmployeeRecords
    FOR EACH ROW
    BEGIN
        DECLARE
            SalaryIncrement NUMBER(10, 2);
        BEGIN
            SalaryIncrement := :NEW.SalaryAmount - :OLD.SalaryAmount;
            IF SalaryIncrement > 1000 THEN 
                INSERT INTO SalaryIncrements(EmployeeID, IncrementAmount) 
                VALUES(:NEW.EmployeeID, SalaryIncrement);
            END IF;
        END;
    END;
    /
    
    UPDATE EmployeeRecords SET SalaryAmount = 53000.00 WHERE EmployeeID = 301;
    UPDATE EmployeeRecords SET SalaryAmount = 68000.00 WHERE EmployeeID = 302;
    UPDATE EmployeeRecords SET SalaryAmount = 49000.75 WHERE EmployeeID = 303;
    UPDATE EmployeeRecords SET SalaryAmount = 75000.50 WHERE EmployeeID = 304;
    UPDATE EmployeeRecords SET SalaryAmount = 59000.00 WHERE EmployeeID = 305;
    
    SELECT * FROM EmployeeRecords;
    
    SELECT * FROM SalaryIncrements;
    
    DROP TABLE EmployeeRecords;
    DROP TABLE SalaryIncrements;