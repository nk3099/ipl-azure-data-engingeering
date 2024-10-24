USE ipl_gold_layer_db;
GO

CREATE OR ALTER PROCEDURE CreateSQLServerlessView_ipl_gold_layer_db 
    @ViewName NVARCHAR(100)
AS
BEGIN
    -- Declare a variable to hold the dynamic SQL statement
    DECLARE @statement NVARCHAR(MAX);

    -- Build the dynamic SQL statement with proper spacing
    SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(@ViewName) + N' AS
        SELECT *
        FROM OPENROWSET(
            BULK ''https://ipl3099datalakegen2.dfs.core.windows.net/gold/' + @ViewName + N'/'',
            FORMAT = ''DELTA''
        ) AS [result]';

    -- Print the dynamic SQL for debugging (optional)
    PRINT @statement;

    -- Execute the dynamic SQL statement
    EXEC sp_executesql @statement;
END;
GO
