CREATE TABLE [lookup].[entity_funding_stage]
(
	[entity_funding_stage_id] INT NOT NULL PRIMARY KEY,
	[entity_funding_stage_description] VARCHAR(50)
)

GO

CREATE UNIQUE INDEX [UK_entity_funding_stage_description] ON [lookup].[entity_funding_stage] ([entity_funding_stage_description])
