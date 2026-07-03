USE CarMarketDB;
GO

ALTER TABLE [User]
ADD user_auth_id INT NULL;
GO

ALTER TABLE [User]
ADD CONSTRAINT FK_User_AuthUser
FOREIGN KEY (user_auth_id)
REFERENCES auth_user(id);
GO
