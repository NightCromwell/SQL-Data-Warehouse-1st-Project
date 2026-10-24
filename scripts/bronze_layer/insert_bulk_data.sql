USE [DataWarehouseProject]
GO
/****** Object:  StoredProcedure [bronze].[load_bronze]    Script Date: 10/23/2026 5:55:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--This is the way you can load a csv file into a table using the BULK INSERT 
--There is a lot more options that the 3 that we used in the WIRH so check them
--also the method that is used is the truncate table so we dont have eny errors

--And create a procedure becouse this will be usded in a daily basis

ALTER   PROCEDURE [bronze].[load_bronze] AS
 BEGIN 
		DECLARE @start_time DATETIME, @end_time DATETIME, @Sprc_time DATETIME, @Eprc_time DATETIME
  BEGIN TRY
   	SET @Sprc_time = GETDATE();

    PRINT '=======STARTING PROCEDURE=========';
	
	PRINT '--------------------';
	PRINT 'Uploading crm Files';
	PRINT '--------------------';

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();

	PRINT '>>>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>>>> Inserting Data to: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	
	SET @end_time = GETDATE();

	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();
	
	PRINT '>>>>Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT '>>>>Inserting Data to: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();
	
	PRINT '>>>>Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	PRINT '>>>>Importing Data to: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '--------------------';
	PRINT 'Uploading erp Files';
	PRINT '--------------------';

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();
	
	PRINT '>>>>Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	PRINT '>>>>Inserting Data to: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_erp\CUST_AZ12.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();
	
	PRINT '>>>>Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT '>>>>Inserting Data to: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_erp\LOC_A101.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '===================================================================================================================';
	SET @start_time = GETDATE();

	PRINT '>>>>Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT '>>>>Inserting Data to: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\Julio Miranda\Desktop\dataaawareh\sql-data-warehouse-project-main\01_datasets\source_erp\PX_CAT_G1V2.csv'
	WITH 
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT CONCAT('>> The Duration Time was: ', CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR), ' seconds');

	PRINT '===================================================================================================================';
	SET @Eprc_time = GETDATE();
	PRINT CONCAT('>> The Duration to Upload the entarity of the bronze layer was: ', CAST(DATEDIFF(second ,@Sprc_time, @Eprc_time) AS NVARCHAR), ' seconds');
 END TRY

 BEGIN CATCH
	PRINT '===========================================';
	PRINT 'An ERROR Ocurred while trying execute procedure: bronze.load_bronze';
	PRINT CONCAT('ERROR Message: ', ERROR_MESSAGE());
	PRINT CONCAT('ERROR Number: ', CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT '===========================================';
 END CATCH
END
