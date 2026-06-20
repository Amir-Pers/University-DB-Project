USE CarMarketDB;
GO


--SP 1
CREATE PROCEDURE InsertAdvertisement
    @userName NVARCHAR(50), @Brand NVARCHAR(100), @Model NVARCHAR(100),
    @Year INT, @Fuel NVARCHAR(50), @BodyStatus NVARCHAR(50),
    @Gearbox NVARCHAR(50), @Function INT, @Color NVARCHAR(50), @Province NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @userid INT, @brandid INT, @modelid INT, 
    @provinceid INT, @addressid INT, @vehicleid INT;

    SET @userid = 
        (SELECT userid FROM [User] WHERE username = @userName);
    IF @userid IS NULL BEGIN RAISERROR('User not found.', 16, 1) RETURN END

    SET @brandid = 
        (SELECT brand_id FROM Brand WHERE name = @Brand);
    IF @brandid IS NULL BEGIN RAISERROR('Brand not found.', 16, 1) RETURN END

    SET @modelid = 
        (SELECT model_id FROM Model WHERE name = @Model AND brand_id = @brandid);
    IF @modelid IS NULL BEGIN RAISERROR('Model not found for this brand.', 16, 1) RETURN END

    SET @provinceid = 
        (SELECT province_id FROM Province WHERE name = @Province);
    IF @provinceid IS NULL BEGIN RAISERROR('Province not found.', 16, 1) RETURN END

    SET @addressid = (SELECT TOP 1 a.address_id
                      FROM Address a INNER JOIN City c ON a.city_id = c.city_id
                      WHERE c.province_id = @provinceid);
    IF @addressid IS NULL BEGIN RAISERROR('No address in this province.', 16, 1) RETURN END

    SET @vehicleid = (SELECT TOP 1 vehicle_id
                      FROM Vehicle
                      WHERE model_id = @modelid AND production_year = @Year
                        AND fuel_type = @Fuel AND transmission_type = @Gearbox
                        AND color_out = @Color);
    IF @vehicleid IS NULL BEGIN
        RAISERROR('Vehicle not found. Please add vehicle first.', 16, 1)
        RETURN
    END

    INSERT INTO Advertisement (
        vehicle_id, userid, address_id, title, sell_type, price,
        descriptions, published, created_date, updated_date, ad_type,
        car_condition, remittance_time, km_age, body_status, free_zone, active_status
    ) VALUES (
        @vehicleid, @userid, @addressid,
        @Brand + N' ' + @Model + N' ',
        N'توافقی', NULL, NULL, 1, GETDATE(), GETDATE(),
        N'عادی', 
            CASE 
                WHEN @Function > 0 THEN N'کارکرده' 
                ELSE N'صفر' 
            END,
        N'۱ روزه', @Function, @BodyStatus, 0, 1
    );

    PRINT N'Advertisement inserted. ID: ' + CAST(SCOPE_IDENTITY() AS NVARCHAR(10));
END
GO

-- test SP1
EXEC InsertAdvertisement
    @userName = N'u4042', @Brand = N'MVM',
    @Model = N'MVM 530', @Year = 1401,
    @Fuel = N'بنزین', @BodyStatus = N'بدون رنگ',
    @Gearbox = N'دنده‌ای', @Function = 0,
    @Color = N'سفید', @Province = N'فارس';
GO


-- SP2
DROP PROCEDURE IF EXISTS SP_ShowAdvertisements;
GO

CREATE PROCEDURE SP_ShowAdvertisements
    @Username1 NVARCHAR(50),  
    @Username2 NVARCHAR(50)    
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @userid1 INT, @userid2 INT;

    SET @userid1 = (SELECT userid FROM [User] WHERE username = @Username1);
    SET @userid2 = (SELECT userid FROM [User] WHERE username = @Username2);

    IF @userid1 IS NULL OR @userid2 IS NULL
        RETURN;

    SELECT * FROM Advertisement WHERE userid IN (@userid1, @userid2);

    DELETE FROM Advertisement WHERE userid = @userid2;

    SELECT * FROM Advertisement WHERE userid IN (@userid1, @userid2);
END
GO

-- test SP2
EXEC SP_ShowAdvertisements @Username1 = 'u4021', @Username2 = 'u4032';
GO

-- Record insertion for @Username2 = 'u4032'
INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, 
	descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, 
	km_age, body_status, free_zone, active_status) VALUES
(8,11,9,N'دنا پلاس سفید صفر',N'نقدی',650000000,N'صفر کیلومتر فاکتور',1,
	GETDATE(),GETDATE(),N'عادی',N'صفر',N'همین روز',0,N'بدون رنگ و زنگ',0,1),
(110,11,10,N'BMW X5 2020 مشکی',N'اقساطی',NULL,N'کارکرد ۳۰ هزار کیلومتر',1,GETDATE(),
	GETDATE(),N'نردبانی',N'کارکرده',N'۵ روزه',30000,N'بدون رنگ و زنگ',0,1),
