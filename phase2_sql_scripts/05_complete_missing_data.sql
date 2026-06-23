USE CarMarketDB;
GO



INSERT INTO Vehicle (model_id, production_year, color_out, 
	color_in, transmission_type, fuel_type, consumption) 
	VALUES  (42, 1401, N'سفید', NULL, N'دنده‌ای', N'بنزین', 8.0);
GO


INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, 
	enginepower, torque, accelerate) 
	VALUES  (202,  N'سدان', N'6 سیلندر 24 سوپاپ', 2500, 200, 270, 7.50);
Go


UPDATE Brand
SET name = N'MVM',
	country = N'China'
WHERE brand_id = 3;
GO


INSERT INTO Address (city_id, neighborhood)
	VALUES (67, NULL);
GO


UPDATE [User]
SET username = N'u4032'
WHERE username = N'u4023';
GO


INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, 
	descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, 
	km_age, body_status, free_zone, active_status) VALUES
(1,9,1,N'سمند سفید ۱۴۰۰',N'نقدی',350000000,N'کارکرد ۴۰ هزار کیلومتر',1,
	GETDATE(),GETDATE(),N'عادی',N'کارکرده',N'۱ روزه',40000,N'بدون رنگ و زنگ',0,1),
(14,9,2,N'هیوندای Santa Fe 2022 مشکی',N'نقدی',2800000000,N'کارکرد ۱۵ هزار کیلومتر',1,
	GETDATE(),GETDATE(),N'نردبانی',N'کارکرده',N'۳ روزه',15000,N'بدون رنگ و زنگ',0,1),
(103,9,3,N'بنز E200 2020 مشکی',N'توافقی',NULL,N'کارکرد ۲۵ هزار کیلومتر',1,
	GETDATE(),GETDATE(),N'نردبانی',N'کارکرده',N'۵ روزه',25000,N'بدون رنگ و زنگ',0,1),
(8,11,9,N'دنا پلاس سفید صفر',N'نقدی',650000000,N'صفر کیلومتر فاکتور',1,
	GETDATE(),GETDATE(),N'عادی',N'صفر',N'همین روز',0,N'بدون رنگ و زنگ',0,1),
(110,11,10,N'BMW X5 2020 مشکی',N'اقساطی',NULL,N'کارکرد ۳۰ هزار کیلومتر',1,GETDATE(),
	GETDATE(),N'نردبانی',N'کارکرده',N'۵ روزه',30000,N'بدون رنگ و زنگ',0,1),
(15,11,11,N'هیوندای Elantra 2021 نقره‌ای',N'نقدی',1700000000,N'کارکرد ۲۰ هزار کیلومتر',1,
GETDATE(),GETDATE(),N'عادی',N'کارکرده',N'۲ روزه',20000,N'بدون رنگ و زنگ',0,1);
GO


-- درج آگهی‌های تست در استان البرز (کرج)
INSERT INTO Advertisement (
    vehicle_id, userid, address_id, title, sell_type, price,
    descriptions, published, created_date, updated_date, ad_type,
    car_condition, remittance_time, km_age, body_status,
    free_zone, active_status
)
SELECT
    v.vehicle_id,
    1 AS userid,  
    ad.address_id,
    b.name + N' ' + m.name + N' مدل ' + CAST(v.production_year AS NVARCHAR(4)) + N' در کرج',
    N'نقدی',
    250000000 + (v.vehicle_id * 5000000),
    N'خودروی سالم با وضعیت بدنه مناسب',
    1, GETDATE(), GETDATE(),
    N'عادی',
    N'کارکرده',
    N'۲ روزه',
    ABS(CHECKSUM(NEWID())) % 80000 + 10000,  
    CASE WHEN v.vehicle_id % 2 = 0 THEN N'بدون رنگ' ELSE N'کاپوت رنگ' END,
    0, 1
FROM Vehicle v
CROSS JOIN (
    SELECT TOP 1 adr.address_id
    FROM Address adr
    INNER JOIN City c ON adr.city_id = c.city_id
    INNER JOIN Province p ON c.province_id = p.province_id
    WHERE p.name = N'البرز'
) ad
INNER JOIN Model m ON v.model_id = m.model_id
INNER JOIN Brand b ON m.brand_id = b.brand_id
WHERE v.vehicle_id IN (1, 2, 10, 11, 14); 

GO




-- ==========================================
-- مرحله ۱: اضافه کردن برندها
-- ==========================================
INSERT INTO Brand (name, country) VALUES 
(N'تی‌وی‌اس', N'هند'),
(N'استلز', N'ایتالیا');
GO

