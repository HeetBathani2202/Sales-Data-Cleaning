Create table sales(
transaction_id int,
customer_id int,
customer_name varchar(50),
email varchar(50),
purchase_date varchar(20),
product_id int,
category varchar(20),
price numeric(10,2),
quantity int,
total_amount numeric(10,2),
payment_method varchar(20),
delivery_status varchar(20),
customer_address varchar(500)
)

select * from sales;

--Checking for duplicates--

select *,
		row_number() over (partition by transaction_id,customer_id,customer_name,email,purchase_date,product_id,category,price,quantity,total_amount,payment_method,delivery_status,customer_address) as row_num
from sales;


select * from
(
select *,
		row_number() over (partition by transaction_id,customer_id,customer_name,email,purchase_date,product_id,category,price,quantity,total_amount,payment_method,delivery_status,customer_address) as row_num
from sales
)
where row_num>1;


delete from sales 
where ctid in 
(
		select ctid from
			(
				select ctid,
				row_number() over (partition by transaction_id,customer_id,customer_name,email,purchase_date,product_id,category,price,quantity,total_amount,payment_method,delivery_status,customer_address) as row_num
				from sales
			)
			where row_num>1
)

--Treating null values datatypes --

select * from sales where transaction_id isnull;

select * from sales where customer_id isnull;

select * from sales where customer_name isnull;
Update sales
set customer_name = 'User'
where customer_name isnull;

select * from sales where email isnull;
select distinct email from sales;
select email from sales
where email not like '%@%';
Update sales
set email = null
where email not like '%@%';

select distinct purchase_date from sales;
Begin;
ALTER TABLE sales
ALTER COLUMN purchase_date TYPE DATE
USING CASE
        WHEN purchase_date ~ '^\d{2}-\d{2}-\d{4}$'
        THEN TO_DATE(purchase_date, 'DD-MM-YYYY')
        ELSE NULL
      End;
Rollback;
-- check
SELECT purchase_date FROM sales LIMIT 100;
SELECT * FROM sales WHERE purchase_date IS NULL;

select * from sales where product_id isnull;

select * from sales where category isnull;
select distinct category from sales; 
Update sales
set category = 'Unknown'
where category isnull;

select * from sales where price isnull;
select category, avg(price)
from sales
group by category;

"Unknown"	2511.4164052287581699
"Electronics"	2663.9278409090909091
"Toys"	2235.4716891891891892
"Home & Kitchen"	2507.0583783783783784
"Books"	2574.4573469387755102
"Clothing"	2539.2781871345029240

Update sales
set price = '2511.4164052287581699'
where price isnull and category = 'Unknown'
Update sales
set price = '2663.9278409090909091'
where price isnull and category = 'Electronics'
Update sales
set price = '2235.4716891891891892'
where price isnull and category = 'Toys'
Update sales
set price = '2507.0583783783783784'
where price isnull and category = 'Home & Kitchen'
Update sales
set price = '2574.4573469387755102'
where price isnull and category = 'Books'
Update sales
set price = '2539.2781871345029240'
where price isnull and category = 'Clothing'

select distinct quantity from sales;
select quantity from sales where quantity is null;
update sales
set quantity = abs(quantity)
where quantity<0;

Update sales
set total_amount = price*quantity
where total_amount isnull or total_amount <> price*quantity;

select distinct payment_method from sales;
Update sales
set payment_method = 'Credit Card'
where payment_method in ('creditcard' ,'CC' ,'credit');
Update sales
set payment_method = 'Cash'
where payment_method isnull;

select distinct delivery_status from sales;
UPDATE sales 
SET delivery_status='Not Delivered'
WHERE delivery_status IS NULL;

select customer_address from sales
where customer_address isnull;
Update sales
set customer_address = 'Not Available'
where customer_address isnull;

-- Date format is left --
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='sales'
