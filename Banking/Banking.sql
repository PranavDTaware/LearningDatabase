CREATE DATABASE banking;
use banking;

CREATE TABLE customers (
	cust_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    registration_date DATETIME
);

INSERT INTO customers(full_name, registration_date)
VALUES	('Pranav Taware', now()),
		('Raju Patil', now()),
        ('Sunil Kale', now()),
        ('Ganesh More', now());

CREATE TABLE accounts (
	acct_id INT AUTO_INCREMENT PRIMARY KEY,
	cust_id INT ,
    created_on DATETIME,
    account_type ENUM ('current','saving'),
    balance DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_cust_id FOREIGN KEY (cust_id) REFERENCES customers(cust_id) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE operations(
	operation_id INT AUTO_INCREMENT PRIMARY KEY,
    acct_id int,
    amount DECIMAL(10,2) NOT NULL,
    operations_date DATETIME,
    operations_type ENUM ('W','D'),
	CONSTRAINT fk_acct_id FOREIGN KEY (acct_id) REFERENCES accounts(acct_id) 
		ON UPDATE CASCADE 
		ON DELETE CASCADE
);

CREATE TABLE log (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    time_stamp DATETIME,
    operation_id INT, 
    status ENUM ('completed'),
    CONSTRAINT fk_operations_id FOREIGN KEY (operation_id) REFERENCES operations(operation_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE 
);


DELIMITER $$

CREATE TRIGGER customer_insert
AFTER INSERT  ON customers
FOR EACH ROW 
BEGIN
	DECLARE new_acctid INT;
    DECLARE new_operationid INT;
    
	INSERT INTO customers(full_name, registration_date)
    VALUES(NEW.full_name, now());
    
    INSERT INTO accounts(cust_id, created_on, account_type, balance)
    VALUES (NEW.cust_id, now(), 'saving', 15000);
    
    SET new_acctid = LAST_INSERT_ID();
    
    INSERT INTO operations (acct_id, amount, operations_date, operations_type)
    VALUES (new_acctid, 15000.00, NOW(), 'deposit');
    
    SET new_operationid = LAST_INSERT_ID();
    
    INSERT INTO log (time_stamp, operation_id, status)
    VALUES (now(), new_operationid, 'completed');
    
END $$

DELIMITER ;


INSERT INTO customers(full_name, registration_date)
VALUES ('Aditya Dagade', now());

DELETE FROM customers	
WHERE cust_id = 9;
