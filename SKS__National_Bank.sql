
USE master
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SKS_National_Bank')
BEGIN
	DROP DATABASE SKS_National_Bank
END


CREATE DATABASE SKS_National_Bank
GO
USE SKS_National_Bank
GO

IF OBJECT_ID('Bank_Employees', 'U') IS NOT NULL DROP TABLE Bank_Employees;

IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;

IF OBJECT_ID('Facilities', 'U') IS NOT NULL DROP TABLE Facilities;

IF OBJECT_ID('Address', 'U') IS NOT NULL DROP TABLE Address;


CREATE TABLE Address(
	address_ID INT IDENTITY PRIMARY KEY,
	City_Name VARCHAR(60) NOT NULL,
	Province_Name VARCHAR(60) NOT NULL,
	Street_Number int NOT NULL,
	Street_Name VARCHAR(60) NOT NULL,
	Appt_Number VARCHAR(10)
);

CREATE TABLE Facilities(
	Facility_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	Is_Branch BIT NOT NULL, --Can store 0 or 1 acts as BOOL
	Facility_Name VARCHAR(75) UNIQUE,
	FOREIGN KEY (Address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Customers(
	Customer_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(100) NOT NULL,
	FOREIGN KEY (address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Bank_Employees(
	Employee_Address_ID INT NOT NULL,
	Role VARCHAR(150)NOT NULL,
	Manager_ID INT NOT NULL,
	Start_Date DATE NOT NULL,
	Employee_First_Name VARCHAR(70),
	Employee_Last_Name VARCHAR(70),
	Employees_Work_AddressesWork_Address_ID INT NOT NULL,
	FOREIGN KEY (Employees_Work_AddressesWork_Address_ID) REFERENCES Address(Address_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Employee_Address_ID) REFERENCES Address(Address_ID) ON DELETE CASCADE
);