-- ==========================================
-- مرحله ۲: اضافه کردن مدل‌ها برای هر برند
-- ==========================================
DECLARE @BrandTVS INT = (SELECT brand_id FROM Brand WHERE name = N'تی‌وی‌اس');
DECLARE @BrandStel INT = (SELECT brand_id FROM Brand WHERE name = N'استلز');

INSERT INTO Model (brand_id, name) VALUES
(@BrandTVS, N'Apache RTR 200'),
(@BrandTVS, N'NTORQ 125'),
(@BrandStel, N'Stelvio 800'),
(@BrandStel, N'V85 TT');
GO

-- ==========================================
-- مرحله ۳: ساخت موتورسیکلت‌ها
-- ==========================================

-- ۱. تی‌وی‌اس Apache RTR 200 (حجم ۲۰۰ سی‌سی، قیمت ۳۵۰ میلیون)
DECLARE @ModelTVS1 INT = (SELECT model_id FROM Model WHERE name = N'Apache RTR 200' AND brand_id = (SELECT brand_id FROM Brand WHERE name = N'تی‌وی‌اس'));

INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
VALUES (@ModelTVS1, 1402, N'قرمز', NULL, N'دنده‌ای', N'بنزین', 3.5);
DECLARE @VehicleTVS1 INT = SCOPE_IDENTITY();

INSERT INTO Motorcycle (vehicle_id, class, engine, engine_cc, gearbox, weight)
VALUES (@VehicleTVS1, N'اسپرت', N'تک سیلندر', 200, N'۶ دنده', 150);

INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
VALUES (@VehicleTVS1, 1, 1, N'تی‌وی‌اس Apache RTR 200', N'نقدی', 350000000, N'موتور اسپرت، کارکرد کم', 1, GETDATE(), GETDATE(), N'عادی', N'کارکرده', N'۱ هفته', 5000, N'بدون رنگ و زنگ', 0, 1);
Go

-- ۲. تی‌وی‌اس NTORQ 125 (حجم ۱۲۵ سی‌سی، قیمت ۳۲۰ میلیون)
DECLARE @ModelTVS2 INT = (SELECT model_id FROM Model WHERE name = N'NTORQ 125' AND brand_id = (SELECT brand_id FROM Brand WHERE name = N'تی‌وی‌اس'));

INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
VALUES (@ModelTVS2, 1401, N'آبی', NULL, N'دنده‌ای', N'بنزین', 2.5);
DECLARE @VehicleTVS2 INT = SCOPE_IDENTITY();

INSERT INTO Motorcycle (vehicle_id, class, engine, engine_cc, gearbox, weight)
VALUES (@VehicleTVS2, N'اسکوتر', N'تک سیلندر', 125, N'دنده‌ای', 120);

INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
VALUES (@VehicleTVS2, 2, 2, N'تی‌وی‌اس NTORQ 125', N'نقدی', 320000000, N'اسکوتر شهری، صفر', 1, GETDATE(), GETDATE(), N'عادی', N'صفر', N'۱ روزه', 0, N'بدون رنگ و زنگ', 0, 1);
GO

-- ۳. استلز V85 TT (حجم ۸۵۰ سی‌سی، قیمت ۴۵۰ میلیون)
DECLARE @ModelStel1 INT = (SELECT model_id FROM Model WHERE name = N'V85 TT' AND brand_id = (SELECT brand_id FROM Brand WHERE name = N'استلز'));

INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
VALUES (@ModelStel1, 1401, N'زرد', NULL, N'دنده‌ای', N'بنزین', 4.5);
DECLARE @VehicleStel1 INT = SCOPE_IDENTITY();

INSERT INTO Motorcycle (vehicle_id, class, engine, engine_cc, gearbox, weight)
VALUES (@VehicleStel1, N'ادونچر', N'دو سیلندر', 850, N'۶ دنده', 220);

INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
VALUES (@VehicleStel1, 3, 3, N'استلز V85 TT', N'نقدی', 450000000, N'موتور ادونچر، صفر', 1, GETDATE(), GETDATE(), N'عادی', N'صفر', N'۱ روزه', 0, N'بدون رنگ و زنگ', 0, 1);

