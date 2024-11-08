DECLARE
n NUMBER := :n;
i number:= 1;
j number:= 0;
x number:= 0;
flag number:= 0;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE prime';
    EXECUTE IMMEDIATE 'DROP TABLE comp';
    EXECUTE IMMEDIATE 'CREATE TABLE prime(prime_num number)';
    EXECUTE IMMEDIATE 'CREATE TABLE comp(composite_num number)';
    WHILE x < n LOOP
        i := i+1;
        flag:=0;
        FOR j in 2..i/2 LOOP
            IF MOD(i,j) = 0 THEN
                dbms_output.put_line(i || ' composite');
                flag:=1;
                x:=x+1;
                INSERT INTO comp(composite_num) Values(i);   
                EXIT;
            END IF;
        END LOOP;
    END LOOP;
    dbms_output.put_line('');

    x := 0;
    i := 1;
    WHILE x < n LOOP
        i := i+1;
        flag :=0;
        FOR j in 2..i/2 LOOP
            IF MOD(i,j) = 0 THEN
                flag := 1;
                EXIT;
            END IF;
        END LOOP;
        IF flag= 0 THEN
            x:=x+1;
            dbms_output.put_line(i || ' prime');
            INSERT INTO prime Values(i); 
        END IF;
    END LOOP;

    dbms_output.put_line('');
    dbms_output.put_line('Prime Numbers FROM Table');
    FOR rec IN (SELECT * FROM prime) LOOP
        dbms_output.put_line(rec.prime_num);
    END LOOP;    
    
    dbms_output.put_line('');
    dbms_output.put_line('Composite Numbers FROM Table');
    FOR rec IN (SELECT * FROM comp) LOOP
        dbms_output.put_line(rec.composite_num);
    END LOOP; 
END;