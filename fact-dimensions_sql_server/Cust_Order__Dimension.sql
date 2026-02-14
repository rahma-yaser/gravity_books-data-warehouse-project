-- create database gravity_books_DWH;
-- Book Dimension
-- Step 1: Select the desired columns
use gravity_books;

select o.order_id,o.order_date

from dbo.cust_order as o;

-- Step 2: Creating the dimension
use gravity_books_DWH;
create table dim_cust_order
(
	cust_order_key int primary key identity(1,1),  --surrogate key
	order_id_bk INT, -- bk
    order_date datetime,

	--Metadata
	source_system_code tinyint not null,
	-- SCD
	start_date datetime,
	end_date datetime,
	is_current tinyint not null,
);


--Step 3: select the dimension after the assignment
select * from dim_cust_order;
select * from dim_cust_order where order_id_bk = 5;