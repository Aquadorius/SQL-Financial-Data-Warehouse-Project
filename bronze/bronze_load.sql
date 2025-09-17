/*=========================================
INSERTING DATA INTO TABLE : bronze.fact_company
  ===========================================
*/
PRINT('>>Truncating Table:  bronze.fact_company');
TRUNCATE TABLE bronze.fact_company;
GO
PRINT('>>Inserting Data into: bronze.fact_company');
GO
BULK INSERT bronze.fact_company
FROM 'D:\Project\AABS1.txt'
WITH(
FIRSTROW=2,
FIELDTERMINATOR='\t',
TABLOCK);

/*=========================================
INSERTING DATA INTO TABLE : bronze.dim_company
  ===========================================
*/
PRINT('>>Truncating Table:  bronze.dim_company');
TRUNCATE TABLE bronze.dim_company;
GO
PRINT('>>Inserting Data into: bronze.dim_company');
GO
BULK INSERT bronze.dim_company
FROM 'D:\Project\Company Codes.txt'
WITH(
FIRSTROW=2,
FIELDTERMINATOR='\t',
TABLOCK);
