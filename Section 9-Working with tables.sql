create database section_9;

use section_9;

CREATE TABLE tasks (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE
);

-- Creating a table with a foreign key example
CREATE TABLE checklists(
  id INT, 
  task_id INT, 
  title VARCHAR(255) NOT NULL, 
  is_completed BOOLEAN NOT NULL DEFAULT FALSE, 
  PRIMARY KEY (id, task_id), 
  FOREIGN KEY (task_id) 
      REFERENCES tasks (id) 
      ON UPDATE RESTRICT 
      ON DELETE CASCADE
);

-- MySQL AUTO_INCREMENT

create table testing_1(
id int auto_increment primary key,
nama varchar(100) not null,
npm int(50) not null) engine = INNODB;

alter table testing_1 engine = MyISAM;

insert into testing_1 (nama, npm)
values ('Faris', 243307017)

select * from testing_1;
CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL
);

-- insert rows with auto_increment column
insert into contacts(name, email)
values ('John Doe', 'john.doe@mysqltutorial.org');

select * from contacts;

SELECT LAST_INSERT_ID();

-- reset value auto increment
ALTER TABLE contacts 
AUTO_INCREMENT = 1;

-- truncate table contacts
TRUNCATE TABLE contacts;

INSERT INTO contacts(name, email) 
VALUES
   ('John Doe', 'john.doe@mysqltutorial.org'),
   ('Jane Doe', 'jane.doe@mysqltutorial.org');
   
ALTER TABLE contacts 
AUTO_INCREMENT = 1;

-- Adding an AUTO_INCREMENT column to an existing table
CREATE TABLE subscribers(
   email VARCHAR(320) NOT NULL UNIQUE
);

ALTER TABLE subscribers
ADD id INT AUTO_INCREMENT PRIMARY KEY;

select * from subscribers;

INSERT INTO contacts(name, email) 
VALUES('Bob Climo', 'bob.climo@mysqltutorial.org');

-- ===========================================
-- MySQL ALTER TABLE
CREATE TABLE vehicles (
    vehicleId INT,
    year INT NOT NULL,
    make VARCHAR(100) NOT NULL,
    PRIMARY KEY(vehicleId)
);
ALTER TABLE vehicles
ADD model VARCHAR(100) NOT NULL;

DESCRIBE vehicles;

-- add multiple columns to a table
ALTER TABLE vehicles
ADD color VARCHAR(50),
ADD note VARCHAR(255);

-- MySQL ALTER TABLE – Modify columns
-- 1) Modify a column
ALTER TABLE vehicles 
MODIFY note VARCHAR(100) NOT NULL;

-- Modify multiple columns
ALTER TABLE vehicles 
MODIFY year SMALLINT NOT NULL,
MODIFY color VARCHAR(20) NULL AFTER make;

-- MySQL ALTER TABLE – Rename a column in a table
ALTER TABLE vehicles 
CHANGE COLUMN note vehicleCondition VARCHAR(100) NOT NULL;

describe vehicles;

-- MySQL ALTER TABLE – Drop a column
ALTER TABLE vehicles
DROP COLUMN vehicleCondition;

-- MySQL ALTER TABLE – Rename table
ALTER TABLE vehicles 
RENAME TO cars; 

select * from vehicles;

-- =====================
-- MySQL RENAME TABLE Statement
CREATE DATABASE IF NOT EXISTS hr;
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id int AUTO_INCREMENT primary key,
    first_name VARCHAR(50) not null,
    last_name VARCHAR(50) not null,
    department_id INT not null,
    FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
);

INSERT INTO departments(dept_name) 
VALUES 
  ('Sales'), 
  ('Markting'), 
  ('Finance'), 
  ('Accounting'), 
  ('Warehouses'), 
  ('Production');

INSERT INTO employees(
  first_name, last_name, department_id
) 
VALUES 
  ('John', 'Doe', 1), 
  ('Bush', 'Lily', 2), 
  ('David', 'Dave', 3), 
  ('Mary', 'Jane', 4), 
  ('Jonatha', 'Josh', 5), 
  ('Mateo', 'More', 1);

SELECT 
    department_id, dept_name
FROM
    departments;

SELECT 
    id, first_name, last_name, department_id
FROM
    employees;
    
CREATE VIEW v_employee_info as 
SELECT 
  id, 
  first_name, 
  last_name, 
  dept_name 
from 
  employees 
  inner join departments USING (department_id);
  
SELECT * FROM v_employee_info;

RENAME TABLE employees TO people;

CHECK TABLE v_employee_info;

-- Renaming a table that is referenced by a stored procedure
RENAME TABLE people TO employees;

DELIMITER $$

CREATE PROCEDURE get_employee(IN p_id INT)
BEGIN
	SELECT first_name, last_name, dept_name
	FROM employees
	INNER JOIN departments using (department_id)
	WHERE id = p_id;
END$$

DELIMITER ;

CALL get_employee(1);

RENAME TABLE employees TO people;

-- Renaming a table that is referenced by foreign key constraints
RENAME TABLE departments TO depts;

DELETE FROM depts 
WHERE
    department_id = 1

-- MySQL MERGE storage engine example
-- First, create a new MyISAM table called t1:
CREATE TABLE t1(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL	
) ENGINE = MyISAM;

-- Second, create another MyISAM table called t2 with identical columns and data types as the table t1:
CREATE TABLE t2(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL
) ENGINE=MyISAM;

-- Third, insert rows into the t1 and t2 tables:
INSERT INTO t1(name) VALUES('John');
INSERT INTO t1(name) VALUES('Jane');
INSERT INTO t2(name) VALUES('Bob');
INSERT INTO t2(name) VALUES('Alice');

-- Fourth, create a MERGE table that includes the MyISAM table t1 and t2:
CREATE TABLE t(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL
) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;

-- Fifth, query data from the MERGE table:
SELECT 
  id, 
  name 
FROM 
  t;

-- MySQL SHOW PROCESSLIST
SHOW PROCESSLIST;

-- MySQL CHECK TABLE statement examples
use classicmodels;

CHECK TABLE customers, products;

-- Using the MySQL CHECK TABLE to check for errors in a view
CREATE DATABASE IF NOT EXISTS test;

-- Second, switch to the test database:
use test;

-- Third, create a table called employees in the test database:
CREATE TABLE employees(
  id INT AUTO_INCREMENT PRIMARY KEY, 
  first_name VARCHAR(255) NOT NULL, 
  last_name VARCHAR(255) NOT NULL, 
  email VARCHAR(255) NOT NULL, 
  phone VARCHAR(255) NOT NULL
);

-- Fourth, create a view called contacts based on the employees table:
CREATE VIEW contacts AS 
SELECT 
  concat_ws(' ', first_name, last_name) as name, 
  email, 
  phone 
FROM 
  employees;

-- Fifth, drop the table employees:
DROP TABLE employees;

-- Finally, check the view contacts for the error:
CHECK TABLE contactsG;