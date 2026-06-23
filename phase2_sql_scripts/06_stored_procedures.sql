USE CarMarketDB;
GO


--SP 1
DROP PROCEDURE IF EXISTS InsertAdvertisement;
GO

CREATE PROCEDURE InsertAdvertisement
    @userName NVARCHAR(50),@Brand NVARCHAR(100),
    @Model NVARCHAR(100),@Year INT,
    @Fuel NVARCHAR(50),@BodyStatus NVARCHAR(50),
    @Gearbox NVARCHAR(50),@Function INT,
    @Color NVARCHAR(50),@Province NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @UserId INT, @ModelId INT,
        @AddressId INT,@VehicleId INT;

    SELECT @UserId = userid
    FROM [User]
    WHERE username = @userName;

    SELECT @ModelId = m.model_id
    FROM Model m
        JOIN Brand b ON b.brand_id = m.brand_id
    WHERE b.name = @Brand
        AND m.name = @Model;

    SELECT TOP (1) @AddressId = a.address_id
    FROM Address a
        JOIN City c ON c.city_id = a.city_id
        JOIN Province p ON p.province_id = c.province_id
    WHERE p.name = @Province;

    SELECT TOP (1) @VehicleId = vehicle_id
    FROM Vehicle
    WHERE model_id = @ModelId
        AND production_year = @Year
        AND fuel_type = @Fuel
        AND transmission_type = @Gearbox
        AND color_out = @Color;

    IF @UserId IS NULL OR @ModelId IS NULL 
        OR @AddressId IS NULL OR @VehicleId IS NULL
    BEGIN
        PRINT N'Invalid input data';
        RETURN;
    END;

    INSERT INTO Advertisement (
        vehicle_id, userid, address_id, title, sell_type, price,
        descriptions, published, created_date, updated_date, ad_type,
        car_condition, remittance_time, km_age, body_status, free_zone, active_status
    ) VALUES (
        @vehicleid, @userid, @addressid,
        N' ' + @Model + N' ',N'توافقی', 
        NULL, NULL, 1, GETDATE(), GETDATE(), N'عادی', 
            CASE 
                WHEN @Function > 0 THEN N'کارکرده' 
                ELSE N'صفر' 
            END,
        N'۱ روزه', @Function, @BodyStatus, 0, 1
    );

    PRINT N'Advertisement inserted successfully.';
    select  * from Advertisement
    order by ad_id desc;

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

    DECLARE @UserId1 INT, @UserId2 INT;

    SET @userid1 = (SELECT userid FROM [User] WHERE username = @Username1);
    SET @userid2 = (SELECT userid FROM [User] WHERE username = @Username2);

    IF @UserId1 IS NULL OR @UserId2 IS NULL
    BEGIN
        PRINT N'User not found';
        RETURN;
    END;

    PRINT N'Advertisements before delete';

    SELECT *
    FROM Advertisement
    WHERE userid IN (@UserId1,@UserId2);

    DELETE
    FROM Advertisement
    WHERE userid = @UserId2;

    PRINT N'Advertisements after delete';

    SELECT *
    FROM Advertisement
    WHERE userid IN (@UserId1,@UserId2);
END;
GO

-- test SP2
EXEC SP_ShowAdvertisements
    @Username1 = N'u4021',
    @Username2 = N'u4032';
GO


-- Record insertion for @Username2 = 'u4032' and test again
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
    SET @Province_id = (SELECT province_id 
        FROM Province WHERE name = @ProvinceName);

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

    
    PRINT N'مرتب سازی بر اساس قیمت';
    SELECT *
    FROM #TempAds
    ORDER BY Price;

    PRINT N'مرتب سازی بر اساس تاریخ آگهی';
    SELECT *
    FROM #TempAds
    ORDER BY CreatedDate DESC;

    PRINT N'مرتب سازی بر اساس سال تولید';
    SELECT *
    FROM #TempAds
    ORDER BY ProductionYear DESC;

    PRINT N'مرتب سازی بر اساس کارکرد';
    SELECT *
    FROM #TempAds
    ORDER BY KmAge;

    -- پاک کردن جدول موقت
    DROP TABLE #TempAds;
END
GO

-- test SP4
EXEC SP_ShowQuery3Sorted 
    @ProvinceName = N'البرز',
    @BodyStatus_A = N'بدون رنگ',
    @BodyStatus_B = N'کاپوت رنگ';


-- SP5
DROP PROCEDURE IF EXISTS SP_DeleteLowestKmAge;
GO

