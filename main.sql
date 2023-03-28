.open createdb.db

DROP TABLE info;

CREATE TABLE info
(
    product_name VARCHAR(100),
    product_id VARCHAR(11) PRIMARY KEY,
    description VARCHAR(700)
);

DROP TABLE finance;

CREATE TABLE finance
(
    product_id VARCHAR(11) PRIMARY KEY,
    listing_price FLOAT,
    sale_price FLOAT,
    discount FLOAT,
    revenue FLOAT
);

DROP TABLE reviews;

CREATE TABLE reviews
(
    product_id VARCHAR(11) PRIMARY KEY,
    rating FLOAT,
    reviews FLOAT
);

DROP TABLE traffic;

CREATE TABLE traffic
(
    product_id VARCHAR(11) PRIMARY KEY,
    last_visited TIMESTAMP
);

DROP TABLE brands;

CREATE TABLE brands
(
    product_id VARCHAR(11) PRIMARY KEY,
    brand VARCHAR(7)
);

.mode csv
.separator , 
.import --skip 1 brands_v2.csv brands
.import --skip 1 finance.csv finance
.import --skip 1 info_v2.csv info
.import --skip 1 reviews_v2.csv reviews
.import --skip 1 traffic_v3.csv traffic

.mode column
.header on
SELECT * from reviews limit 5;

/*counting missing value*/
SELECT
    COUNT(*) AS total_rows,
    COUNT(i.description) AS count_description,
    COUNT(f.listing_price) AS count_listing_price,
    COUNT(t.last_visited) AS count_last_visited
FROM info AS i
JOIN finance AS f ON i.product_id = f.product_id
JOIN traffic AS t ON f.product_id = t.product_id;

/*Nike vs Adidas pricing*/
SELECT
    b.brand,
    CAST(f.listing_price AS int),
    COUNT(*) 
FROM finance AS f
JOIN brands AS b ON f.product_id = b.product_id
WHERE f.listing_price > 0
GROUP BY b.brand, f.listing_price
ORDER BY CAST(f.listing_price AS int) DESC;

/*Labeling price ranges*/
SELECT
    b.brand,
    COUNT(*),
    SUM(f.revenue) AS total_revenue,
    CASE
        WHEN f.listing_price < 42 THEN 'Budget'
        WHEN f.listing_price >= 42 AND f.listing_price < 74 THEN 'Average'
        WHEN f.listing_price >= 74 AND f.listing_price < 129 THEN 'Expensive' 
        ELSE 'Elite'
    END AS price_category
FROM finance AS f
JOIN brands AS b ON f.product_id = b.product_id
WHERE b.brand IS NOT NULL
GROUP BY b.brand, price_category
ORDER BY total_revenue DESC;

/*Average discount by brand*/
SELECT
    b.brand,
    AVG(f.discount)*100 AS average_discount
FROM finance AS f
INNER JOIN brands AS b
ON f.product_id = b.product_id
GROUP BY b.brand
HAVING b.brand IS NOT NULL
ORDER BY average_discount;

