CREATE TABLE [lookup].[naics](
	[naics_code] [int] NOT NULL,
	[parent_code] [int] NULL,
	[naics_title] [varchar](255) NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_naics] PRIMARY KEY CLUSTERED 
(
	[naics_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [lookup].[naics] ADD  CONSTRAINT [DF_lookup_naics_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [lookup].[naics] ADD  CONSTRAINT [DF_lookup_naics_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [lookup].[naics_AfterUpdate]
ON  [lookup].[naics]
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;
UPDATE a SET modified_by = SUSER_SNAME(), modified_date = GETDATE()
FROM [lookup].[naics] a
JOIN INSERTED b ON b.naics_code = a.naics_code;
END

GO

ALTER TABLE [lookup].[naics] ENABLE TRIGGER [naics_AfterUpdate]
GO
