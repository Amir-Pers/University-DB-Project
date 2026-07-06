USE CarMarketDB;
GO


BEGIN TRANSACTION;

-- Honda
UPDATE Model
SET brand_id = 9
WHERE name IN (
    N'CBR 500',
    N'CBR 650',
    N'CB 400',
    N'NC 750',
    N'AFRICA TWIN'
);

-- Suzuki
UPDATE Model
SET brand_id = 12
WHERE name IN (
    N'GSX-R 1000',
    N'GSX-S 750',
    N'V-Strom 650'
);

-- BMW
UPDATE Model
SET brand_id = 29
WHERE name IN (
    N'R 1200',
    N'R 1250',
    N'S 1000',
    N'K 1600'
);

COMMIT;
GO
