-- Create a table that matches your CSV structure
CREATE TABLE store_orders (
    row_id VARCHAR(10),
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(25),
    customer_id VARCHAR(15),
    customer_name VARCHAR(100),
    segment VARCHAR(20),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(10),
    region VARCHAR(15),
    product_id VARCHAR(25),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10, 2),
    quantity INTEGER,
    discount DECIMAL(4, 2),
    profit DECIMAL(10, 2)
);
SET datestyle = 'SQL, MDY';

COPY store_orders
FROM 'C:\Users\Public\Downloads\sample_superstore.csv'
DELIMITER ',' 
CSV HEADER;

-- Check for NULL Values --
SELECT 
    COUNT(*) - COUNT(row_id) AS row_id_nulls,
    COUNT(*) - COUNT(order_id) AS order_id_nulls,
    COUNT(*) - COUNT(order_date) AS order_date_nulls,
    COUNT(*) - COUNT(ship_date) AS ship_date_nulls,
    COUNT(*) - COUNT(ship_mode) AS ship_mode_nulls,
    COUNT(*) - COUNT(customer_id) AS customer_id_nulls,
    COUNT(*) - COUNT(customer_name) AS customer_name_nulls,
    COUNT(*) - COUNT(segment) AS segment_nulls,
    COUNT(*) - COUNT(country) AS country_nulls,
    COUNT(*) - COUNT(city) AS city_nulls,
    COUNT(*) - COUNT(state) AS state_nulls,
    COUNT(*) - COUNT(postal_code) AS postal_code_nulls,
    COUNT(*) - COUNT(region) AS region_nulls,
    COUNT(*) - COUNT(product_id) AS product_id_nulls,
    COUNT(*) - COUNT(category) AS category_nulls,
    COUNT(*) - COUNT(sub_category) AS sub_category_nulls,
    COUNT(*) - COUNT(product_name) AS product_name_nulls,
    COUNT(*) - COUNT(sales) AS sales_nulls,
    COUNT(*) - COUNT(quantity) AS quantity_nulls,
    COUNT(*) - COUNT(discount) AS discount_nulls,
    COUNT(*) - COUNT(profit) AS profit_nulls
FROM store_orders;

------------ Total sales & profit by Month -----------
CREATE VIEW monthly_sales_profit AS
	SELECT 
        TO_CHAR(order_date, 'Mon, YYYY') AS month_year, -- Get month in string 'Jan, Feb, Mar...'
		SUM(sales) AS total_sales, 
		SUM(profit) AS total_profit
	FROM store_orders
	-- Group by numerical month
	GROUP BY month_year, EXTRACT(YEAR FROM order_date),EXTRACT(MONTH FROM order_date)
	-- Order by numerical month
	ORDER BY EXTRACT(YEAR FROM order_date) ASC, EXTRACT(MONTH FROM order_date) ASC;
SELECT * FROM monthly_sales_profit;

------------------ Total Revenue --------------------
CREATE VIEW total_customers_revenue AS
	WITH customers_revenue AS (
		SELECT customer_id, customer_name,
		SUM(sales) AS total_sales,
		SUM(profit) as total_profit
	FROM store_orders
	GROUP BY customer_id,  customer_name
	)
	SELECT 
		customer_id, customer_name, total_sales, total_profit
	FROM customers_revenue
	ORDER BY total_sales;
SELECT * FROM total_customers_revenue;

-- Top 10 Customers by revenue --
CREATE VIEW top_10_customers AS
	SELECT * FROM total_customers_revenue
	ORDER BY total_sales DESC LIMIT 10;
SELECT * FROM top_10_customers;

-- Loss-making Products/Categories --
CREATE VIEW loss_making_products AS
	WITH loss_made AS (
		SELECT category, sub_category, product_name,
		SUM(sales) AS total_sales,
		SUM(profit) as total_profit
	FROM store_orders
	GROUP BY category, sub_category, product_name
	)
	SELECT 
		category, sub_category, product_name, total_sales, total_profit
	FROM loss_made
	WHERE total_profit < 0
	ORDER BY total_profit ASC ;
SELECT * FROM loss_making_products;

-------------- Region Performance ---------------
CREATE VIEW region_sales AS
	WITH aggregated_region_sales AS (
	SELECT region, 
			SUM(sales) AS total_sales, 
			SUM(profit) as total_profit, 
			COUNT(DISTINCT order_id) AS order_count
	FROM store_orders
	GROUP BY region
	)
	SELECT 
		region, total_sales, total_profit, order_count,
		ROUND((total_profit/total_sales) * 100, 2) AS profit_margin_pct
	FROM aggregated_region_sales
	GROUP BY region, total_sales, total_profit, order_count
	ORDER BY total_sales DESC;
SELECT * FROM region_sales;

------------ First purchase date per customer -------- 
CREATE VIEW customer_first_purchase_date AS
	SELECT customer_id, customer_name, order_date
	FROM (
	    SELECT customer_id, customer_name, order_date,
	        -- "Tag" every row for a customer as 1,2,3... based on time.
			ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) as purchase_number
	    FROM store_orders
	) AS ranked_purchases
	-- By filtering '1' get the full record of their very first interaction
	WHERE purchase_number = 1
	ORDER BY order_date;
SELECT * FROM customer_first_purchase_date

