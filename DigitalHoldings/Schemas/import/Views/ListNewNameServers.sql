CREATE VIEW [import].[ListNewNameServers]
WITH SCHEMABINDING
AS
	SELECT		[domain_id], CONVERT(VARCHAR(50), [server_name]) [server_name]
	FROM		[import].[ListAllNameServers]
	WHERE		[nameserver_id] IS NULL
	GROUP BY	[domain_id], [server_name];
