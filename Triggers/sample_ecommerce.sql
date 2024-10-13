
CREATE DATABASE sample_ecommerce;
USE sample_ecommerce;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATETIME,
    status ENUM('pending', 'completed', 'canceled')
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT
);

CREATE TABLE payments (
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME,
    status ENUM('pending','completed')
);

DELIMITER $$
CREATE TRIGGER after_order_insert
AFTER  INSERT ON  orders
FOR EACH ROW
BEGIN
	DECLARE available_stock INT;
    SELECT stock_quantity INTO available_stock
    FROM inventory
    WHERE product_id = NEW.product_id;
     IF available_stock IS NOT NULL AND available_stock >= NEW.quantity THEN
		UPDATE  inventory
		SET  stock_quantity=stock_quantity-NEW.quantity
		WHERE  product_id=NEW.product_id;
     ELSE
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT= 'Insufficient stock for the product';
     END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER update_on_successful_payment
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
	IF NEW.status='completed' THEN
		UPDATE orders
        SET status='completed'
        WHERE order_id = NEW.order_id;
	END IF;
END$$
DELIMITER ;

INSERT INTO payments (order_id, amount, payment_date, status)
VALUES(4, 100, now(), 'completed');


INSERT INTO inventory (product_id,stock_quantity)
values(1,56),
		(2,78),
		(5,00);
        
INSERT INTO orders (product_id, quantity, order_date, status)
Values (1, 10, NOW(), 'pending');


