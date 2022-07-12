SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
procedure GenerateLoginInfo
IS
  CURSOR C_Employees
   IS
      SELECT First_Name, Last_Name,Hire_Date, Employee_ID
             FROM Employee FOR UPDATE;
				v_user1 EMPLOYEE.Username%TYPE;
			    v_passw1 EMPLOYEE.Password%TYPE;
				
   CURSOR C_Members
   IS
      SELECT First_Name,Last_Name,Member_ID,Zip
               FROM MEMBER FOR UPDATE;
				v_user MEMBER.Username%TYPE;
				v_passw MEMBER.Password%TYPE;

BEGIN
FOR v_row in C_Employees
   LOOP
      v_user1:= lower(substr(v_row.First_Name,0,1)) || lower(substr(v_row.Last_Name,0,9));
	  v_passw1:= upper(substr(v_row.First_Name,0,2))||to_char(v_row.Hire_date, 'DD') ||upper(substr(v_row.Last_Name,1,2))||to_char(v_row.Hire_date, 'YYYY');

	UPDATE Employee SET Username = v_user1 WHERE Employee_ID = v_row.Employee_id;
	UPDATE Employee SET Password = v_passw1 WHERE CURRENT OF C_EMPLOYEES;
	DBMS_OUTPUT.PUT_LINE ('Employee`s username ' || v_user1);
	DBMS_OUTPUT.PUT_LINE ('Employee`s password ' || v_passw1);

END LOOP;

   FOR v_row in c_members
   LOOP
      v_user:= upper(substr(v_row.Last_Name,0,1)) || lower(substr(v_row.Last_Name,2,1)) || v_row.Member_ID;
	  v_passw:= '00'||upper(substr(v_row.First_Name,0,2))||v_row.Zip;
	
	UPDATE Member SET Username = v_user WHERE Member_ID = v_row.member_id;
	UPDATE Member SET Password = v_passw WHERE CURRENT OF c_members;
	
	DBMS_OUTPUT.PUT_LINE ('Member`s username ' || v_user);
	DBMS_OUTPUT.PUT_LINE ('Member`s password  ' || v_passw);
	
END LOOP;
END GenerateLoginInfo;

BEGIN 
 GenerateLoginInfo();
--COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.PUT_LINE ('EXCEPTION: NOT FOUND');
END;
.
/