CREATE TABLE [dh].[domain_nameserver]
(
	[domain_id] INT NOT NULL, 
    [nameserver_id] INT NOT NULL,
	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,  
)
GO

ALTER TABLE [dh].[domain_nameserver] ADD  CONSTRAINT [DF_dh_domain_nameserver_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[domain_nameserver] ADD CONSTRAINT [DF_dh_domain_nameserver_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

CREATE TRIGGER [dh].[domain_nameserver_AfterUpdate]
ON  [dh].[domain_nameserver]
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;
	UPDATE	a 
	SET		[modified_by] = SUSER_SNAME(), [modified_date] = GETDATE()
	FROM	[dh].[domain_nameserver] a
	JOIN	[inserted] b 
	ON		b.[domain_id] = a.[domain_id] 
	AND		b.[nameserver_id] = a.[nameserver_id];
END
GO
