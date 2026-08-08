USE CarMarketDB;
GO

IF OBJECT_ID('ContactMessages', 'U') IS NOT NULL
    DROP TABLE ContactMessages;
GO

CREATE TABLE ContactMessages (
    contact_message_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(150) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    email NVARCHAR(254) NOT NULL,
    subject NVARCHAR(30) NOT NULL CHECK (subject IN ('support', 'ad', 'cooperation', 'other')),
    message NVARCHAR(MAX) NOT NULL,
    created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    is_read BIT NOT NULL DEFAULT 0
);
GO

CREATE INDEX IX_ContactMessages_IsRead ON ContactMessages (is_read);
CREATE INDEX IX_ContactMessages_CreatedDate ON ContactMessages (created_date);
GO