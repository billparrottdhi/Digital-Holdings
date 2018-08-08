CREATE VIEW [import].[ListNewEmailAddresses]
AS
WITH Emails([email_address]) AS (
	SELECT	[registrant_email]
	FROM	[import].[domain]
	UNION
	SELECT	[admin_email]
	FROM	[import].[domain]
	UNION
	SELECT	[technical_email]
	FROM	[import].[domain]
	UNION
	SELECT	[billing_email]
	FROM	[import].[domain] ),
	 EmailList([email_address]) AS (
	SELECT		[email_address]
	FROM		[Emails]
	GROUP BY	[email_address] ),
	 NextId([EmailId]) AS (
	 SELECT IDENT_CURRENT('[dh].[email]') )
SELECT		COALESCE(dhe.[email_id], (ROW_NUMBER() OVER (ORDER BY el.[email_address]) - 1 + a.[EmailId])) [email_id],
			CASE WHEN dhe.[email_id] IS NULL THEN CONVERT(BIT, 1) ELSE CONVERT(BIT, 0) END [new_email_address],
			el.[email_address]
FROM		[EmailList] el
CROSS APPLY	(SELECT [EmailId] FROM NextId) a
LEFT JOIN	[dh].[email] dhe
ON			dhe.[email_address] = el.[email_address];

