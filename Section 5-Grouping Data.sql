-- MySQL GROUP BY
-- Basic MySQL GROUP BY example

SELECT 
  status 
FROM 
  orders 
GROUP BY 
  status;
  
-- Using MySQL GROUP BY with aggregate functions
SELECT 
  status, 
  COUNT(*) as total
FROM 
  orders 
GROUP BY 
  status;

-- MySQL GROUP BY with expression example
SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  YEAR(orderDate);
  
-- Using MySQL GROUP BY with HAVING clause example
SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  year 
HAVING 
  year > 2003;
  
-- Grouping by multiple columns
SELECT 
  YEAR(orderDate) AS year, 
  status, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
GROUP BY 
  year, 
  status 
ORDER BY 
  year;

-- ==============================
-- MySQL HAVING
SELECT 
  ordernumber, 
  SUM(quantityOrdered) AS itemsCount, 
  SUM(priceeach * quantityOrdered) AS total 
FROM 
  orderdetails 
GROUP BY 
  ordernumber 
HAVING 
  total > 1000;
  
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING 
    total > 1000 AND 
    itemsCount > 600;
    
SELECT 
    a.ordernumber, 
    status, 
    SUM(priceeach*quantityOrdered) total
FROM
    orderdetails a
INNER JOIN orders b 
    ON b.ordernumber = a.ordernumber
GROUP BY  
    ordernumber, 
    status
HAVING 
    status = 'Shipped' AND 
    total > 1500;

-- =================================
-- MySQL HAVING COUNT
-- Simple HAVING COUNT example

-- First, create a new table of sales that has three columns sale_id, product_name, and sale_amount
CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    sale_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO sales (product_name, sale_amount)
VALUES
    ('Product A', 100.50),
    ('Product B', 75.25),
    ('Product A', 120.75),
    ('Product C', 50.00),
    ('Product B', 90.80);
    
SELECT product_name, COUNT(id)
FROM sales
GROUP BY product_name;

-- to find which product
SELECT 
  product_name, 
  COUNT(id) 
FROM 
  sales 
GROUP BY 
  product_name 
HAVING 
  COUNT(id) = 1;
  
SELECT 
  product_name, 
  COUNT(id) 
FROM 
  sales 
GROUP BY 
  product_name 
HAVING 
  COUNT(id) > 1;
  
-- Practical HAVING with COUNT example
SELECT 
  customerName, 
  COUNT(*) order_count 
FROM 
  orders 
  INNER JOIN customers using (customerNumber) 
GROUP BY 
  customerName 
HAVING 
  COUNT(*) > 4 
ORDER BY 
  order_count;

-- =======================
-- MySQL ROLLUP
-- Setting up a sample table
CREATE TABLE sales2
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);
    
select * from sales2;

-- MySQL ROLLUP Overview
SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales2
GROUP BY 
    productline;

SELECT 
    SUM(orderValue) totalOrderValue
FROM
    sales2;

-- If you want to generate two or more grouping sets together in one query, you may use the UNION ALL operator as follows:
SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales2
GROUP BY 
    productline 
UNION ALL
SELECT 
    NULL, 
    SUM(orderValue) totalOrderValue
FROM
    sales2;

-- The ROLLUP generates multiple grouping sets based on the columns or expressions specified in the GROUP BY clause. For example
SELECT 
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales2
GROUP BY 
    productline WITH ROLLUP;

SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales2
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;


-- The GROUPING() function
SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue,
    GROUPING(orderYear),
    GROUPING(productLine)
FROM
    sales2
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;

SELECT 
    IF(GROUPING(orderYear),
        'All Years',
        orderYear) orderYear,
    IF(GROUPING(productLine),
        'All Product Lines',
        productLine) productLine,
    SUM(orderValue) totalOrderValue
FROM
    sales2
GROUP BY 
    orderYear , 
    productline 
WITH ROLLUP;