-- ۴. استلز Stelvio 800 (حجم ۸۰۰ سی‌سی، قیمت ۴۲۰ میلیون)
DECLARE @ModelStel2 INT = (SELECT model_id FROM Model WHERE name = N'Stelvio 800' AND brand_id = (SELECT brand_id FROM Brand WHERE name = N'استلز'));

INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
VALUES (@ModelStel2, 1400, N'سفید', NULL, N'دنده‌ای', N'بنزین', 4.2);
DECLARE @VehicleStel2 INT = SCOPE_IDENTITY();

INSERT INTO Motorcycle (vehicle_id, class, engine, engine_cc, gearbox, weight)
VALUES (@VehicleStel2, N'ادونچر', N'دو سیلندر', 800, N'۶ دنده', 210);

INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
VALUES (@VehicleStel2, 4, 4, N'استلز Stelvio 800', N'نقدی', 420000000, N'موتور ادونچر، کارکرد ۱۰۰۰۰', 1, GETDATE(), GETDATE(), N'عادی', N'کارکرده', N'۲ روزه', 10000, N'بدون رنگ و زنگ', 0, 1);
GO


-- ==========================================
-- مرحله ۱: اضافه کردن مدل‌های بنز (اگر وجود ندارند)
-- ==========================================
DECLARE @BrandBenz INT = 28; 

-- مدل‌های بنز
INSERT INTO Model (brand_id, name)
SELECT @BrandBenz, name
FROM (VALUES 
    (N'E200'),
    (N'C200'),
    (N'GLE'),
    (N'GLC'),
    (N'S500')
) AS Models(name)
WHERE NOT EXISTS (
    SELECT 1 FROM Model 
    WHERE brand_id = @BrandBenz AND name = Models.name
);

PRINT N'مدل‌های بنز اضافه شدند.';
GO

-- ==========================================
-- مرحله ۲: درج خودروهای بنز با کارکرد ۱۰۰۰۰ و وضعیت "سالم و بدون رنگ"
-- ==========================================
DECLARE @BrandBenzID INT = 28;

-- خودروی ۱: بنز E200 مدل ۲۰۲۰ - قیمت ۲,۵۰۰,۰۰۰,۰۰۰
DECLARE @ModelE200 INT = (SELECT model_id FROM Model WHERE name = N'E200' AND brand_id = @BrandBenzID);
IF @ModelE200 IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelE200, 2020, N'مشکی', N'بژ', N'اتوماتیک', N'بنزین', 8.5);
    DECLARE @VehicleID1 INT = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleID1, N'سدان', N'4 سیلندر 16 سوپاپ', 2000, 150, 250, 8.5);

    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (@VehicleID1, 1, 1, N'بنز E200 2020', N'نقدی', 2500000000, N'کارکرد ۱۰۰۰۰ کیلومتر، سالم و بدون رنگ', 1, GETDATE(), GETDATE(), N'نردبانی', N'کارکرده', N'۱ روزه', 10000, N'سالم و بدون رنگ', 0, 1);
    PRINT N'خودروی ۱ اضافه شد: E200';
END

-- خودروی ۲: بنز C200 مدل ۲۰۲۱ - قیمت ۲,۸۰۰,۰۰۰,۰۰۰
DECLARE @ModelC200 INT = (SELECT model_id FROM Model WHERE name = N'C200' AND brand_id = @BrandBenzID);
IF @ModelC200 IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelC200, 2021, N'سفید', N'مشکی', N'اتوماتیک', N'بنزین', 8.0);
    DECLARE @VehicleID2 INT = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleID2, N'سدان', N'4 سیلندر 16 سوپاپ', 2000, 160, 260, 8.0);

    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (@VehicleID2, 2, 2, N'بنز C200 2021', N'نقدی', 2800000000, N'کارکرد ۱۰۰۰۰ کیلومتر، سالم و بدون رنگ', 1, GETDATE(), GETDATE(), N'نردبانی', N'کارکرده', N'۱ روزه', 10000, N'سالم و بدون رنگ', 0, 1);
    PRINT N'خودروی ۲ اضافه شد: C200';
END

-- خودروی ۳: بنز GLE مدل ۲۰۲۲ - قیمت ۳,۲۰۰,۰۰۰,۰۰۰
DECLARE @ModelGLE INT = (SELECT model_id FROM Model WHERE name = N'GLE' AND brand_id = @BrandBenzID);
IF @ModelGLE IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelGLE, 2022, N'نقره‌ای', N'بژ', N'اتوماتیک', N'بنزین', 9.0);
    DECLARE @VehicleID3 INT = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleID3, N'شاسی‌بلند', N'6 سیلندر 24 سوپاپ', 3000, 250, 380, 7.0);

    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (@VehicleID3, 3, 3, N'بنز GLE 2022', N'نقدی', 3200000000, N'کارکرد ۱۰۰۰۰ کیلومتر، سالم و بدون رنگ', 1, GETDATE(), GETDATE(), N'نردبانی', N'کارکرده', N'۱ روزه', 10000, N'سالم و بدون رنگ', 0, 1);
    PRINT N'خودروی ۳ اضافه شد: GLE';
