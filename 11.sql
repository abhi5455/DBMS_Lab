SET SERVEROUTPUT ON;
    
    CREATE TABLE Book (
        accNo INT PRIMARY KEY, 
        title VARCHAR2(20), 
        author VARCHAR2(20), 
        publisher VARCHAR2(20), 
        edition INT, 
        copyNo INT
    );
    
    INSERT INTO Book VALUES (1000, 'The Alchemist', 'Paulo Coelho', 'HarperCollins', 1, 5);
    INSERT INTO Book VALUES (2005, '1984', 'George Orwell', 'Secker & Warburg', 1, 3);
    INSERT INTO Book VALUES (2045, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1, 4);
    INSERT INTO Book VALUES (1500, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Charles Scribners Sons', 2, 2);
    
    CREATE OR REPLACE TRIGGER TOTAL_TUPLE
    AFTER INSERT OR DELETE OR UPDATE ON BOOK
    FOR EACH ROW
    DECLARE
        NO NUMBER;
    BEGIN
        SELECT COUNT(*) INTO NO FROM BOOK;
        DBMS_OUTPUT.PUT_LINE('No of Books: ' || NO);
    END;
    /

    INSERT INTO Book VALUES (700, 'War and Peace', 'Leo Tolstoy', 'The Russian Messenger', 1, 1);
    