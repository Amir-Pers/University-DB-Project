USE CarMarketDB;
GO

CREATE TABLE Favorite (
    favorite_id INT IDENTITY(1,1) PRIMARY KEY,

    userid INT NOT NULL,
    ad_id INT NOT NULL,

    created_date DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Favorite_User
        FOREIGN KEY (userid)
        REFERENCES [User](userid),

    CONSTRAINT FK_Favorite_Advertisement
        FOREIGN KEY (ad_id)
        REFERENCES Advertisement(ad_id)
        ON DELETE CASCADE,

    CONSTRAINT UQ_Favorite_User_Advertisement
        UNIQUE (userid, ad_id)
);
GO



CREATE INDEX IX_Favorite_UserID
ON Favorite(userid);

CREATE INDEX IX_Favorite_AdvertisementID
ON Favorite(ad_id);
GO

