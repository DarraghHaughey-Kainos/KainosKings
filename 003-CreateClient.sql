DELIMITER $$
DROP PROCEDURE IF EXISTS my_client_transaction $$
CREATE PROCEDURE my_client_transaction()
BEGIN
	START TRANSACTION;

	CREATE TABLE `Client`
	(
		ClientID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		ClientFirstName VARCHAR(20),
		ClientSurname VARCHAR(20),
		ClientAddress TEXT,
        ClientPhoneNumber VARCHAR(20),
		EmployeeID SMALLINT UNSIGNED
	);
    
    ALTER TABLE `Client`
	ADD CONSTRAINT fk_Client_EmployeeID
	FOREIGN KEY(EmployeeID)
	REFERENCES Employee(EmployeeID);
    
	INSERT INTO `Client`(ClientFirstName, ClientSurname, ClientAddress, ClientPhoneNumber, EmployeeID)
	VALUES ('Giuseppe', 'Lupari', '4-6 Upper Crescent', '01234', 1);

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
CALL my_client_transaction();