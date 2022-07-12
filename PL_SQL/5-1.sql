SET SERVEROUTPUT ON
SET VERIFY OFF

CREATE OR REPLACE PROCEDURE RETURN_BOOK (I_CARD_ID   IN   NUMBER, I_BOOK_ID   IN   NUMBER)
IS

v_due_date  DATE;
v_late_days NUMBER;
v_late_fees NUMBER;


BEGIN
    
	UPDATE RENTAL SET Return_Date =  SYSDATE WHERE BOOK_ID = i_Book_ID AND CARD_ID =  i_Card_ID;
	UPDATE BOOK   SET STATUS =  'AVAILABLE' WHERE BOOK_ID = i_Book_ID;
    
	
	SELECT DUE_DATE INTO v_due_date 
	FROM Rental WHERE CARD_ID = i_Card_ID AND BOOK_ID = i_Book_ID ;
	
	IF SYSDATE > v_due_date THEN
		v_late_days := ROUND(SYSDATE - v_due_date);
		v_late_fees := ROUND(v_late_days * 0.25 , 2);
		
		UPDATE CARD SET Late_Fees = Late_Fees + v_late_fees WHERE CARD_ID =  i_Card_ID;
		UPDATE CARD SET STATUS = 'INNACTIVE' WHERE CARD_ID =  i_Card_ID;
		
		DBMS_OUTPUT.PUT_LINE ('You have : ' || v_late_days ||' days of delay...');
		DBMS_OUTPUT.PUT_LINE ('Your fees : ' || v_late_fees ||' Dollars ...');
	ELSE
		DBMS_OUTPUT.PUT_LINE ('You are not late to return  ');
	END IF;
	
	-- COMMIT;
END RETURN_BOOK;
.
/
