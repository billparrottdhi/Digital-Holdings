CREATE VIEW [import].[ListNameServerUpdates]
AS
	select	[record_id], [nameserver_id], 
			row_number() over (partition by [record_id] order by [nameserver_id]) [ns_id] 
	from	[import].[ListAllNameServers];


