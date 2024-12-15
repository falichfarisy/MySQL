-- Section 11. MySQL data types
-- MySQL BIT Data Type
create database section_11;
use section_11;

CREATE TABLE working_calendars(
    year INT,
    week INT,
    days BIT(7),
    PRIMARY KEY(year,week)
);

INSERT INTO working_calendars(year,week,days)
VALUES(2017,1,B'1111100');

SELECT 
    year, week, days
FROM
    working_calendars;

SELECT 
    year, week, bin(days)
FROM
    working_calendars;

INSERT INTO working_calendars(year,week,days)
VALUES(2017,2,B'111100');

SELECT 
    year, week , bin(days)
FROM
    working_calendars; 

SELECT 
    year, week, lpad(bin(days),7,'0')
FROM
    working_calendars;

-- ==========================
-- MySQL INT Data Type
-- MySQL INT data type examples
CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_text VARCHAR(255)
);

INSERT INTO 
    items(item_text)
VALUES
    ('laptop'), 
    ('mouse'),
    ('headphone');

SELECT * FROM items;

INSERT INTO items(item_id,item_text)
VALUES(10,'Server');

INSERT INTO items(item_text)
VALUES('Router');

SELECT * FROM items;

-- Using INT UNSIGNED example
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    total_member INT UNSIGNED,
    PRIMARY KEY (class_id)
);

INSERT INTO classes(name, total_member)
VALUES('Weekend',100);

INSERT INTO classes(name, total_member)
VALUES('Weekend',100);

-- MySQL BOOLEAN Data Type
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN
);

DESCRIBE tasks;

INSERT INTO tasks(title, completed) 
VALUES 
  ('Master MySQL Boolean type', true), 
  ('Design database table', false);

SELECT 
  id, 
  title, 
  completed 
FROM 
  tasks;

INSERT INTO tasks(title, completed) 
VALUES 
  ('Test Boolean with a number', 2);

SELECT * FROM tasks;

SELECT 
  id, 
  title, 
  IF(completed, 'true', 'false') completed 
FROM 
  tasks;

INSERT INTO tasks(title, completed) 
VALUES 
  ('Test Boolean with NULL', NULL);

-- MySQL BOOLEAN operators
SELECT 
    id, title, completed
FROM
    tasks
WHERE
    completed = TRUE;

SELECT 
  id, 
  title, 
  completed 
FROM 
  tasks 
WHERE 
  completed IS TRUE;

SELECT 
  id, 
  title, 
  completed 
FROM 
  tasks 
WHERE 
  completed IS NOT TRUE;

-- ========================
-- MySQL DECIMAL Data Type
--  MySQL DECIMAL data type example
CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    cost DECIMAL(19,4) NOT NULL
);

INSERT INTO materials(description, cost) 
VALUES 
  ('Bicycle', 500.34), 
  ('Seat', 10.23), 
  ('Break', 5.21);

SELECT 
    *
FROM
    materials;

-- MySQL CHAR Data Type
CREATE TABLE mysql_char_test (
    status CHAR(3)
);

INSERT INTO mysql_char_test(status)
VALUES('Yes'),('No');

SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;

INSERT INTO mysql_char_test(status)
VALUES(' Y ');

SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;

-- Comparing MySQL CHAR values
SELECT * 
FROM mysql_char_test
WHERE status = 'Y';

-- MySQL CHAR and UNIQUE index
CREATE UNIQUE INDEX uidx_status 
ON mysql_char_test(status);

INSERT INTO mysql_char_test(status)
VALUES('N');

INSERT INTO mysql_char_test(status)
VALUES('N ');


-- ==============================
-- MySQL VARCHAR Data Type
CREATE TABLE IF NOT EXISTS varchar_test (
    s1 VARCHAR(32765) NOT NULL,
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;

CREATE TABLE IF NOT EXISTS varchar_test_2 (
    s1 VARCHAR(32766) NOT NULL, -- error
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;

drop table items;
CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(3)
);

INSERT INTO items(title)
VALUES('ABCD');

-- MySQL VARCHAR and spaces
INSERT INTO items(title)
VALUES('AB ');

SELECT 
    id, title, length(title)
FROM
    items;

INSERT INTO items(title)
VALUES('ABC ');

SELECT 
    title, LENGTH(title)
FROM
    items;


-- =======================
-- MySQL TEXT Data Type
-- TINYTEXT – 255 Bytes (255 characters)
CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    summary TINYTEXT
);

-- TEXT – 64KB (65,535 characters)
ALTER TABLE articles 
ADD COLUMN body TEXT NOT NULL
AFTER summary;

-- MEDIUMTEXT – 16MB (16,777,215 characters)
CREATE TABLE whitepapers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    body MEDIUMTEXT NOT NULL,
    published_on DATE NOT NULL
); 

