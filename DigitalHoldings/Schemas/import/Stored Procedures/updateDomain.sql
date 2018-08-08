CREATE PROCEDURE [import].[updateDomain]
	@tld				varchar(10),
	@name				varchar(100),
	@domain_id			int,
	@registrar_id		int,
	@create_date		date,
	@expiration_date	date,
	@is_active			bit,
	@is_public			bit,
	@is_locked			bit,
	@auto_renew			bit,
	@is_system			bit,
	@company_id			int
AS
	-- EXEC import.updateDomain ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?

	set nocount on;

	update	dh.domain
	set		tld = @tld,
			[name] = @name,
			registrar_id = @registrar_id,
			create_date = @create_date,
			expiration_date = @expiration_date,
			is_active = @is_active,
			is_public = @is_public,
			is_locked = @is_locked,
			auto_renew = @auto_renew,
			is_system = @is_system,
			company_id = @company_id
	where	domain_id = @domain_id;

RETURN 0
