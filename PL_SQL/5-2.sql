SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
	v_card_id NUMBER := &sv_card_id;
	v_book_id NUMBER := &sv_book_id;

BEGIN Return_Book( v_card_id, v_book_id);
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('EXCEPTION: NO DATA FOUND');
END;
.
/