SELECT * from customers;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT*FROM products;
END //

DELIMITER ;

CALL GetAllPRoducts;

CALL getordercountbystatus('shipped', @total);
SELECT @total;

DROP PROCEDURE IF EXISTS getemployees;

SHOW PROCEDURE STATUS;

SELECT 
    customerNumber, 
    creditLimit
FROM 
    customers
WHERE 
    creditLimit > 50000
ORDER BY 
    creditLimit DESC;
    
CALL getcustomerlevel (141, @sp_customerlevel);
SELECT @sp_customerlevel AS level;

-------------------------------------------------------------------

-- SHOW WARNINGS

SELECT 
    DATE_SUB('2017-02-29', INTERVAL - 1 DAY) d1,
    DATE_SUB('2017-12-32', INTERVAL + 2 DAY) d2,
    DATE_SUB('2017-15-03', INTERVAL + 5 DAY) d3;

SHOW WARNINGS;

SHOW WARNINGS LIMIT 1;
SHOW COUNT(*) WARNINGS;

------------------------------------------------------------------

-- SHOW ERRORS

SELECT id FROM products;

SHOW ERRORS;

SHOW COUNT(*) ERRORS;
-- or
SELECT @@error_count;