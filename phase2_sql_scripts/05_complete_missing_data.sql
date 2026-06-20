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



select * from [User]
where username='u4042';

select * from Model
where brand_id = 2

select * from Brand
where brand_id = 2


select * from Province as p
	inner join City as C
	on p.province_id=c.province_id

select * from Advertisement


select * from Vehicle
where model_id = 42

select * from Address as A
	inner join city as c
		on A.city_id = C.city_id