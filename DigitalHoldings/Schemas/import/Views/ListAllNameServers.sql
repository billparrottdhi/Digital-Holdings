CREATE VIEW [import].[ListAllNameServers]
WITH SCHEMABINDING
AS 
	WITH nameservers AS (
		SELECT		[record_id], a.[nameserver]
		FROM		[import].[domain] id
		CROSS APPLY	(SELECT [value] [nameserver] FROM STRING_SPLIT(REPLACE(REPLACE(REPLACE(id.[nameservers], ' ', ''), '(', ''), ')', ''), ',')) a),
		 serverlist AS (
		SELECT		n.[record_id], ROW_NUMBER() OVER (PARTITION BY n.[record_id] ORDER BY v.[value]) [row_number], v.[value]
		FROM		[nameservers] n
		CROSS APPLY	(SELECT [value] FROM STRING_SPLIT(n.[nameserver], '.')) v)
	SELECT		a.[record_id], d.[domain_id], ns.[nameserver_id], e.[server_name], c.[tld], b.[name]
	FROM		[serverlist] a
	JOIN		(SELECT [record_id], [value] [name] FROM [serverlist] WHERE [row_number] = 3) b
	ON			b.[record_id] = a.[record_id]
	JOIN		(SELECT [record_id], [value] [tld] FROM [serverlist] WHERE [row_number] = 1) c
	ON			c.[record_id] = a.[record_id]
	JOIN		(SELECT [record_id], [value] [server_name] FROM [serverlist] WHERE [row_number] = 5) e
	ON			e.[record_id] = a.[record_id]
	JOIN		[dh].[domain] d
	ON			d.[tld] = c.[tld]
	AND			d.[name] = b.[name]
	LEFT JOIN	[dh].[nameserver] ns
	ON			ns.[domain_id] = d.[domain_id]
	AND			ns.[server_name] = e.[server_name]
	UNION
	SELECT		a.[record_id], d.[domain_id], ns.[nameserver_id], e.[server_name], c.[tld], b.[name]
	FROM		[serverlist] a
	JOIN		(SELECT [record_id], [value] [name] FROM [serverlist] WHERE [row_number] = 3) b
	ON			b.[record_id] = a.[record_id]
	JOIN		(SELECT [record_id], [value] [tld] FROM [serverlist] WHERE [row_number] = 1) c
	ON			c.[record_id] = a.[record_id]
	JOIN		(SELECT [record_id], [value] [server_name] FROM [serverlist] WHERE [row_number] = 6) e
	ON			e.[record_id] = a.[record_id]
	JOIN		[dh].[domain] d
	ON			d.[tld] = c.[tld]
	AND			d.[name] = b.[name]
	LEFT JOIN	[dh].[nameserver] ns
	ON			ns.[domain_id] = d.[domain_id]
	AND			ns.[server_name] = e.[server_name];
