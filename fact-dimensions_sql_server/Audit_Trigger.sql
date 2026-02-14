CREATE TABLE Audit_LatestOrder (
    FactBookOrderSK INT PRIMARY KEY,
    DateSK INT
);

INSERT INTO Audit_LatestOrder (FactBookOrderSK, DateSK)
SELECT TOP 1 fact_SK, date_key
FROM dbo.fact_orders
ORDER BY fact_SK DESC;

select *
from Audit_LatestOrder;

CREATE TRIGGER trg_UpdateLatestOrder
ON dbo.fact_orders
AFTER INSERT
AS
BEGIN
    DECLARE @LatestOrderSK INT, @LatestDateSK int;

    SELECT TOP 1 
        @LatestOrderSK = fact_SK,
        @LatestDateSK = date_key
    FROM dbo.fact_orders
    ORDER BY fact_SK DESC;

    UPDATE Audit_LatestOrder
    SET 
        FactBookOrderSK = @LatestOrderSK,
        DateSK = @LatestDateSK;
END;


--test
INSERT INTO fact_orders (
    line_id_bk,
    order_id_bk,
    book_key,
    customer_key,
    O_status_key,
    Sh_method_key,
    date_key,
    price,
    created_at
)
VALUES (
    101,       -- line_id_bk (business key from order_line)
    5001,      -- order_id_bk (business key from cust_order)
    12,        -- book_key (from dim_book)
    345,       -- customer_key (from dim_customer)
    2,         -- O_status_key (from dim_order_status)
    3,         -- Sh_method_key (from dim_shipping_method)
    20230912,  -- date_key (from dim_date, format yyyymmdd)
    25.50,     -- price (from order_line)
    '2023-09-12 14:30:00'  -- created_at (order_date from cust_order)
);
