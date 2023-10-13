DELIMITER $$
DROP PROCEDURE IF EXISTS my_delivery_employee_transaction $$
CREATE PROCEDURE my_delivery_employee_transaction ()
BEGIN
	START TRANSACTION;
	-- Grant Access
        
    -- 1. Populate the Employee table using an insert, use the corresponding job titleID for a delivery employee
     INSERT INTO Employee (EmployeeFirstName, EmployeeSurname, Salary, BankAccountNo, NationalInsuranceNo, JobTitleID) 
     VALUES ('Jonathan', 'Evans', 35000.00, "2345678901", "CD123456E", 2);
    

	SELECT * FROM Employee
	WHERE JobTitleID = 2;


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
CALL my_delivery_employee_transaction();