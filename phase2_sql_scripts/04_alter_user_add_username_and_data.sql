USE CarMarketDB;
GO

-- مرحله ۱: اضافه کردن ستون username (بدون UNIQUE در این مرحله)
ALTER TABLE [User] ADD username NVARCHAR(50) NULL;
GO

-- مرحله ۲: به‌روزرسانی username برای کاربران موجود
UPDATE [User] SET username = 'user' + CAST(userid AS NVARCHAR(10)) WHERE username IS NULL;
GO

-- مرحله ۳: اضافه کردن محدودیت UNIQUE روی ستون username
ALTER TABLE [User] ADD CONSTRAINT UQ_User_Username UNIQUE (username);
GO

-- مرحله ۴: اضافه کردن کاربران جدید (با username)
INSERT INTO [User] (phone, reg_status, account_status, register_date, national_id, username) VALUES 
('09129998888', 1, 1, GETDATE(), '7788990011', 'u4042'),
('09127776666', 1, 1, GETDATE(), '6677889900', 'u4021'),
('09128887777', 1, 1, GETDATE(), '5566778899', 'u4022'),
('09126665555', 1, 1, GETDATE(), '4455667788', 'u4023'),
('09124445555', 1, 1, GETDATE(), '3344556677', N'پرسنل 3'),
('09123336666', 1, 1, GETDATE(), '2233445566', 'user_test1'),
('09122224444', 1, 1, GETDATE(), '1122334455', 'user_test2');
GO

-- مرحله ۵: بررسی کاربران
SELECT userid, phone, username, national_id, reg_status, account_status, register_date
FROM [User]
ORDER BY userid;
GO