-- ========================
-- MySQL DATETIME Data Type
CREATE TABLE events(
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO events(event_name)
VALUES('Connected to MySQL Server');

SELECT * FROM events;

-- MySQL DATETIME vs.TIMESTAMP
CREATE TABLE timestamp_n_datetime (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ts TIMESTAMP,
    dt DATETIME
);

create database section_11;

INSERT INTO timestamp_n_datetime(ts,dt)
VALUES(NOW(),NOW());

SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;
    
SET time_zone = '+03:00';

SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;

-- MySQL DATETIME functions
SET @dt =  NOW();

SELECT @dt;

-- MySQL DATE() function
SELECT DATE(@dt);

CREATE TABLE test_dt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME
);

INSERT INTO test_dt(created_at)
VALUES('2015-11-05 14:29:36');

SELECT 
    *
FROM
    test_dt
WHERE
    created_at = '2015-11-05';
    
SELECT 
    *
FROM
    test_dt
WHERE
    DATE(created_at) = '2015-11-05';

-- MySQL TIME function
SELECT TIME(@dt);

-- MySQL YEAR, QUARTER, MONTH, WEEK, DAY, HOUR, MINUTE and SECOND functions To get the year, quarter, month, week, day, hour,
SELECT 
    HOUR(@dt),
    MINUTE(@dt),
    SECOND(@dt),
    DAY(@dt),
    WEEK(@dt),
    MONTH(@dt),
    QUARTER(@dt),
    YEAR(@dt);

-- MySQL DATE_FORMAT function
SELECT DATE_FORMAT(@dt, '%H:%i:%s - %W %M %Y');

-- MySQL DATE_ADD function
SELECT @dt start, 
       DATE_ADD(@dt, INTERVAL 1 SECOND) '1 second later',
       DATE_ADD(@dt, INTERVAL 1 MINUTE) '1 minute later',
       DATE_ADD(@dt, INTERVAL 1 HOUR) '1 hour later',
       DATE_ADD(@dt, INTERVAL 1 DAY) '1 day later',
       DATE_ADD(@dt, INTERVAL 1 WEEK) '1 week later',
       DATE_ADD(@dt, INTERVAL 1 MONTH) '1 month later',
       DATE_ADD(@dt, INTERVAL 1 YEAR) '1 year later';

-- MySQL DATE_SUB function
SELECT @dt start, 
       DATE_SUB(@dt, INTERVAL 1 SECOND) '1 second before',
       DATE_SUB(@dt, INTERVAL 1 MINUTE) '1 minute before',
       DATE_SUB(@dt, INTERVAL 1 HOUR) '1 hour before',
       DATE_SUB(@dt, INTERVAL 1 DAY) '1 day before',
       DATE_SUB(@dt, INTERVAL 1 WEEK) '1 week before',
       DATE_SUB(@dt, INTERVAL 1 MONTH) '1 month before',
       DATE_SUB(@dt, INTERVAL 1 YEAR) '1 year before';
       
-- MySQL DATE_DIFF function
CREATE TABLE datediff_test (
    dt DATETIME
);       
       
INSERT INTO datediff_test(dt)
VALUES('2010-04-30 07:27:39'),
	('2010-05-17 22:52:21'),
	('2010-05-18 01:19:10'),
	('2010-05-22 14:17:16'),
	('2010-05-26 03:26:56'),
	('2010-06-10 04:44:38'),
	('2010-06-13 13:55:53');

SELECT 
    dt, 
    DATEDIFF(NOW(), dt)
FROM
    datediff_test;

-- =========================
-- MySQL TIMESTAMP Data Type
CREATE TABLE t (
   ts TIMESTAMP
);

SET time_zone='+00:00';

INSERT INTO t(ts)
VALUES('2008-01-01 00:00:01');

SELECT ts FROM t;

SET time_zone ='+03:00';

SELECT ts FROM t;

-- Automatic initialization and updating for TIMESTAMP columns
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categories(name) 
VALUES ('A');

SELECT * FROM categories;

ALTER TABLE categories
ADD COLUMN updated_at 
  TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP;

INSERT INTO categories(name)
VALUES('B');

UPDATE categories 
SET name = 'B+'
WHERE id = 2;

SELECT *
FROM categories
WHERE id = 2;

-- MySQL DATE Data Type
CREATE TABLE people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL
);

INSERT INTO people(first_name,last_name,birth_date)
VALUES('John','Doe','1990-09-01');

SELECT 
    first_name, 
    last_name, 
    birth_date
FROM
    people;

INSERT INTO people(first_name,last_name,birth_date)
VALUES('Jack','Daniel','01-09-01'),
      ('Lily','Bush','80-09-01');

SELECT 
    first_name, 
    last_name, 
    birth_date
FROM
    people;

-- MySQL Date Functions
SELECT NOW();

