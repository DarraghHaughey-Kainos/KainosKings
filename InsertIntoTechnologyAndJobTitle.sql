DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction()
BEGIN
	START TRANSACTION;
    
    INSERT INTO JobTitle(JobTitleName)
    VALUES ("Sales");
    
    INSERT INTO JobTitle(JobTitleName)
    VALUES ("Delivery");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Java");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Javascript");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("MySQL");
    
    INSERT INTO Technology(TechnologyName)
    VALUES ("Typescript");
    
END $$
DELIMITER ;
CALL my_transaction();