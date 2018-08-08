CREATE VIEW [dh].[00-EntityInitialsNameDomainSegmentedbyVCverticals]
AS 
	SELECT	ev.[vertical_id], e.[entity_id], d.[domain_id], d.[is_public],
			d.[expiration_date], e.[entity_letters], e.[entity_name], d.[domain_name], vc.[vertical_name]
	FROM	[dh].[domain] d
	JOIN	[dh].[entity] e
	ON		d.[domain_id] = e.[domain_id]
	JOIN	[dh].[entity_vertical] ev
	ON		ev.[entity_id] = e.[entity_id]
	JOIN	[lookup].[vc_vertical] vc
	ON		vc.[vertical_id] = ev.[vertical_id];
