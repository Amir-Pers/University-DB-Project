USE CarMarketDB;
GO

-- ============================================================
-- ۱. درج رکوردها در جدول Car (بدون تکرار VALUES)
-- ============================================================
INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
SELECT DISTINCT
    v.vehicle_id,
    src.body_type,
    src.engine,
    src.cylinder_volume,
    src.enginepower,
    src.torque,
    src.accelerate
FROM (
    VALUES
        -- ایران خودرو
        (N'ایران خودرو', N'سمند', N'سدان', N'موتور ۴ سیلندر ۱٫۸ لیتری', 1800, 110, 160, 11.5),
        (N'ایران خودرو', N'دنا', N'سدان', N'موتور ۴ سیلندر ۱٫۶ لیتری توربو', 1600, 150, 215, 9.0),
        (N'ایران خودرو', N'تارا', N'سدان', N'موتور ۴ سیلندر ۱٫۶ لیتری', 1600, 110, 160, 11.0),
        (N'ایران خودرو', N'۲۰۶ صندوقدار', N'سدان', N'موتور ۴ سیلندر ۱٫۶ لیتری', 1600, 110, 150, 12.0),
        (N'ایران خودرو', N'۲۰۶ هاچ‌بک', N'هاچ‌بک', N'موتور ۴ سیلندر ۱٫۶ لیتری', 1600, 110, 150, 12.5),
        (N'ایران خودرو', N'۴۰۵', N'سدان', N'موتور ۴ سیلندر ۱٫۸ لیتری', 1800, 110, 160, 13.0),
        (N'ایران خودرو', N'رانا', N'سدان', N'موتور ۴ سیلندر ۱٫۶ لیتری', 1600, 110, 150, 11.5),
        (N'ایران خودرو', N'پارس', N'سدان', N'موتور ۴ سیلندر ۱٫۸ لیتری', 1800, 110, 160, 12.5),

        -- سایپا
        (N'سایپا', N'پراید', N'سدان', N'موتور ۴ سیلندر ۱٫۳ لیتری', 1300, 75, 105, 14.0),
        (N'سایپا', N'تیبا', N'سدان', N'موتور ۴ سیلندر ۱٫۵ لیتری', 1500, 95, 135, 12.0),
        (N'سایپا', N'ساینا', N'سدان', N'موتور ۴ سیلندر ۱٫۵ لیتری', 1500, 95, 135, 12.0),
        (N'سایپا', N'کوییک', N'هاچ‌بک', N'موتور ۴ سیلندر ۱٫۵ لیتری', 1500, 95, 135, 12.0),
        (N'سایپا', N'شاهین', N'سدان', N'موتور ۴ سیلندر ۱٫۶ لیتری توربو', 1600, 150, 215, 9.5),

        -- بهمن
        (N'بهمن', N'دیگنیتی', N'سدان', N'موتور ۴ سیلندر ۲ لیتری توربو', 2000, 180, 280, 8.0),
        (N'بهمن', N'ریرا', N'سدان', N'موتور ۴ سیلندر ۱٫۵ لیتری', 1500, 110, 160, 11.0),

        -- کرمان موتور
        (N'کرمان موتور', N'جک J4', N'سدان', N'موتور ۴ سیلندر ۱٫۵ لیتری', 1500, 115, 146, 11.0),

        -- پارس خودرو
        (N'پارس خودرو', N'هایما S5', N'SUV', N'موتور ۴ سیلندر ۱٫۶ لیتری توربو', 1600, 160, 220, 10.0),

        -- مدیران خودرو
        (N'مدیران خودرو', N'ام‌وی‌ام X55', N'SUV', N'موتور ۴ سیلندر ۱٫۵ لیتری توربو', 1500, 150, 210, 9.5),

        -- خارجی
        (N'تویوتا', N'کرولا', N'سدان', N'موتور ۴ سیلندر ۱٫۸ لیتری', 1800, 140, 170, 9.5),
        (N'هیوندای', N'سوناتا', N'سدان', N'موتور ۴ سیلندر ۲ لیتری', 2000, 180, 270, 8.0),
        (N'بنز', N'کلاس S', N'سدان', N'موتور ۶ سیلندر ۳ لیتری توربو', 3000, 350, 500, 5.5),
        (N'BMW', N'سری ۵', N'سدان', N'موتور ۴ سیلندر ۲ لیتری توربو', 2000, 250, 350, 6.0),
        (N'هیوندای', N'توسان', N'SUV', N'موتور ۴ سیلندر ۲ لیتری', 2000, 165, 200, 9.0),
        (N'کیا', N'اسپورتیج', N'SUV', N'موتور ۴ سیلندر ۱٫۶ لیتری توربو', 1600, 180, 265, 8.5),
        (N'آئودی', N'Q5', N'SUV', N'موتور ۴ سیلندر ۲ لیتری توربو', 2000, 200, 320, 7.0)
) AS src(brand_name, model_name, body_type, engine, cylinder_volume, enginepower, torque, accelerate)
INNER JOIN Brand b ON b.name = src.brand_name
INNER JOIN Model m ON m.brand_id = b.brand_id AND m.name = src.model_name
INNER JOIN Vehicle v ON v.model_id = m.model_id
WHERE NOT EXISTS (SELECT 1 FROM Car c WHERE c.vehicle_id = v.vehicle_id);


