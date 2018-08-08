CREATE TABLE [dh].[tld] (
    [tld]           VARCHAR (10)   NOT NULL,
    [created_by]    NVARCHAR (128) NOT NULL,
    [created_date]  DATETIME       NOT NULL,
    [modified_by]   NVARCHAR (128) NULL,
    [modified_date] DATETIME       NULL, 
    CONSTRAINT [PK_tld] PRIMARY KEY ([tld])
);
GO

ALTER TABLE [dh].[tld]
    ADD CONSTRAINT [DF_dh_tld_created_by] DEFAULT (suser_sname()) FOR [created_by];
GO

ALTER TABLE [dh].[tld]
    ADD CONSTRAINT [DF_dh_tld_created_date] DEFAULT (getdate()) FOR [created_date];
GO
CREATE TRIGGER [dh].[tld_AfterUpdate]
ON  [dh].[tld]
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;
	UPDATE	a 
	SET		modified_by = SUSER_SNAME(), modified_date = GETDATE()
	FROM	[dh].[tld] a
	JOIN	[inserted] b 
	ON		b.[tld] = a.[tld];
END

GO

ALTER TABLE [dh].[tld] ENABLE TRIGGER [tld_AfterUpdate]
GO
