DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;

-- Sample data to assign a client (client_id = 1) to a project (project_id = 1)
UPDATE Projects
SET client_id = 1
WHERE project_id = 1;


END $$
DELIMITER ;
CALL my_transaction();