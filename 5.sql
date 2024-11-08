set serveroutput on
declare
	x number := &x;
	temp number := 0;
	i number := 0;
	sum_total number := 0;
begin
	dbms_output.put_line('Entered Number: ' || x);
	temp:=x;
	While x>0 Loop
		i:=i+1;
		x:=Floor(x/10);
	End Loop;
	x:=temp;
	While x>0 Loop
		sum_total := sum_total + Power(Mod(x,10),i);
		x:=Floor(x/10);
	End Loop;
	if sum_total=temp then
		dbms_output.put_line('The Number ' || temp || ' is a narcissistic number.');
	else
		dbms_output.put_line('The Number ' || temp || ' is not a narcissistic number.');
	End if;
end;
/