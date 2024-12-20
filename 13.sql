SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION GETVALUE (GRADE IN VARCHAR2)
RETURN NUMBER IS
BEGIN
    IF GRADE='S' THEN
        RETURN 100;
    ELSIF GRADE='A+' THEN
        RETURN 90;
    ELSIF GRADE='A' THEN
        RETURN 80;
    ELSIF GRADE='B+' THEN
        RETURN 70;
    ELSIF GRADE='B' THEN
        RETURN 60;
    ELSIF GRADE='C+' THEN
        RETURN 50;
    ELSIF GRADE='C' THEN
        RETURN 40;
    ELSIF GRADE='F' THEN
        RETURN 0;
    END IF;
END GETVALUE;
/

CREATE TABLE STUDENTMARKS
(NAME VARCHAR(30),
KTUID VARCHAR(10),
SEMESTER NUMBER,
SUBJECT_NAME VARCHAR(30),
SUBJECT_CODE VARCHAR(10),
CREDIT NUMBER,
INTERNAL NUMBER,
GRADE VARCHAR(2),
PRIMARY KEY(KTUID,SEMESTER,SUBJECT_CODE)
);

CREATE TABLE SGPTABLE
(KTUID VARCHAR(10),
SEMESTER INT,
SGPA NUMBER(4,2));

CREATE TABLE CGPATABLE
(KTUID VARCHAR(10),
CGPA NUMBER(4,2));

CREATE OR REPLACE TRIGGER MARK_MODIFIED
BEFORE UPDATE OR INSERT
ON STUDENTMARKS
FOR EACH ROW
    DECLARE
        CURSOR CRSTUDENT(ID VARCHAR2,SEM NUMBER) IS 
        SELECT * FROM STUDENTMARKS WHERE KTUID=ID AND 
        SEMESTER=SEM;
        TEMP NUMBER(5);
        SGPA NUMBER(4,2);
        CNT NUMBER;
        PRESENT NUMBER;

        SGPA_SUM NUMBER(5,2);
        SEM NUMBER;
        CGPA NUMBER(4,2);

BEGIN

TEMP := :NEW.CREDIT * GETVALUE(:NEW.GRADE) / 10;
CNT := :NEW.CREDIT;
FOR REC IN CRSTUDENT(:NEW.KTUID,:NEW.SEMESTER) LOOP
    CNT := CNT + REC.CREDIT;
    TEMP := TEMP +  (REC.CREDIT * GETVALUE(REC.GRADE)/10);
END LOOP;
SGPA := TRUNC(TEMP/CNT,2);
SELECT COUNT(*) INTO PRESENT FROM SGPTABLE WHERE KTUID=:NEW.KTUID AND SEMESTER=:NEW.SEMESTER;
IF PRESENT = 0 THEN
    INSERT INTO SGPTABLE VALUES (:NEW.KTUID,:NEW.SEMESTER,SGPA);
ELSE
    UPDATE SGPTABLE SET SGPA=SGPA WHERE KTUID=:NEW.KTUID AND SEMESTER=:NEW.SEMESTER;
END IF;

SELECT SUM(SGPA),COUNT(*) INTO SGPA_SUM,SEM FROM SGPTABLE WHERE KTUID=:NEW.KTUID;
CGPA := TRUNC((SGPA_SUM/SEM),2);  

SELECT COUNT(*) INTO PRESENT FROM CGPATABLE WHERE KTUID=:NEW.KTUID;
IF PRESENT = 0 THEN
    INSERT INTO CGPATABLE VALUES (:NEW.KTUID,CGPA);
ELSE
    UPDATE CGPATABLE SET CGPA=CGPA WHERE KTUID=:NEW.KTUID;
END IF;
END;
/

INSERT INTO STUDENTMARKS
VALUES('AYSHA','KTE22CS099',1,'MECHANICS','EM308',3,50,'A+');
INSERT INTO STUDENTMARKS 
VALUES('AYSHA','KTE22CS099',1,'PHYSICS','PHY001',3,50,'A');
INSERT INTO STUDENTMARKS
VALUES('AYSHA','KTE22CS099',1,'OOP USING JAVA','CST406',2,50,'S');
INSERT INTO STUDENTMARKS 
VALUES('AYSHA','KTE22CS099',2,'GRAPHICS','GRP003',4,50,'A');
INSERT INTO STUDENTMARKS 
VALUES('AYSHA','KTE22CS099',2,'CHEMISTRY','CHM004',5,50,'S');

SELECT * FROM STUDENTMARKS;
SELECT * FROM SGPTABLE;

DROP TABLE CGPATABLE;
DROP TABLE SGPTABLE;
DROP TABLE STUDENTMARKS;