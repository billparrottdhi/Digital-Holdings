CREATE VIEW [import].[ListExistingDomains]
WITH SCHEMABINDING
AS 
	SELECT	id.[record_id], dd.[domain_id], id.[domain_name]
	FROM	[import].[domain] id
	JOIN	[dh].[domain] dd
	ON		dd.[domain_name] = id.[domain_name];