CREATE PROCEDURE SP_DeleteLowestKmAge
    @ProvinceName NVARCHAR(100),
    @BodyStatus_A NVARCHAR(100),
    @BodyStatus_B NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Province_id INT;
    DECLARE @AdID INT;

    SELECT @Province_id = province_id
    FROM Province
    WHERE name = @ProvinceName;

    SELECT TOP 1 @AdID = a.ad_id
    FROM Advertisement a
    JOIN Address ad ON a.address_id = ad.address_id
    JOIN City c ON ad.city_id = c.city_id
    WHERE c.province_id = @Province_id
      AND a.active_status = 1
      AND a.published = 1
      AND a.body_status IN (@BodyStatus_A, @BodyStatus_B)
    ORDER BY a.km_age;

    IF @AdID IS NULL
    BEGIN
        PRINT N'آگهی‌ای پیدا نشد';
        RETURN;
    END;

    DELETE FROM Advertisement
    WHERE ad_id = @AdID;

    PRINT N'آگهی حذف شد';

    EXEC SP_ShowQuery3Sorted
        @ProvinceName,
        @BodyStatus_A,
        @BodyStatus_B;
END
GO

-- test SP5
EXEC SP_DeleteLowestKmAge
    @ProvinceName = N'البرز',
    @BodyStatus_A = N'بدون رنگ',
    @BodyStatus_B = N'کاپوت رنگ';
GO



-- SP6
DROP PROCEDURE IF EXISTS SP_GetMotorcyclesByBrandAndCC;
GO

