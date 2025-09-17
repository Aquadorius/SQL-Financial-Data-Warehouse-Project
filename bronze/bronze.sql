

USE master;

-- Check if database exists and drop it
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Project')
BEGIN
    PRINT ('Database Project found. Proceeding to drop...');
    
    -- Step 1: Set database to single user mode to disconnect all users
    ALTER DATABASE Project SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    PRINT ('Database set to single user mode.');
    
    -- Step 2: Drop the database
    DROP DATABASE Project;
    PRINT ('Database Project dropped successfully.');
END
ELSE
BEGIN
    PRINT ('Database Project does not exist.');
END
GO
-- Step 3: Create the database
CREATE DATABASE Project;
GO
PRINT ('Database DataWarehouse created successfully.');

-- Step 4: Switch to the new database
USE Project;
GO
-- Step 5: Create schemas
CREATE SCHEMA bronze;
GO
PRINT ('Schema bronze created successfully.');

GO
CREATE SCHEMA silver;
GO
PRINT ('Schema silver created successfully.');
GO
CREATE SCHEMA gold;
GO
PRINT ('Schema gold created successfully.');
GO
PRINT( '========================================');
PRINT ('Database and schemas setup completed successfully!');
PRINT ('Ready for table creation and data loading.');
PRINT ('========================================');


/*============================================
CREATING TABLE: bronze.fact_company
==============================================*/

IF OBJECT_ID('bronze.fact_company','U') IS NOT NULL
    DROP TABLE bronze.fact_company;
GO
CREATE TABLE bronze.fact_company(
    company_id     INT NOT NULL,
	ticker         NVARCHAR(50) NULL,
    company_name   NVARCHAR(200) NULL,
    statement_type NVARCHAR(50) NOT NULL,     -- 'IS','BS','CF'
    account_type   NVARCHAR(50) NULL,         -- optional grouping (Revenue, Expense, Asset, etc.)
    account_name   NVARCHAR(200) NOT NULL,    -- raw account label
    amount        FLOAT NULL,        -- FLOAT amount
    unit           NVARCHAR(50) NULL,         -- 'Units','Thousands','Millions'
    year_ended     DATE NOT NULL,             -- e.g. '2015-09-30'
    currency       NVARCHAR(100) NULL,
);
GO

/*============================================
CREATING TABLE: bronze.dim_company
==============================================*/
	
IF OBJECT_ID('bronze.dim_company','U') IS NOT NULL
    DROP TABLE bronze.dim_company;

CREATE TABLE bronze.dim_company(
unique_code INT,
company_ticker VARCHAR(255),
company_name VARCHAR(255),
sector_name VARCHAR(255),
sector_type VARCHAR(10)
);
