-- MySQL Aliases
select concat_ws(', ', lastName, firstname) as `Nama panjang`
from employees
order by `Nama panjang`;

-- The following statement selects orders whose total amount is greater than 60000. It uses column aliases in GROUP BY and HAVING clauses.
select 
	orderNumber `order no.`,
	SUM(quantityOrdered*priceEach) `Total`
from
	orderdetails
group by 
	`order no.`
having total>60000;

-- Table aliases
select
	e.firstName,
	e.lastName
from
	employees e
order by firstName;

-- In practice, you often use table aliases in statements that contain INNER JOIN, LEFT JOIN, RIGHT JOIN clauses or in subqueries.
select
	customerName,
	count(o.orderNumber) `Total`
from 
	customers c
inner join orders o on c.customerNumber=o.customerNumber
group by 
	 customerName
order by total desc;

-- ===================================
-- MySQL Join
create table members (
	member_id INT auto_increment,
    name varchar(100),
    primary key (member_id)
);

create table committees (
	committee_id int auto_increment,
    name varchar(100),
    primary key (committee_id)
);

-- Setting up sample tables
insert into members (name)
value ('arif'), ('faris'), ('faiz'), ('alvian'), ('ridwan');
insert into committees (name)
value ('arif'), ('faris'), ('marry'), ('lybes');

-- MySQL INNER JOIN clause
select
	m.member_id,
    m.name as member,
    c.committee_id,
    c.name as committee
from 
	members m
inner join committees c using(name);

-- MySQL LEFT JOIN clause
select
	m.member_id,
    m.name as member,
    c.committee_id,
    c.name as committee
from 
	members m
left join committees c using(name)
where c.committee_id is null;

-- 	MySQL RIGHT JOIN clause
select
	m.member_id,
    m.name as member,
    c.committee_id,
    c.name as committee
from 
	members m
right join committees c using(name)
where m.member_id is null;

-- MySQL CROSS JOIN clause
select
	m.member_id,
    m.name as member,
    c.committee_id,
    c.name as committee
from 
	members m
cross join committees c;

-- MySQL INNER JOIN
select
	productCode, productName, textDescription
from
	products
inner join productlines
on products.productLine=productlines.productLine;

-- MySQL INNER JOIN with GROUP BY clause example
select 
	t1.orderNumber,
    productCode,
    sum(quantityOrdered*priceEach) 'total'
from
	orderdetails t1
inner join orders t2
on t1.orderNumber=t2.orderNumber
group by t1.orderNumber

SELECT
	orderNumber,
    status,
    sum(quantityOrdered * priceEach) 'total'
FROM
	orders
inner join orderdetails using (orderNumber)
group by orderNumber;

-- MySQL INNER JOIN – join three tables example
select
	orderNumber, orderDate, orderLineNumber, productName, (quantityOrdered*priceEach) 'total'
from
	orders
inner join orderdetails using (orderNumber)
inner join products using (productCode)
order by 
	orderNumber, orderLineNumber;

-- MySQL INNER JOIN – join four tables example
select
    orderNumber,
    orderDate,
    customerName,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
from 
	orders
inner join orderdetails using (orderNumber)
inner join products using (productCode)
inner join customers using (customerNumber)
order by
	orderLineNumber, orderNumber
    
-- MySQL INNER JOIN using other operators
SELECT 
    orderNumber, 
    productName, 
    msrp, 
    priceEach
FROM
    products p
INNER JOIN orderdetails o 
   ON p.productcode = o.productcode
      AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';
    
-- ================================
-- MySQL LEFT JOIN
select
	c.customerNumber,
    customerName,
    orderNumber,
    status
from
	customers c
left join orders o
on c.customerNumber = o.customerNumber;

-- Using MySQL LEFT JOIN clause to find unmatched rows
select
	c.customerNumber,
    c.customerName,
    o.orderNumber,
    o.status
from
	customers c
left join orders o
on c.customerNumber = o.customerNumber
where orderNumber is null;

-- Using MySQL LEFT JOIN to join three tables
select 
	lastName,
    firstName,
    customerName,
    checkNumber,
    amount
from
	employees
left join customers on
	employeeNumber = salesRepEmployeeNumber
left join payments on
	payments.customerNumber = customers.customerName
