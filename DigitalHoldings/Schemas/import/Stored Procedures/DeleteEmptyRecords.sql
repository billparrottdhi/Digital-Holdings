CREATE PROCEDURE [import].[DeleteEmptyRecords]
AS
BEGIN
	DELETE FROM [import].[domain] WHERE [create_date] = '1899-12-30';
END

