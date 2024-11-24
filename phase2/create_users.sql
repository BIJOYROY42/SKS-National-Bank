-- Create a login and user named “customer_group_[?]” where [?] is your
-- group letter. (For example, “customer_group_A”.)
-- Their password should be “customer”.
-- Their user account should only be able to read tables that are related
-- to customers, based on your ERD. (For example, tables related to
-- customer information, accounts, loans, and payments).

-- Giving access to the customer_group_A user to the tables related to customers such as:
-- customers, accounts, customers/accounts, transfers, addresses, accounts/Employees, accounts types?
USE Master;
GO
USE SKS_National_Bank;
GO
CREATE LOGIN customer_group_A WITH PASSWORD = 'customer';
CREATE USER customer_group_A FOR LOGIN customer_group_A;
GO
GRANT SELECT ON Customers TO customer_group_A;
GRANT SELECT ON Accounts TO customer_group_A;
GRANT SELECT ON Customers_Accounts TO customer_group_A;
GRANT SELECT ON Transfers TO customer_group_A;
GRANT SELECT ON Address TO customer_group_A;  
GRANT SELECT ON Employees_Accounts TO customer_group_A;
-- GRANT SELECT ON Account_Types TO customer_group_A;
GO
-- Remove the public role from the customer_group_A user
EXEC sp_droprolemember 'public', 'customer_group_A';
GO
-- Query to check the user and their permissions
SELECT 
    princ.name AS user_name,
    perm.permission_name,
    perm.state_desc AS permission_state,
    obj.name AS object_name,
    obj.type_desc AS object_type
FROM 
    sys.database_principals AS princ
JOIN 
    sys.database_permissions AS perm
    ON perm.grantee_principal_id = princ.principal_id
JOIN 
    sys.objects AS obj
    ON obj.object_id = perm.major_id
WHERE 
    princ.name = 'customer_group_A';

select * from  Address;
select * from Bank_Employees;
UPDATE Address SET City_Name = 'Toronto' WHERE Address_ID = 1;

-- Create a login and user named “accountant_group_[?]” where [?] is your
-- group letter. (For example, “accountant_group_B”.)
-- Their password should be “accountant”.
-- Their user account should be able to read all tables.
-- Their user account should not be able to update tables that are related
-- to accounts, payments and loans, based on your ERD.

