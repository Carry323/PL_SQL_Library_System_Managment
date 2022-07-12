SET SERVEROUTPUT ON
SET VERIFY OFF

CREATE OR REPLACE PROCEDURE lost_book (I_CARD_ID   IN   NUMBER, I_BOOK_ID   IN   NUMBER)
IS

v_late_fees NUMBER;
v_lost_cost NUMBER;


BEGIN
 
	UPDATE BOOK   SET STATUS =  'LOST' WHERE BOOK_ID = i_Book_ID;
	SELECT LOST_COST INTO v_lost_cost FROM BOOK WHERE BOOK_ID = I_BOOK_ID;
    select  Late_Fees INTO v_Late_Fees from card WHERE CARD_ID =  i_Card_ID;

	IF v_lost_cost > 0 THEN

		v_late_fees :=  v_late_fees + v_lost_cost;

		UPDATE CARD SET STATUS = 'INNACTIVE' WHERE CARD_ID =  i_Card_ID;
		
		DBMS_OUTPUT.PUT_LINE ('You have to pay  :  ' || v_late_fees ||' Dollars ...');
	ELSE
		DBMS_OUTPUT.PUT_LINE ('You are not lost book  ');
	END IF;

	-- COMMIT;
END lost_book;
/
