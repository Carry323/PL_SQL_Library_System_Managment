SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
	v_book_id NUMBER := &sv_book_id;
--ACCEPT sv_book_id  NUMBER PROMPT 'Enter book ID, please';
	v_status VARCHAR2(15);

BEGIN
--COMMIT;
DBMS_OUTPUT.PUT_LINE('NEW BOOK: ');
MANAGE_BOOKS.ADD_BOOK(1234, 'Harry Potter', 'Philosopher`s stone', 37);

DBMS_OUTPUT.PUT_LINE('UPDATE STATUS: ');
MANAGE_BOOKS.UPDATE_BOOK_STATUS(1234, 'LOST');

v_status := MANAGE_BOOKS.GET_BOOK_STATUS(v_book_id);
DBMS_OUTPUT.PUT_LINE('STATUS OF THE BOOK: '|| v_status);

DBMS_OUTPUT.PUT_LINE('DELETE BOOK: ');
MANAGE_BOOKS.REMOVE_BOOK(1234);

DBMS_OUTPUT.PUT_LINE('LIST OF BOOKS: ');
MANAGE_BOOKS.LIST_ALL_BOOKS('AVAILABLE');

--COMMIT;

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;

END;
.
/