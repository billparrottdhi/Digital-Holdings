CREATE TABLE [dh].[contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[last_name] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[business_name] [varchar](100) NULL,
	[address_line1] [varchar](100) NULL,
	[address_line2] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[postal_code] [varchar](50) NULL,
	[country] [varchar](100) NULL,
	[phone_number] [varchar](50) NULL,
	[fax_number] [varchar](50) NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dh].[contact] ADD  CONSTRAINT [DF_dh_contact_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[contact] ADD  CONSTRAINT [DF_dh_contact_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[contact_AfterUpdate]
ON  [dh].[contact]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[contact] a
	JOIN	[inserted] b
	ON		b.[contact_id] = a.[contact_id];
END

GO

ALTER TABLE [dh].[contact] ENABLE TRIGGER [contact_AfterUpdate]
GO

CREATE INDEX [IX_dh_contact_NameLookup] ON [dh].[contact] ([last_name], [first_name], [business_name], [address_line1], [address_line2], [city], [state], [postal_code], [country])
