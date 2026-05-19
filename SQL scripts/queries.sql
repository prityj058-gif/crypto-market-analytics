 USE crypto_market;
 
 CREATE TABLE crypto_prices (
    start_date DATE,
    end_date DATE,
    open_price FLOAT,
    high_price FLOAT,
    low_price FLOAT,
    close_price FLOAT,
    volume BIGINT,
    market_cap FLOAT,
    daily_return FLOAT,
    volatility FLOAT,
    market_trend VARCHAR(20),
    moving_avg_7 FLOAT,
    crash_flag VARCHAR(20),
    market_cap_growth FLOAT
); 

SELECT 
    *
FROM
    crypto_prices
LIMIT 10;

----------- Highest Trading Volume Days ------------
 SELECT 
    start_date, volume
FROM
    crypto_prices
ORDER BY volume DESC
LIMIT 10;

-----------  Bullish vs Bearish Market Analysis ------------
SELECT 
    market_trend, COUNT(*) AS total_days
FROM
    crypto_prices
GROUP BY market_trend;

----------- Top 10 Most Volatile Days ------------
SELECT 
    start_date, volatility
FROM
    crypto_prices
ORDER BY volatility DESC
LIMIT 10;

-----------  Crash Detection Query ------------ 
SELECT 
    start_date, daily_return
FROM
    crypto_prices
WHERE
    daily_return < - 10
ORDER BY daily_return ASC;

----------- Highest Single-Day Gain   ------------ 
 SELECT 
    start_date, daily_return
FROM
    crypto_prices
ORDER BY daily_return DESC
LIMIT 1;

----------- Monthly Average Closing Price   ------------ 
  SELECT 
    YEAR(start_date) AS year_num,
    MONTH(start_date) AS month_num,
    AVG(close_price) AS avg_close_price
FROM
    crypto_prices
GROUP BY YEAR(start_date) , MONTH(start_date)
ORDER BY year_num , month_num;

-----------  Volume Spike Detection  ------------
   SELECT 
    start_date, volume
FROM
    crypto_prices
WHERE
    volume > (SELECT 
            AVG(volume)
        FROM
            crypto_prices)
ORDER BY volume DESC;

----------- Price Range Analysis   ------------ 
    SELECT 
    start_date, (high_price - low_price) AS price_range
FROM
    crypto_prices
ORDER BY price_range DESC
LIMIT 10;

-----------  Market Cap Growth Analysis  ------------ 
  SELECT 
    start_date, market_cap_growth
FROM
    crypto_prices
ORDER BY market_cap_growth DESC
LIMIT 10;

-----------   Moving Average Trend Analysis  ------------ 
SELECT 
    start_date, close_price, moving_avg_7
FROM
    crypto_prices
WHERE
    close_price > moving_avg_7;