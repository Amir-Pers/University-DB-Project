USE CarMarketDB;
GO

CREATE TABLE Province (
    province_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL
);
GO


CREATE TABLE City (
    city_id INT PRIMARY KEY IDENTITY(1,1),
    province_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL, 
    CONSTRAINT FK_City_Province FOREIGN KEY (province_id) 
        REFERENCES Province(province_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE Brand (
    brand_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    country NVARCHAR(50) NULL
);
GO


CREATE TABLE Model (
    model_id INT PRIMARY KEY IDENTITY(1,1),
    brand_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Model_Brand FOREIGN KEY (brand_id) 
        REFERENCES Brand(brand_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO


CREATE TABLE [User] (
    userid INT PRIMARY KEY IDENTITY(1,1),
    phone NVARCHAR(20) NOT NULL,
    reg_status BIT DEFAULT 0,                 
    account_status BIT DEFAULT 1,            
    register_date DATETIME2 NULL,             
    national_id NVARCHAR(10) NULL,
    CONSTRAINT UQ_User_Phone UNIQUE (phone),
    CONSTRAINT CHK_User_RegStatus CHECK (reg_status IN (0, 1)),
    CONSTRAINT CHK_User_AccountStatus CHECK (account_status IN (0, 1)),
    CONSTRAINT CHK_User_NationalID CHECK (
        national_id IS NULL OR (LEN(national_id) = 10 AND national_id NOT LIKE '%[^0-9]%')
    )
);
GO

CREATE INDEX IX_User_Phone ON [User] (phone);
GO


CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY IDENTITY(1,1),
    model_id INT NOT NULL,
    production_year INT NULL,
    color_out NVARCHAR(50) NOT NULL,
    color_in NVARCHAR(50) NULL,
    transmission_type NVARCHAR(50) NULL,
    fuel_type NVARCHAR(50) NOT NULL,
    consumption DECIMAL(5,2) NULL,
    CONSTRAINT FK_Vehicle_Model FOREIGN KEY (model_id) 
        REFERENCES Model(model_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
);
GO


CREATE TABLE Car (
    vehicle_id INT PRIMARY KEY,
    body_type NVARCHAR(50) NOT NULL,
    engine NVARCHAR(100) NULL,
    cylinder_volume INT NULL,
    enginepower INT NULL,
    torque INT NULL,
    accelerate DECIMAL(4,2) NULL,
    CONSTRAINT FK_Car_Vehicle FOREIGN KEY (vehicle_id) 
        REFERENCES Vehicle(vehicle_id)
        ON DELETE CASCADE
);
GO


CREATE TABLE Motorcycle (
    vehicle_id INT PRIMARY KEY,
    class NVARCHAR(50) NULL,                 
    engine NVARCHAR(100) NULL,               
    engine_cc INT NULL,                      
    gearbox NVARCHAR(50) NULL,               
    weight INT NULL,                       
    CONSTRAINT FK_Motorcycle_Vehicle FOREIGN KEY (vehicle_id) 
        REFERENCES Vehicle(vehicle_id)
        ON DELETE CASCADE
);
GO


CREATE TABLE HeavyVehicle(
    vehicle_id INT PRIMARY KEY,
    heavy_type NVARCHAR(50) NOT NULL,
    [usage] NVARCHAR(100) NULL,  
    CONSTRAINT FK_HeavyVehicle_Vehicle FOREIGN KEY (vehicle_id) 
        REFERENCES Vehicle(vehicle_id)
        ON DELETE CASCADE
);
GO


CREATE TABLE Address (
    address_id INT PRIMARY KEY IDENTITY(1,1),
    city_id INT NOT NULL,
    neighborhood NVARCHAR(200) NULL,
    CONSTRAINT FK_Address_City FOREIGN KEY (city_id) 
        REFERENCES City(city_id)
        ON DELETE CASCADE
);
GO

CREATE INDEX IX_Address_CityID ON Address (city_id);
GO


CREATE TABLE Advertisement (
    ad_id INT PRIMARY KEY IDENTITY(1,1),
    vehicle_id INT NOT NULL,
    userid INT NOT NULL,
    address_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    sell_type NVARCHAR(60) NOT NULL,
    price DECIMAL(18,0) NULL,
    descriptions NVARCHAR(MAX) NULL,
    published BIT DEFAULT 1,                
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME NULL,
    ad_type NVARCHAR(50) NULL,              
    car_condition NVARCHAR(50) NULL,          
    remittance_time NVARCHAR(50) NULL,        
    km_age INT NULL,                          
    body_status NVARCHAR(50) NULL,           
    free_zone BIT DEFAULT 0,                  
    active_status BIT DEFAULT 1,              
    CONSTRAINT FK_Advertisement_Vehicle FOREIGN KEY (vehicle_id) 
        REFERENCES Vehicle(vehicle_id)
        ON DELETE CASCADE,
    CONSTRAINT FK_Advertisement_User FOREIGN KEY (userid) 
        REFERENCES [User](userid)
        ON DELETE CASCADE,
    CONSTRAINT FK_Advertisement_Address FOREIGN KEY (address_id) 
        REFERENCES Address(address_id)
        ON DELETE CASCADE,
    CONSTRAINT CHK_Advertisement_SellType CHECK (
    sell_type IN (N'نقدی', N'اقساطی', N'توافقی')
    )
);
GO

CREATE INDEX IX_Advertisement_UserID ON Advertisement (userid);
CREATE INDEX IX_Advertisement_AddressID ON Advertisement (address_id);
CREATE INDEX IX_Advertisement_CreatedDate ON Advertisement (created_date DESC);
GO


