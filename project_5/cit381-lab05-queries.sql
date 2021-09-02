-- Create a WHERE subquery that returns the customer with the minimum payment (customer number 398)
SELECT 
	customerNumber
 FROM payments
 WHERE amount = (SELECT MIN(amount) FROM payments);
 
-- Create a WHERE subquery that returns customer that have <= the average payment (108 rows returned)
SELECT
	customerNumber
FROM payments
WHERE amount <= (SELECT AVG(amount) FROM payments);

-- Create a WHERE subquery that returns the number of customers that have placed an order (the number should be 98)
SELECT 
    COUNT(customerName)
FROM
    customers
WHERE
    customerNumber IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);
            
-- Create a FROM subquery that creates a temporary table of products with a quantityInStock > 10 and 
-- returns maximum buyPrice and minimum buyPrice (should return one row of 103.42 and 15.91)
SELECT
	MAX(buyPrice),
    MIN(buyPrice)
FROM
	(SELECT
		buyPrice,
		quantityInStock as quantity
	 FROM
		products
	WHERE
		quantityInStock > 10) as price;
    
-- Create a WHERE correlated subquery that returns products where the quantityInStock >= average 
-- quantityOrdered found in the orderDetails table (108 rows returned)
SELECT
	productCode,
	productName
FROM
	products p
WHERE
	quantityInStock >=
		(SELECT
			AVG(quantityOrdered)
		FROM
			orderdetails
		WHERE
			productCode = p.productCode)
            
-- GROUP BY productCode;
-- debugging: was trying to figure out why the WHERE filter was returning 108 rows versus no filter returning 109 rows
-- discovered that column productCode in orderdetails doesn't have the same product code S18_3233 which is in table products
/* SELECT
	p.productCode,
    od.productCode
FROM
	products p
LEFT JOIN orderdetails od on p.productCode = od.productCode
WHERE
	p.productCode LIKE 'S18%'
*/

    