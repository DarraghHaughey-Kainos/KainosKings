DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;

-- Getting average value

-- GRANT PERMISSION to 'SalesEmployees'

SELECT
    Client.ClientID,
    CONCAT(Client.ClientFirstName, ' ', Client.ClientSurname) AS ClientName,
    AVG(Project.ProjectValue) AS AverageProjectValue
FROM
    Client
LEFT JOIN
    Project ON Client.ClientID = Project.ClientID
GROUP BY
    Client.ClientID, ClientName;

END $$
DELIMITER ;
CALL my_transaction();