order by
	customerName,
    checkNumber;
    
-- Condition in WHERE clause vs. ON clause
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails 
    USING (orderNumber)
WHERE
    orderNumber = 10123;
    
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;
       
-- ==================================
-- MySQL RIGHT JOIN
select
	employeeNumber,
    customerNumber
from customers 
right join employees 
	on salesRepEmployeeNumber = employeeNumber
order by employeeNumber;

-- Using MySQL RIGHT JOIN to find unmatching rows
select
	employeeNumber,
    customerNumber
from 
	customers 
right join employees 
	on salesRepEmployeeNumber = employeeNumber
where customerNumber is null
order by employeeNumber;

-- ==================
-- MySQL self join examples
-- Performing a self join using an inner join
SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;

-- Performing a self join using a left join
SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
LEFT JOIN employees m ON 
    m.employeeNumber = e.reportsto
ORDER BY 
    manager DESC;

-- Using a self join to compare successive rows within the same table
SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON 
    c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;

-- ========================
-- MySQL CROSS JOIN
-- Simple cross join example
-- First, create a table that stores suits:
CREATE TABLE suits (
    suit_id INT,
    suit_name VARCHAR(10)
);

-- Second, create a table to store ranks:
CREATE TABLE ranks (
    rank_id INT,
    rank_name VARCHAR(5)
);

-- Third, insert data into the suits and ranks table:
INSERT INTO suits (suit_id, suit_name) VALUES
    (1, 'Hearts'),
    (2, 'Diamonds'),
    (3, 'Clubs'),
    (4, 'Spades');

INSERT INTO ranks (rank_id, rank_name) VALUES
    (1, 'Ace'),
    (2, '2'),
    (3, '3'),
    (4, '4'),
    (5, '5'),
    (6, '6'),
    (7, '7'),
    (8, '8'),
    (9, '9'),
    (10, '10'),
    (11, 'Jack'),
    (12, 'Queen'),
    (13, 'King');
    
-- Finally, use a cross to combine the suits and ranks to create a deck of 52 playing cards:
SELECT 
  suit_name, 
  rank_name 
FROM 
  suits CROSS 
  JOIN ranks 
ORDER BY 
  suit_name, 
  rank_name;

-- A complex cross join example
-- create new database
CREATE DATABASE IF NOT EXISTS salesdb;
use salesdb

-- create new tables
create table products (
id int primary key auto_increment,
product_name varchar(100),
price decimal (13,2)
);
CREATE TABLE stores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);

CREATE TABLE sales (
    product_id INT,
    store_id INT,
    quantity DECIMAL(13 , 2 ) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id , store_id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id)
        REFERENCES stores (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- insert data in table
INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
      ('iPad',599),
      ('Macbook Pro',1299);

INSERT INTO stores(store_name)
VALUES('North'),
      ('South');

INSERT INTO sales(store_id,product_id,quantity,sales_date)
VALUES(1,1,20,'2017-01-02'),
      (1,2,15,'2017-01-05'),
      (1,3,25,'2017-01-05'),
      (2,1,30,'2017-01-02'),
      (2,2,35,'2017-01-05');
      
SELECT 
    store_name,
    product_name,
    SUM(quantity * price) AS revenue
FROM
    sales
        INNER JOIN
    products ON products.id = sales.product_id
        INNER JOIN
    stores ON stores.id = sales.store_id
GROUP BY store_name , product_name; 

-- cross join
SELECT 
    store_name, product_name
FROM
    stores AS a
        CROSS JOIN
    products AS b;

-- join the result of the query above with a query that returns the total of sales by store and product
SELECT 
    b.store_name,
    a.product_name,
    IFNULL(c.revenue, 0) AS revenue
FROM
    products AS a
        CROSS JOIN
    stores AS b
        LEFT JOIN
    (SELECT 
        stores.id AS store_id,
        products.id AS product_id,
        store_name,
            product_name,
            ROUND(SUM(quantity * price), 0) AS revenue
    FROM
        sales
    INNER JOIN products ON products.id = sales.product_id
    INNER JOIN stores ON stores.id = sales.store_id
    GROUP BY stores.id, products.id, store_name , product_name) AS c ON c.store_id = b.id
        AND c.product_id= a.id
ORDER BY b.store_name;
