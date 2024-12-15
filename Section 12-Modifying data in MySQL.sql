DROP TABLE IF EXISTS tasks;
use section_12;
CREATE TABLE tasks (
  task_id INT AUTO_INCREMENT PRIMARY KEY, 
  title VARCHAR(255) NOT NULL, 
  start_date DATE, 
  due_date DATE, 
  priority TINYINT NOT NULL DEFAULT 3, 
  description TEXT
);

INSERT INTO tasks(title, priority) 
VALUES('Learn MySQL INSERT Statement', 1);

INSERT INTO tasks(title, priority) 
VALUES('Understanding DEFAULT keyword', DEFAULT);

select * from tasks;

-- Inserting dates into the table example
INSERT INTO tasks(title, start_date, due_date) 
VALUES ('Insert date into table', '2018-01-09', '2018-09-15');

INSERT INTO tasks(title, start_date, due_date) 
VALUES 
  (
    'Use current date for the task', 
    CURRENT_DATE(), 
    CURRENT_DATE()
  );
  
  INSERT INTO tasks(title, priority)
VALUES
	('My first task', 1),
	('It is the second task',2),
	('This is the third task of the week',3);
    
    select * from tasks;
    
    -- Dealing with auto-increment column
    CREATE TABLE t(
   id INT AUTO_INCREMENT PRIMARY KEY
);
    
    INSERT INTO t VALUES();
    
    SELECT * FROM t;
    
    -- ====================
    -- MySQL Insert Multiple Rows
SHOW VARIABLES LIKE 'max_allowed_packet';

-- MySQL INSERT multiple rows examples
CREATE TABLE projects(
  project_id INT AUTO_INCREMENT, 
  name VARCHAR(100) NOT NULL, 
  start_date DATE, 
  end_date DATE, 
  PRIMARY KEY(project_id)
);

INSERT INTO projects(name, start_date, end_date) 
VALUES 
  ('AI for Marketing', '2019-08-01', '2019-12-31'), 
  ('ML for Sales', '2019-05-15', '2019-11-20');

SELECT * FROM projects;

-- Using the LAST_INSERT_ID() function
INSERT INTO projects(name, start_date, end_date) 
VALUES 
  ('NeuroSynthIQ', '2023-12-01', '2024-12-31'), 
  ('QuantumMind Explorer', '2023-05-15', '2024-12-20'), 
  ('SentientBot Assistant', '2023-05-15','2024-10-20');

SELECT LAST_INSERT_ID();

-- ======================
-- MySQL INSERT INTO SELECT
use classicmodels;

CREATE TABLE suppliers (
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);

SELECT 
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';

INSERT INTO suppliers (
    supplierName, 
    phone, 
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    customerNumber
)
SELECT 
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state ,
    postalCode,
    country,
    customerNumber
FROM 
    customers
WHERE 
    country = 'USA' AND 
    state = 'CA';

SELECT * FROM suppliers;

-- Using SELECT statement in the VALUES list
CREATE TABLE stats (
    totalProduct INT,
    totalCustomer INT,
    totalOrder INT
);

INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES(
	(SELECT COUNT(*) FROM products),
	(SELECT COUNT(*) FROM customers),
	(SELECT COUNT(*) FROM orders)
);

SELECT * FROM stats;

-- MySQL INSERT IGNORE Statement
CREATE TABLE subscribers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(130) NOT NULL UNIQUE
);

INSERT INTO subscribers(email)
VALUES('john.doe@gmail.com');

INSERT INTO subscribers(email)
VALUES('john.doe@gmail.com'), 
      ('jane.smith@ibm.com');

INSERT IGNORE INTO subscribers(email)
VALUES('john.doe@gmail.com'), 
      ('jane.smith@ibm.com');

SHOW WARNINGS;

-- MySQL INSERT IGNORE and STRICT mode
CREATE TABLE tokens (
    s VARCHAR(6)
);

INSERT INTO tokens VALUES('abcdefg');

