CREATE TABLE [dh].[entity_naics]
(
	[entity_id] INT NOT NULL, 
    [naics_code] INT NOT NULL , 
 	[created_by] [nvarchar](128) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_by] [nvarchar](128) NULL,
	[modified_date] [datetime] NULL, 
    CONSTRAINT [FK_entity_naics_dh_entity] FOREIGN KEY ([entity_id]) REFERENCES [dh].[entity]([entity_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_entity_naics_lookup_naics] FOREIGN KEY ([naics_code]) REFERENCES [lookup].[naics]([naics_code]) ON DELETE CASCADE, 
    CONSTRAINT [PK_entity_naics] PRIMARY KEY ([entity_id], [naics_code]),
)
GO

ALTER TABLE	[dh].[entity_naics] ADD CONSTRAINT [DF_dh_entity_naics_created_by] DEFAULT (suser_sname()) FOR [created_by]
GO

ALTER TABLE	[dh].[entity_naics] ADD CONSTRAINT [DF_dh_entity_naics_created_date] DEFAULT (getdate()) FOR [created_date]
GO
