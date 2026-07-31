use forecasting_project;

-- total no. of customers 99441
select count(customer_id) as total_customers
from customers;

-- total no.of orders 96470
select count(order_id) as total_orders
from orders;

-- revenue 16008872.12
select round(sum(payment_value),2) as total_revenue
from payments;

-- monthly orders trend
select 
	year(order_purchase_timestamp) as year,
    month(order_purchase_timestamp) as month,
    count(order_id) as total_orders
from orders 
group by year,month
order by year,month;

-- daily orders trend
select 	
	date(order_purchase_timestamp) as order_date,
    count(order_id) as total_orders
from orders
group by order_date
order by order_date;

-- deleviry time analysis
select 
	round(
		avg(
			datediff(order_delivered_customer_date,
            order_purchase_timestamp)
			),2
        ) as avg_delivery_days
from orders
where order_status = 'delivered';


-- monthly delivery perfomance
select 
	month(order_purchase_timestamp) as month,
    
    round(
			avg(
				datediff(order_delivered_customer_date,
						 order_purchase_timestamp)
				),2
            ) as avg_delivery_days
from orders
where order_status = 'delivered'
group by month
order by month;

-- payment type used
select
	payment_type,count(*) as total_usage
from payments
group by payment_type
order by total_usage desc;

-- avrage payment values
select
	round(avg(payment_value),2) as avg_paymetn
from payments;

-- highest payment orders
select
	order_id,payment_value
from payments
order by payment_value desc
limit 10;

-- installment analysis
select 
	payment_installments,
    count(*) as total_orders
from payments
group by payment_installments
order by payment_installments;

-- product category distrubution
select 
	product_category_name,
    count(*) as total_products
from products
group by product_category_name
order by total_products desc
limit 10;

-- seller activity
select 
	seller_id,
    count(order_id) as total_orders
from order_items
group by seller_id
order by total_orders desc
limit 10;

-- shipping cost analysis
select 
	round(avg(freight_value),2) as avg_shipping_cost
from order_items;

-- expensive shipping orders
select 
	order_id,freight_value
from order_items
order by freight_value desc
limit 10;

-- state wise customer distribution
select 
	customer_state,
    count(*) as total_customers
from customers
group by customer_state
order by total_customers desc;

-- order status analysis
select
	order_status,
    count(*) as total_orders
from orders
group by order_status
order by total_orders desc;

-- yearly growth trend
select 
	year(order_purchase_timestamp) as year,
    count(order_id) as total_orders
from orders
group by year
order by year;

-- monthly peak sales month
select 
	month(order_purchase_timestamp) as month,
    count(order_id) as total_orders
from orders
group by month
order by total_orders desc
limit 5;

-- weekend vs weekday orders
select 
	case
		when dayofweek(order_purchase_timestamp) in (1,7)
        then 'weekend'
        else 'weekday'
	end as day_type,
	
    count(order_id) as total_orders
from orders
group by day_type;