INSERT IGNORE INTO tokens VALUES('abcdefg');

-- MySQL Insert DateTime
CREATE TABLE events(
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_time DATETIME NOT NULL
);

INSERT INTO events(event_name, event_time)
VALUES('MySQL tutorial livestream', '2023-10-28 19:30:35');

SELECT * FROM events;

-- Inserting the current datetime
INSERT INTO events(event_name, event_time)
VALUES('MySQL Workshop', NOW());

-- Inserting a datetime string example
INSERT INTO events (event_name, event_time)
VALUES ('MySQL Party', STR_TO_DATE('10/28/2023 20:00:00', '%m/%d/%Y %H:%i:%s'));

-- MySQL Insert Date
CREATE TABLE events(
   id INT AUTO_INCREMENT PRIMARY KEY,
   event_name VARCHAR(255) NOT NULL,
   event_date DATE NOT NULL
);

INSERT INTO events(event_name, event_date)
VALUES('MySQL Conference','2023-10-29');

SELECT event_name, event_date
FROM events;

INSERT INTO events(event_name, event_date)
VALUES('MySQL Database Design Workshop','2023-10-39');

-- Inserting the current date
INSERT INTO events(event_name, event_date)
VALUES('MySQL Replication Workshop', CURRENT_DATE);

INSERT INTO events(event_name, event_date)
VALUES('MySQL Day in USA', UTC_DATE());

-- Inserting a date string example
INSERT INTO events (event_name, event_date)
VALUES ('MySQL Innovate', STR_TO_DATE('10/29/2023', '%m/%d/%Y'));

-- ==================
-- MySQL UPDATE
SELECT 
    firstname, 
    lastname, 
    email
FROM
    employees
WHERE
    employeeNumber	 = 1056;
    
use classicmodels;

UPDATE employees 
SET 
    email = 'mary.patterson@classicmodelcars.com'
WHERE
    employeeNumber = 1056;

UPDATE employees 
SET 
    lastname = 'Hill',
    email = 'mary.hill@classicmodelcars.com'
WHERE
    employeeNumber = 1056;

SELECT 
    firstname, 
    lastname, 
    email
FROM
    employees
WHERE
    employeeNumber = 1056;

UPDATE employees
SET email = REPLACE(email,'@classicmodelcars.com','@mysqltutorial.org')
WHERE
   jobTitle = 'Sales Rep' AND
   officeCode = 6;

SELECT 
    customername, 
    salesRepEmployeeNumber
FROM
    customers
WHERE
    salesRepEmployeeNumber IS NULL;

SELECT 
    employeeNumber
FROM
    employees
WHERE
    jobtitle = 'Sales Rep'
ORDER BY RAND()
LIMIT 1;

UPDATE customers 
SET 
    salesRepEmployeeNumber = (SELECT 
            employeeNumber
        FROM
            employees
        WHERE
            jobtitle = 'Sales Rep'
        ORDER BY RAND()
        LIMIT 1)
WHERE
    salesRepEmployeeNumber IS NULL;

SELECT 
    employeeNumber
FROM
    employees
WHERE
    jobtitle = 'Sales Rep'
ORDER BY RAND()
LIMIT 1;

UPDATE customers 
SET 
    salesRepEmployeeNumber = (SELECT 
            employeeNumber
        FROM
            employees
        WHERE
            jobtitle = 'Sales Rep'
        ORDER BY RAND()
        LIMIT 1)
WHERE
    salesRepEmployeeNumber IS NULL;

SELECT 
     salesRepEmployeeNumber
FROM
    customers
WHERE
    salesRepEmployeeNumber IS NULL;

-- ==========================
-- MySQL UPDATE JOIN
CREATE DATABASE IF NOT EXISTS hr;

USE hr;

CREATE TABLE merits (
  performance INT PRIMARY KEY, 
  percentage DEC(11, 2) NOT NULL
);

