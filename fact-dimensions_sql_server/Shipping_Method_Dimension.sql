-- create database gravity_books_DWH;
-- Book Dimension
-- Step 1: Select the desired columns
use gravity_books;

select m.method_id, m.method_name, m.cost

from dbo.shipping_method as m;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table dim_shipping_method
(
	Sh_method_key int primary key identity(1,1),  --surrogate key
	method_id_bk INT, -- bk
    method_name VARCHAR(100),
    cost DECIMAL(6, 2),

	--Metadata
	source_system_code tinyint not null,
	-- SCD
	start_date datetime,
	end_date datetime,
	is_current tinyint not null,
);


--Step 3: select the dimension after the assignment
select * from dim_shipping_method;
select * from dim_shipping_method where method_id_bk = 5;