SELECT DATE(NOW());

SELECT CURDATE();

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') today;

SELECT DATEDIFF('2015-11-04','2014-11-04') days;

SELECT 
    '2015-01-01' start,
    DATE_ADD('2015-01-01', INTERVAL 1 DAY) 'one day later',
    DATE_ADD('2015-01-01', INTERVAL 1 WEEK) 'one week later',
    DATE_ADD('2015-01-01', INTERVAL 1 MONTH) 'one month later',
    DATE_ADD('2015-01-01', INTERVAL 1 YEAR) 'one year later';

SELECT 
    '2015-01-01' start,
    DATE_SUB('2015-01-01', INTERVAL 1 DAY) 'one day before',
    DATE_SUB('2015-01-01', INTERVAL 1 WEEK) 'one week before',
    DATE_SUB('2015-01-01', INTERVAL 1 MONTH) 'one month before',
    DATE_SUB('2015-01-01', INTERVAL 1 YEAR) 'one year before';

SELECT DAY('2000-12-31') day, 
       MONTH('2000-12-31') month, 
       QUARTER('2000-12-31') quarter, 
       YEAR('2000-12-31') year;

SELECT 
    WEEKDAY('2000-12-31') weekday,
    WEEK('2000-12-31') week,
    WEEKOFYEAR('2000-12-31') weekofyear;

SELECT 
    WEEKDAY('2000-12-31') weekday,
    WEEK('2000-12-31',1) week,
    WEEKOFYEAR('2000-12-31') weekofyear;

CREATE TABLE binary_demo(	
    id INT AUTO_INCREMENT PRIMARY KEY,
    data BINARY(32) -- 32 bytes for SHA-256
);

CREATE TABLE binary_demo(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data BINARY(32) -- 32 bytes for SHA-256
);

INSERT INTO binary_demo(data) 
VALUES (UNHEX(SHA2('Hello', 256)));

SELECT HEX(data) 
FROM binary_demo WHERE id = 1;

-- MySQL VARBINARY Data Type
CREATE TABLE varbinary_demo(
   id INT AUTO_INCREMENT PRIMARY KEY,
   data VARBINARY(256)
);

INSERT INTO varbinary_demo(data) 
VALUES('Hello');

SELECT * FROM varbinary_demo;

-- ===========
-- MySQL BLOB
CREATE TABLE images (
   id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(255) NOT NULL,
   image_data LONGBLOB NOT NULL
);

SELECT @@secure_file_priv;

INSERT INTO images (title,image_data) 
VALUES ('MySQL tutorial', LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/logo.png'));

SELECT * FROM images;

-- ==================
-- MySQL ENUM
CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL
);

INSERT INTO tickets(title, priority)
VALUES('Scan virus for computer A', 'High');

INSERT INTO tickets(title, priority)
VALUES('Upgrade Windows OS for all computers', 1);

INSERT INTO tickets(title, priority)
VALUES('Install Google Chrome for Mr. John', 'Medium'),
      ('Create a new user for the new employee David', 'High');     

INSERT INTO tickets(title)
VALUES('Refresh the computer of Ms. Lily');

INSERT INTO tickets(title, priority)
VALUES('Invalid ticket',-1);

-- Filtering MySQL ENUM values
SELECT 
  * 
FROM 
  tickets 
WHERE 
  priority = 'High';

SELECT 
  * 
FROM 
  tickets 
WHERE 
  priority = 3;

SELECT 
  title, 
  priority 
FROM 
  tickets 
ORDER BY 
  priority DESC;

-- MySQL JSON Data Type
CREATE TABLE products(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   properties JSON
);

-- Inserting JSON data into the table
INSERT INTO products(name, price, properties)
VALUES('T-Shirt', 25.99, '{"sizes":["S","M","L","XL"], "colors": ["white","black"]}');

-- Querying JSON data from the table
SELECT name, properties 
FROM products;

-- Getting the keys of a JSON document
SELECT JSON_KEYS(properties)
FROM products;

-- ==============================
-- MySQL UUID Smackdown: UUID vs. INT for Primary Key
SELECT UUID();

-- MySQL UUID vs. Auto-Increment INT as the primary key
CREATE TABLE customers (
    id BINARY(16) PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO customers(id, name)
VALUES(UUID_TO_BIN(UUID()),'John Doe'),
      (UUID_TO_BIN(UUID()),'Will Smith'),
      (UUID_TO_BIN(UUID()),'Mary Jane');

SELECT 
    BIN_TO_UUID(id) id, 
    name
FROM
    customers;

CREATE TABLE vendors(
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255),
    PRIMARY KEY(id)
);

INSERT INTO vendors(name)
VALUES('ABC Inc.');

SELECT 
    BIN_TO_UUID(id) id, 
    name
FROM
    vendors;


