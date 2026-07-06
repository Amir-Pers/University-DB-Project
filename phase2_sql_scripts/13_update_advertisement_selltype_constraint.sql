USE CarMarketDB;
GO


ALTER TABLE Advertisement
DROP CONSTRAINT CHK_Advertisement_SellType;
GO

ALTER TABLE Advertisement
ADD CONSTRAINT CHK_Advertisement_SellType
CHECK (
    sell_type IN (
        N'نقدی',
        N'اقساطی',
        N'حواله',
        N'توافقی'
    )
);
GO