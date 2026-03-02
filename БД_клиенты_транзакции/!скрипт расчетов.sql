
#количество активных пользователей по месяцам 
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(DISTINCT client_id) AS active_clients
FROM transactions
WHERE status = 'success'
GROUP BY month
ORDER BY month;

#ARPU (Average Revenue Per User) - за месяц
SELECT 
	DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(revenue) / COUNT(DISTINCT client_id) AS ARPU
FROM transactions
WHERE status = 'success'
GROUP BY month;

#выручка по продуктам
SELECT
    product_type,
    SUM(revenue) AS total_revenue
FROM transactions
WHERE status = 'success'
GROUP BY product_type;

#сравнение сегментов 
SELECT
	c.segment AS segment,
    COUNT(DISTINCT c.client_id) AS number_of_clients,
    SUM(revenue) AS total_revenue    
FROM clients AS c JOIN transactions AS t ON c.client_id = t.client_id
WHERE status = 'success'
GROUP BY segment;

#распределение продуктов по сегментам
SELECT
	c.segment AS segment,
    t.product_type AS product_type,
    COUNT(DISTINCT c.client_id) AS number_of_clients,
    SUM(revenue) AS total_revenue    
FROM clients AS c JOIN transactions AS t ON c.client_id = t.client_id
WHERE status = 'success'
GROUP BY segment, product_type;

