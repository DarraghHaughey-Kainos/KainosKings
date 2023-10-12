DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;


INSERT INTO Clients (ClientFirstName, ClientSurname, ClientAddress, ClientPhoneNumber, EmployeeID)
VALUES ('Jonny', 'Evans', '4-6 Upper Crescent', '01234', 1);



	-- check the number of affected rows
	GET DIAGNOSTICS @rows = ROW_COUNT;
	IF @rows = 0 THEN
		-- if an error occurred rollback the transaction
		ROLLBACK;
		SELECT 'Transaction rolled back due to error.';
	ELSE
		--  If no error occurred, commit transaction
		COMMIT;
		SELECT 'Transaction committed successfully';
	 END IF;
END $$
DELIMITER ;
CALL my_transaction();