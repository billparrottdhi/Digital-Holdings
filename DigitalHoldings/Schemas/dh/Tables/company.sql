CREATE TABLE [dh].[company]
(
	[company_id] INT NOT NULL IDENTITY, 
    [company_name] VARCHAR(100) NOT NULL, 
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL, 
    CONSTRAINT [PK_company] PRIMARY KEY ([company_id]), 
    CONSTRAINT [UK_company_company_name] UNIQUE ([company_name]),
)
GO

ALTER TABLE [dh].[company] ADD  CONSTRAINT [DF_dh_company_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[company] ADD  CONSTRAINT [DF_dh_company_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[company_AfterUpdate]
ON  [dh].[company]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[company] a
	JOIN	[inserted] b
	ON		b.[company_id] = a.[company_id];
END

GO
