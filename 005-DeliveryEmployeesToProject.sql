DELIMITER $$
DROP PROCEDURE IF EXISTS my_delivery_project_transaction $$
CREATE PROCEDURE my_delivery_project_transaction ()
BEGIN
	START TRANSACTION;

	CREATE TABLE DeliveryProject
	(
		DeliveryProjectID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		TechLead BOOLEAN,
		ActiveOnProject BOOLEAN,
		EmployeeID SMALLINT UNSIGNED,
		ProjectID SMALLINT UNSIGNED,
        
        CONSTRAINT fk_DeliveryProject_EmployeeID
		FOREIGN KEY(EmployeeID)
		REFERENCES Employee(EmployeeID),
        
        CONSTRAINT fk_DeliveryProject_ProjectID
		FOREIGN KEY(ProjectID)
		REFERENCES Project(ProjectID)
	);
    
	-- Sample data to assign a delivery employee (employee_id = 1) to a project (project_id = 1)
	INSERT INTO DeliveryEmployeeProjects (delivery_employee_id, project_id)
	VALUES (1, 1);

	-- Sample data to assign the same delivery employee (employee_id = 1) to the same project (project_id = 1) again
	INSERT INTO DeliveryEmployeeProjects (delivery_employee_id, project_id)
	VALUES (1, 1);

	-- Sample data to assign a different delivery employee (employee_id = 2) to a different project (project_id = 2)
	INSERT INTO DeliveryEmployeeProjects (delivery_employee_id, project_id)
	VALUES (2, 2);

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