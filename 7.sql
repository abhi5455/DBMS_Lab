set serveroutput on
declare
	  num number:=&num;
	  num1 number:=0;
	  num2 number:=1;
	  temp number;
begin
	  dbms_output.put_line('Fibonacci Series: ');
	  if num=0 then
	        dbms_output.put_line(0);
	  elsif num=1 then
		    dbms_output.put_line(0);
		    dbms_output.put_line(1);
	  else
		    dbms_output.put_line(0);
		    dbms_output.put_line(1);
		    for i in 1..(num-2) Loop
			    dbms_output.put_line(num1+num2);
			    temp:=num2;
			    num2:=num1+num2;
			    num1:=temp;
		    end Loop;
	  end if;
end;
/