CREATE VIEW [import].[ListNewContacts]
AS
	WITH Contacts([last_name], [first_name], [business_name], [address_line1], [address_line2],
					[city], [state], [postal_code], [country], [phone_number], [fax_number]) AS (
		SELECT	[registrant_last_name], [registrant_first_name], [registrant_organization],
				[registrant_address_1], [registrant_address_2], [registrant_city],
				[registrant_state_or_province], [registrant_postal_code], [registrant_country],
				[registrant_phone], [registrant_fax]
		FROM	[import].[domain]
		UNION
		SELECT	[admin_last_name], [admin_first_name], [admin_organization],
				[admin_address_1], [admin_address_2], [admin_city],
				[admin_state_or_province], [admin_postal_code], [admin_country],
				[admin_phone], [admin_fax]
		FROM	[import].[domain]
		UNION
		SELECT	[technical_last_name], [technical_first_name], [technical_organization],
				[technical_address_1], [technical_address_2], [technical_city],
				[technical_state_or_province], [technical_postal_code], [technical_country],
				[technical_phone], [technical_fax]
		FROM	[import].[domain]
		UNION
		SELECT	[billing_last_name], [billing_first_name], [billing_organization],
				[billing_address_1], [billing_address_2], [billing_city],
				[billing_state_or_province], [billing_postal_code], [billing_country],
				[billing_phone], [billing_fax]
		FROM	[import].[domain]),
			 ContactList ([last_name], [first_name], [business_name], [address_line1], [address_line2],
						[city], [state], [postal_code], [country], [phone_number], [fax_number]) AS (
		SELECT	[last_name], [first_name], [business_name], [address_line1], [address_line2],
				[city], [state], [postal_code], [country], [phone_number], [fax_number]
		FROM	[Contacts] GROUP BY [last_name], [first_name], [business_name], [address_line1], [address_line2],
									[city], [state], [postal_code], [country], [phone_number], [fax_number]),
		NextId([ContactId]) AS (
			SELECT IDENT_CURRENT('[dh].[contact]') )
	SELECT		COALESCE(dhc.[contact_id], (ROW_NUMBER() OVER (ORDER BY cl.[last_name], cl.[first_name], cl.[business_name], cl.[address_line1], cl.[address_line2], cl.[city], cl.[state], cl.[postal_code], cl.[country]) - 1 + a.[ContactId])) [contact_id],
				CASE WHEN dhc.[contact_id] IS NULL THEN CONVERT(BIT, 1) ELSE CONVERT(BIT, 0) END [NewRecord],
				convert(varchar(50), cl.[last_name]) [last_name], convert(varchar(50), cl.[first_name]) [first_name], convert(varchar(100), cl.[business_name]) [business_name], cl.[address_line1], 
				cl.[address_line2], convert(varchar(50), cl.[city]) [city], convert(varchar(50), cl.[state]) [state], convert(varchar(50), cl.[postal_code]) [postal_code], cl.[country],
				convert(varchar(50), cl.[phone_number]) [phone_number], convert(varchar(50), cl.[fax_number]) [fax_number]
	FROM		[ContactList] cl
	CROSS APPLY (SELECT [ContactId] FROM [NextId]) a
	LEFT JOIN	[dh].[contact] dhc
	ON			dhc.[last_name] =  cl.[last_name]
	AND			dhc.[first_name] = cl.[first_name]
	AND			dhc.[business_name] = cl.[business_name]
	AND			dhc.[address_line1] = cl.[address_line1]
	AND			dhc.[address_line2] = cl.[address_line2]
	AND			dhc.[city] = cl.[city]
	AND			dhc.[state] = cl.[state]
	AND			dhc.[postal_code] = cl.[postal_code]
	AND			dhc.[country] = cl.[country];
