--This is an DDL
--This Script makes the VIEWS of the gold layer
USE DataWarehouseProject;

--Create customer VIEW
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS(
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS [customer_key],
	ci.cst_id AS [customer_id],
	ci.cst_key AS [customer_number],
	ci.cst_firstname AS [first_name],
	ci.cst_lastname AS [last_name],
	CASE 
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE ISNULL(cbd.gen, 'n/a')
	END AS [gender],
	cbd.bdate AS [birth_date],
	ci.cst_marital_status AS [marital_status],
	cl.cntry AS [country],
	ci.cst_create_date AS [create_date]
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS cbd
ON ci.cst_key = cbd.cid
LEFT JOIN silver.erp_loc_a101 AS cl
ON ci.cst_key = cl.cid
);


--Creates products VIEW
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS 
(
SELECT
	ROW_NUMBER() OVER(ORDER BY cpi.prd_start_dt, cpi.prd_key) AS [product_key],
	cpi.prd_id AS [product_id],
	cpi.prd_key AS [product_number],
	cpi.prd_nm AS [product_name],
	cpi.cat_id AS [category_id],
	pcg.cat AS [category],
	pcg.subcat AS [subcategory],
	cpi.prd_cost AS [cost],
	cpi.prd_line AS [product_line],
	pcg.maintenance,
	cpi.prd_start_dt AS [product_start_date]
FROM silver.crm_prd_info AS [cpi]
LEFT JOIN silver.erp_px_cat_g1v2 AS [pcg]
ON cpi.cat_id = pcg.id
WHERE cpi.prd_end_dt IS NULL --To filter the current data from the historical
);

--Create sales VIEW
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS (
SELECT	
	SD.sls_ord_num AS [order_number],
	DP.product_key,
	DC.customer_key,
	SD.sls_order_dt AS [order_date],
	SD.sls_ship_dt AS [ship_date],
	SD.sls_due_dt AS [due_date],
	SD.sls_sales AS [sales_amount],
	SD.sls_quantity AS [quantity],
	SD.sls_price AS [price]
FROM silver.crm_sales_details AS [SD]
LEFT JOIN gold.dim_products AS [DP]
ON SD.sls_prd_key = DP.product_number
LEFT JOIN gold.dim_customers AS [DC]
ON SD.sls_cust_id = DC.customer_id
);
