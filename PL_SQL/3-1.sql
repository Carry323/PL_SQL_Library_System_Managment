CREATE OR REPLACE PROCEDURE Automatic_renewal(i_card_id IN NUMBER, i_book_id IN NUMBER)
IS
	v_reserved NUMBER;
	v_active NUMBER;
	v_available NUMBER;
	v_due_date NUMBER;
	v_returned NUMBER;
	
BEGIN
	SELECT COUNT(1) INTO v_reserved FROM Reservation WHERE Book_ID = i_book_id AND Card_ID != i_card_id;

	IF v_reserved = 0 THEN 	SELECT COUNT(1) INTO v_active FROM Card WHERE status = 'ACTIVE' AND Card_ID = i_card_id;

	IF v_active > 0 THEN SELECT COUNT(1) INTO v_available FROM Book WHERE status = 'AVAILABLE' AND Book_ID = i_book_id;

	IF v_available > 0 THEN SELECT COUNT(1) INTO v_due_date FROM Rental WHERE Card_ID = i_card_id AND Book_ID = i_book_id AND 
		TO_DATE (TO_CHAR (Due_Date, 'DD-Mon-YYYY')) < TO_DATE (TO_CHAR (SYSDATE, 'DD-Mon-YYYY'));
			   
	IF v_due_date = 0 THEN SELECT COUNT(1) INTO v_returned FROM Rental WHERE Card_ID = i_card_id AND Book_ID = i_book_id AND Return_Date IS NULL;

	IF v_returned = 0 THEN INSERT INTO Rental (Card_ID, Book_ID, Rent_Date, Due_Date, Return_Date) VALUES (i_card_id, i_book_id, SYSDATE, SYSDATE + 15, NULL);

				DBMS_OUTPUT.PUT_LINE ('The book number ' || i_book_id || ' is used by your card' );
                DBMS_OUTPUT.PUT_LINE ('This book has been inserted in rental table.');

	ELSE
		DBMS_OUTPUT.PUT_LINE ('The automatic renewal is not allowed after return the book');
	END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('The automatic renewal is not allowed after the Due Date');
	END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('The book number '|| i_book_id ||' is not available');
	END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('The card number '|| i_card_id ||' is not active');
	END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('The book number '|| i_book_id ||' is already reserved');
	END IF;
	--COMMIT;
END AUTOMATIC_RENEWAL;
/