(15,11,11,N'هیوندای Elantra 2021 نقره‌ای',N'نقدی',1700000000,N'کارکرد ۲۰ هزار کیلومتر',1,
    GETDATE(),GETDATE(),N'عادی',N'کارکرده',N'۲ روزه',20000,N'بدون رنگ و زنگ',0,1);
GO


-- SP3
DROP PROCEDURE IF EXISTS SP_GetCarsByProvince;
GO

CREATE PROCEDURE SP_GetCarsByProvince
    @ProvinceName NVARCHAR(100),
    @BodyStatus_A NVARCHAR(100),
    @BodyStatus_B NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Province_id INT;
    SET @Province_id = (SELECT province_id FROM Province WHERE name = @ProvinceName);

    SELECT 
        b.name AS BrandName,
        m.name AS ModelName,
        a.km_age AS KmAge
    FROM Advertisement AS a
        INNER JOIN Vehicle AS v ON a.vehicle_id = v.vehicle_id
        INNER JOIN Model AS m ON v.model_id = m.model_id
        INNER JOIN Brand AS b ON m.brand_id = b.brand_id
    WHERE a.address_id IN (
        SELECT address_id FROM Address
        WHERE city_id IN (
            SELECT city_id FROM City
            WHERE province_id = @Province_id
        )
    )
    AND a.active_status = 1
    AND a.published = 1
    AND a.body_status IN (@BodyStatus_A, @BodyStatus_B)
    ORDER BY a.km_age;
END
GO


--  test SP3
EXEC SP_GetCarsByProvince 
    @ProvinceName = N'البرز',
    @BodyStatus_A = N'بدون رنگ',
    @BodyStatus_B = N'کاپوت رنگ';



-- SP4
DROP PROCEDURE IF EXISTS SP_ShowQuery3Sorted;
GO

CREATE PROCEDURE SP_ShowQuery3Sorted
    @ProvinceName NVARCHAR(100),
    @BodyStatus_A NVARCHAR(100),
    @BodyStatus_B NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Province_id INT;
    SET @Province_id = (SELECT province_id FROM Province WHERE name = @ProvinceName);

    -- ایجاد جدول موقت برای ذخیره نتایج
    CREATE TABLE #TempAds (
        BrandName NVARCHAR(100),
        ModelName NVARCHAR(100),
        KmAge INT,
        Price DECIMAL(18,0),
        ProductionYear INT,
        CreatedDate DATETIME,
        Title NVARCHAR(255)
    );

    -- یک بار اجرای کوئری و ذخیره در جدول موقت
    INSERT INTO #TempAds
    SELECT 
        b.name AS BrandName,
        m.name AS ModelName,
        a.km_age AS KmAge,
        a.price AS Price,
        v.production_year AS ProductionYear,
        a.created_date AS CreatedDate,
        a.title AS Title
    FROM Advertisement AS a
        INNER JOIN Vehicle AS v ON a.vehicle_id = v.vehicle_id
        INNER JOIN Model AS m ON v.model_id = m.model_id
        INNER JOIN Brand AS b ON m.brand_id = b.brand_id
    WHERE a.address_id IN (
        SELECT address_id FROM Address
        WHERE city_id IN (
            SELECT city_id FROM City
            WHERE province_id = @Province_id
        )
    )
    AND a.active_status = 1
    AND a.published = 1
    AND a.body_status IN (@BodyStatus_A, @BodyStatus_B);

    -- ۴ بار SELECT با ORDER BY مختلف از جدول موقت

    SELECT 
        N'ارزان‌ترین' AS SortOrder,
        BrandName, ModelName, KmAge, Price, ProductionYear, CreatedDate, Title
    FROM #TempAds
    WHERE Price IS NOT NULL
    ORDER BY Price ASC;

    SELECT 
        N'به‌روزترین' AS SortOrder,
        BrandName, ModelName, KmAge, Price, ProductionYear, CreatedDate, Title
    FROM #TempAds
    ORDER BY CreatedDate DESC;

    SELECT 
        N'جدیدترین سال' AS SortOrder,
        BrandName, ModelName, KmAge, Price, ProductionYear, CreatedDate, Title
    FROM #TempAds
    ORDER BY ProductionYear DESC;

    SELECT 
        N'کم‌کارکردترین' AS SortOrder,
        BrandName, ModelName, KmAge, Price, ProductionYear, CreatedDate, Title
    FROM #TempAds
    ORDER BY KmAge ASC;

    -- پاک کردن جدول موقت
    DROP TABLE #TempAds;
END
GO

-- test SP4
EXEC SP_ShowQuery3Sorted 
    @ProvinceName = N'البرز',
    @BodyStatus_A = N'بدون رنگ',
    @BodyStatus_B = N'کاپوت رنگ';





select * from [User]
where username='u4021';

select * from Model
where name = 'MVM 530'

select * from Brand
where brand_id = 3

select * from Advertisement
where userid=11

select * from Vehicle
where model_id = 42

select * from Address as A
	inner join city as c
		on A.city_id = C.city_id


