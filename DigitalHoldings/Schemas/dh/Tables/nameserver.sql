CREATE TABLE [dh].[nameserver]
(
	[nameserver_id] INT NOT NULL IDENTITY(1,1), 
    [domain_id] INT NOT NULL, 
    [server_name] VARCHAR(50) NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL, 
    CONSTRAINT [PK_nameserver] PRIMARY KEY ([domain_id], [server_name]), 
)
GO

ALTER TABLE [dh].[nameserver] ADD  CONSTRAINT [DF_dh_nameserver_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[nameserver] ADD CONSTRAINT [DF_dh_nameserver_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[nameserver_AfterUpdate]
ON  [dh].[nameserver]
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[nameserver] a
	JOIN	[inserted] b 
	ON		b.[domain_id] = a.[domain_id] 
	AND		b.[server_name] = a.[server_name];
END
GO

CREATE UNIQUE INDEX [UK_dh_nameserver_nameserver_id] ON [dh].[nameserver] ([nameserver_id])
  
GO
