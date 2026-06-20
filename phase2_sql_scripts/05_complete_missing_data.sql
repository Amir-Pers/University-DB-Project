USE CarMarketDB;
GO



INSERT INTO Vehicle (model_id, production_year, color_out, 
	color_in, transmission_type, fuel_type, consumption) 
	VALUES  (42, 1401, N'سفید', NULL, N'دنده‌ای', N'بنزین', 8.0);
GO


INSERT INTO Car (vehicle_id, body_type, engine, cylinder_volume, 
	enginepower, torque, accelerate) 
	VALUES  (1003,  N'سدان', N'6 سیلندر 24 سوپاپ', 2500, 200, 270, 7.50);
Go


UPDATE Brand
SET name = N'MVM',
	country = N'China'
WHERE brand_id = 3;
GO


INSERT INTO Address (city_id, neighborhood)
	VALUES (67, NULL);
GO





select * from [User]
where username='u4042';

select * from Model
where name = 'MVM 530'

select * from Brand
where brand_id = 3

select * from Advertisement
where vehicle_id=42

select * from Vehicle
where model_id = 42

select * from Address as A
	inner join city as c
		on A.city_id = C.city_id