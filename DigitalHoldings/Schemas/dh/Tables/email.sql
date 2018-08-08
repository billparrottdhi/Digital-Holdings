CREATE TABLE [dh].[email]
(
	[email_id] INT NOT NULL IDENTITY(1,1),
	[email_address] VARCHAR(255) NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_dh_email] PRIMARY KEY CLUSTERED 
([email_address])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dh].[email] ADD  CONSTRAINT [DF_dh_email_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[email] ADD  CONSTRAINT [DF_dh_email_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[email_AfterUpdate]
ON  [dh].[email]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[email] a
	JOIN	[inserted] b
	ON		b.[email_id] = a.[email_id];
END

GO



GO

CREATE UNIQUE INDEX [UK_dh_email_email_id] ON [dh].[email] ([email_id])
GO