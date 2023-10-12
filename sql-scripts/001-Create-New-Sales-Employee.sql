DELIMITER $$
DROP PROCEDURE IF EXISTS my_sales_employee_transaction $$
CREATE PROCEDURE my_sales_employee_transaction()
BEGIN

	START TRANSACTION;
    
    CREATE TABLE JobTitle
	(
		JobTitleID TINYINT PRIMARY KEY AUTO_INCREMENT,
		JobTitleName VARCHAR (20)
	);
    
	CREATE TABLE Employee
	(	
		EmployeeID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
		EmployeeFirstName VARCHAR(20),
		EmployeeSurname VARCHAR(20),
		Salary DECIMAL(10,2),
		BankAccountNo VARCHAR(64),
		NationalInsuranceNo VARCHAR(64),
		JobTitleID TINYINT,
        
        CONSTRAINT fk_Employee_JobTitleID
		FOREIGN KEY(JobTitleID)
		REFERENCES JobTitle(JobTitleID)
        
	);

	CREATE TABLE SalesEmployee
	(
    
		EmployeeID SMALLINT UNSIGNED,
		CommissionRate DECIMAL (4, 4),
		
        PRIMARY KEY(EmployeeID, CommissionRate)
		
	);
    
	-- As a member of the HR team I want to be able to create a new sales employee. 
    -- I should be able to store a name, salary, bank account number, national insurance number and commission rate
    
    -- Populate JobTitleTable
    
    INSERT INTO JobTitle(JobTitleName)
    VALUES ("Sales");
    
    INSERT INTO JobTitle(JobTitleName)
    VALUES ("Delivery");
    
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
    
    -- 1. Populate the Employee table using an insert
     INSERT INTO Employee (EmployeeFirstName, EmployeeSurname, Salary, BankAccountNo, NationalInsuranceNo, JobTitleID) 
     VALUES ('Darragh', 'Haughey', 300000.00, "12345678-01-02-03", "AB123456C", 1);
    
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
    INSERT INTO SalesEmployee (CommissionRate) 
	VALUES (0.2);
    
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
CALL my_sales_employee_transaction();