DELIMITER $$
DROP PROCEDURE IF EXISTS my_transaction $$
CREATE PROCEDURE my_transaction ()
BEGIN
	START TRANSACTION;

-- Getting client with max project value

-- GRANT PERMISSION to 'SalesEmployees'

SELECT
    Client.ClientID,
    CONCAT(Client.ClientFirstName, ' ', Client.ClientSurname) AS ClientName,
    SUM(Project.ProjectValue) AS TotalProjectValue
FROM
    Clients
LEFT JOIN
    Projects ON Client.ClientID = Project.ClientID
GROUP BY
    Client.ClientID, ClientName
ORDER BY
    TotalProjectValue ASC

LIMIT 1

END $$
DELIMITER ;
CALL my_transaction();