DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;
        
    -- 1. Populate the Employee table using an insert, use the corresponding job titleID for a delivery employee
     INSERT INTO Employee (EmployeeID, EmployeeFistName, EmployeeSurname, Salary, BankAccountNumber, NationalInsuranceNumber, JobTitleID) 
     VALUES ( , '', '', , , , );
    
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