END

-- خودروی ۴: بنز GLC مدل ۲۰۲۱ - قیمت ۲,۹۰۰,۰۰۰,۰۰۰
DECLARE @ModelGLC INT = (SELECT model_id FROM Model WHERE name = N'GLC' AND brand_id = @BrandBenzID);
IF @ModelGLC IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelGLC, 2021, N'آبی', N'خاکستری', N'اتوماتیک', N'بنزین', 8.2);
    DECLARE @VehicleID4 INT = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleID4, N'شاسی‌بلند', N'4 سیلندر 16 سوپاپ', 2000, 170, 270, 7.5);

    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (@VehicleID4, 4, 4, N'بنز GLC 2021', N'نقدی', 2900000000, N'کارکرد ۱۰۰۰۰ کیلومتر، سالم و بدون رنگ', 1, GETDATE(), GETDATE(), N'نردبانی', N'کارکرده', N'۱ روزه', 10000, N'سالم و بدون رنگ', 0, 1);
    PRINT N'خودروی ۴ اضافه شد: GLC';
END

GO



-- ==========================================
-- ۱. اطمینان از وجود برند BMW
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Brand WHERE name = N'BMW')
BEGIN
    INSERT INTO Brand (name, country) VALUES (N'BMW', N'آلمان');
    PRINT N'برند BMW اضافه شد.';
END

-- ==========================================
-- ۲. اطمینان از وجود مدل BMW (X5 یا 320i)
-- ==========================================
DECLARE @BrandBMW INT = (SELECT brand_id FROM Brand WHERE name = N'BMW');

-- اگر X5 نبود، از 320i استفاده می‌کنیم (و اگر هیچکدام نبود، X5 را می‌سازیم)
IF NOT EXISTS (SELECT 1 FROM Model WHERE name = N'X5' AND brand_id = @BrandBMW)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Model WHERE name = N'320i' AND brand_id = @BrandBMW)
    BEGIN
        INSERT INTO Model (brand_id, name) VALUES (@BrandBMW, N'X5');
        PRINT N'مدل BMW X5 اضافه شد.';
    END
    ELSE
    BEGIN
        PRINT N'مدل BMW 320i از قبل وجود دارد. از آن استفاده می‌کنیم.';
    END
END
ELSE
BEGIN
    PRINT N'مدل BMW X5 از قبل وجود دارد.';
END

-- ==========================================
-- ۳. اطمینان از وجود شهر تهران
-- ==========================================
DECLARE @ProvinceTehran INT = (SELECT province_id FROM Province WHERE name = N'تهران');
IF @ProvinceTehran IS NULL
BEGIN
    PRINT N'خطا: استان تهران وجود ندارد! لطفاً ابتدا استان تهران را اضافه کنید.';
    RETURN;
END

IF NOT EXISTS (SELECT 1 FROM City WHERE name = N'تهران' AND province_id = @ProvinceTehran)
BEGIN
    INSERT INTO City (province_id, name) VALUES (@ProvinceTehran, N'تهران');
    PRINT N'شهر تهران اضافه شد.';
END

-- ==========================================
-- ۴. اطمینان از وجود آدرس در تهران
-- ==========================================
DECLARE @CityTehran INT = (SELECT city_id FROM City WHERE name = N'تهران' AND province_id = @ProvinceTehran);

IF NOT EXISTS (SELECT 1 FROM Address WHERE city_id = @CityTehran)
BEGIN
    INSERT INTO Address (city_id, neighborhood) VALUES (@CityTehran, N'ونک');
    PRINT N'آدرس در تهران اضافه شد.';
END

-- ==========================================
-- ۵. ایجاد خودروی BMW (با مدل موجود)
-- ==========================================
DECLARE @ModelBMW INT = (SELECT TOP 1 model_id FROM Model WHERE brand_id = @BrandBMW AND name IN (N'X5', N'320i') ORDER BY model_id);
DECLARE @AddressTehranID INT = (SELECT TOP 1 address_id FROM Address WHERE city_id = @CityTehran);

