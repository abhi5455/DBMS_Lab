DECLARE
    n         NUMBER;
    i         NUMBER := 1;
    CURSOR c1 IS SELECT * FROM SQUARES;    
    CURSOR c2 IS SELECT * FROM CUBES;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Enter a positive integer n:');
    n := :n;

    EXECUTE IMMEDIATE 'CREATE TABLE SQUARES (num NUMBER)';
    EXECUTE IMMEDIATE 'CREATE TABLE CUBES (num NUMBER)';

    FOR i IN 0..n LOOP
        FOR j IN 0..CEIL(i/2) LOOP
            IF j*j = i THEN
                INSERT INTO SQUARES VALUES(i);
            END IF;
            IF j*j*j = i THEN
                INSERT INTO CUBES VALUES(i);
            END IF;
        END LOOP;
    END LOOP;


    dbms_output.put_line('Square Numbers from table');
    OPEN c1;
    LOOP
        FETCH c1 INTO snum;
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line(snum);
    END LOOP;

    dbms_output.put_line('Cube Numbers from table');
    OPEN c2;
    LOOP
        FETCH c2 INTO cnum;
        EXIT WHEN c2%NOTFOUND;
        dbms_output.put_line(cnum);
    END LOOP;

    CLOSE c1;
    CLOSE c2;
    EXECUTE IMMEDIATE 'DROP TABLE SQUARE';
    EXECUTE IMMEDIATE 'DROP TABLE CUBE';
END;
