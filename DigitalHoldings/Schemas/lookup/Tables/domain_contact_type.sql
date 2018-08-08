CREATE TABLE [lookup].[domain_contact_type](
	[contact_type_id] [smallint] NOT NULL,
	[contact_type_name] [varchar](50) NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_domain_contact_type] PRIMARY KEY CLUSTERED 
(
	[contact_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [lookup].[domain_contact_type] ADD  CONSTRAINT [DF_lookup_domain_contact_type_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [lookup].[domain_contact_type] ADD  CONSTRAINT [DF_lookup_domain_contact_type_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [lookup].[domain_contact_type_AfterUpdate]
ON  [lookup].[domain_contact_type]
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;
UPDATE a SET modified_by = SUSER_SNAME(), modified_date = GETDATE()
FROM [lookup].[domain_contact_type] a
JOIN INSERTED b ON b.contact_type_id = a.contact_type_id;
END

GO

ALTER TABLE [lookup].[domain_contact_type] ENABLE TRIGGER [domain_contact_type_AfterUpdate]
GO