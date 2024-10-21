DELIMITER $$
	CREATE PROCEDURE apply_discount()
	BEGIN
    
    -- Declare variables
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE order_id INT;
    DECLARE amount_total DECIMAL(10, 2);

	-- Declare a cursor for selecting orders with total_amount >100
	DECLARE order_cursor  CURSOR FOR
	SELECT id, total_amount
	FROM orders
	WHERE total_amount >100;

	-- Delcare a continue handler to set done  to TRUE , when there are no more rows
	DECLARE CONTINUE HANDLER  FOR NOT FOUND  SET done = TRUE;
	
	-- Open the cursor
	OPEN order_cursor;

	-- Loop through the rows of curosor

	read_loop:LOOP
		FETCH order_cursor  INTO  order_id , amount_total;
		IF done THEN
			LEAVE read_loop;
		END IF;

		-- Apply a 10 % discount
		UPDATE  orders
		SET  total_amount = amount_total * 0.90
		WHERE id = order_id;
	END LOOP;
	CLOSE order_cursor;

	END $$

DELIMITER ;

DROP PROCEDURE apply_discount;

CALL apply_discount();

SELECT * FROM orders WHERE total_amount > 100;