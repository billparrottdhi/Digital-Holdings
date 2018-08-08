CREATE PROCEDURE [import].[updateContacts]
	@contact_id int,
	@last_name varchar(50), 
	@first_name varchar(50), 
	@business_name varchar(100), 
	@address_line1 varchar(100), 
	@address_line2 varchar(100),
	@city varchar(50), 
	@state varchar(50), 
	@postal_code varchar(50), 
	@country varchar(100)
AS
	update	import.domain
	set		registrant_id = @contact_id
	where	registrant_first_name = @first_name
	and		registrant_last_name = @last_name
	and		registrant_organization = @business_name
	and		registrant_address_1 = @address_line1
	and		registrant_address_2 = @address_line2
	and		registrant_city = @city
	and		registrant_state_or_province = @state
	and		registrant_country = @country;

	update	import.domain
	set		admin_id = @contact_id
	where	admin_first_name = @first_name
	and		admin_last_name = @last_name
	and		admin_organization = @business_name
	and		admin_address_1 = @address_line1
	and		admin_address_2 = @address_line2
	and		admin_city = @city
	and		admin_state_or_province = @state
	and		admin_country = @country;

	update	import.domain
	set		technical_id = @contact_id
	where	technical_first_name = @first_name
	and		technical_last_name = @last_name
	and		technical_organization = @business_name
	and		technical_address_1 = @address_line1
	and		technical_address_2 = @address_line2
	and		technical_city = @city
	and		technical_state_or_province = @state
	and		technical_country = @country;

	update	import.domain
	set		billing_id = @contact_id
	where	billing_first_name = @first_name
	and		billing_last_name = @last_name
	and		billing_organization = @business_name
	and		billing_address_1 = @address_line1
	and		billing_address_2 = @address_line2
	and		billing_city = @city
	and		billing_state_or_province = @state
	and		billing_country = @country;

RETURN 0
