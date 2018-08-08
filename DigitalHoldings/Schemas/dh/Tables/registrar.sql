CREATE TABLE [dh].[registrar](
	[registrar_id] [int] IDENTITY(1,1) NOT NULL,
	[registrar_name] [varchar](50) NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
 CONSTRAINT [PK_registrar] PRIMARY KEY CLUSTERED 
(
	[registrar_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_registrar_registrar_id] UNIQUE NONCLUSTERED 
(
	[registrar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dh].[registrar] ADD  CONSTRAINT [DF_dh_registrar_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[registrar] ADD  CONSTRAINT [DF_dh_registrar_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[registrar_AfterUpdate]ON  [dh].[registrar]AFTER UPDATEASBEGIN	SET NOCOUNT ON;	UPDATE	a	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()	FROM	[dh].[registrar] a	JOIN	[inserted] b 	ON		b.[registrar_name] = a.[registrar_name];END
GO

ALTER TABLE [dh].[registrar] ENABLE TRIGGER [registrar_AfterUpdate]
GO
