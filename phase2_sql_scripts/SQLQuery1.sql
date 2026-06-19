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

CREATE NONCLUSTERED INDEX IX_User_Phone ON [User] (phone);
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


