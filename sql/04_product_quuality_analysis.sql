-- 02 Data Analysis: Annual Product Category Quality Analysis
/** 1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun 
(Hint: Revenue adalah harga barang dan juga biaya kirim. 
Pastikan juga melakukan filtering terhadap order status yang tepat untuk menghitung pendapatan)**/

SELECT 
	EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
	SUM(ROUND((oi.price + oi.freight_value)::numeric,2)) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE order_status = 'delivered'
GROUP BY year;

/**2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun 
(Hint: Perhatikan filtering terhadap order status yang tepat untuk menghitung jumlah cancel order)**/
SELECT 
	EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
	COUNT(order_status) AS total_cancel
FROM orders
WHERE order_status = 'canceled'
GROUP BY year;

/**3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi 
untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)**/
WITH rank_revenue AS(
	SELECT 
		EXTRACT (YEAR FROM o.order_purchase_timestamp) AS year,
		p.product_category_name AS category,
		SUM(ROUND((oi.price + oi.freight_value)::numeric, 2)) AS total_revenue,
		RANK () OVER(
			PARTITION BY EXTRACT (YEAR FROM o.order_purchase_timestamp)
			ORDER BY SUM(ROUND((oi.price + oi.freight_value)::numeric, 2)) DESC
		) AS rank
	FROM orders o
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
	WHERE o.order_status = 'delivered'
	GROUP BY year, category
)
SELECT
	year,
	category,
	total_revenue
FROM rank_revenue
WHERE rank = 1;

/** 4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak 
untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)**/
WITH rank_cancel AS(
	SELECT
		EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
		p.product_category_name AS category,
		COUNT(oi.order_id) AS total_cancel,
		RANK () OVER(
			PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp)
			ORDER BY COUNT(oi.order_id) DESC
		) AS rank
	FROM orders o
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
	WHERE o.order_status = 'canceled'
	GROUP BY year, category
	)
SELECT
	year,
	category,
	total_cancel
FROM rank_cancel
WHERE rank = 1;

/** 5.Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel 
(Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih)**/
WITH total_revenue AS(
	SELECT 
		EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
		SUM(ROUND((oi.price + oi.freight_value)::numeric,2)) AS total_revenue
	FROM orders o
	JOIN order_items oi
	ON o.order_id = oi.order_id
	WHERE order_status = 'delivered'
	GROUP BY year
),

total_cancel AS(
	SELECT 
		EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
		COUNT(order_status) AS total_cancel
	FROM orders
	WHERE order_status = 'canceled'
	GROUP BY year
),

rank_revenue_cat AS(
	SELECT 
			EXTRACT (YEAR FROM o.order_purchase_timestamp) AS year,
			p.product_category_name AS category,
			SUM(ROUND((oi.price + oi.freight_value)::numeric, 2)) AS total_revenue,
			RANK () OVER(
				PARTITION BY EXTRACT (YEAR FROM o.order_purchase_timestamp)
				ORDER BY SUM(ROUND((oi.price + oi.freight_value)::numeric, 2)) DESC
			) AS rank
		FROM orders o
		JOIN order_items oi ON o.order_id = oi.order_id
		JOIN products p ON oi.product_id = p.product_id
		WHERE o.order_status = 'delivered'
		GROUP BY year, category
),


rank_cancel_cat AS(
	SELECT
			EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
			p.product_category_name AS category,
			COUNT(oi.order_id) AS total_cancel,
			RANK () OVER(
				PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp)
				ORDER BY COUNT(oi.order_id) DESC
			) AS rank
		FROM orders o
		JOIN order_items oi ON o.order_id = oi.order_id
		JOIN products p ON oi.product_id = p.product_id
		WHERE o.order_status = 'canceled'
		GROUP BY year, category
)

SELECT
	tr.year,
	rrc.category,
	tr.total_revenue,
	rcc.category,
	tc.total_cancel
FROM total_revenue tr
JOIN rank_revenue_cat rrc ON tr.year = rrc.year AND rrc.rank = 1
JOIN rank_cancel_cat rcc ON rrc.year = rcc.year AND rcc.rank = 1
JOIN total_cancel tc ON rcc.year = tc.year;