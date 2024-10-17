CREATE DATABASE SKS_National_Bank
GO
USE SKS_National_Bank
GO

CREATE TABLE Facilities(
	Facility_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	Is_Branch BIT NOT NULL, --Can store 0 or 1 acts as BOOL
	Facility_Name VARCHAR(75) UNIQUE
	FOREIGN KEY (Address_ID) REFERENCES Address(address_ID)
);

CREATE TABLE Address(
	address_ID INT IDENTITY PRIMARY KEY,
	City_Name VARCHAR(60) NOT NULL,
	Province_Name VARCHAR(60) NOT NULL,
	Street_Number int NOT NULL,
	Street_Name VARCHAR(60) NOT NULL,
	Appt_Number VARCHAR(10) NOT NULL,
);

CREATE TABLE Customers(
	Customer_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(100) NOT NULL,
	FOREIGN KEY (address_ID) REFERENCES Address(address_ID)
);

CREATE TABLE Bank_Employees(
	Employee_ID INT IDENTITY PRIMARY KEY,
	Employee_Address_ID INT NOT NULL,
	Role VARCHAR(150)NOT NULL,
	Manager_ID INT NOT NULL,
	Start_Date DATE NOT NULL,
	Employee_First_Name VARCHAR(70),
	Employee_Last_Name VARCHAR(70)
	FOREIGN KEY (Employee_Address_ID) REFERENCES Address(Address_ID)
);

CREATE TABLE Employees_Work_Addresses(
	Employee_ID INT,
	Address_ID iNT,
	PRIMARY KEY(Employee_ID, Address_ID),
	FOREIGN KEY (Employee_ID) REFERENCES Bank_Employees(Employee_ID),
	FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);