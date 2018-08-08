CREATE PROCEDURE [import].[getCompanyInfo]
	@file_name		VARCHAR(1000),
	@company_id		INT				OUTPUT,
	@company_name	VARCHAR(100)	OUTPUT
AS
	DECLARE @list TABLE (row_id INT IDENTITY(1,1) PRIMARY KEY, [value] varchar(255));

	INSERT INTO @list([value])
		SELECT	[value]
		FROM	string_split(@file_name, '\');

	

	;WITH CompanyName(company_name) AS (
		SELECT	TOP 1 [value] 
		FROM	STRING_SPLIT((SELECT [value] from @list where row_id = (SELECT MAX(row_id) FROM @list)), '_') )
	SELECT	@company_id = c.company_id, @company_name = c.company_name
	FROM	[dh].[company] c
	JOIN	CompanyName cn
	ON		cn.[company_name] = c.[company_name]