-- ============================================================
-- ۲. درج رکوردها در جدول Motorcycle
-- ============================================================
INSERT INTO Motorcycle (vehicle_id, class, engine, engine_cc, gearbox, weight)
SELECT DISTINCT
    v.vehicle_id,
    src.class,
    src.engine,
    src.engine_cc,
    src.gearbox,
    src.weight
FROM (
    VALUES
        (N'هوندا', N'سی‌بی‌آر ۱۰۰۰آرآر', N'اسپورت', N'موتور ۴ سیلندر خطی ۱۰۰۰ سی‌سی', 1000, N'دستی', 195),
        (N'یاماها', N'ام‌تی-۰۹', N'استریت فایتر', N'موتور ۳ سیلندر ۸۴۷ سی‌سی', 847, N'دستی', 190),
        (N'یاماها', N'ام‌تی-۰۷', N'استریت فایتر', N'موتور ۲ سیلندر ۶۸۹ سی‌سی', 689, N'دستی', 180)
) AS src(brand_name, model_name, class, engine, engine_cc, gearbox, weight)
INNER JOIN Brand b ON b.name = src.brand_name
INNER JOIN Model m ON m.brand_id = b.brand_id AND m.name = src.model_name
INNER JOIN Vehicle v ON v.model_id = m.model_id
WHERE NOT EXISTS (SELECT 1 FROM Motorcycle mc WHERE mc.vehicle_id = v.vehicle_id);


-- ============================================================
-- ۳. درج رکوردها در جدول HeavyVehicle
-- ============================================================
INSERT INTO HeavyVehicle (vehicle_id, heavy_type, [usage])
SELECT DISTINCT
    v.vehicle_id,
    src.heavy_type,
    src.[usage]
FROM (
    VALUES
        (N'بنز', N'اکتروس', N'کامیون سنگین', N'باربری بین‌شهری'),
        (N'اسکانیا', N'سری R', N'کامیون سنگین', N'باربری سنگین'),
        (N'ولوو', N'FH', N'کامیون سنگین', N'باربری طولانی‌مسافت')
) AS src(brand_name, model_name, heavy_type, [usage])
INNER JOIN Brand b ON b.name = src.brand_name
INNER JOIN Model m ON m.brand_id = b.brand_id AND m.name = src.model_name
INNER JOIN Vehicle v ON v.model_id = m.model_id
WHERE NOT EXISTS (SELECT 1 FROM HeavyVehicle hv WHERE hv.vehicle_id = v.vehicle_id);

GO