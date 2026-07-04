USE CarMarketDB;
GO

ALTER TABLE [User]
ADD address_id INT NULL;
GO

ALTER TABLE [User]
ADD CONSTRAINT FK_User_Address
FOREIGN KEY (address_id)
REFERENCES Address(address_id);
GO
