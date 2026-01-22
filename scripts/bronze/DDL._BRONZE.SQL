/*
=============================================
Create Database and Schema
=============================================
script purpose:
This script creates a new Database named 'DataWareHouse' after checking if already exists.
if the database exists, it is dropped and recreated. additinally, the scripts sets three schemas
within the database: 'bronze',

create or alter procedure bronze.load_bronze as
begin
   DECLARE @START_TIME DATETIME, @END_TIME DATETIME,@BATCH_START_TIME DATETIME, @BATCH_end_time datetime;
   begin try
   set @batch_start_time = getdate();
    print'=================================================';
    print'loading bronze layer';
    print'=================================================';
    SET @START_TIME=GETDATE();
    print'>>Inserting data into:bronze.crm_cust_info';
    INSERT INTO bronze.crm_cust_info
    (
        cst_id,
        cst_fristname,
        cst_lastname, 
        cst_country,
        cst_score
    )
    VALUES
    (1, 'komala','mn', 'usa',78),
    (2, 'Ravi',   'Kumar',  'India', 90),
    (3, 'Anita',  'Sharma', 'India', 88),
    (4, 'Suresh', 'Patil',  'India', 75);
    SET @END_TIME=GETDATE();
    PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'

    SET @START_TIME=GETDATE();
    print'>>Inserting data into:bronze.crm_prd_info';
    INSERT INTO bronze.crm_prd_info
    (
        prd_productID,
        prd_product,
        prd_category,
        prd_price
    )
    VALUES
    (101, 'Laptop',        'Electronics', 65000),
    (102, 'Mobile Phone',  'Electronics', 25000),
    (103, 'Office Chair',  'Furniture',   4500),
    (104, 'Pen Drive',     'Accessories', 800);
    SET @END_TIME=GETDATE();
    PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'

    SET @START_TIME=GETDATE();
    print'>>Inserting data into:bronze.crm_sale_info';
    INSERT INTO Bronze.crm_sale_info
    (
        sale_orderID,
        sale_orderdt,
        sale_shipdt,
        sale_sale
    )
    VALUES
    (1001, 20240115, 20240118, 50000),
    (1002, 20240116, 20240119, 35000),
    (1003, 20240117, 20240120, 42000);
    INSERT INTO Bronze.crm_sale_info
    VALUES
    (1004, 20240119, NULL, 15000);
    SET @END_TIME=GETDATE();
    PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'
    print'-------------------------------------------------';
    print'loading CRM tables';
    print'--------------------------------------------------';

    SET @START_TIME=GETDATE();
    print'>>Inserting data into:bronze.erp_cust_az12.';
    INSERT INTO Bronze.erp_cust_az12
    (
        cid,
        bdate,
        gen
    )
    VALUES
    ('C001', '1998-05-12', 'Female'),
    ('C002', '1995-03-20', 'Male'),
    ('C003', '2000-11-08', 'Female'),
    ('C004', '1992-07-15', 'Male');
    SET @END_TIME=GETDATE();
   PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'

    SET @START_TIME=GETDATE();
    print'>>Inserting data into:Bronze.erp_loc_a101.';
    INSERT INTO Bronze.erp_loc_a101
    (
        cid,
        ctry
    )
    VALUES
    ('C001', 'India'),
    ('C002', 'India'),
    ('C003', 'USA'),
    ('C004', 'UK'),
    ('C005', 'India');
    SET @END_TIME=GETDATE();
    PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'

    SET @START_TIME=GETDATE();
    print'>>Inserting data into:Bronze.erp_px_cat_g1v2';
    INSERT INTO Bronze.erp_px_cat_g1v2
    (
        id,
        cat,
        subcat,
        maintanance
    )
    VALUES
    ('P001', 'Electronics', 'Laptop', 'Low'),
    ('P002', 'Electronics', 'Mobile', 'Low'),
    ('P003', 'Furniture',   'Chair',  'Medium'),
    ('P004', 'Accessories', 'PenDrive','Low'),
    ('P005', 'Electronics', 'Tablet', 'Medium');
    SET @END_TIME=GETDATE();
    PRINT'>>LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR) + 'SECONDS';
    PRINT'------------------'

    set @batch_end_time = getdate();
    print'>>total duration' + cast(datediff(second,@batch_start_time, @batch_end_time) as nvarchar)+'seconds';
    print'======================================='
end try
begin catch
          print'==============================================='
          print'error occured during loading bronze layer'
          print'error message' + ERROR_MESSAGE();
          print'error message' + cast(ERROR_NUMBER() AS NVARCHAR);
          print'error message'+ cast(ERROR_STATE() AS NVARCHAR);
          print'==============================================='
END CATCH
end
