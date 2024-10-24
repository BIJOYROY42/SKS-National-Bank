USE SKS_National_Bank
GO

--Drop the stored procedure if it exists
IF OBJECT_ID('dbo.Track_Loan', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Track_Loan;
END

--Tracks the top three largest loan amongst all accounts that has loan in it
CREATE PROCEDURE Track_Loan ( @accType AS NVARCHAR(100))
AS
BEGIN 
    SELECT TOP 3
        Accounts.Account_ID, Account_Types.Account_Type_Name, Accounts.Balance
    FROM 
        dbo.Accounts
	INNER JOIN
		dbo.Account_Types ON Accounts.Account_Type_ID = Account_Types.Account_Type_ID 
    WHERE 
        Account_Types.Account_Type_Name = @accType
    ORDER BY
        Accounts.Balance DESC;
END
GO

--Ensure that all things must be dynamic and avoid hardcoding it
EXEC Track_Loan 'loan'

--Rertrieve all employees in a branch
IF OBJECT_ID('dbo.Get_Employees', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Get_Employees
END

CREATE PROCEDURE Get_Employees (@BranchName AS NVARCHAR(40))
AS
BEGIN
	SELECT
		be.Employee_ID, f.Facility_Name, be.Employee_First_Name, be.Employee_Last_Name, be.Role
	FROM
		dbo.Bank_Employees be
	INNER JOIN
		dbo.Facilities f ON be.Facility_ID = f.Facility_ID
	WHERE
		f.Facility_Name = @BranchName
	ORDER BY
		be.Employee_First_Name
END

EXEC Get_Employees 'office 4'

--Add Transfer to Account of Customer
IF OBJECT_ID('dbo.Transfer_Money', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Transfer_Money
END

CREATE PROCEDURE Transfer_Money (@Account_ID AS INT, @Transfer AS MONEY, @Transfer_Date AS DATE)
AS
BEGIN
	INSERT INTO Transfers
	VALUES (
		 @Account_ID, @Transfer, @Transfer_Date)
END

EXEC Transfer_Money 1, 20000.00, '2024-10-24'

SELECT * FROM TRANSFERS
SELECT Account_ID From Accounts
