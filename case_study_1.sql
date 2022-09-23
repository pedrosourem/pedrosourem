-- CASE STUDY #1 - DANNY'S DINER

-- Creating a table with information from all 3 tables.
DROP TABLE IF EXISTS order_tbl;
CREATE TEMPORARY TABLE order_tbl 
SELECT s.customer_id, 
	   s.order_date, 
	   s.product_id,
	   m1.join_date,
	   m2.product_name,
	   m2.price
FROM sales AS s
LEFT JOIN members AS m1
ON s.customer_id = m1.customer_id
LEFT JOIN menu AS m2
ON s.product_id = m2.product_id;

-- QUESTIONS:          
-- 1. What is the total amount each customer spent at the restaurant?
SELECT customer_id, 
	   SUM(price) AS total_spent
FROM order_tbl
GROUP BY customer_id;

# Customers with membership (A and B) spent more money than non-members (C). 
# Customers A and B spent 76 and 74,respectively, and customer C spent only 36.

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, 
	   COUNT(DISTINCT(order_date)) AS days
FROM sales
GROUP BY customer_id;

# As expected, customers with membership (A and B) visit the restaurant more often than non-members (C). 

-- 3. What was the first item from the menu purchased by each customer?
WITH CTE AS 
	(SELECT customer_id, 
			order_date, 
			product_name,
			DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS ranking
	 FROM order_tbl) -- Table counting the order of products by customer
SELECT customer_id,
	   order_date, 
       product_name
FROM CTE
WHERE ranking=1
GROUP BY customer_id, product_name;

# Customers picked different items in their first orders.

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers? 
SELECT product_name, 
	   COUNT(*) AS quantity_purchased
FROM order_tbl
GROUP BY product_name
ORDER BY quantity_purchased DESC
LIMIT 1;

# Ramen was the most purchased item on the menu.

-- 5. Which item was the most popular for each customer?
WITH CTE AS 
	(SELECT customer_id, 
				product_name, 
				COUNT(product_id) AS quantity_ordered,
				RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS ranking
	 FROM order_tbl
	 GROUP BY customer_id, product_id
	 ORDER BY customer_id, ranking)
SELECT customer_id, 
	   product_name,
       quantity_ordered
FROM CTE
WHERE ranking = 1;

# Ramen was the most popular item for customer A (3 times), curry, sushi and ramen for customer B (2 times each) 
# and ramen for customer C (3 times).

-- 6. Which item was purchased first by the customer after they became a member?
WITH CTE AS
	(SELECT customer_id,
		   order_date,
		   product_name,
		   DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS ranking
	FROM order_tbl
	WHERE join_date <= order_date)
SELECT customer_id, 
	   order_date, 
       product_name
FROM CTE
WHERE ranking = 1;

# After becoming a member customer A ordered curry and customer B ordered sushi.

-- 7. Which item was purchased just before the customer became a member?
WITH CTE AS
	(SELECT customer_id,
			order_date,
			product_name,
			DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS ranking
	 FROM order_tbl
	 WHERE join_date > order_date)
SELECT customer_id,
	   order_date, 
       product_name
FROM CTE
WHERE ranking = 1;


# Before being a member, customers A ordered sushi and curry and customer B ordered curry.

-- 8. What is the total items and amount spent for each member before they became a member?
WITH CTE AS
	(SELECT customer_id,
			product_name,
            price AS item_price,
            COUNT(*) AS item_amount,
            price*COUNT(*) AS price
	 FROM order_tbl
	 WHERE join_date > order_date
     GROUP BY customer_id, product_id)
SELECT customer_id,
	   SUM(item_amount) AS total_items, 
	   SUM(price) AS total_amount_spent
FROM CTE
GROUP BY customer_id;

# Customer A ordered 2 items and spent a total of 25, 
# and customer B ordered 3 items and spent a total of 40 before being members.

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - 
-- how many points would each customer have?
WITH CTE AS 
	(SELECT customer_id, 
			product_name, 
            COUNT(*) AS item_amount, 
            price AS item_price,
			COUNT(*)*price AS price,
			CASE WHEN product_name = 'sushi' THEN COUNT(*)*price*20
			ELSE (COUNT(*)*price*10) 
            END AS points
	 FROM order_tbl
	 GROUP BY customer_id, product_name) -- total points per item
SELECT customer_id, 
	   SUM(points) AS total_points
FROM CTE
GROUP BY customer_id; -- total points per customer

# Customers with membership (A,860 points and B, 940 points) had a considerable higher amount of points than
# non-members (C, 360).

-- 10. In the first week after a customer joins the program 
-- (including their join date) they earn 2x points on all items, not just sushi - 
-- how many points do customer A and B have at the end of January?
WITH CTE AS 
	(SELECT customer_id, 
			order_date,
            join_date,
            product_name, 
            COUNT(*) AS item_amount, 
            price AS item_price,
			COUNT(*)*price AS total_price,
			WEEK(order_date) - WEEK(join_date) AS weeks_after_joining,
			CASE 
				WHEN product_name = 'sushi' OR WEEK(order_date) - WEEK(join_date) = 1 OR WEEK(order_date) - WEEK(join_date) = 0
                THEN COUNT(*)*price*20
				ELSE COUNT(*)*price*10 
                END AS points
	FROM order_tbl
	WHERE MONTH(order_date) = 1 AND join_date IS NOT NULL
	GROUP BY customer_id, order_date, product_id) -- points earned per order
SELECT customer_id, 
	   SUM(points) AS points_earned
FROM CTE
GROUP BY customer_id;

# In this case, Customer A had more points than customer B in the month of January.

-- Bonus Questions 
-- 1. Join All The Things
DROP TABLE IF EXISTS customer_tbl;
CREATE TEMPORARY TABLE customer_tbl 
SELECT s.customer_id, 
	   s.order_date, 
	   m2.product_name,
	   m2.price,
	   CASE
		WHEN m1.join_date IS NULL OR join_date > order_date 
        THEN 'N' ELSE 'Y' END AS member
FROM sales AS s
LEFT JOIN members AS m1
ON s.customer_id = m1.customer_id
LEFT JOIN menu AS m2
ON s.product_id = m2.product_id
ORDER BY s.customer_id, s.order_date, m2.price DESC;

-- 2. Rank All The Things
DROP TABLE IF EXISTS member_tbl;
CREATE TEMPORARY TABLE member_tbl 
SELECT customer_id,
	   order_date,
       product_name,
       price,
       member,
	   CASE 
		WHEN member = 'Y' THEN RANK() OVER(PARTITION BY customer_id, member ORDER BY order_date)
		ELSE NULL 
		END AS ranking
FROM customer_tbl;
