CREATE PROCEDURE [import].[updateEmails]
	@email_id int,
	@email_address varchar(255)
AS
	update	import.domain
	set		registrant_email_id = @email_id
	where	registrant_email = @email_address;

	update	import.domain
	set		technical_email_id = @email_id
	where	technical_email = @email_address;

	update	import.domain
	set		admin_email_id = @email_id
	where	admin_email = @email_address;

	update	import.domain
	set		billing_email_id = @email_id
	where	billing_email = @email_address;

RETURN 0
