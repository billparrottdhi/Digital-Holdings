CREATE TABLE [dh].[domain_contact](
	[domain_id] [int] NOT NULL,
	[contact_type_id] [smallint] NOT NULL,
	[contact_id] [int] NOT NULL,
	[email_id] [int] NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_domain_contact] PRIMARY KEY CLUSTERED 
(
	[domain_id] ASC,
	[contact_type_id] ASC,
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY], 
    CONSTRAINT [FK_domain_contact_dh_email] FOREIGN KEY ([email_id]) REFERENCES [dh].[email]([email_id])
) ON [PRIMARY]
GO

ALTER TABLE [dh].[domain_contact] ADD  CONSTRAINT [DF_dh_domain_contact_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[domain_contact] ADD  CONSTRAINT [DF_dh_domain_contact_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dh].[domain_contact]  WITH CHECK ADD  CONSTRAINT [FK_domain_contact_contact] FOREIGN KEY([contact_id])
REFERENCES [dh].[contact] ([contact_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dh].[domain_contact] CHECK CONSTRAINT [FK_domain_contact_contact]
GO

ALTER TABLE [dh].[domain_contact]  WITH CHECK ADD  CONSTRAINT [FK_domain_contact_domain] FOREIGN KEY([domain_id])
REFERENCES [dh].[domain] ([domain_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dh].[domain_contact] CHECK CONSTRAINT [FK_domain_contact_domain]
GO

ALTER TABLE [dh].[domain_contact]  WITH CHECK ADD  CONSTRAINT [FK_domain_contact_domain_contact_type] FOREIGN KEY([contact_type_id])
REFERENCES [lookup].[domain_contact_type] ([contact_type_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dh].[domain_contact] CHECK CONSTRAINT [FK_domain_contact_domain_contact_type]
GO

CREATE TRIGGER [dh].[domain_contact_AfterUpdate]
ON  [dh].[domain_contact]
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;
UPDATE a SET modified_by = SUSER_SNAME(), modified_date = GETDATE()
FROM [dh].[domain_contact] a
JOIN INSERTED b ON b.domain_id = a.domain_id AND b.contact_type_id = a.contact_type_id AND b.contact_id = a.contact_id;
END

GO

ALTER TABLE [dh].[domain_contact] ENABLE TRIGGER [domain_contact_AfterUpdate]
GO


