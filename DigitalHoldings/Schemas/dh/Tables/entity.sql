CREATE TABLE [dh].[entity](
	[entity_id] [int] NOT NULL,
	[entity_name] [varchar](100) NULL,
	[entity_letters] [varchar](10) NULL,
	[domain_id] [int] NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_entity] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY], 
    CONSTRAINT [FK_entity_domain] FOREIGN KEY ([domain_id]) REFERENCES [dh].[domain]([domain_id]) ON DELETE SET NULL
) ON [PRIMARY]
GO

ALTER TABLE [dh].[entity] ADD  CONSTRAINT [DF_dh_entity_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[entity] ADD  CONSTRAINT [DF_dh_entity_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[entity_AfterUpdate]
ON  [dh].[entity]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[entity] a
	JOIN	[inserted] b 
	ON		b.[entity_id] = a.[entity_id];
END

GO

ALTER TABLE [dh].[entity] ENABLE TRIGGER [entity_AfterUpdate]
GO


