-- SECTION 2. SORTING DATA
-- ORDER BY

-- Using ORDER BY clause to sort the result set by one column example
select lastName, firstName, email
from employees
order by firstName;

select lastName, firstName
from employees 
order by firstName desc;

-- Using the ORDER BY clause to sort the result set by multiple columns example
select addressLine2, state, country
from offices
order by 
state asc,
addressLine2 desc;

-- Using the ORDER BY clause to sort a result set by an expression example
select orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, quantityOrdered * priceEach
from orderdetails
order by quantityOrdered * priceEach desc;

-- ordwr by with column allias
select orderNumber, quantityOrdered, priceEach, quantityOrdered * priceEach as subtotal
from orderdetails
order by subtotal desc;

-- Using MySQL ORDER BY clause to sort data using a custom list
select orderNumber, status
from orders
order by field (
status, 'shipped', 'cancelled', 'resolved', 'On Hold', 'Disputed', 'In Process');

-- MySQL ORDER BY and NULL
SELECT 
  firstName, 
  lastName, 
  reportsTo 
FROM 
  employees 
ORDER BY 
  reportsTo desc;
  
  -- SUMMARY
  select customerName, contactFirstName, contactLastName
  from customers
  order by customerName;
  
  select customerNumber, customerName, city
  from customers
  order by customerNumber desc, customerName asc;
