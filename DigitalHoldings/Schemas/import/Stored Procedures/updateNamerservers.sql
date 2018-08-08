CREATE PROCEDURE [import].[updateNamerservers]
	@record_id int,
	@nameserver_id int,
	@which_nameserver int
AS
	if (@which_nameserver = 1)
		update	import.domain
		set		nameserver_id_1 = @nameserver_id
		where	record_id = @record_id;
	else
		update	import.domain
		set		nameserver_id_2 = @nameserver_id
		where	record_id = @record_id;
RETURN 0
