DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;
        

       -- As a member of the Management team I want to be able to set a project as completed. 
       -- Completed projects shouldn't be included in any of the lists


    -- GRANT(Management Team)

    -- 1. Set Project as complete 
             UPDATE project
             Set IsCompleted = 1
             WHERE ProjectID = ProjectID
    
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