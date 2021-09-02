-- #1 (13 rows): Employees in offices not in the US using offices.country
-- # Number, Employee, Office
-- 1102, Bondur, Gerard, Paris
-- 1337, Bondur, Loui, Paris
-- 1370, Hernandez, Gerard, Paris
select
	e1.employeeNumber as 'Number',
	concat(e1.lastName, ', ', e1.firstName) as 'Employee',
    offices.country as 'Office'
from employees e1 
join offices on e1.officeCode = offices.officeCode
where country not in ('USA');



-- #2 (2 rows): Products and product line where MSRP > $200
-- # Line, Product, Qty, MSRP, Price
-- 'Classic Cars', '1952 Alpine Renault 1300', '7305', '214.30', '98.58'
-- 'Classic Cars', '2001 Ferrari Enzo', '3619', '207.80', '95.59'
select
	p.productLine as 'Line',
    p.productName as 'Product',
    p.quantityInStock as 'Qty',
    p.MSRP,
    p.buyPrice as 'Price'
from products p where MSRP > 200;

-- #3 (435 rows): All orders shipped within 1 day ordered by customer name then ordered by product name
-- # customerName, orderNumber, orderDate, productName, quantityOrdered, o.shippedDate - o.orderDate
-- 'Atelier graphique', '10345', '2004-11-25', '1938 Cadillac V-16 Presidential Limousine', '43', '1'
-- 'Australian Collectors, Co.', '10347', '2004-11-29', '18th Century Vintage Horse Carriage', '45', '1'
-- 'Australian Collectors, Co.', '10347', '2004-11-29', '1913 Ford Model T Speedster', '48', '1'
select
	c.customerName,
    o.orderNumber,
    o.orderDate,
    p.productName,
    od.quantityOrdered,
    o.shippedDate - o.orderDate
from orders o
inner join customers c on o.customerNumber = c.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
inner join products p on p.productCode = od.productCode
where o.shippedDate - o.orderDate = 1
order by customerName, productName;



-- #4 (1 row): Average, maximum, and minimum buyPrice of all products
-- # AvgPrice, MaxPrice, MinPrice
-- '54.395182', '103.42', '15.91'
select
	avg(buyPrice) as 'AvgPrice',
	max(buyPrice) as 'MaxPrice',
    min(buyPrice) as 'MinPrice'
from products