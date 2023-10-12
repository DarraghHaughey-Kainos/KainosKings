DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;
        

       -- As a member of the Sales team I want to see a list of clients, 
       -- the name of the sales employee who works with that client and the list of projects that the client has


    -- GRANT(Sales Team)


    -- 1. See the list of clients
             Select ClientName as 'Client List', CONCAT(EmployeeFirstName, ' ', EmployeeSurname) as 'Sales Employee'
             From Clients;
             JOIN Employee USING (EmployeeID)
             WHERE JobTitleID is 'ENTER (SALES) JobTitleID'
             UNION
             Select ProjectName as 'List of Client Projects', ClientName as 'Client'
             From Clients 
             JOIN Project USING (ClientID)
             WHERE ClientID is 'ENTER ClientID'
    
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