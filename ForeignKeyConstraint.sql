DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction()
BEGIN
	START TRANSACTION;
    
    ALTER TABLE Employee
	ADD CONSTRAINT fk_Employee_JobTitleID
	FOREIGN KEY(JobTitleID)
	REFERENCES JobTitle(JobTitleID);
    
    ALTER TABLE SalesEmployee
	ADD CONSTRAINT fk_SalesEmployee_EmployeeID
	FOREIGN KEY(EmployeeID)
	REFERENCES Employee(EmployeeID);
    
    ALTER TABLE DeliveryProject
	ADD CONSTRAINT fk_DeliveryProject_EmployeeID
	FOREIGN KEY(EmployeeID)
	REFERENCES Employee(EmployeeID);
    
    ALTER TABLE DeliveryProject
	ADD CONSTRAINT fk_DeliveryProject_ProjectID
	FOREIGN KEY(ProjectID)
	REFERENCES Project(ProjectID);
    
    ALTER TABLE `Client`
	ADD CONSTRAINT fk_Client_EmployeeID
	FOREIGN KEY(EmployeeID)
	REFERENCES Employee(EmployeeID);
    
    ALTER TABLE Project
	ADD CONSTRAINT fk_Project_ClientID
	FOREIGN KEY(ClientID)
	REFERENCES `Client`(ClientID);
    
    ALTER TABLE ProjectTechnology
	ADD CONSTRAINT fk_ProjectTechnology_ProjectID
	FOREIGN KEY(ProjectID)
	REFERENCES Project(ProjectID);
    
    ALTER TABLE ProjectTechnology
	ADD CONSTRAINT fk_ProjectTechnology_TechnologyID
	FOREIGN KEY(TechnologyID)
	REFERENCES Technology(TechnologyID);
    
END $$
DELIMITER ;
CALL my_transaction();