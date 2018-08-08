CREATE VIEW [import].[ListNameserversandContacts]
AS 
	SELECT	[domain_id], [nameserver_id_1], [nameserver_id_2], 
			(SELECT [contact_type_id] FROM [lookup].[domain_contact_type] WHERE [contact_type_name] = 'Registrant') [registrant_id_type], [registrant_id],
			(SELECT [contact_type_id] FROM [lookup].[domain_contact_type] WHERE [contact_type_name] = 'Administrative Contact') [admin_id_type], [admin_id],
			(SELECT [contact_type_id] FROM [lookup].[domain_contact_type] WHERE [contact_type_name] = 'Technical Contact') [technical_id_type], [technical_id],
			(SELECT [contact_type_id] FROM [lookup].[domain_contact_type] WHERE [contact_type_name] = 'Billing Contact') [billing_id_type], [billing_id]
	FROM	[import].[domain] d
