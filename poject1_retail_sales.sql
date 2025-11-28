show databases;

use sql_projects;


drop table if exists retail_sales;

create table retail_sales 
        ( 
			transaction_id int primary key,
				sale_date	date,
				sale_time   time,
				customer_id  int,
				gender	    varchar(15),
				age	        int,
				category	varchar(15),
				quantiy	    int,
				price_per_unit	float,
				cogs	        float,
				total_sale      float
         );
         
         
       select * from retail_sales;
       
       select count(*) from retail_sales;
       -- 1987
       
drop table if exists retail_sales;

create table retail_sales 
        ( 
			transaction_id int primary key,
				sale_date	date,
				sale_time   time,
				customer_id  int,
				gender	    varchar(15),
				age	        int,
				category	varchar(15),
				quantiy	    int,
				price_per_unit	float,
				cogs	        float,
				total_sale      float
         );
         
         
  ALTER TABLE retail_sales
  MODIFY age INT NULL,
  MODIFY quantiy INT NULL;
  
  select count(*) from retail_sales;
  -- 1987

-- SHOW VARIABLES LIKE 'secure_file_priv';


  drop table if exists retail_sales;

create table retail_sales 
        ( 
			transaction_id int primary key,
				sale_date	date,
				sale_time   time,
				customer_id  int,
				gender	    varchar(15),
				age	        int,
				category	varchar(15),
				quantiy	    int,
				price_per_unit	float,
				cogs	        float,
				total_sale      float
         );       

select * from retail_sales;
-- so here I made the blanks as null first in the dataset,changed the date column in yyyy/mm/dd format
-- and then imported it into mysql it worked
-- mysql doesnt take blank values
-- as well if date is there,it should be in yyyy/mm/dd format

-- but one thing happened I didnt get transaction id column as it is-- no I got it ,it just that it automatically was in ascneding after imported

select count(*) from retail_sales;

select * from retail_sales
limit 2000;




-- Data Cleaning



SELECT *
FROM retail_sales
WHERE age IS NULL;
   -- OR quantiy = '';
   -- bu anyway while importing mysql doesnt take blank values,you have to convert blank into null first

SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_count,
    SUM(CASE WHEN quantiy = '' THEN 1 ELSE 0 END) AS blank_count
FROM retail_sales;

SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_count,
    SUM(CASE WHEN quantiy IS NULL THEN 1 ELSE 0 END) AS null_count1
FROM retail_sales;

-- another way

select count(*)
from retail_sales
where age is null;

select count(*)
from retail_sales
where quantiy is null;

select * from retail_sales
where 
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null;


-- SELECT AVG(age) FROM retail_sales;


UPDATE retail_sales
SET age = (SELECT avg(age) FROM retail_sales)
WHERE age IS NULL;
-- that didnot take

UPDATE retail_sales
SET age = (
    SELECT avg_age FROM (
        SELECT AVG(age) AS avg_age
        FROM retail_sales
    ) AS t
)
WHERE age IS NULL;


select * from retail_sales
where age is null;

-- avg age is given for null values here

select * from retail_sales
limit 200;


rollback;
-- did not work

select * from retail_sales
limit 200;

-- instead of updating just age with avg we can do following as well based on other columns


/*
SELECT
    gender,
    category,
    AVG(age) AS average_age_in_group
FROM
    retail_sales
WHERE
    age IS NOT NULL -- Only consider existing ages for the average
GROUP BY
    gender,
    category;
*/


select * from retail_sales
limit 2000;


select * from retail_sales
where 
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null;



delete from retail_sales
where 
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null;



select count(*) from retail_sales;
-- 1997


select * from retail_sales
where 
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null;




-- Data Exploration




select * from retail_sales;

-- How many sales we have?

select count(*) as total_sales 
from retail_sales;

-- How many uniuque customers we have ?

select count(distinct customer_id ) as distinct_cust_id from retail_sales;

select distinct category from retail_sales;



-- Data Analysis & Business Key Problems & Answers


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022



select * from retail_sales
where category = 'clothing'
and
month(sale_date) = 11
and 
year(sale_date) = 2022
and 
quantiy >= 4;

-- as per YT video
/*
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
*/

 select DATE_FORMAT(sale_date, '%Y-%m') AS month_year
FROM retail_sales;

select DATE_FORMAT(sale_date, '%Y-%M') AS month_year
FROM retail_sales;

select * from retail_sales
where 
sale_date in (
             select date_format(sale_date,'%Y-%m') as new_date
             from retail_sales
			)
and
category = 'clothing'
and
quantiy >= 4;
            