IF @ModelBMW IS NOT NULL AND @AddressTehranID IS NOT NULL
BEGIN
    -- بررسی اینکه آیا خودرویی با این مدل از قبل وجود دارد
    DECLARE @ExistingVehicleID INT = (SELECT TOP 1 v.vehicle_id FROM Vehicle v WHERE v.model_id = @ModelBMW);
    
    IF @ExistingVehicleID IS NULL
    BEGIN
        -- ایجاد خودروی جدید
        INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
        VALUES (@ModelBMW, 2020, N'مشکی', N'مشکی', N'اتوماتیک', N'بنزین', 9.0);
        SET @ExistingVehicleID = SCOPE_IDENTITY();

        INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
        VALUES (@ExistingVehicleID, N'شاسی‌بلند', N'6 سیلندر 24 سوپاپ', 3000, 250, 400, 6.5);
        PRINT N'خودروی BMW ایجاد شد.';
    END
    ELSE
    BEGIN
        PRINT N'خودروی BMW قبلاً وجود دارد.';
    END

    -- ==========================================
    -- ۶. ثبت آگهی در تهران (اگر وجود نداشته باشد)
    -- ==========================================
    IF NOT EXISTS (SELECT 1 FROM Advertisement WHERE vehicle_id = @ExistingVehicleID AND address_id = @AddressTehranID)
    BEGIN
        INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
        VALUES (
            @ExistingVehicleID,
            1,
            @AddressTehranID,
            N'BMW مدل 2020 مشکی',
            N'نقدی',
            4500000000,
            N'وارداتی، کارکرد ۳۰ هزار کیلومتر',
            1, GETDATE(), GETDATE(),
            N'نردبانی',
            N'کارکرده',
            N'۳ روزه',
            30000,
            N'بدون رنگ و زنگ',
            0, 1
        );
        PRINT N'آگهی BMW در تهران ثبت شد.';
    END
    ELSE
    BEGIN
        PRINT N'آگهی BMW در تهران قبلاً وجود دارد.';
    END
END
ELSE
BEGIN
    PRINT N'خطا: مدل BMW یا آدرس تهران پیدا نشد.';
END
GO




-- ==========================================
-- ۱. اطمینان از وجود استان اصفهان
-- ==========================================
DECLARE @ProvinceIsfahan INT = (SELECT province_id FROM Province WHERE name = N'اصفهان');
IF @ProvinceIsfahan IS NULL
BEGIN
    PRINT N'خطا: استان اصفهان وجود ندارد!';
    RETURN;
END

-- ==========================================
-- ۲. اطمینان از وجود شهر اصفهان
-- ==========================================
DECLARE @CityIsfahan INT = (SELECT city_id FROM City WHERE name = N'اصفهان' AND province_id = @ProvinceIsfahan);
IF @CityIsfahan IS NULL
BEGIN
    INSERT INTO City (province_id, name) VALUES (@ProvinceIsfahan, N'اصفهان');
    SET @CityIsfahan = SCOPE_IDENTITY();
    PRINT N'شهر اصفهان اضافه شد.';
END

-- ==========================================
-- ۳. اطمینان از وجود آدرس در اصفهان
-- ==========================================
DECLARE @AddressIsfahan INT = (SELECT TOP 1 address_id FROM Address WHERE city_id = @CityIsfahan);
IF @AddressIsfahan IS NULL
BEGIN
    INSERT INTO Address (city_id, neighborhood) VALUES (@CityIsfahan, N'نقش جهان');
    SET @AddressIsfahan = SCOPE_IDENTITY();
    PRINT N'آدرس در اصفهان اضافه شد.';
END

-- ==========================================
-- ۴. اضافه کردن برند تویوتا (اگر وجود ندارد)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Brand WHERE name = N'تویوتا')
BEGIN
    INSERT INTO Brand (name, country) VALUES (N'تویوتا', N'ژاپن');
    PRINT N'برند تویوتا اضافه شد.';
END

-- ==========================================
-- ۵. اضافه کردن مدل RAV4 برای تویوتا (اگر وجود ندارد)
-- ==========================================
DECLARE @BrandToyota INT = (SELECT brand_id FROM Brand WHERE name = N'تویوتا');
DECLARE @ModelRAV4 INT = (SELECT model_id FROM Model WHERE name = N'RAV4' AND brand_id = @BrandToyota);

