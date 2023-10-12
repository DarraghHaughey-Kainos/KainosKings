DELIMITER $$
DROP PROCEDURE IF EXISTS my_project_transaction $$
CREATE PROCEDURE my_project_transaction ()
BEGIN
	START TRANSACTION;
    
    CREATE TABLE Project
	(
		ProjectID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		ProjectName VARCHAR(50),
		ProjectValue DECIMAL(10,2),
		IsCompleted BOOLEAN,
		ClientID SMALLINT UNSIGNED
	);
    
    ALTER TABLE Project
	ADD CONSTRAINT fk_Project_ClientID
	FOREIGN KEY(ClientID)
	REFERENCES `Client`(ClientID);
    
  -- As a member of the Sales team I want to be able to create a new project. 
  -- I should be able to store a project name, value and a list of technologies that the project will use
    
    -- 1. Populate the project table 
     INSERT INTO Project (ProjectName, ProjectValue, IsCompleted, ClientID) 
     VALUES ("Databases", 1000000.00, 0, 1);
    
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
    
    CREATE TABLE Technology
	(
		TechnologyID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		TechnologyName VARCHAR(20)
	);
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Java");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Javascript");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("MySQL");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Typescript");
    
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
    
    CREATE TABLE ProjectTechnology
	(
		ProjectTechnology SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		ProjectID SMALLINT UNSIGNED,
		TechnologyID SMALLINT UNSIGNED
	);
    
    ALTER TABLE ProjectTechnology
	ADD CONSTRAINT fk_ProjectTechnology_ProjectID
	FOREIGN KEY(ProjectID)
	REFERENCES Project(ProjectID);
    
    ALTER TABLE ProjectTechnology
	ADD CONSTRAINT fk_ProjectTechnology_TechnologyID
	FOREIGN KEY(TechnologyID)
	REFERENCES Technology(TechnologyID);
    
    -- 2. Populate the ProjectTechnoloies with the ProjectID
    INSERT INTO ProjectTechnology(ProjectID, TechnologyID) 
	VALUES (1, 1);
    
    INSERT INTO ProjectTechnology(ProjectID, TechnologyID) 
	VALUES (1, 2);
    
    INSERT INTO ProjectTechnology(ProjectID, TechnologyID) 
	VALUES (1, 3);

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
CALL my_project_transaction();