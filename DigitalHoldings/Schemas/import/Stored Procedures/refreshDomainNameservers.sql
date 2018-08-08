CREATE PROCEDURE [import].[refreshDomainNameservers]
AS
BEGIN

	WITH nameservers([nameserver_id], [nameserver]) AS (
		SELECT	ns.[nameserver_id], (ns.[server_name]+'.'+dd.[domain_name])
		FROM	[dh].[nameserver] ns
		JOIN	[dh].[domain] dd
		ON		dd.[domain_id] = ns.[domain_id]),
		 domainnameservers([record_id], [nameserver]) AS (
		SELECT		id.[record_id], ns.[value]
		FROM		[import].[domain] id
		CROSS APPLY	(SELECT [value] FROM STRING_SPLIT(id.[nameservers], ',')) ns)
	INSERT INTO [import].[nameserver]([domain_id], [nameserver_id])
		SELECT	id.[domain_id], ns.[nameserver_id]
		FROM	[domainnameservers] dns
		JOIN	[nameservers] ns
		ON		ns.[nameserver] = dns.[nameserver]
		JOIN	[import].[domain] id
		ON		id.[record_id] = dns.[record_id]

	BEGIN TRY
		BEGIN TRANSACTION;

		MERGE	[dh].[domain_nameserver] AS t
		USING	[import].[nameserver] AS s
		ON		(s.[domain_id] = t.[domain_id] AND s.[nameserver_id] =  t.[nameserver_id])
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ([domain_id], [nameserver_id]) VALUES (s.[domain_id], s.[nameserver_id])
		WHEN NOT MATCHED BY SOURCE THEN
			DELETE;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH

	RETURN(0);
END