CREATE TABLE employees (
  emp_id INT AUTO_INCREMENT PRIMARY KEY, 
  emp_name VARCHAR(255) NOT NULL, 
  performance INT DEFAULT NULL, 
  salary DEC(11, 2) DEFAULT NULL, 
  FOREIGN KEY (performance) REFERENCES merits (performance)
);

INSERT INTO merits(performance, percentage) 
VALUES 
  (1, 0), 
  (2, 0.01), 
  (3, 0.03), 
  (4, 0.05), 
  (5, 0.08);

INSERT INTO employees(emp_name, performance, salary) 
VALUES 
  ('Mary Doe', 1, 50000), 
  ('Cindy Smith', 3, 65000), 
  ('Sue Greenspan', 4, 75000), 
  ('Grace Dell', 5, 125000), 
  ('Nancy Johnson', 3, 85000), 
  ('John Doe', 2, 45000), 
  ('Lily Bush', 3, 55000);

UPDATE 
  employees 
  INNER JOIN merits ON employees.performance = merits.performance 
SET 
  salary = salary + salary * percentage;

SELECT * FROM employees;

-- MySQL UPDATE JOIN example with LEFT JOIN
TRUNCATE TABLE employees;

INSERT INTO employees(emp_name, performance, salary) 
VALUES 
  ('Mary Doe', 1, 50000), 
  ('Cindy Smith', 3, 65000), 
  ('Sue Greenspan', 4, 75000), 
  ('Grace Dell', 5, 125000), 
  ('Nancy Johnson', 3, 85000), 
  ('John Doe', 2, 45000), 
  ('Lily Bush', 3, 55000),
  ('Jack William', NULL, 43000), 
  ('Ricky Bond', NULL, 52000);

SELECT * FROM employees;

UPDATE 
  employees 
  LEFT JOIN merits ON employees.performance = merits.performance 
SET 
  salary = salary + salary * COALESCE(percentage, 0.015);	

-- ====================
-- MySQL DELETE
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

INSERT INTO contacts (first_name, last_name, email, phone)
VALUES
    ('John', 'Doe', 'john.doe@email.com', '123-456-7890'),
    ('Jane', 'Smith', 'jane.smith@email.com', '987-654-3210'),
    ('Alice', 'Doe', 'alice.doe@email.com', '555-123-4567'),
    ('Bob', 'Johnson', 'bob.johnson@email.com', '789-321-6540'),
    ('Eva', 'Doe', 'eva.doe@email.com', '111-222-3333'),
    ('Michael', 'Smith', 'michael.smith@email.com', '444-555-6666'),
    ('Sophia', 'Johnson', 'sophia.johnson@email.com', '777-888-9999'),
    ('Matthew', 'Doe', 'matthew.doe@email.com', '333-222-1111'),
    ('Olivia', 'Smith', 'olivia.smith@email.com', '999-888-7777'),
    ('Daniel', 'Johnson', 'daniel.johnson@email.com', '666-555-4444'),
    ('Emma', 'Doe', 'emma.doe@email.com', '222-333-4444'),
    ('William', 'Smith', 'william.smith@email.com', '888-999-0000'),
    ('Ava', 'Johnson', 'ava.johnson@email.com', '111-000-9999'),
    ('Liam', 'Doe', 'liam.doe@email.com', '444-777-3333'),
    ('Mia', 'Smith', 'mia.smith@email.com', '222-444-8888'),
    ('James', 'Johnson', 'james.johnson@email.com', '555-666-1111'),
    ('Grace', 'Doe', 'grace.doe@email.com', '777-222-8888'),
    ('Benjamin', 'Smith', 'benjamin.smith@email.com', '999-111-3333'),
    ('Chloe', 'Johnson', 'chloe.johnson@email.com', '111-444-7777'),
    ('Logan', 'Doe', 'logan.doe@email.com', '333-555-9999');

DELETE FROM contacts
WHERE id = 1;

SELECT * FROM contacts 
WHERE last_name = 'Smith';

DELETE FROM contacts
WHERE last_name = 'Smith';

