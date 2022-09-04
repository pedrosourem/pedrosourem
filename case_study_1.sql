-- CASE STUDY #1 - DANNY'S DINER

-- Creating a table with information from all 3 tables.
CREATE TABLE order_tbl 
AS (SELECT customer_id, t.join_date, order_date, t.product_id, product_name, price
	FROM (SELECT s.customer_id, order_date, product_id, join_date
		  FROM sales AS s
	      LEFT JOIN members AS m1
		  ON s.customer_id = m1.customer_id) AS t
		  LEFT JOIN menu AS m2
		  ON t.product_id = m2.product_id);
-- QUESTIONS:          
-- 1. What is the total amount each customer spent at the restaurant?
SELECT customer_id, sum(price) AS total_spent
FROM order_tbl
group by customer_id;

# Customers with membership (A and B) spend more money than non-members (C). 
# Customers A and B spent 76 and 74,respectively, and customer C spent only 36.

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT(order_date)) AS days
FROM sales
GROUP BY customer_id;

# As expected, customers with membership (A and B) visit the restaurant more often than non-members (C). 

-- 3. What was the first item from the menu purchased by each customer?
WITH added_row_number AS (
						 SELECT customer_id, order_date, product_name,
								ROW_NUMBER() OVER(PARTITION BY customer_id) as rn
						 FROM order_tbl)		-- Table counting the order of products by customer
SELECT customer_id, order_date, product_name
FROM added_row_number
WHERE rn=1;

# Customers picked different items in their first orders.

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers? 
SELECT product_name, COUNT(*) AS quantity_purchased
FROM order_tbl
GROUP BY product_name
ORDER BY quantity_purchased DESC
LIMIT 1;

# Ramen was the most purchased item on the menu.

WITH cte AS (SELECT customer_id, order_tbl.product_name, 
				    ROW_NUMBER() OVER(PARTITION BY customer_id) AS quantity_purchased
			 FROM order_tbl
			 RIGHT JOIN (SELECT product_name, COUNT(*) AS quantity_purchased
						 FROM order_tbl
						 GROUP BY product_name
						 ORDER BY quantity_purchased DESC
						 LIMIT 1) AS t -- Most purchased product
			 ON order_tbl.product_name = t.product_name) -- Joining with order_tbl to get sales only for the most purchased product
SELECT customer_id, MAX(quantity_purchased) AS ramen_quantity_purchased
FROM cte
GROUP BY customer_id;

# Customers A and C bought ordered it 3 times and customer B 2 times.

-- 5. Which item was the most popular for each customer?
WITH cte AS(SELECT customer_id, product_name, COUNT(*) AS quantity_purchased
			FROM order_tbl
			GROUP BY customer_id, product_name)
SELECT customer_id, product_name, MAX(quantity_purchased) 
FROM cte
GROUP BY customer_id;

# Sushi was the most popular item for customer A, curry for customer B and ramen for customer C.

-- 6. Which item was purchased first by the customer after they became a member?
WITH first_item AS (WITH order_as_member AS (
											SELECT customer_id, join_date, order_date, product_name
											FROM order_tbl
											WHERE (CASE WHEN order_date > join_date THEN 1 ELSE 0 END)=1) 
				    SELECT *,
		            ROW_NUMBER() OVER(PARTITION BY customer_id) AS RN
		            FROM order_as_member)
SELECT customer_id, join_date, order_date, product_name
FROM first_item
WHERE RN = 1;

# After becoming a member customer A ordered ramen and customer B ordered sushi.

-- 7. Which item was purchased just before the customer became a member?
SELECT customer_id, join_date, order_date, product_name
FROM order_tbl
WHERE (CASE WHEN order_date < join_date THEN 1 ELSE 0 END) = 1
GROUP BY customer_id, product_name;

# Before being a member, customers A and B had both ordered sushi and curry.

-- 8. What is the total items and amount spent for each member before they became a member?
WITH CTE AS (SELECT *,
			COUNT(product_name) AS unit,
			price*COUNT(product_name) AS total_per_item
			FROM (        
				  SELECT customer_id, join_date, order_date, product_name, price
				  FROM order_tbl
				  WHERE (CASE WHEN order_date < join_date THEN 1 ELSE 0 END) = 1 -- orders before becoming members
				  ) AS order_not_members 
			GROUP BY customer_id, product_name) --  cte with number of units and total spent per item
SELECT customer_id, SUM(unit), SUM(total_per_item) AS total_spent_before_membership
FROM cte
GROUP BY customer_id; -- total spent by customers before becoming members

# Customer A ordered 2 items and spent a total of 25, 
# and customer B ordered 3 items and spent a total of 40 before being members.

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - 
-- how many points would each customer have?
WITH cte AS (SELECT customer_id, product_name, COUNT(*) AS unit, price,
					COUNT(*)*price as total_price,
					(CASE WHEN product_name = 'sushi' THEN COUNT(*)*price*20
					ELSE (COUNT(*)*price*10) END) points
			FROM order_tbl
            GROUP BY customer_id, product_name) -- total points per item
SELECT customer_id, SUM(points)
FROM cte
GROUP BY customer_id; -- total points per customer

# Customers with membership (A,860 points and B, 940 points) had a considerable higher amount of points than
# non-members (C, 360).

-- 10. In the first week after a customer joins the program 
-- (including their join date) they earn 2x points on all items, not just sushi - 
-- how many points do customer A and B have at the end of January?
WITH cte AS (SELECT customer_id, order_date, product_name, COUNT(*) AS unit, price,
					COUNT(*)*price as total_price,
                    WEEK(order_date) - WEEK(join_date) AS weeks_after_joining,
					(CASE WHEN product_name = 'sushi' OR 
							   WEEK(order_date) - WEEK(join_date) = 1 THEN COUNT(*)*price*20
						  ELSE (COUNT(*)*price*10) END) points
			FROM order_tbl
            WHERE MONTH(order_date) = 1
            GROUP BY customer_id, product_name)
SELECT customer_id, SUM(points) AS points_earned
FROM cte
WHERE customer_id = "A" OR customer_id = "B"
GROUP BY customer_id;

# In this case, Customer A had more points than customer B in the month of January.