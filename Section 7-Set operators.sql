-- MySQL UNION
-- MySQL UNION and column alias examples

SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;
    
SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;
    
-- MySQL UNION and ORDER BY
SELECT 
    concat(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY fullname;

SELECT 
    CONCAT(firstName, ' ', lastName) fullname, 
    'Employee' as contactType
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName, ' ', contactLastName),
    'Customer' as contactType
FROM
    customers
ORDER BY 
    fullname

-- =====================
-- MySQL EXCEPT
SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers
ORDER BY firstName;

-- A practical MySQL INTERSECT example
SELECT 
    firstName
FROM
    employees 
INTERSECT
SELECT 
    contactFirstname
FROM
    customers;
    
-- Using INTERSECT operator with ORDER BY clause
SELECT 
    firstName
FROM
    employees 
INTERSECT
SELECT 
    contactFirstname
FROM
    customers
ORDER BY firstName;

-- Using INTERSECT operator with ALL option example
SELECT 
    firstName
FROM
    employees 
INTERSECT ALL
SELECT 
    contactFirstname
FROM
    customers
ORDER BY firstName;