-- SECTION 1. QUERYING DATA
-- SELECT FROM

-- Using the SELECT FROM statement to retrieve data from a single column example
use classicmodels;
select lastname
from employees;

-- Using the SELECT FROM statement to query data from multiple columns example
SELECT employeeNumber,
       lastName,
       firstName,
FROM   employees; 

--  Using the SELECT FROM statement to retrieve data from all columns example
select employeeNumber,
       lastName,
       firstName,
       extension,
       email,
       officeCode,
       reportsTo,
       jobTitle
from employees;

-- Alternatif select all
select * from customers;

-- SUMMARY
select orderNumber
from orderdetails
select *
from customers

-- SELECT 
-- math functions
select 4+5-2*7

-- date functions real time
select now();

-- string functions
select concat('Muhammad', 'Falich', ' ', 'Farisy');

-- expression specified
select concat('Falich', ' ', 'Farisy') as 'nama orang gamteng';
