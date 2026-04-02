-- CREATE TABLE
-- create table products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	product_id VARCHAR (50) PRIMARY KEY,
	product_category_name VARCHAR (70),	
	product_name_lenght INT, 
	product_description_lenght INT,	
	product_photos_qty	INT,
	product_weight_g INT,
	product_length_cm INT, 
	product_height_cm INT,	
	product_width_cm INT
);

-- create table sellers
DROP  TABLE IF EXISTS sellers;
CREATE TABLE sellers(
	seller_id	VARCHAR (40) PRIMARY KEY,
	seller_zip_code_prefix	INT,
	seller_city	VARCHAR (40),
	seller_state VARCHAR (40)
);

-- create table customers
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id	VARCHAR(40) PRIMARY KEY,
	customer_unique_id VARCHAR(40),
	customer_zip_code_prefix INT,
	customer_city	VARCHAR(40),
	customer_state VARCHAR(10)
);

-- create table geolocation
DROP TABLE IF EXISTS geolocation;
CREATE TABLE geolocation(
	geolocation_zip_code_prefix	VARCHAR (10),
	geolocation_lat	FLOAT,
	geolocation_lng	FLOAT,
	geolocation_city VARCHAR(40),
	geolocation_state VARCHAR(10)
);

-- create table order_items
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items(
	order_id VARCHAR(40),
 	order_item_id	INT,
	product_id	VARCHAR(50),
	seller_id	VARCHAR (40),
	shipping_limit_date	DATE,
	price	FLOAT,
	freight_value FLOAT
);

-- create table order_payments
DROP TABLE IF EXISTS order_payments;
CREATE TABLE order_payments(
	order_id VARCHAR(40),	
	payment_sequential INT,
	payment_type	VARCHAR(40),
	payment_installments INT,
	payment_value FLOAT
);

-- create table order_review
DROP TABLE IF EXISTS order_review;
CREATE TABLE order_review(
	review_id	VARCHAR(40),
	order_id VARCHAR(40),
	review_score INT,
	review_comment_title VARCHAR(40),
	review_comment_message VARCHAR(500),
	review_creation_date DATE,
	review_answer_timestamp DATE
);

-- create table orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id VARCHAR(40) PRIMARY KEY,
	customer_id VARCHAR(40),
	order_status VARCHAR(15),
	order_purchase_timestamp DATE,	
	order_approved_at DATE,
	order_delivered_carrier_date DATE,	
	order_delivered_customer_date DATE, 
	order_estimated_delivery_date DATE
);

-- ADD FOREIGN KEY
ALTER TABLE order_items
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_payments
ADD CONSTRAINT fk_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_review
ADD CONSTRAINT fk_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE orders
ADD CONSTRAINT fk_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);