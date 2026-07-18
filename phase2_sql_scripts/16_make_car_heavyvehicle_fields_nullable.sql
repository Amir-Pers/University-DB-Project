USE CarMarketDB;
GO

ALTER TABLE Car
ALTER COLUMN body_type NVARCHAR(50) NULL;
GO

ALTER TABLE HeavyVehicle
ALTER COLUMN heavy_type NVARCHAR(50) NULL;
GO


sp_help Car
sp_help HeavyVehicle