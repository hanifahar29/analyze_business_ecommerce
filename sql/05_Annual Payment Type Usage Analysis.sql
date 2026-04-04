-- 05. Data Analysis: Annual Payment Type Usage Analysis
/** 1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit 
(Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)**/
SELECT
	payment_type,
	COUNT(order_id) AS total_payment
FROM order_payments
GROUP BY payment_type
ORDER BY COUNT(order_id) DESC;

/** 2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun 
(Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)**/
SELECT
	EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
	COUNT(CASE WHEN op.payment_type = 'credit_card' THEN 1 END) AS credit_card,
	COUNT(CASE WHEN op.payment_type = 'boleto' THEN 1 END) AS boleto,
	COUNT(CASE WHEN op.payment_type = 'voucher'THEN 1 END) AS voucher,
	COUNT(CASE WHEN op.payment_type = 'debit_card' THEN 1 END) AS debit_card
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY year;
