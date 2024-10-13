CREATE database HRDB;
use HRDB;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER update_last_updated
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
SET NEW.last_updated = current_timestamp();
END;
//
 
CREATE TRIGGER update_last_updated_on_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

INSERT INTO employees (name, department) VALUES ('Ravi Tambade', 'training');
INSERT INTO employees (name, department) VALUES ('Sunil Patil', 'HR');
INSERT INTO employees (name, department) VALUES ('Kunal Kumar', 'Accounts');

UPDATE employees  SET department='accounts' WHERE id=3;
