USE CarMarketDB;
GO

/*=========================================================
 Add category column to Model
=========================================================*/

ALTER TABLE Model
ADD category VARCHAR(20) NOT NULL
CONSTRAINT DF_Model_Category DEFAULT 'car';
GO


/*=========================================================
 Heavy vehicles
=========================================================*/

UPDATE Model
SET category='heavy_vehicle'
WHERE name IN
(
'Actros','Atego','Travego',
'TGA','TGX','Lion City',
'Daily','Stralis',
'R-Series','S-Series',
'FH','FM',
'Transit',
'F-150',
'Ram',
'Tunland'
);
GO


/*=========================================================
 Motorcycles
=========================================================*/

UPDATE Model
SET category='motorcycle'
WHERE name IN
(
'CBR 500',
'CBR 650',
'CB 400',
'NC 750',
'AFRICA TWIN',

'GSX-R 1000',
'GSX-S 750',
'V-Strom 650',

'R 1250',
'R 1200',
'S 1000',
'K 1600'
);
GO


/*=========================================================
 Everything else is car
=========================================================*/

UPDATE Model
SET category='car'
WHERE category NOT IN ('motorcycle','heavy_vehicle');
GO

