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