CREATE PROCEDURE SP_GetMotorcyclesByBrandAndCC
    @Brand1 NVARCHAR(100),
    @Brand2 NVARCHAR(100) = NULL,  
    @MaxCC INT,
    @MinPrice DECIMAL(18,0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.name AS Brand,
        m.name AS Model,
        v.production_year AS ProductionYear,
        mc.class AS Class,
        mc.engine AS Engine,
        mc.engine_cc AS EngineCC,
        mc.gearbox AS Gearbox,
        mc.weight AS Weight,
        a.km_age AS Mileage,
        a.price AS Price,
        a.body_status AS BodyStatus,
        a.title AS AdTitle,
        a.created_date AS CreatedDate
    FROM Motorcycle mc
        INNER JOIN Vehicle v ON mc.vehicle_id = v.vehicle_id
        INNER JOIN Model m ON v.model_id = m.model_id
        INNER JOIN Brand b ON m.brand_id = b.brand_id
        INNER JOIN Advertisement a ON v.vehicle_id = a.vehicle_id
    WHERE (b.name = @Brand1 OR b.name = @Brand2)
        AND mc.engine_cc <= @MaxCC
        AND a.price >= @MinPrice
        AND a.published = 1
        AND a.active_status = 1
    ORDER BY mc.engine_cc;
END
GO


-- test SP6
EXEC SP_GetMotorcyclesByBrandAndCC 
    @Brand1 = N'تی‌وی‌اس',
    @Brand2 = N'استلز',
    @MaxCC = 1000,
    @MinPrice = 300000000;


-- SP7
DROP PROCEDURE IF EXISTS SP_EstimatePrice;
GO

CREATE PROCEDURE SP_EstimatePrice
    @BrandName NVARCHAR(100),
    @kmage INT,
    @BodyStatus NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.name AS Brand,
        MIN(a.price) AS MinPrice,
        MAX(a.price) AS MaxPrice,
        AVG(a.price) AS AvgPrice,
        COUNT(*) AS AdCount
    FROM Advertisement a
    INNER JOIN Vehicle v ON a.vehicle_id = v.vehicle_id
    INNER JOIN Model m ON v.model_id = m.model_id
    INNER JOIN Brand b ON m.brand_id = b.brand_id
    WHERE b.name = @BrandName
      AND a.km_age = @kmage
      AND a.body_status = @BodyStatus
      AND a.price IS NOT NULL
      AND a.published = 1
      AND a.active_status = 1
    GROUP BY b.name;  
END
GO


-- test SP7
EXEC SP_EstimatePrice 
    @BrandName = N'بنز',
    @kmage = 10000,
    @BodyStatus = N'سالم و بدون رنگ';


-- SP8
DROP PROCEDURE IF EXISTS SP_GetBrandsByCountryOnlyInCities;
GO

CREATE PROCEDURE SP_GetBrandsByCountryOnlyInCities
    @Country NVARCHAR(100),
    @City1 NVARCHAR(100),
    @City2 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    WITH BrandsInCities AS
    (
        SELECT DISTINCT
            b.brand_id,
            b.name
        FROM Brand b
        JOIN Model m ON b.brand_id = m.brand_id
        JOIN Vehicle v ON m.model_id = v.model_id
        JOIN Advertisement a ON v.vehicle_id = a.vehicle_id
        JOIN Address ad ON a.address_id = ad.address_id
        JOIN City c ON ad.city_id = c.city_id
        WHERE b.country = @Country
          AND c.name IN (@City1,@City2)
          AND a.active_status = 1
          AND a.published = 1
    ),
    OtherCities AS
    (
        SELECT DISTINCT
            b.brand_id
        FROM Brand b
        JOIN Model m ON b.brand_id = m.brand_id
        JOIN Vehicle v ON m.model_id = v.model_id
        JOIN Advertisement a ON v.vehicle_id = a.vehicle_id
        JOIN Address ad ON a.address_id = ad.address_id
        JOIN City c ON ad.city_id = c.city_id
        WHERE b.country = @Country
          AND c.name NOT IN (@City1,@City2)
          AND a.active_status = 1
          AND a.published = 1
    )

    SELECT name AS Brand
    FROM BrandsInCities
    WHERE brand_id NOT IN (SELECT brand_id FROM OtherCities)
    ORDER BY name;

END
GO

-- test SP8
EXEC SP_GetBrandsByCountryOnlyInCities 
    @Country = N'آلمان',
    @City1 = N'تهران',
    @City2 = N'ساری';


-- SP9
DROP PROCEDURE IF EXISTS SP_GetVehicleDetails;
GO

CREATE PROCEDURE SP_GetVehicleDetails
    @ExcludeColor NVARCHAR(50),  
    @BodyType NVARCHAR(50),       
    @FuelType NVARCHAR(50),       
    @ProvinceName NVARCHAR(100)   
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.name AS Brand,
        m.name AS Model,
        v.production_year AS ProductionYear,
        v.color_out AS Color,
        v.color_in AS InteriorColor,
        v.transmission_type AS Transmission,
        v.fuel_type AS FuelType,
        v.consumption AS FuelConsumption,
        c.body_type AS BodyType,
        c.engine AS Engine,
        c.cylinder_volume AS CylinderCC,
        c.enginepower AS Power_HP,
        c.torque AS Torque_Nm,
        c.accelerate AS Acceleration_0_100,
        p.name AS Province,
        ct.name AS City,
        a.price AS Price,
        a.km_age AS Mileage,
        a.body_status AS BodyStatus,
        a.title AS AdTitle,
        a.created_date AS CreatedDate
    FROM Vehicle v
    INNER JOIN Car c ON v.vehicle_id = c.vehicle_id
    INNER JOIN Model m ON v.model_id = m.model_id
    INNER JOIN Brand b ON m.brand_id = b.brand_id
    INNER JOIN Advertisement a ON v.vehicle_id = a.vehicle_id
    INNER JOIN Address ad ON a.address_id = ad.address_id
    INNER JOIN City ct ON ad.city_id = ct.city_id
    INNER JOIN Province p ON ct.province_id = p.province_id
    WHERE c.body_type = @BodyType
      AND v.fuel_type = @FuelType
      AND p.name = @ProvinceName
      AND v.color_out != @ExcludeColor
      AND a.published = 1
      AND a.active_status = 1
    ORDER BY b.name, v.production_year;
END
GO

-- test SP9
EXEC SP_GetVehicleDetails 
    @ExcludeColor = N'سفید',
    @BodyType = N'شاسی‌بلند',
    @FuelType = N'هیبریدی',
    @ProvinceName = N'اصفهان';
Go

-- test 2 SP9
EXEC SP_GetVehicleDetails 
    @ExcludeColor = N'مشکی',
    @BodyType = N'شاسی‌بلند',
    @FuelType = N'هیبریدی',
    @ProvinceName = N'اصفهان';
Go


-- SP10
DROP PROCEDURE IF EXISTS SP_UpdateColorAndReRunSP9;
GO

CREATE PROCEDURE SP_UpdateColorAndReRunSP9
    @ColorFrom NVARCHAR(50),
    @ColorTo NVARCHAR(50),
    @BodyType NVARCHAR(50),
    @FuelType NVARCHAR(50),
    @ProvinceName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Vehicle
    SET color_out = @ColorTo
    FROM Vehicle
    JOIN Car ON Vehicle.vehicle_id = Car.vehicle_id
    JOIN Advertisement ON Vehicle.vehicle_id = Advertisement.vehicle_id
    JOIN Address ON Advertisement.address_id = Address.address_id
    JOIN City ON Address.city_id = City.city_id
    JOIN Province ON City.province_id = Province.province_id
    WHERE Vehicle.color_out = @ColorFrom
      AND Car.body_type = @BodyType
      AND Vehicle.fuel_type = @FuelType
      AND Province.name = @ProvinceName
      AND Advertisement.published = 1
      AND Advertisement.active_status = 1;

    EXEC SP_GetVehicleDetails
        @ExcludeColor = @ColorTo,
        @BodyType = @BodyType,
        @FuelType = @FuelType,
        @ProvinceName = @ProvinceName;
END
GO

-- test SP10
EXEC SP_UpdateColorAndReRunSP9
    @ColorFrom = N'مشکی',
    @ColorTo = N'سفید',
    @BodyType = N'شاسی‌بلند',
    @FuelType = N'هیبریدی',
    @ProvinceName = N'اصفهان';
GO