-- create database gravity_books_DWH;
-- Book Dimension
-- Step 1: Select the desired columns
use gravity_books;

select cust.customer_id, cust.first_name, cust.last_name, cust.email,
custaddr.address_id, custaddr.status_id,
addr.street_number, addr.street_name, addr.city,
addrstat.address_status,
cntry.country_id, cntry.country_name

from dbo.customer as cust
left join dbo.customer_address as custaddr
on cust.customer_id=custaddr.customer_id
left join dbo.address as addr
on custaddr.address_id=addr.address_id
left join dbo.address_status as addrstat
on custaddr.status_id=addrstat.status_id
left join country as cntry
on addr.country_id=cntry.country_id;

ALTER TABLE dbo.customer
  ALTER COLUMN first_name      NVARCHAR(500)   NULL;
ALTER TABLE dbo.customer
  ALTER COLUMN last_name       NVARCHAR(500)   NULL;
ALTER TABLE dbo.customer
  ALTER COLUMN email           NVARCHAR(500)   NULL;   -- or NVARCHAR(254) if you prefer standard
ALTER TABLE dbo.address
  ALTER COLUMN street_number   NVARCHAR(500)    NULL;   -- you planned to store "Unknown" as text
ALTER TABLE dbo.address
  ALTER COLUMN street_name     NVARCHAR(500)   NULL;
ALTER TABLE dbo.address
  ALTER COLUMN city            NVARCHAR(500)   NULL;
ALTER TABLE dbo.address_status
  ALTER COLUMN address_status  NVARCHAR(500)    NULL;
ALTER TABLE dbo.country
  ALTER COLUMN country_name    NVARCHAR(500)   NULL;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table dim_customer
(
	cust_key int primary key identity(1,1),  --surrogate key
	customer_id_bk INT,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350),
	address_id INT,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
	status_id INT,
    address_status VARCHAR(30),
	country_id INT,
    country_name VARCHAR(200),

	--Metadata
	source_system_code tinyint not null,
	-- SCD
	start_date datetime,
	end_date datetime,
	is_current tinyint not null,
);

-- Modifications
ALTER TABLE dbo.dim_customer
  ALTER COLUMN first_name      NVARCHAR(500)   NULL;
ALTER TABLE dbo.dim_customer
  ALTER COLUMN last_name       NVARCHAR(500)   NULL;
ALTER TABLE dbo.dim_customer
  ALTER COLUMN email           NVARCHAR(500)   NULL;   -- or NVARCHAR(254) if you prefer standard
ALTER TABLE dbo.dim_customer
  ALTER COLUMN street_number   NVARCHAR(500)    NULL;   -- you planned to store "Unknown" as text
ALTER TABLE dbo.dim_customer
  ALTER COLUMN street_name     NVARCHAR(500)   NULL;
ALTER TABLE dbo.dim_customer
  ALTER COLUMN city            NVARCHAR(500)   NULL;
ALTER TABLE dbo.dim_customer
  ALTER COLUMN address_status  NVARCHAR(500)    NULL;
ALTER TABLE dbo.dim_customer
  ALTER COLUMN country_name    NVARCHAR(500)   NULL;

-- INT columns stay as they are:
-- customer_id_bk, address_id, status_id, country_id


--Step 3: select the dimension after the assignment
select * from dim_customer;
select * from dim_customer where customer_id_bk = 5;