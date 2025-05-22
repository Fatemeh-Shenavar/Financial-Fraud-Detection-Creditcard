CREATE SCHEMA finance;
USE finance;
CREATE TABLE finance.cc_data (
    `index` INT,
    trans_date_trans_time TIMESTAMP,
    cc_num BIGINT,
    merchant VARCHAR(255),
    category VARCHAR(100),
    amt DECIMAL(10,2),
    first VARCHAR(100),
    last VARCHAR(100),
    gender CHAR(1),
    street VARCHAR(255),
    city VARCHAR(100),
    state CHAR(2),
    zip INT,
    lat DECIMAL(9,6),
    `long` DECIMAL(9,6),
    city_pop INT,
    job VARCHAR(150),
    dob DATE,
    trans_num VARCHAR(100),
    unix_time BIGINT,
    merch_lat DECIMAL(9,6),
    merch_long DECIMAL(9,6),
    is_fraud TINYINT
);
CREATE TABLE finance.location_data (
    cc_num BIGINT,
    lat DECIMAL(9,6),
    `long` DECIMAL(9,6)
);

SELECT COUNT(*) AS total_transactions
FROM finance.cc_data;

SELECT category, AVG(amt) AS average_amount
FROM cc_data
GROUP BY category
ORDER BY average_amount DESC;

SELECT 
    SUM(is_fraud) AS total_fraud_transactions,
    COUNT(*) AS total_transactions,
    (SUM(is_fraud) / COUNT(*)) * 100 AS fraud_percentage
FROM finance.cc_data;

SELECT 
    c.trans_num,
    c.cc_num,
    c.amt,
    l.lat,
    l.long
FROM finance.cc_data c
JOIN finance.location_data l
ON c.cc_num = l.cc_num;

SELECT city, MAX(city_pop) AS highest_population
FROM finance.cc_data
GROUP BY city
ORDER BY highest_population DESC
LIMIT 1;

SELECT 
    MIN(trans_date_trans_time) AS earliest_transaction,
    MAX(trans_date_trans_time) AS latest_transaction
FROM finance.cc_data;

SELECT SUM(amt) AS total_amount_spent
FROM finance.cc_data;

SELECT category, COUNT(*) AS transaction_count
FROM finance.cc_data
GROUP BY category
ORDER BY transaction_count DESC;

SELECT gender, AVG(amt) AS avg_transaction_amount
FROM finance.cc_data
GROUP BY gender;

SELECT 
    DAYNAME(trans_date_trans_time) AS day_of_week,
    AVG(amt) AS avg_amount
FROM finance.cc_data
GROUP BY day_of_week
ORDER BY avg_amount DESC
LIMIT 1;

