-- MySQL Primary Key
-- Primary Key
CREATE TABLE products(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);

INSERT INTO products (id, name) 
VALUES 
    (1, 'Laptop'),
    (2, 'Smartphone'),
    (3, 'Wireless Headphones');

-- eror
INSERT INTO products (id, name) 
VALUES 
  (1, 'Bluetooth Speaker');
  
-- Defining a single-column primary key with AUTO_INCREMENT attribute example
DROP TABLE products; 

CREATE TABLE products(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);

INSERT INTO products (name) 
VALUES 
    ('Laptop'),
    ('Smartphone'),
    ('Wireless Headphones');

SELECT * FROM products;

-- =====================
-- Defining a multi-column primary key example
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE faviorites(
    customer_id INT,
    product_id INT,
    favorite_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(customer_id, product_id)
);

-- Adding a primary key to a table example
CREATE TABLE tags(
    id INT,
    name VARCHAR(25) NOT NULL
);

ALTER TABLE tags
ADD PRIMARY KEY(id);

ALTER TABLE tags
DROP PRIMARY KEY;


-- 	MySQL Foreign Key
-- MySQL FOREIGN KEY examples
CREATE DATABASE fkdemo;
USE fkdemo;

CREATE TABLE categories(
  categoryId INT AUTO_INCREMENT PRIMARY KEY, 
  categoryName VARCHAR(100) NOT NULL
) ENGINE = INNODB;

CREATE TABLE products(
  productId INT AUTO_INCREMENT PRIMARY KEY, 
  productName VARCHAR(100) NOT NULL, 
  categoryId INT, 
  CONSTRAINT fk_category FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
) ENGINE = INNODB;

INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');

select * from categories;

INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;


INSERT INTO products(productName, categoryId)
VALUES('iPhone',1);

-- eror
INSERT INTO products(productName, categoryId)
VALUES('iPad',3);

-- eror
UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

-- CASCADE action
DROP TABLE products;

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT NOT NULL,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
    REFERENCES categories(categoryId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);

SELECT * FROM products;

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

DELETE FROM categories
WHERE categoryId = 2;

-- SET NULL action
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;

CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
)ENGINE=INNODB;

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
        ON UPDATE SET NULL
        ON DELETE SET NULL 
)ENGINE=INNODB;

INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');

INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

SELECT * FROM categories;

DELETE FROM categories 
WHERE categoryId = 2;


-- =======================
-- MySQL Disable Foreign Key Checks
SET foreign_key_checks = 0;
SET foreign_key_checks = 1;

-- Disable foreign key check example
CREATE TABLE countries(
    country_id INT AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(country_id)
);

CREATE TABLE cities(
    city_id INT AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY(city_id),
    FOREIGN KEY(country_id) 
		REFERENCES countries(country_id)
);

INSERT INTO cities(city_name, country_id)
VALUES('New York',1);

SELECT * FROM cities;

SET foreign_key_checks = 1;

INSERT INTO countries(country_id, country_name)
VALUES(1,'USA');

-- Drop tables that have foreign key constraints
drop table countries;

SET foreign_key_checks = 0;

DROP TABLE countries;
DROP TABLE cities;

SET foreign_key_checks = 1;


-- =================
-- MySQL NOT NULL Constraint
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

desc tasks;

INSERT INTO tasks(title ,start_date, end_date)
VALUES('Learn MySQL NOT NULL constraint', '2017-02-01','2017-02-02'),
      ('Check and update NOT NULL constraint to your database', '2017-02-01',NULL);

SELECT * FROM tasks 
WHERE end_date IS NULL;

UPDATE tasks 
SET 
    end_date = start_date + 7
WHERE
    end_date IS NULL;

SELECT * FROM tasks;

ALTER TABLE tasks 
CHANGE 
    end_date 
    end_date DATE NOT NULL;

desc tasks;

-- Removing a NOT NULL constraint
ALTER TABLE tasks 
MODIFY end_date DATE;


-- =======================
-- MySQL UNIQUE Constraint

-- MySQL UNIQUE constraint example
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT uc_name_address UNIQUE (name,address)
);

INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-2476',
       '4000 North 1st Street');

INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-2476','3000 North 1st Street');

INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-3333','3000 North 1st Street');

INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-1111',
       '4000 North 1st Street');

-- MySQL UNIQUE constraint & NULL
CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE
);

INSERT INTO contacts(name, phone)
VALUES('Alice','(408)-102-2456'), ('John', NULL), ('Jane', NULL);   

SELECT * FROM contacts;

-- 	MySQL UNIQUE constraints and indexes
SHOW CREATE TABLE suppliers;

SHOW INDEX FROM suppliers;

-- Drop a unique constraint
DROP INDEX uc_name_address ON suppliers;
SHOW INDEX FROM suppliers;

-- Add new unique constraint
ALTER TABLE suppliers
ADD CONSTRAINT uc_name_address 
UNIQUE (name,address);


-- =========================
-- MySQL CHECK Constraint
CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',0,-100);

-- Creating CHECK constraints as a table constraints
DROP TABLE IF EXISTS parts;

CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT parts_chk_price_gt_cost
        CHECK(price >= cost)
);

CONSTRAINT parts_chk_price_gt_cost CHECK(price >= cost)

INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',200,100);

-- Adding a check constraint to a table
ALTER TABLE parts
ADD CHECK (part_no <> description);

INSERT INTO parts 
VALUES('A','A',100,120);

-- Removing a check constraint from a table
ALTER TABLE parts
DROP CHECK parts_chk_3;


-- =================================
-- MySQL DEFAULT
CREATE TABLE cart_items 
(
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DEC(5,2) NOT NULL,
    sales_tax DEC(5,2) NOT NULL DEFAULT 0.1,
    CHECK(quantity > 0),
    CHECK(sales_tax >= 0) 
);	

DESC cart_items;

INSERT INTO cart_items(name, quantity, price)
VALUES('Keyboard', 1, 50);

SELECT * FROM cart_items;

INSERT INTO cart_items(name, quantity, price, sales_tax)
VALUES('Battery',4, 0.25 , DEFAULT);

-- Adding a DEFAULT constraint to a column
ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT default_value;

ALTER TABLE cart_items
ALTER COLUMN quantity SET DEFAULT 1;

DESC cart_items;

INSERT INTO cart_items(name, price, sales_tax)
VALUES('Maintenance services',25.99, 0);

SELECT * FROM cart_items;

-- Removing a DEFAULT constraint from a column
ALTER TABLE cart_items
ALTER COLUMN quantity DROP DEFAULT;

DESC cart_items;