DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;
    
    -- As a member of the HR team I want to be able to create a new sales employee. 
    -- I should be able to store a name, salary, bank account number, national insurance number and commission rate
    
    
    -- 1. Populate the Employee table using an insert
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
     
     
    -- 2. The employee exists and their comission can be exclusively applied to them in the SalesEmployee table
    INSERT INTO SalesEmployee (EmployeeID, CommissionRate) 
     VALUES ( , );
    
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