IF @ModelRAV4 IS NULL
BEGIN
    INSERT INTO Model (brand_id, name) VALUES (@BrandToyota, N'RAV4');
    SET @ModelRAV4 = SCOPE_IDENTITY();
    PRINT N'مدل تویوتا RAV4 اضافه شد.';
END

-- ==========================================
-- ۶. اضافه کردن برند هیوندای (اگر وجود ندارد)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Brand WHERE name = N'هیوندای')
BEGIN
    INSERT INTO Brand (name, country) VALUES (N'هیوندای', N'کره جنوبی');
    PRINT N'برند هیوندای اضافه شد.';
END

-- ==========================================
-- ۷. اضافه کردن مدل Santa Fe برای هیوندای (اگر وجود ندارد)
-- ==========================================
DECLARE @BrandHyundai INT = (SELECT brand_id FROM Brand WHERE name = N'هیوندای');
DECLARE @ModelSantaFe INT = (SELECT model_id FROM Model WHERE name = N'Santa Fe' AND brand_id = @BrandHyundai);

IF @ModelSantaFe IS NULL
BEGIN
    INSERT INTO Model (brand_id, name) VALUES (@BrandHyundai, N'Santa Fe');
    SET @ModelSantaFe = SCOPE_IDENTITY();
    PRINT N'مدل هیوندای Santa Fe اضافه شد.';
END

-- ==========================================
-- ۸. ایجاد خودروی تویوتا RAV4 هیبریدی با رنگ مشکی
-- ==========================================
DECLARE @VehicleRAV4 INT;
SELECT @VehicleRAV4 = v.vehicle_id
FROM Vehicle v
WHERE v.model_id = @ModelRAV4 AND v.fuel_type = N'هیبریدی' AND v.color_out = N'مشکی';

IF @VehicleRAV4 IS NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelRAV4, 2022, N'مشکی', N'بژ', N'اتوماتیک', N'هیبریدی', 5.0);
    SET @VehicleRAV4 = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleRAV4, N'شاسی‌بلند', N'4 سیلندر 16 سوپاپ', 2000, 180, 280, 7.5);
    PRINT N'خودروی تویوتا RAV4 هیبریدی مشکی ایجاد شد.';
END
ELSE
BEGIN
    PRINT N'خودروی تویوتا RAV4 هیبریدی مشکی قبلاً وجود دارد.';
END

-- ==========================================
-- ۹. ثبت آگهی برای RAV4 در اصفهان
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Advertisement WHERE vehicle_id = @VehicleRAV4 AND address_id = @AddressIsfahan)
BEGIN
    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (
        @VehicleRAV4,
        1,
        @AddressIsfahan,
        N'تویوتا RAV4 2022 هیبریدی مشکی',
        N'نقدی',
        3000000000,
        N'هیبریدی، صفر کیلومتر',
        1, GETDATE(), GETDATE(),
        N'عادی',
        N'صفر',
        N'۱ روزه',
        0,
        N'بدون رنگ و زنگ',
        0, 1
    );
    PRINT N'آگهی تویوتا RAV4 در اصفهان ثبت شد.';
END
ELSE
BEGIN
    PRINT N'آگهی تویوتا RAV4 در اصفهان قبلاً وجود دارد.';
END

-- ==========================================
-- ۱۰. ایجاد خودروی هیوندای Santa Fe هیبریدی با رنگ آبی
-- ==========================================
DECLARE @VehicleSantaFe INT;
SELECT @VehicleSantaFe = v.vehicle_id
FROM Vehicle v
WHERE v.model_id = @ModelSantaFe AND v.fuel_type = N'هیبریدی' AND v.color_out = N'آبی';

IF @VehicleSantaFe IS NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelSantaFe, 2023, N'آبی', N'خاکستری', N'اتوماتیک', N'هیبریدی', 6.0);
    SET @VehicleSantaFe = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleSantaFe, N'شاسی‌بلند', N'6 سیلندر 24 سوپاپ', 2500, 210, 300, 7.0);
    PRINT N'خودروی هیوندای Santa Fe هیبریدی آبی ایجاد شد.';
END
ELSE
BEGIN
    PRINT N'خودروی هیوندای Santa Fe هیبریدی آبی قبلاً وجود دارد.';
END