-- that did not work



SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022'
  AND quantiy >= 4;
  
  
  
       
SELECT *
FROM retail_sales
WHERE DATE_FORMAT(sale_date, '%Y-%m') IN (
        SELECT DATE_FORMAT(sale_date, '%Y-%m')
        FROM retail_sales
      )
  AND category = 'Clothing'
  AND quantiy >= 4;
  
  -- this is the right way,but we don't need subquery here
  
  
  
  -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
  
  
select category,sum(total_sale) as total_sales from retail_sales
group by category;

select category,sum(total_sale)as total_sales,COUNT(*) as total_orders  from retail_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select count(*),category,avg(age) as avg_age from retail_sales
where category = 'Beauty';

-- by YT video
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- I want to see what are the customers there
select * from retail_sales
where 
category = 'Beauty' 
and
avg(age) in (select avg(age) as avg_age from retail_sales);

-- something wrong


SELECT 
    *,
    (
    SELECT AVG(age) FROM retail_sales WHERE category = 'Beauty'
    ) AS avg_age_beauty
FROM retail_sales
 WHERE category = 'Beauty';
-- here subquery is in selecy statement itself
-- it Show all Beauty customers + overall average age


SELECT *
FROM retail_sales
WHERE category = 'Beauty'
  AND age = (
      SELECT AVG(age)
      FROM retail_sales
      WHERE category = 'Beauty'
  );
  -- query is right but did not work
  -- it will work  if you only want customers whose age equals the average age of Beauty customers
-- here subquery is for age in where statement



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales;

select * from retail_sales
where total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.


select category,gender,count(*) as total_trans
from retail_sales
group by category,gender
order by category;-- optional


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from retail_sales;

select 
year(sale_date) as yearly_sale ,
month(sale_date) as monthly_sale,
avg(total_sale) as avg_sale
from retail_sales
group by yearly_sale,monthly_sale
order by yearly_sale,monthly_sale;



select 
year(sale_date) as yearly_sale ,
month(sale_date) as monthly_sale,
avg(total_sale) as avg_sale
from retail_sales
group by yearly_sale,monthly_sale
order by yearly_sale,avg_sale desc;
-- this will give year in ascending and avg_sale in desc i.e most sale in which month of which year
-- clearly we want 7th month in 2022 as most_avg_sale and 2nd month in 2023.



select 
year(sale_date) as yearly_sale ,
month(sale_date) as monthly_sale,
avg(total_sale) as avg_sale,
rank() over (partition by year(sale_date) order by avg(total_sale)desc) as rank_position
from retail_sales
group by yearly_sale,monthly_sale;
-- order by yearly_sale,avg_sale desc;

-- so we got highest avg_sale that we want in 1st position as per rank function used here




select * from
(
select 
year(sale_date) as yearly_sale ,
month(sale_date) as monthly_sale,
avg(total_sale) as avg_sale,
rank() over (partition by year(sale_date) order by avg(total_sale)desc) as rank_position
from retail_sales
group by yearly_sale,monthly_sale
) as t1
where rank_position = 1;



select 
yearly_sale,
monthly_sale,
avg_sale
from
(
		select 
		year(sale_date) as yearly_sale ,
		month(sale_date) as monthly_sale,
		avg(total_sale) as avg_sale,
		rank() over (partition by year(sale_date) order by avg(total_sale)desc) as rank_position
		from retail_sales
		group by yearly_sale,monthly_sale
) as t1
where rank_position = 1;
-- the above solution is using subquery



-- we can do it using CTE as well

with avg_sales as 
(
        select 
		year(sale_date) as yearly_sale ,
		month(sale_date) as monthly_sale,
		avg(total_sale) as avg_sale,
		rank() over (partition by year(sale_date) order by avg(total_sale)desc) as rank_position
		from retail_sales
		group by yearly_sale,monthly_sale
)
select yearly_sale, monthly_sale,avg_sale
from avg_sales 
where rank_position = 1;




-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select 
customer_id ,
sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;



SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;




-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
count(distinct customer_id) as unique_customers,
category
from retail_sales
group by category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_orders as 
(
		select * ,
		case
		 when hour(sale_time) < 12 then 'Morning'
		 when hour(sale_time) between 12 and 17 then 'afternoon'
         else 'evening'
		--  when hour(sale_time) >17 then 'evening'
		 end  as shift 
		from retail_sales
)
select 
shift,
count(*)
from hourly_orders
group by shift;

-- mine query result is different from his,I guess while importing ,sale_time column has been updated by me.



