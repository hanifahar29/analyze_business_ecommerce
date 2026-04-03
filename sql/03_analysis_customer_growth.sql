-- Data Analysis: Analysis Customer Growth
/**1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk setiap tahun 
(Hint: Perhatikan kesesuaian format tanggal)**/

SELECT
	year,
	ROUND(AVG(total_customer)) AS avg_monthly_cust
FROM (
	SELECT 
		COUNT(DISTINCT customer_id) AS total_customer,
		EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
		EXTRACT(YEAR FROM order_purchase_timestamp ) AS year
	FROM orders
	GROUP BY year, month
	) AS monthly_active
GROUP BY year
ORDER BY year;

/**2. Menampilkan jumlah customer baru pada masing-masing tahun 
(Hint: Pelanggan baru adalah pelanggan yang melakukan order pertama kali)**/
SELECT 
	year,
	COUNT(customer_unique_id)AS total_new_cust
FROM (
	SELECT
		c.customer_unique_id,
		EXTRACT(YEAR FROM MIN (o.order_purchase_timestamp)) AS year
	FROM orders o
	JOIN customers c
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id
	) AS first_orders
GROUP BY year
ORDER BY year;

/**3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) 
pada masing-masing tahun (Hint: Pelanggan yang melakukan repeat order adalah pelanggan yang 
melakukan order lebih dari 1 kali)**/
SELECT
	year,
	COUNT(customer_unique_id) AS total_cust_repeat
FROM (
	SELECT
		c.customer_unique_id,
		EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
		COUNT (o.order_id) AS total_order
	FROM customers c
	JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id, year
	HAVING COUNT (o.order_id) > 1
	) AS repeat_order
GROUP BY year;

/** 4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun 
(Hint: Hitung frekuensi order (berapa kali order) untuk masing-masing customer terlebih dahulu)**/
SELECT
	year,
	ROUND(AVG(total_order))AS avg_total_order
FROM (
	SELECT 
		c.customer_unique_id AS customer,
		COUNT(o.order_id) AS total_order,
		EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year
	FROM customers c
	JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY customer, year
	) AS frek_order
GROUP BY year;

/**5. Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel**/
WITH monthly_active_user AS(
	SELECT
		year,
		ROUND(AVG(total_customer)) AS avg_monthly_cust
	FROM (
		SELECT 
			COUNT(DISTINCT customer_id) AS total_customer,
			EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
			EXTRACT(YEAR FROM order_purchase_timestamp ) AS year
		FROM orders
		GROUP BY year, month
		) AS monthly_active
	GROUP BY year
),

new_customer AS(
	SELECT 
	year,
	COUNT(customer_unique_id)AS total_new_cust
	FROM (
		SELECT
			c.customer_unique_id,
			EXTRACT(YEAR FROM MIN (o.order_purchase_timestamp)) AS year
		FROM orders o
		JOIN customers c
		ON c.customer_id = o.customer_id
		GROUP BY c.customer_unique_id
		) AS first_orders
	GROUP BY year
),

repeat_customer AS (
	SELECT
		year,
		COUNT(customer_unique_id) AS total_cust_repeat
	FROM (
		SELECT
			c.customer_unique_id,
			EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
			COUNT (o.order_id) AS total_order
		FROM customers c
		JOIN orders o
		ON c.customer_id = o.customer_id
		GROUP BY c.customer_unique_id, year
		HAVING COUNT (o.order_id) > 1
		) AS repeat_order
	GROUP BY year
),

avg_order AS(
SELECT
	year,
	ROUND(AVG(total_order))AS avg_total_order
FROM (
	SELECT 
		c.customer_unique_id AS customer,
		COUNT(o.order_id) AS total_order,
		EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year
	FROM customers c
	JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY customer, year
	) AS frek_order
GROUP BY year
)

SELECT 
	mau.year,
	mau.avg_monthly_cust,
	nc.total_new_cust,
	rc.total_cust_repeat,
	ao.avg_total_order
FROM monthly_active_user mau
JOIN new_customer nc ON mau.year = nc.year
JOIN repeat_customer rc ON nc.year = rc.year
JOIN avg_order ao ON rc.year = ao.year
ORDER BY mau.year;