-- ==========================================
-- ۱۱. ثبت آگهی برای Santa Fe در اصفهان
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Advertisement WHERE vehicle_id = @VehicleSantaFe AND address_id = @AddressIsfahan)
BEGIN
    INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
    VALUES (
        @VehicleSantaFe,
        2,
        @AddressIsfahan,
        N'هیوندای Santa Fe 2023 هیبریدی آبی',
        N'نقدی',
        3500000000,
        N'هیبریدی، کارکرد ۱۰۰۰۰ کیلومتر',
        1, GETDATE(), GETDATE(),
        N'نردبانی',
        N'کارکرده',
        N'۲ روزه',
        10000,
        N'بدون رنگ و زنگ',
        0, 1
    );
    PRINT N'آگهی هیوندای Santa Fe در اصفهان ثبت شد.';
END
ELSE
BEGIN
    PRINT N'آگهی هیوندای Santa Fe در اصفهان قبلاً وجود دارد.';
END

PRINT N'==========================================';
PRINT N'داده‌های تست برای SP9 با موفقیت اضافه شدند.';
PRINT N'==========================================';
GO


-- ==========================================
-- ۱. اطمینان از وجود استان البرز و شهر کرج
-- ==========================================
DECLARE @ProvinceAlborz INT = (SELECT province_id FROM Province WHERE name = N'البرز');
IF @ProvinceAlborz IS NULL
BEGIN
    PRINT N'استان البرز وجود ندارد! لطفاً ابتدا استان را اضافه کنید.';
    RETURN;
END

DECLARE @CityKaraj INT = (SELECT city_id FROM City WHERE name = N'کرج' AND province_id = @ProvinceAlborz);
IF @CityKaraj IS NULL
BEGIN
    INSERT INTO City (province_id, name) VALUES (@ProvinceAlborz, N'کرج');
    SET @CityKaraj = SCOPE_IDENTITY();
    PRINT N'شهر کرج اضافه شد.';
END

DECLARE @AddressKaraj INT = (SELECT TOP 1 address_id FROM Address WHERE city_id = @CityKaraj);
IF @AddressKaraj IS NULL
BEGIN
    INSERT INTO Address (city_id, neighborhood) VALUES (@CityKaraj, N'گوهردشت');
    SET @AddressKaraj = SCOPE_IDENTITY();
    PRINT N'آدرس در کرج اضافه شد.';
END

-- ==========================================
-- ۲. درج آگهی‌های تست با وضعیت‌های مختلف
-- ==========================================
INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
SELECT TOP 5
    v.vehicle_id,
    1 AS userid,
    @AddressKaraj,
    b.name + N' ' + m.name + N' در البرز',
    N'نقدی',
    250000000 + (v.vehicle_id * 5000000),
    N'آگهی تست برای البرز',
    1, GETDATE(), GETDATE(),
    N'عادی', N'کارکرده', N'۲ روزه',
    ABS(CHECKSUM(NEWID())) % 80000 + 10000,
    CASE 
        WHEN v.vehicle_id % 2 = 0 THEN N'بدون رنگ'
        ELSE N'کاپوت رنگ'
    END,
    0, 1
FROM Vehicle v
INNER JOIN Model m ON v.model_id = m.model_id
INNER JOIN Brand b ON m.brand_id = b.brand_id
WHERE v.vehicle_id IN (1, 2, 10, 11, 14)  -- چند خودروی نمونه
AND NOT EXISTS (
    SELECT 1 FROM Advertisement 
    WHERE vehicle_id = v.vehicle_id AND address_id = @AddressKaraj
);

PRINT N'آگهی‌های تست در البرز اضافه شدند.';


USE CarMarketDB;
GO

-- ==========================================
-- پیدا کردن شناسه‌های مورد نیاز
-- ==========================================
DECLARE @ProvinceAlborz INT = (SELECT province_id FROM Province WHERE name = N'البرز');
DECLARE @CityKaraj INT = (SELECT city_id FROM City WHERE name = N'کرج' AND province_id = @ProvinceAlborz);
DECLARE @AddressKaraj INT = (SELECT TOP 1 address_id FROM Address WHERE city_id = @CityKaraj);

-- برند سایپا
DECLARE @BrandSaipa INT = (SELECT brand_id FROM Brand WHERE name = N'سایپا');

-- مدل پراید ۱۳۱
DECLARE @ModelPride131 INT = (SELECT model_id FROM Model WHERE name = N'پراید ۱۳۱' AND brand_id = @BrandSaipa);

-- مدل کوییک R
DECLARE @ModelQuickR INT = (SELECT model_id FROM Model WHERE name = N'کوییک R' AND brand_id = @BrandSaipa);

