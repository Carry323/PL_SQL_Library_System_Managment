CREATE OR REPLACE PACKAGE BODY MANAGE_BOOKS
AS
	PROCEDURE ADD_BOOK (i_book_id IN NUMBER, i_title IN VARCHAR2, i_category IN VARCHAR2, i_cost IN NUMBER)
	AS
	BEGIN
		INSERT INTO Book (Book_ID, Title, Category, Status, Lost_Cost) 
		VALUES (i_book_id, i_title, i_category, 'AVAILABLE', i_cost);
		DBMS_OUTPUT.PUT_LINE ('The book number number ' || i_book_id || ' was added');
		--COMMIT;
	END;
------------------------------------------------
	PROCEDURE REMOVE_BOOK (i_book_id IN NUMBER)
	AS
	BEGIN
		DELETE FROM Book WHERE Book_ID = i_book_id;
        IF SQL%ROWCOUNT = 0 THEN
		DBMS_OUTPUT.PUT_LINE('No rows deleted');	
		END IF;
		DBMS_OUTPUT.PUT_LINE ('The book number ' || i_book_id || ' was deleted');
		--COMMIT;
	END;
------------------------------------------------
	PROCEDURE LIST_ALL_BOOKS (i_status IN VARCHAR2)
	AS
		CURSOR c_list IS
			SELECT * FROM Book WHERE Status = i_status;
	BEGIN
		FOR I IN c_list
		LOOP
			DBMS_OUTPUT.PUT_LINE ('Book ID, ' || I.Book_ID || ' Title, ' || I.Title || 'Category, ' || I.Category || 'Status, ' || I.Status || ' Lost cost, ' || I.Lost_Cost);
			DBMS_OUTPUT.PUT_LINE (CHR (10));
		END LOOP;
		--COMMIT;
	END;
------------------------------------------------
	PROCEDURE UPDATE_BOOK_STATUS (i_book_id IN NUMBER, i_status IN VARCHAR2)
	AS
	BEGIN
		UPDATE Book SET Status = i_status WHERE Book_ID = i_book_id;
		DBMS_OUTPUT.PUT_LINE ('The book number ' || i_book_id || ' was updated');
		--COMMIT;
	END;
------------------------------------------------
   FUNCTION GET_BOOK_STATUS (i_book_id IN NUMBER) RETURN VARCHAR2
	AS
      v_status VARCHAR2 (20);
	BEGIN
		SELECT Status INTO v_status FROM Book WHERE Book_ID = i_book_id;
			RETURN v_status;
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Book is not found.');
			RETURN v_status;
   --COMMIT;
   END;
END MANAGE_BOOKS;
.
/