
select co.order_id, co.order_date, c.customer_id, b.book_id, sm.method_id
from cust_order as co
left join customer as c
on co.customer_id = c.customer_id
left join order_line as ol
on ol.order_id = co.order_id
left join book as b
on ol.book_id = b.book_id
left join shipping_method as sm
on sm.method_id = co.shipping_method_id;