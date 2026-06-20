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


select * from [User]
where username='u4042';

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