-- ==========================================
-- ۱. ایجاد خودروی پراید ۱۳۱ (اگر وجود نداشته باشد)
-- ==========================================
DECLARE @VehiclePride INT;
SELECT @VehiclePride = v.vehicle_id
FROM Vehicle v
WHERE v.model_id = @ModelPride131 AND v.production_year = 1390 AND v.color_out = N'سفید';

IF @VehiclePride IS NULL AND @ModelPride131 IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelPride131, 1390, N'سفید', N'خاکستری', N'دنده‌ای', N'بنزین', 6.5);
    SET @VehiclePride = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehiclePride, N'سدان', N'4 سیلندر 8 سوپاپ', 1300, 85, 115, 13.0);
    PRINT N'خودروی پراید ۱۳۱ ایجاد شد.';
END
ELSE IF @ModelPride131 IS NULL
BEGIN
    PRINT N'خطا: مدل پراید ۱۳۱ برای برند سایپا پیدا نشد.';
END

-- ==========================================
-- ۲. ایجاد خودروی کوییک R (اگر وجود نداشته باشد)
-- ==========================================
DECLARE @VehicleQuick INT;
SELECT @VehicleQuick = v.vehicle_id
FROM Vehicle v
WHERE v.model_id = @ModelQuickR AND v.production_year = 1402 AND v.color_out = N'مشکی';

IF @VehicleQuick IS NULL AND @ModelQuickR IS NOT NULL
BEGIN
    INSERT INTO Vehicle (model_id, production_year, color_out, color_in, transmission_type, fuel_type, consumption)
    VALUES (@ModelQuickR, 1402, N'مشکی', N'مشکی', N'اتوماتیک', N'بنزین', 5.5);
    SET @VehicleQuick = SCOPE_IDENTITY();

    INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
    VALUES (@VehicleQuick, N'هچ‌بک', N'3 سیلندر 1.0 لیتر توربو', 1000, 120, 150, 9.5);
    PRINT N'خودروی کوییک R ایجاد شد.';
END
ELSE IF @ModelQuickR IS NULL
BEGIN
    PRINT N'خطا: مدل کوییک R برای برند سایپا پیدا نشد.';
END

-- ==========================================
-- ۳. درج آگهی پراید ۱۳۱ در البرز (اگر وجود نداشته باشد)
-- ==========================================
IF @VehiclePride IS NOT NULL AND @AddressKaraj IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Advertisement WHERE vehicle_id = @VehiclePride AND address_id = @AddressKaraj)
    BEGIN
        INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
        VALUES (
            @VehiclePride,
            1,
            @AddressKaraj,
            N'پراید ۱۳۱ مدل ۱۳۹۰ سفید',
            N'نقدی',
            120000000,
            N'کارکرد ۲۰۰ هزار کیلومتر، کاپوت رنگ',
            1, GETDATE(), GETDATE(),
            N'عادی',
            N'کارکرده',
            N'۵ روزه',
            200000,
            N'کاپوت رنگ',
            0, 1
        );
        PRINT N'آگهی پراید ۱۳۱ در کرج ثبت شد.';
    END
    ELSE
    BEGIN
        PRINT N'آگهی پراید ۱۳۱ قبلاً در کرج وجود دارد.';
    END
END

-- ==========================================
-- ۴. درج آگهی کوییک R در البرز (اگر وجود نداشته باشد)
-- ==========================================
IF @VehicleQuick IS NOT NULL AND @AddressKaraj IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Advertisement WHERE vehicle_id = @VehicleQuick AND address_id = @AddressKaraj)
    BEGIN
        INSERT INTO Advertisement (vehicle_id, userid, address_id, title, sell_type, price, descriptions, published, created_date, updated_date, ad_type, car_condition, remittance_time, km_age, body_status, free_zone, active_status)
        VALUES (
            @VehicleQuick,
            1,
            @AddressKaraj,
            N'کوییک R مشکی ۱۴۰۲',
            N'نقدی',
            450000000,
            N'کارکرد ۵ هزار کیلومتر، صفر',
            1, GETDATE(), GETDATE(),
            N'عادی',
            N'کارکرده',
            N'همین روز',
            5000,
            N'بدون رنگ',
            0, 1
        );
        PRINT N'آگهی کوییک R در کرج ثبت شد.';
    END
    ELSE
    BEGIN
        PRINT N'آگهی کوییک R قبلاً در کرج وجود دارد.';
    END
END

PRINT N'دو آگهی جدید از برند سایپا در استان البرز اضافه شدند.';
