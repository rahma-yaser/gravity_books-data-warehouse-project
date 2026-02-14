-- Sales Fact Table
-- Step 1: Select the desired columns
use gravity_books;


SELECT 
    o.order_id,
	MAX(CASE WHEN os.status_value = 'Order Received' THEN oh.status_date END) AS received,
	MAX(CASE WHEN os.status_value = 'Pending Delivery' THEN oh.status_date END) AS PendingDelivery,
	MAX(CASE WHEN os.status_value = 'Delivery In Progress' THEN oh.status_date END) AS DeliveryInProgress,
    MAX(CASE WHEN os.status_value = 'delivered' THEN oh.status_date END) AS delivered,
    MAX(CASE WHEN os.status_value = 'cancelled' THEN oh.status_date END) AS cancelled,
    MAX(CASE WHEN os.status_value = 'returned' THEN oh.status_date END) AS returned,
    o.customer_id,
    o.shipping_method_id AS method_id,
    sm.cost,
    MAX(oh.status_id) AS status_id FROM cust_order o
	LEFT JOIN order_history oh
    ON o.order_id = oh.order_id
	LEFT JOIN order_status os
    ON oh.status_id = os.status_id
	LEFT JOIN shipping_method sm
    ON o.shipping_method_id = sm.method_id
	GROUP BY 
		o.order_id, o.customer_id, o.shipping_method_id, sm.cost;


-- Step 2: Creating the dimension
use gravity_books_DWH;

CREATE TABLE fact_order_pipeline (
	order_sk INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    order_id int  null,
	received DATETIME  null, 
	PendingDelivery DATETIME  null,
	DeliveryInProgress DATETIME NULL, 
    delivered DATETIME NULL,
    cancelled DATETIME NULL,
    returned DATETIME NULL,
    customer_id INT NOT NULL,
    method_id INT NOT NULL,
    cost DECIMAL(6,2) NULL,
    status_id INT NULL,
);

--Step 3: select the dimension after the assignment
select * from fact_order_pipeline;
select * from fact_order_pipeline where order_sk = 5;
