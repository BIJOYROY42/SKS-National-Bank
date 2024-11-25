Use SKS_National_Bank;

GO

ALTER TABLE Address ADD AddressJSON NVARCHAR (MAX);

GO
UPDATE Address
SET
    AddressJSON = (
        SELECT
            Address_ID,
            City_Name,
            Province_Name L,
            Street_Number,
            Street_Name,
            Appt_Number
        FROM Address AS a
        WHERE
            a.Address_ID = Address.Address_ID FOR JSON PATH,
            INCLUDE_NULL_VALUES,
            WITHOUT_ARRAY_WRAPPER
    );
GO

SELECT * FROM Address;