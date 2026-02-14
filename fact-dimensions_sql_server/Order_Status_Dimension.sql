-- create database gravity_books_DWH;
-- Book Dimension
-- Step 1: Select the desired columns
use gravity_books;

select status_id ,
    status_value 

from order_status;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table dim_status
(
	O_status_key int primary key identity(1,1),  --surrogate key
	status_id_bk INT,
    status_value VARCHAR(20),

	--Metadata
	source_system_code tinyint not null,
	-- SCD
	start_date datetime,
	end_date datetime,
	is_current tinyint not null,
);


--Step 3: select the dimension after the assignment
select * from dim_status;
select * from dim_status where O_status_key = 5;