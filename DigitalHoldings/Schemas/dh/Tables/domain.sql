CREATE TABLE [dh].[domain](
	[tld] [varchar](10) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[domain_name]  AS (([name]+'.')+[tld]) PERSISTED NOT NULL,
	[domain_id] [int] NOT NULL,
	[registrar_id] [int] NULL,
	[create_date] [date] NULL,
	[expiration_date] [date] NULL,
	[is_active] [bit] NULL,
	[is_public] [bit] NULL,
	[is_locked] [bit] NULL,
	[auto_renew] [bit] NULL,
	[is_system] [bit] NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
	[company_id] INT NOT NULL DEFAULT -1, 
    CONSTRAINT [PK_domain] PRIMARY KEY CLUSTERED 
(
	[tld] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_domain_domain_id] UNIQUE NONCLUSTERED 
(
	[domain_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dh].[domain] ADD  CONSTRAINT [DF_dh_domain_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[domain] ADD  CONSTRAINT [DF_dh_domain_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dh].[domain] ADD CONSTRAINT [DF_dh_domain_is_system] DEFAULT (CONVERT(BIT, 0)) FOR [is_system]
GO

ALTER TABLE [dh].[domain]  WITH CHECK ADD  CONSTRAINT [FK_domain_registrar] FOREIGN KEY([registrar_id])
REFERENCES [dh].[registrar] ([registrar_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dh].[domain] CHECK CONSTRAINT [FK_domain_registrar]
GO

ALTER TABLE [dh].[domain]  WITH CHECK ADD  CONSTRAINT [FK_domain_tld] FOREIGN KEY([tld])
REFERENCES [dh].[tld] ([tld])
GO

ALTER TABLE [dh].[domain] CHECK CONSTRAINT [FK_domain_tld]
GO

CREATE TRIGGER [dh].[domain_AfterUpdate]
ON  [dh].[domain]
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[domain] a
	JOIN	[inserted] b 
	ON		b.[tld] = a.[tld] 
	AND		b.[name] = a.[name];
END
GO

ALTER TABLE [dh].[domain] ENABLE TRIGGER [domain_AfterUpdate]
GO



