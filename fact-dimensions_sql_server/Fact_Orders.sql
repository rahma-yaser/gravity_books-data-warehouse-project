-- Sales Fact Table
-- Step 1: Select the desired columns
use gravity_books;
'
select ordline.line_id, ordline.order_id, ordline.price, 
custord.order_date

from dbo.order_line as ordline
left join dbo.cust_order as custord
on ordline.order_id = custord.order_id;
'
select 
ord_line.book_id, 
ord_line.line_id,  
ord_line.order_id,
ord_line.price,
cus_ord.order_date,
cus_ord.shipping_method_id,
cus_ord.customer_id,
ship.cost,
ship.method_name,
dd.DateSK,
ord_stat.status_id,
ord_stat.status_value

from [dbo].[order_line] as ord_line
inner join [dbo].[cust_order] as cus_ord
on ord_line.order_id=cus_ord.order_id
inner join [dbo].[shipping_method] as ship
on ship.method_id=cus_ord.shipping_method_id
inner join [dbo].[DimDate] as dd on convert(int,format(cus_ord.order_date,'yyyyMMdd'))=dd.DateSK
inner join [dbo].[order_history]as ord_hist
on ord_line.order_id=ord_hist.order_id
inner join [dbo].[order_status] ord_stat
on ord_hist.status_id=ord_stat.status_id;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table fact_orders
(
	fact_SK int primary key identity(1,1),  -- fact surrogate key
	line_id_bk INT,  -- business key1  „·ÊÊÊÊ‘ ·“„… ·«‰ ›ÌÂ fact_SK ????
    order_id_bk INT, -- business key2
	
	-- surrogate keys
	book_key int,
	customer_key int,
	O_status_key int,
	Sh_method_key int,
	date_key int,

	-- measure
    price DECIMAL(5, 2),
	created_at datetime  -- order_date in cust_order
);


--Step 3: select the dimension after the assignment
select * from fact_orders;
select * from fact_orders where fact_SK = 5;
