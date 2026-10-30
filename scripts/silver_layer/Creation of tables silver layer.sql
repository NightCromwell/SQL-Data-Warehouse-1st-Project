--SCRIPT PURPOISE: this script creates the 6 tables that will be needed in the ingestion of data in the bronze layer
--They are done following the next requirements
-- 1.- the name of the table should be the layer that the table will be inserted Bronze, silver, gold
-- 2.- The source system crm or erp 
-- 3.- And the table of the name and the columns should have the same name as the source

--==============================================================================================================
CREATE TABLE silver.crm_cust_info 
(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(20),
	cst_gndr NVARCHAR(20)
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
--==============================================================================================================
CREATE TABLE silver.crm_prd_info 
(
	prd_id INT,
	cat_id NVARCHAR(20),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(20),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

--==============================================================================================================

CREATE TABLE silver.crm_sales_details
(
	sls_ord_num NVARCHAR(20),
	sls_prd_key NVARCHAR(20),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
--==============================================================================================================
CREATE TABLE silver.erp_cust_az12
(
	cid NVARCHAR (20),
	bdate DATE,
	gen NVARCHAR (10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
--==============================================================================================================

CREATE TABLE silver.erp_loc_a101
(
	cid NVARCHAR (20),
	cntry NVARCHAR (50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
--==============================================================================================================
CREATE TABLE silver.erp_px_cat_g1v2
(
	id NVARCHAR (20),
	cat NVARCHAR (30),
	subcat NVARCHAR (30),
	maintenance NVARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
