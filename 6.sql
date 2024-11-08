set serveroutput on
declare
	  str varchar(20);
	  revstr varchar(20):='';
	  i integer;
begin
      str := '&Enter';
	  dbms_output.put_line('Original String ' || str);
	  For i IN REVERSE 1..Length(str) Loop
			revstr:= revstr || SUBSTR(str,i,1);
	  End Loop;
	  dbms_output.put_line('Reversed String ' || revstr);
	  if str=revstr then
			dbms_output.put_line('The String ' || str || ' is a Palindrome');
	  else 
			dbms_output.put_line('The String ' || str || ' is not a Palindrome');
	  end if;
end;
/	