DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;
        

       -- As a member of the Management team I want to be able to remove a delivery employee from a project. 
       -- A record should be retained to show that person worked on that project at some point


    -- 1. Remove delivery employee from a project (Update the active status to false/0)
             UPDATE DeliveryProject 
             SET Active = 0
             WHERE EmployeeID =
             AND
             WHERE ProjectID = ; 
    
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