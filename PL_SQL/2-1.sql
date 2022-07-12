CREATE OR REPLACE PROCEDURE Borrow_Book(i_card_id IN NUMBER, i_book_id IN NUMBER)
IS
	v_available NUMBER;
	v_active NUMBER;
   
BEGIN
	SELECT COUNT(1) INTO v_active FROM Card WHERE status = 'ACTIVE' AND card_id = i_card_id;
	IF v_active > 0 THEN SELECT COUNT(1) INTO v_available FROM Book WHERE status = 'AVAILABLE' AND Book_ID = i_book_id;
	IF v_available > 0 THEN
			INSERT INTO Rental(Card_ID, Book_ID, Rent_Date, Due_Date, Return_Date) VALUES (i_card_id, i_book_id, SYSDATE, SYSDATE + 15, NULL);
			DBMS_OUTPUT.PUT_LINE ('The book number ' || i_book_id || ' is borrowed for card ' || i_card_id );

	ELSE
	DBMS_OUTPUT.PUT_LINE ('The book number ' || i_book_id || ' not available');
	
	END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('The card number ' || i_card_id || ' innactive');
		
	END IF;
--COMMIT;
END Borrow_Book;
.
/