-- NIM: 243307017
-- NAMA: MUHAMMAD FALICH FARISY
-- DIGIT TERAKHIR = GANJIL
-- 1 DIGIT TERAKHIR = 9
-- 2 DIGIT TERAKHIR = 17
-- KARAKTER PERTAMA NAMA = F

-- PRAKTIKUM 1
select * 
from customers
order by customerName asc;

-- PRAKTIKUM 2
select *
from employees
where officeCode = 17;

-- PRAKTIKUM 3
select distinct country
from customers
order by country desc
limit 10;

-- PRAKTIKUM 4
select *
from products
where buyPrice > 50 and productLine= 'Classic Cars';

-- PRAKTIKUM 5
select *
from customers
where city not in ('USA', 'Canada', 'UK');

-- PRAKTIKUM 6
select * 
from orders
where orderDate between '2004-01-01' and '2004-12-31' and orderNumber between 10217 and 10242;

-- PRAKTIKUM 7
select customerName
from customers
where customerName like 'F%';

-- PRAKTIKUM 8
select *
from products
order by productName desc
limit 7;

-- PRAKTIKUM 9
select *
from payments
where checkNumber is null
order by paymentDate desc;

-- PRAKTIKUM 10
select *
from products
where buyPrice > 17 and productLine= 'Classic Cars'
order by productName asc
limit 17; 