-------------- Customer repeat purchase rate ---------------
CREATE VIEW customer_repeat_purchase_rate AS
	WITH customer_order_counts AS (
    -- Step 1: Count unique orders for each customer
	    SELECT 
	        customer_id, 
	        COUNT(DISTINCT order_id) AS total_orders
	    FROM store_orders
	    GROUP BY customer_id
		),
	repeat_metrics AS (
	-- Step 2: Categorize customers as "Repeat" (1) or "Single" (0)
	    SELECT 
	        COUNT(*) AS total_customers,
	        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers
	    FROM customer_order_counts
	)
	-- Step 3: Calculate the percentage
	SELECT 
	    total_customers, repeat_customers,
	    ROUND((repeat_customers::NUMERIC / total_customers) * 100, 2) AS repeat_purchase_rate_percent
	FROM repeat_metrics;
SELECT * FROM customer_repeat_purchase_rate

----------- Customer Lifetime Value (total spending per customer)-----------
CREATE VIEW customer_lifetime_value AS
	SELECT customer_id, customer_name,
    -- 1. Total Profit generated (The "Value" part of CLV)
    SUM(profit) AS lifetime_profit,
    -- 2. Total Sales generated
    SUM(sales) AS lifetime_sales,    
    -- 3. Number of unique orders placed
    COUNT(DISTINCT order_id) AS total_orders,   
    -- 4. Days between their first and last purchase
    MAX(order_date) - MIN(order_date) AS customer_lifespan_days,   
    -- 5. Average Profit per Order
    ROUND(SUM(profit) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS avg_order_value_profit
	FROM store_orders
	GROUP BY customer_id, customer_name
	ORDER BY lifetime_profit DESC;
SELECT * FROM customer_lifetime_value

------- Month-over-Month (MoM) and Year-over-Year (YoY) --------
CREATE VIEW mom_and_yoy AS
	SELECT 
    TO_CHAR(order_date, 'Mon YYYY') AS month_year,
    SUM(sales) AS total_sales,
    -- Month vs Previous Month (MoM)
    COALESCE(LAG(SUM(sales), 1) OVER (ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)), 0) AS prev_month_sales,
    -- Year on Year (YoY) 
    COALESCE(LAG(SUM(sales), 12) OVER (ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)), 0) AS last_year_sales,
    -- YoY Growth Percentage
    ROUND(((SUM(sales) - LAG(SUM(sales), 12) OVER (ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date))) / 
           NULLIF(LAG(SUM(sales), 12) OVER (ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)), 0)) * 100, 2) AS yoy_growth_pct
	FROM store_orders
	GROUP BY 1, EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
	ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);
SELECT * FROM mom_and_yoy

----- Catergory vs Overall Average ------
CREATE VIEW category_vs_overall_avg AS
	WITH category_avgs AS (
	    SELECT 
	        category,
	        AVG(profit) AS cat_avg_profit,
	        -- Window function gets the average across ALL rows regardless of category
	        AVG(AVG(profit)) OVER() AS overall_store_avg
	    FROM store_orders
	    GROUP BY category
	)
	SELECT 
	    category,
	    ROUND(cat_avg_profit, 2) AS cat_avg_profit,
	    ROUND(overall_store_avg, 2) AS overall_store_avg,
	    -- Difference from the mean
	    ROUND(cat_avg_profit - overall_store_avg, 2) AS profit_diff,
	    -- Percentage difference
	    ROUND(((cat_avg_profit - overall_store_avg) / NULLIF(overall_store_avg, 0)), 2) AS performance_ratio
	FROM category_avgs
	ORDER BY performance_ratio DESC;

SELECT * FROM category_vs_overall_avg

------- Aggregate Segments ---------
CREATE VIEW underperform_segments AS
	WITH segment_stats AS (
	    SELECT 
	        segment,
	        SUM(sales) AS total_sales,
			SUM(profit) AS total_profit,
	        COUNT(DISTINCT order_id) AS order_count,
			ROUND(AVG(AVG(profit/sales) * 100) OVER(), 2) AS store_avg_margin
	    FROM store_orders
	    WHERE sales > 0
	    GROUP BY segment
		)
	SELECT segment, total_sales, total_profit, order_count, store_avg_margin,
	ROUND((total_profit/total_sales) * 100, 2) AS profit_margin_pct,
	ROUND((total_sales/order_count), 2) AS avg_order_value
	FROM segment_stats 
	GROUP BY segment, total_sales, total_profit, order_count, store_avg_margin
	ORDER BY profit_margin_pct;
SELECT * FROM underperform_segments

-- DROP VIEW underperform_segments
-- DROP TABLE IF EXISTS store_orders CASCADE; 

-- Export VIEW to CSV
COPY (SELECT * FROM monthly_total_sales_profit)
TO 'C:\Users\Public\Downloads\monthly_total_sales_profit.csv'
WITH (FORMAT CSV, HEADER);

COPY (SELECT * FROM products_profit)
TO 'C:\Users\Public\Downloads\products_profit.csv'
WITH (FORMAT CSV, HEADER);

COPY (SELECT * FROM region_average_discount_and_profit)
TO 'C:\Users\Public\Downloads\region_average_discount_and_profit.csv'
WITH (FORMAT CSV, HEADER);

COPY (SELECT * FROM customer_lifetime_value)
TO 'C:\Users\Public\Downloads\customer_lifetime_value.csv'
WITH (FORMAT CSV, HEADER);