-- WHERE
-- Using the WHERE clause with equality operator example	
SELECT 
	*
from customers
where city = 'Las Vegas';

-- Using the WHERE clause with the AND operator
select 
	contactFirstName,
    country,
    salesRepEmployeeNumber,
    city
from customers
where city= 'Nantes' and
salesRepEmployeeNumber=1370;

-- Using MySQL WHERE clause with OR operator
select 
	contactFirstName,
    country,
    salesRepEmployeeNumber,
    city
from customers
where city= 'Nantes' or
salesRepEmployeeNumber=1370;

-- Using the WHERE clause with the BETWEEN operator example
select *
from orderdetails
where quantityOrdered between 10 and 25
order by quantityOrdered

-- Using the WHERE clause with the LIKE operator example
select firstName, lastName
from employees
where lastName like '%son'
order by firstName asc;

-- Using the WHERE clause with the IN operator example
select firstName, lastName, officeCode
from employees
where officeCode in (1 , 2, 3)
order by officeCode;
    
-- Using MySQL WHERE clause with the IS NULL operator
select lastName, firstName, reportsTo
from employees
where reportsTo is null;

-- Using MySQL WHERE clause with comparison operators
select lastname, firstname, jobtitle
from employees
where jobtitle <> 'Sales Rep';

-- Using MySQL LIMIT to get the highest or lowest rows
select customerNumber, customerName, creditLimit
from customers
order by creditLimit desc
limit 5;

-- Using MySQL LIMIT clause for pagination
select count(*)
from orderdetails

-- Using MySQL LIMIT to get the nth highest or lowest value
select customerName, creditLimit
from customers
order by creditLimit desc
limit 1,1;