-- DATA CLEANING
--=============================================================================

-------------------------------------------------------------------------------
-- 1. CUSTOMER
-------------------------------------------------------------------------------
-- 1.1 Check Total Rows
SELECT COUNT(*) AS total_customer FROM customers;

-- 1.2 Check Missing Value
SELECT 
	COUNT(*) - COUNT(customer_id)         	  	AS missing_customer_id,
    COUNT(*) - COUNT(customer_unique_id)    	AS missing_customer_unique_id,
    COUNT(*) - COUNT(customer_zip_code_prefix) 	AS missing_zip_code,
    COUNT(*) - COUNT(customer_city)         	AS missing_city,
    COUNT(*) - COUNT(customer_state)        	AS missing_state
FROM customers;

-- 1.3 Check Duplicate
SELECT 
	customer_id,
	COUNT(*) AS total_duplicate
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-----------------------------------------------------------------------------
-- 2. GEOLOCATION
-----------------------------------------------------------------------------
-- 2.1 Check total row geolocation
SELECT COUNT(*) AS total_rows_geo FROM geolocation ;

-- 2.2 Check data inconsistency (city name)
SELECT 
	DISTINCT(geolocation_zip_code_prefix),
	geolocation_city,
	geolocation_state
FROM geolocation 
ORDER BY geolocation_state, geolocation_city ;

-- 2.3 Check Missing Value
SELECT 
	COUNT(*) - COUNT(geolocation_zip_code_prefix) AS missing_zip_code_prefix,
    COUNT(*) - COUNT(geolocation_lat)    	AS missing_geolocation_lat,
    COUNT(*) - COUNT(geolocation_lng) 	AS missing_geolocation_lng,
    COUNT(*) - COUNT(geolocation_city)         	AS missing_geolocation_city,
    COUNT(*) - COUNT(geolocation_state)        	AS missing_geolocation_state
FROM geolocation;

-- 2.4 Check Duplicate
SELECT 
	geolocation_zip_code_prefix, 
	COUNT(*)
FROM geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;

-----------------------------------------------------------------------------
-- 3. ORDER ITEMS
-----------------------------------------------------------------------------
-- 3.1 Check Total Rows
SELECT COUNT(*) AS total_rows FROM order_items;

-- 3.2 Check Missing Value
SELECT 
	COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(order_item_id) AS missing_oder_item_id,
    COUNT(*) - COUNT(product_id) AS missing_product_id,
    COUNT(*) - COUNT(seller_id)	AS missing_seller_id,
	COUNT(*) - COUNT(shipping_limit_date) AS missing_shipping_limit_date,
	COUNT(*) - COUNT(price) AS missing_price,
	COUNT(*) - COUNT(freight_value) AS missing_freight_value
FROM order_items;

-- 3.3 Check negative or zero price
SELECT COUNT(*) AS invalid_price
FROM order_items
WHERE price <= 0;
 
-- 3.4 Check negative freight value
SELECT COUNT(*) AS invalid_freight
FROM order_items
WHERE freight_value < 0;

------------------------------------------------------------------------------
-- 4. ORDER PAYMENTS
------------------------------------------------------------------------------
-- 4.1 Check Total Rows
SELECT COUNT(*) AS total_rows FROM order_payments;

--4.2 Check Missing Value
SELECT 
	COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(payment_sequential) AS missing_payment_sequential,
    COUNT(*) - COUNT(payment_type) AS missing_payment_type,
    COUNT(*) - COUNT(payment_installments)	AS missing_payment_installments,
	COUNT(*) - COUNT(payment_value) AS missing_payment_value
FROM order_payments;

-- 4.3 Check distinct payment type
SELECT DISTINCT payment_type FROM order_payments;
 
-- 4.4 Check negative payment value
SELECT COUNT(*) AS invalid_payment_value
FROM order_payments
WHERE payment_value < 0;

----------------------------------------------------------------------------
-- 5. ORDER REVIEW
----------------------------------------------------------------------------
-- 5.1 Check Total Rows
SELECT COUNT(*) AS total_row FROM order_review;

-- 5.2 Check Missing Value
SELECT 
	COUNT(*) - COUNT(review_id) AS missing_review_id,
	COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(review_score) AS missing_review_score,
    COUNT(*) - COUNT(review_comment_title) AS missing_review_comment_title,
    COUNT(*) - COUNT(review_comment_message) AS missing_review_comment_message,
	COUNT(*) - COUNT(review_creation_date) AS missing_review_creation_date,
	COUNT(*) - COUNT(review_answer_timestamp) AS missing_review_answer_timestamp
FROM order_review;

-- 5.3 Check Duplicate
SELECT 
	review_id,
	COUNT(*) AS total_duplicate
FROM order_review
GROUP BY review_id
HAVING COUNT(*) > 1;

-----------------------------------------------------------------------------------
-- 6. ORDERS
-----------------------------------------------------------------------------------
-- 6.1 Check Total Rows
SELECT COUNT(*) AS total_rows FROM orders;

-- 6.2 Check Missing Value
SELECT 
	COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(customer_id) AS missing_customer_id,
    COUNT(*) - COUNT(order_status) AS missing_order_status,
    COUNT(*) - COUNT(order_purchase_timestamp) AS missing_order_purchase_timestamp,
	COUNT(*) - COUNT(order_approved_at) AS missing_order_approved_at,
	COUNT(*) - COUNT(order_delivered_carrier_date) AS missing_order_delivered_carrier_date,
	COUNT(*) - COUNT(order_delivered_customer_date) AS missing_order_delivered_customer_date,
	COUNT(*) - COUNT(order_estimated_delivery_date) AS missing_order_estimated_delivery_date
FROM orders;

-- 6.3 Check Duplicate
SELECT 
	order_id,
	COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-------------------------------------------------------------------------------
-- 7. PRODUCT
-------------------------------------------------------------------------------
-- 7.1 Check Total Row
SELECT COUNT(*) AS total_row FROM products;

-- 7.2 Check Missing Value
SELECT
    COUNT(*) - COUNT(product_id)                AS missing_product_id,
    COUNT(*) - COUNT(product_category_name)     AS missing_category_name,
    COUNT(*) - COUNT(product_weight_g)          AS missing_weight,
    COUNT(*) - COUNT(product_length_cm)         AS missing_length,
    COUNT(*) - COUNT(product_height_cm)         AS missing_height,
    COUNT(*) - COUNT(product_width_cm)          AS missing_width
FROM products;

-- 7.3 Check distinct category
SELECT DISTINCT product_category_name 
FROM products 
ORDER BY product_category_name;
SELECT * FROM products;

-------------------------------------------------------------------------------
-- 8. SELLERS
-------------------------------------------------------------------------------
-- 8.1 Check total rows
SELECT COUNT(*) AS total_rows FROM sellers;

-- 8.2 Check missing values
SELECT
    COUNT(*) - COUNT(seller_id)             AS missing_seller_id,
    COUNT(*) - COUNT(seller_zip_code_prefix) AS missing_zip_code,
    COUNT(*) - COUNT(seller_city)           AS missing_city,
    COUNT(*) - COUNT(seller_state)          AS missing_state
FROM sellers;

-- 8.3 Check Duplicate
SELECT 
	seller_id,
	COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
