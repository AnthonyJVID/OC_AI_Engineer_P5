-------------------------------------------------------------------------------------------------------------
-- Requête 1

-- Commandes récentes de moins de 3 mois avec au moins 3 jours de retard (en excluant les commandes annulées)
-------------------------------------------------------------------------------------------------------------
SELECT order_id, customer_id, order_purchase_timestamp, order_estimated_delivery_date, order_delivered_customer_date
FROM orders
WHERE order_status <> 'canceled'
AND order_delivered_customer_date IS NOT NULL
AND DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date, '+3 days')
AND DATE(order_delivered_customer_date) >= DATE((SELECT MAX(order_purchase_timestamp) FROM orders), '-3 months')
ORDER BY order_delivered_customer_date DESC;
-------------------------------------------------------------------------------------------------------------
-- Version longue
-------------------------------------------------------------------------------------------------------------
WITH latest_order_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM orders
),
recent_delivered_orders AS (
    SELECT o.order_id, o.customer_id, o.order_delivered_customer_date, o.order_estimated_delivery_date
    FROM orders o
    WHERE o.order_status != 'canceled'
    AND DATE(o.order_delivered_customer_date) >= DATE((SELECT max_date FROM latest_order_date), '-3 months')
)
SELECT order_id, customer_id, order_delivered_customer_date, order_estimated_delivery_date
FROM recent_delivered_orders
WHERE DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date, '+3 days')
ORDER BY order_delivered_customer_date ASC;



-------------------------------------------------------------------------------------------------------------
-- Requête 2

-- Vendeurs ayant généré un chiffre d'affaires de plus de 100 000 Real sur des commandes livrées via Olist
-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
-- avec WITH & INNER JOIN
-------------------------------------------------------------------------------------------------------------
WITH seller_revenues AS (
    SELECT oi.seller_id, SUM(oi.price) AS total_revenue
    FROM order_items oi
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id
)
SELECT seller_id, total_revenue
FROM seller_revenues
WHERE total_revenue > 100000
ORDER BY total_revenue DESC;



-------------------------------------------------------------------------------------------------------------
-- Requête 3 (3 result)

-- Nouveaux vendeurs (moins de 3 mois d’ancienneté) ayant déjà vendu plus de 30 produits
-------------------------------------------------------------------------------------------------------------
SELECT s.seller_id, MIN(o.order_purchase_timestamp) AS first_sale_date, COUNT(oi.product_id) AS total_products_sold
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY s.seller_id
HAVING first_sale_date >= DATE((SELECT MAX(order_purchase_timestamp) FROM orders), '-3 months')
AND total_products_sold > 30;



-------------------------------------------------------------------------------------------------------------
-- Requête 4

-- Les 5 codes postaux avec plus de 30 avis et le pire score moyen sur les 12 derniers mois
-------------------------------------------------------------------------------------------------------------
WITH latest_order as(
select max(order_purchase_timestamp)
from orders
),
join_orders_geoloc as (
SELECT distinct o.order_id, o.order_purchase_timestamp,
c.customer_zip_code_prefix
FROM orders as o
INNER JOIN customers as c
ON o.customer_id = c.customer_id
),
average_review_score_per_zip as (
SELECT customer_zip_code_prefix,
AVG(review_score) as avg_review_score,
COUNT(review_score) as nb_reviews
FROM order_reviews as r
INNER JOIN join_orders_geoloc as o
on r.order_id = o.order_id
WHERE order_purchase_timestamp >= DATE((SELECT * from
latest_order), '-12 months')
GROUP BY customer_zip_code_prefix
)
SELECT * From average_review_score_per_zip
where nb_reviews > 30
order by avg_review_score
LIMIT 5;



-------------------------------------------------------------------------------------------------------------
-- INFORMATIONS SUPPLEMENTAIRES
-------------------------------------------------------------------------------------------------------------
-- Date d'achat la plus ancienne : 2016-09-04 21:15:19
-- Date d'achat la plus récente : 2018-10-17 17:30:18
-- Date de livraison la plus ancienne : 2016-10-11 13:46:32
-- Date de livraison la plus récente : 2018-10-17 13:22:46
-- Date de livraison estimée la plus ancienne : 2016-09-30 00:00:00
-- Date de livraison estimée la plus récente : 2018-11-12 00:00:00