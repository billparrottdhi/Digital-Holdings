CREATE TABLE [dh].[entity_vertical]
(
	[entity_id] INT NOT NULL , 
    [vertical_id] INT NOT NULL, 
 	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL,
   PRIMARY KEY ([entity_id], [vertical_id]), 
    CONSTRAINT [FK_entity_vertical_entity] FOREIGN KEY ([entity_id]) REFERENCES [dh].[entity]([entity_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_entity_vertical_lookup_vc_vertical] FOREIGN KEY ([vertical_id]) REFERENCES [lookup].[vc_vertical]([vertical_id]) ON DELETE CASCADE
)
GO

ALTER TABLE [dh].[entity_vertical] ADD  CONSTRAINT [DF_dh_entity_vertical_created_by]  DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE [dh].[entity_vertical] ADD  CONSTRAINT [DF_dh_entity_vertical_created_date]  DEFAULT (getdate()) FOR [created_date]
GO
