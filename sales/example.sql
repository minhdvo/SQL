/* 1. Return a list of order numbers (order_num) and the total quantity of items for each order */

SELECT order_num, SUM(quantity)
FROM OrderItems
GROUP BY order_num;

/* 2. Returns orders of at least 100 items, and sort the results from largest order to
smallest. */

SELECT order_num, SUM(quantity)
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity) > 100
ORDER BY SUM(quantity) DESC;

/* 3. Return a list of customers who bought items priced 10 or more */

SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
		    FROM OrderItems
		    WHERE item_price >= 10);

/* 4. List all product names (prod_name) from the Products table, along with a derived field named quant_sold
containing the total number of this item sold */

SELECT prod_name,
	(SELECT SUM(quantity)
	FROM OrderItems
	WHERE OrderItems.prod_id = Products.prod_id) AS quant_sold
FROM Products;

/* */
