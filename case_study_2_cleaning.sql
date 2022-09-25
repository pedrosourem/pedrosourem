-- Before answering questions, the datasets need to be clean.
	# Changing data types:
		-- 1. runner_orders table:
			# The data types cannot be changed while having null strings and blank cells. Let's update them with NULLs:
			UPDATE runner_orders
			SET 
			pickup_time = CASE WHEN pickup_time = 'null' OR pickup_time = '' THEN NULL ELSE pickup_time END,
			distance = CASE WHEN distance = 'null' OR distance = '' THEN NULL ELSE distance END,
			duration = CASE WHEN duration = 'null' OR duration = '' THEN NULL ELSE duration END,
			cancellation = CASE WHEN cancellation = 'null' OR cancellation = '' THEN NULL ELSE cancellation END;

			-- Now the data type can be altered. 
			# Modifying the order_id and runner_id to smallint data type to reduce the memory usage
            # and pickup_time to TIMESTAMP:
            ALTER TABLE runner_orders
			MODIFY COLUMN order_id SMALLINT,
			MODIFY COLUMN runner_id SMALLINT,
			MODIFY COLUMN pickup_time TIMESTAMP;
            
            # Modifying distance and duration columns data types:
            -- The distance column contains "km" measure unit included. Let's remove it from the cells.
            UPDATE runner_orders
            SET 
				distance = CASE WHEN distance LIKE '%km' THEN TRIM('km' FROM distance) ELSE distance END,
				duration = CASE WHEN duration LIKE '%min%' THEN TRIM('mins' FROM duration) ELSE duration END,
                duration = CASE WHEN duration LIKE '%min%' THEN TRIM('minute' FROM duration) ELSE duration END,
                duration = CASE WHEN duration LIKE '%min%' THEN TRIM('minutes' FROM duration) ELSE duration END;
            
            -- Changing the distance column data type to float with values with 1 decimal order
            -- and duration data type to smallint.
            ALTER TABLE runner_orders
            MODIFY COLUMN distance FLOAT(3, 1),
            MODIFY COLUMN duration SMALLINT;
            
            
		-- 2. customer_orders table:
			# Replacing null texts and empty cells to NULL values from exclusions and extras columns.
            UPDATE customer_orders
            SET 
				exclusions = CASE WHEN exclusions LIKE 'null' OR exclusions LIKE '' THEN NULL ELSE exclusions END,
				extras = CASE WHEN extras LIKE 'null' OR extras LIKE '' THEN NULL ELSE extras END;
            
            # Modifying data type to smallint on columns order_id, customer_id, and tinyint on column pizza_id:
            ALTER TABLE customer_orders
            MODIFY COLUMN order_id SMALLINT,
            MODIFY COLUMN customer_id SMALLINT,
            MODIFY COLUMN pizza_id TINYINT;