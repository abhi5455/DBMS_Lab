SET SERVEROUTPUT ON;
        
        CREATE OR REPLACE FUNCTION GET_SCORE (GRADE IN VARCHAR2)
        RETURN NUMBER IS
        BEGIN
            CASE GRADE
                WHEN 'S' THEN RETURN 100;
                WHEN 'A+' THEN RETURN 90;
                WHEN 'A' THEN RETURN 80;
                WHEN 'B+' THEN RETURN 70;
                WHEN 'B' THEN RETURN 60;
                WHEN 'C+' THEN RETURN 50;
                WHEN 'C' THEN RETURN 40;
                WHEN 'F' THEN RETURN 0;
                ELSE RETURN NULL; 
            END CASE;
        END GET_SCORE;
        /
        
        CREATE TABLE STUDENT_GRADES (
            STUDENT_NAME VARCHAR(30),
            STUDENT_ID VARCHAR(10),
            TERM NUMBER,
            COURSE_NAME VARCHAR(30),
            COURSE_CODE VARCHAR(10),
            CREDITS NUMBER,
            MIDTERM_SCORE NUMBER,
            LETTER_GRADE VARCHAR(2),
            PRIMARY KEY(STUDENT_ID, TERM, COURSE_CODE)
        );
        
        CREATE TABLE SGPA_RECORD (
            STUDENT_ID VARCHAR(10),
            TERM INT,
            SGPA NUMBER(4,2)
        );
        
        CREATE TABLE CGPA_RECORD (
            STUDENT_ID VARCHAR(10),
            CGPA NUMBER(4,2)
        );
        
        CREATE OR REPLACE TRIGGER TRG_GRADE_UPDATE
        BEFORE UPDATE OR INSERT
        ON STUDENT_GRADES
        FOR EACH ROW
        DECLARE
            CURSOR GRADE_CURSOR IS 
                SELECT * FROM STUDENT_GRADES WHERE STUDENT_ID = :NEW.STUDENT_ID 
                AND TERM = :NEW.TERM;
            TEMP_SCORE NUMBER(5);
            TOTAL_CREDITS NUMBER;
            CURRENT_SGPA NUMBER(4,2);
            TOTAL_SGPA NUMBER(5,2);
            TOTAL_TERMS NUMBER;
            NEW_CGPA NUMBER(4,2);
            
        BEGIN
            TEMP_SCORE := :NEW.CREDITS * GET_SCORE(:NEW.LETTER_GRADE) / 10;
            TOTAL_CREDITS := :NEW.CREDITS;
        
            FOR GRADE_REC IN GRADE_CURSOR LOOP
                TOTAL_CREDITS := TOTAL_CREDITS + GRADE_REC.CREDITS;
                TEMP_SCORE := TEMP_SCORE + (GRADE_REC.CREDITS * 
                GET_SCORE(GRADE_REC.LETTER_GRADE) / 10);
            END LOOP;
        
            CURRENT_SGPA := TRUNC(TEMP_SCORE / TOTAL_CREDITS, 2);
            
            MERGE INTO SGPA_RECORD USING DUAL
            ON (STUDENT_ID = :NEW.STUDENT_ID AND TERM = :NEW.TERM)
            WHEN MATCHED THEN
                UPDATE SET SGPA = CURRENT_SGPA
            WHEN NOT MATCHED THEN
                INSERT (STUDENT_ID, TERM, SGPA) VALUES (:NEW.STUDENT_ID, :NEW.TERM, 
                CURRENT_SGPA);
        
            SELECT SUM(SGPA), COUNT(*) INTO TOTAL_SGPA, TOTAL_TERMS FROM SGPA_RECORD 
            WHERE STUDENT_ID = :NEW.STUDENT_ID;
            NEW_CGPA := TRUNC((TOTAL_SGPA / TOTAL_TERMS), 2);
        
            MERGE INTO CGPA_RECORD USING DUAL
            ON (STUDENT_ID = :NEW.STUDENT_ID)
            WHEN MATCHED THEN
                UPDATE SET CGPA = NEW_CGPA
            WHEN NOT MATCHED THEN
                INSERT (STUDENT_ID, CGPA) VALUES (:NEW.STUDENT_ID, NEW_CGPA);
        END;
        /
        
        INSERT INTO STUDENT_GRADES
        VALUES('Joseph','KTE22CS001',1,'ENGINEERING PHYSICS','EP101',3,45,'A');
        INSERT INTO STUDENT_GRADES 
        VALUES('Joseph','KTE22CS001',1,'DATA STRUCTURES','DS202',3,48,'B+');
        INSERT INTO STUDENT_GRADES
        VALUES('Joseph','KTE22CS001',1,'DATABASE SYSTEMS','DB303',3,50,'A');
        INSERT INTO STUDENT_GRADES 
        VALUES('Joseph','KTE22CS001',2,'COMPUTER GRAPHICS','CG404',4,40,'B');
        INSERT INTO STUDENT_GRADES 
        VALUES('Joseph','KTE22CS001',2,'CHEMICAL ENGINEERING','CE505',5,50,'S');
        
        SELECT * FROM STUDENT_GRADES;
        
        SELECT * FROM SGPA_RECORD;
        
        DROP TABLE CGPA_RECORD;
        DROP TABLE SGPA_RECORD;
        DROP TABLE STUDENT_GRADES;