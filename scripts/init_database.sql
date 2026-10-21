/*
==========================================================================================
QUERY Purpose:
This query detects and creates the DataBase Named DataWarehiyseProject and the 3 schemas in it
===========================================================================================

WARNING: This script drops the entire database be sure to have a duplicate or a back up before executing it
*/

--Creation and checking of the database droping it if exist
USE master; 
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseProject')
BEGIN
	ALTER DATABASE DataWarehouseProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouseProject;
END
GO

CREATE DATABASE DataWarehouseProject;
GO

USE DataWarehouseProject;
GO

--Creation of the 3 Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
