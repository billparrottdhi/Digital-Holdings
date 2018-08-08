CREATE VIEW [dbo].[ListDomains]
AS
	WITH SplitDomainNames([record_id], [row_id], [name]) AS (
		SELECT		record_id, ROW_NUMBER() OVER (PARTITION BY [record_id] ORDER BY [record_id]), [value]
		FROM		[import].[domain]
		CROSS APPLY	STRING_SPLIT([domain_name], '.') ),
		 NameList([record_id], [name]) AS (
		SELECT [record_id], [name] FROM SplitDomainNames WHERE [row_id] = 1 )
	SELECT		d.[tld], CONVERT(VARCHAR(100), nl.[name]) [name], d.[domain_id], r.[registrar_id], d.[create_date], d.[expiration_date],
				d.[company_id],
				CONVERT(BIT, (CASE d.[status] WHEN 'Active' THEN 1 ELSE 0 END)) [is_active],
				CONVERT(BIT, (CASE d.[privacy] WHEN 'Public' THEN 1 ELSE 0 END)) [is_public],
				CONVERT(BIT, (CASE d.[locked] WHEN 'Locked' THEN 1 ELSE 0 END)) [is_locked],
				CONVERT(BIT, (CASE d.[auto_renew] WHEN 'On' THEN 1 ELSE 0 END)) [auto_renew],
				CONVERT(BIT, 0) [is_system],
				[new_domain]
	FROM		[import].[domain] d
	JOIN		NameList nl
	ON			nl.[record_id] = d.[record_id]
	CROSS APPLY	(SELECT [registrar_id] FROM [dh].[registrar] WHERE [registrar_name] = 'GoDaddy') r
