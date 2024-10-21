use tflecommerce;
DELIMITER $$

CREATE PROCEDURE my_procedure()
BEGIN
    INSERT INTO users (username, password, email, address)
    VALUES ('Hemant_thorat', 'htpassword', 'hthorat@gmail.com', 'Thergaon');
END $$

DELIMITER ;

SHOW VARIABLES LIKE 'event_scheduler';
	SET GLOBAL event_scheduler = ON;
    
    DROP EVENT my_event;
    
    CREATE EVENT my_event
	ON SCHEDULE AT '2024-10-18 13:06:00'
	DO
		CALL my_procedure();
        
SHOW EVENTS;