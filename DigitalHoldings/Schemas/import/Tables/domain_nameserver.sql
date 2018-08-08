CREATE TABLE [import].[domain_nameserver]
(
	[domain_id] INT NOT NULL , 
    [nameserver_id] INT NOT NULL, 
    PRIMARY KEY ([domain_id], [nameserver_id])
)
