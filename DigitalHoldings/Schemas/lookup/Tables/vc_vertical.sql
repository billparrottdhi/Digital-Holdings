CREATE TABLE [lookup].[vc_vertical](
	[vertical_id] [int] NOT NULL,
	[vertical_name] [varchar](100) NOT NULL,
	[vertical_decsription] [varchar](max) NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_vc_vertical] PRIMARY KEY CLUSTERED 
(
	[vertical_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [lookup].[vc_vertical] ADD  CONSTRAINT [DF_lookup_vc_vertical_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [lookup].[vc_vertical] ADD  CONSTRAINT [DF_lookup_vc_vertical_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [lookup].[vc_vertical_AfterUpdate]
ON  [lookup].[vc_vertical]
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;
UPDATE a SET modified_by = SUSER_SNAME(), modified_date = GETDATE()
FROM [lookup].[vc_vertical] a
JOIN INSERTED b ON b.vertical_id = a.vertical_id;
END

GO

ALTER TABLE [lookup].[vc_vertical] ENABLE TRIGGER [vc_vertical_AfterUpdate]
GO


CREATE INDEX [IX_vc_vertical_vertical_name] ON [lookup].[vc_vertical] ([vertical_name])
