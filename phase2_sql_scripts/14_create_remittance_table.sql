USE CarMarketDB;
GO

ALTER TABLE Advertisement
DROP COLUMN remittance_time;
GO

CREATE TABLE Remittance (
    remittance_id INT PRIMARY KEY IDENTITY(1,1),

    ad_id INT NOT NULL UNIQUE,

    deposit_amount DECIMAL(18,0) NOT NULL,

    final_price DECIMAL(18,0) NOT NULL,

    delivery_time NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_Remittance_Advertisement
        FOREIGN KEY (ad_id)
        REFERENCES Advertisement(ad_id)
        ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX IX_Remittance_AdID
ON Remittance(ad_id);

CREATE INDEX IX_Remittance_FinalPrice
ON Remittance(final_price);
GO