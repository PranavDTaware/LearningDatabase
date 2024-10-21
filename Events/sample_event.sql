CREATE DATABASE IF NOT EXISTS mydb;

USE mydb;

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW()
);


-- 1) Creating a one-time event example
CREATE EVENT IF NOT EXISTS one_time_log
ON SCHEDULE AT CURRENT_TIMESTAMP
DO
  INSERT INTO messages(message)
  VALUES('One-time event');
  
-- one-time event that is executed after its creation time of 1 minute 
CREATE EVENT one_time_log
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
   INSERT INTO messages(message)
   VALUES('Preserved One-time event');

-- 2) Creating a recurring event example
   
CREATE EVENT recurring_log
ON SCHEDULE EVERY 10 SECOND
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
   INSERT INTO messages(message)
   VALUES(CONCAT('Running at ', NOW()));
   
   
SELECT * FROM messages;

SHOW EVENTS FROM mydb;