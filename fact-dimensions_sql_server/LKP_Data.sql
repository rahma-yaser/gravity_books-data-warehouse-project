--create database gravity_books_DWH;
use gravity_books_DWH;

-- Book Dimension
select book_key,book_id_bk
from dim_books
where is_current=1;

--#########################################
-- Customer Dimension
select cust_key,customer_id_bk
from dim_customer
where is_current=1;

--#########################################
-- Ship Method Dimension
select Sh_method_key,method_id_bk
from dim_shipping_method
where is_current=1;

--#########################################
-- Status Dimension
select O_status_key,status_id_bk
from dim_status
where is_current=1;

--#########################################
-- Date Dimension
select DateSK,Date
from DimDate;