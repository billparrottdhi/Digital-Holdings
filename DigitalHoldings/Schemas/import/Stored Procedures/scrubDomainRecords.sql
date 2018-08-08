CREATE PROCEDURE [import].[scrubDomainRecords]
AS
BEGIN
	/*
		Remove bad records from import.domain table
	*/
	DELETE FROM [import].[domain] WHERE [create_date] = '1899-12-30';

	UPDATE	[import].[domain]
	SET		[nameservers] = REPLACE(REPLACE(REPLACE([nameservers], ' ', ''), ')', ''), '(', ''),
			[tld] = REPLACE([tld], '.', '');

	UPDATE	id
	SET		[new_domain] = 0,
			[domain_id] = dhd.[domain_id]
	FROM	[import].[domain] id
	JOIN	[dh].[domain] dhd
	ON		dhd.[domain_name] = id.[domain_name];

	WITH NextId([domain_id]) AS (
		SELECT MAX([domain_id]) FROM [dh].[domain] ),
		 NewDomainIds([record_id], [domain_id]) AS (
		SELECT		d.[record_id],
					((ROW_NUMBER() OVER (ORDER BY d.[domain_name])) + a.[domain_id]) 
		FROM		[import].[domain] d
		CROSS APPLY	(SELECT [domain_id] FROM NextId) a
		WHERE		d.[new_domain] = 1
		GROUP BY	d.[record_id], d.[domain_name], a.[domain_id] )
	UPDATE	id
	SET		[domain_id] = ndi.[domain_id]
	FROM	[import].[domain] id
	JOIN	NewDomainIds ndi
	ON		ndi.[record_id] = id.[record_id];

END
