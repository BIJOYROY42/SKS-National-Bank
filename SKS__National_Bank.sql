
USE master
GO

IF EXISTS (SELECT name
FROM sys.databases
WHERE name = 'SKS_National_Bank')
BEGIN
	DROP DATABASE SKS_National_Bank
END


CREATE DATABASE SKS_National_Bank
GO
USE SKS_National_Bank
GO

CREATE TABLE Address
(
	address_ID INT IDENTITY PRIMARY KEY,
	City_Name VARCHAR(60) NOT NULL,
	Province_Name VARCHAR(60) NOT NULL,
	Street_Number int NOT NULL,
	Street_Name VARCHAR(60) NOT NULL,
	Appt_Number VARCHAR(10)
);


CREATE TABLE Facilities
(
	Facility_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	Is_Branch BIT NOT NULL,
	--Can store 0 or 1 acts as BOOL
	Facility_Name VARCHAR(75) UNIQUE,
	FOREIGN KEY (Address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Customers
(
	Customer_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(100) NOT NULL,
	FOREIGN KEY (address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Bank_Employees
(
	Employee_ID INT IDENTITY PRIMARY KEY,
	Facility_ID INT NOT NULL,
	Employee_Address_ID INT NOT NULL,
	Role VARCHAR(150)NOT NULL,
	Manager_ID INT NOT NULL,
	Start_Date DATE NOT NULL,
	Employee_First_Name VARCHAR(70),
	Employee_Last_Name VARCHAR(70),
	FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Employee_Address_ID) REFERENCES Address(Address_ID) ON DELETE CASCADE
);

CREATE TABLE Account_Types
(
	Account_Type_ID INT IDENTITY PRIMARY KEY,
	Account_Type_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Accounts
(
	Account_ID INT IDENTITY PRIMARY KEY,
	Account_Type_ID INT NOT NULL,
	Facility_ID INT NOT NULL,
	Balance money NOT NULL,
	Data_Last_transaction DATE NOT NULL,
	Check_Number INT,
	Interest_rate DECIMAL(5,2),
	FOREIGN KEY (Account_Type_ID) REFERENCES Account_Types(Account_Type_ID) ON DELETE CASCADE,
	FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE CASCADE
);

CREATE TABLE Customers_Accounts
(
	Customer_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
	PRIMARY KEY (Customer_ID, Account_ID)
);

CREATE TABLE Employees_Accounts
(
	Employee_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Employee_ID) REFERENCES Bank_Employees(Employee_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
);

CREATE TABLE Transfers
(
	Transfer_ID INT IDENTITY PRIMARY KEY,
	Account_ID INT NOT NULL,
	Amount money NOT NULL,
	Transfer_Date DATE NOT NULL,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
);

-- Sample Data

INSERT INTO Address
	(City_Name, Province_Name, Street_Number, Street_Name, Appt_Number)
VALUES
	('New York', 'NY', 123, '5th Ave', '1A'),
	('Los Angeles', 'CA', 456, 'Sunset Blvd', '2B'),
	('Chicago', 'IL', 789, 'Michigan Ave', '3C'),
	('Houston', 'TX', 101, 'Main St', '4D'),
	('Phoenix', 'AZ', 202, 'Central Ave', '5E'),
	('Philadelphia', 'PA', 303, 'Market St', '6F'),
	('San Antonio', 'TX', 404, 'Broadway', '7G'),
	('San Diego', 'CA', 505, 'Ocean Blvd', '8H'),
	('Dallas', 'TX', 606, 'Elm St', '9I'),
	('San Jose', 'CA', 707, 'Santa Clara St', '10J'),
	('Austin', 'TX', 808, 'Congress Ave', '11K'),
	('Jacksonville', 'FL', 909, 'Bay St', '12L'),
	('Fort Worth', 'TX', 1010, 'Main St', '13M'),
	('Columbus', 'OH', 1111, 'High St', '14N'),
	('Charlotte', 'NC', 1212, 'Tryon St', '15O'),
	('San Francisco', 'CA', 1313, 'Market St', '16P'),
	('Indianapolis', 'IN', 1414, 'Meridian St', '17Q'),
	('Seattle', 'WA', 1515, 'Pine St', '18R'),
	('Denver', 'CO', 1616, 'Colfax Ave', '19S'),
	('Washington', 'DC', 1717, 'Pennsylvania Ave', '20T'),
	('Boston', 'MA', 1818, 'Boylston St', '21U'),
	('El Paso', 'TX', 1919, 'Mesa St', '22V'),
	('Nashville', 'TN', 2020, 'Broadway', '23W'),
	('Memphis', 'TN', 2323, 'Beale St', '26Z'),
	('Louisville', 'KY', 2424, 'Main St', '27A'),
	('Baltimore', 'MD', 2525, 'Pratt St', '28B'),
	('Milwaukee', 'WI', 2626, 'Water St', '29C'),
	('Albuquerque', 'NM', 2727, 'Central Ave', '30D'),
	('Tucson', 'AZ', 2828, 'Speedway Blvd', '31E'),
	('Fresno', 'CA', 2929, 'Fulton St', '32F'),
	('Sacramento', 'CA', 3030, 'Capitol Mall', '33G'),
	('Kansas City', 'MO', 3131, 'Main St', '34H'),
	('Mesa', 'AZ', 3232, 'Main St', '35I'),
	('Atlanta', 'GA', 3333, 'Peachtree St', '36J'),
	('Omaha', 'NE', 3434, 'Dodge St', '37K'),
	('Colorado Springs', 'CO', 3535, 'Tejon St', '38L'),
	('Raleigh', 'NC', 3636, 'Fayetteville St', '39M'),
	('Miami', 'FL', 3737, 'Biscayne Blvd', '40N'),
	('Virginia Beach', 'VA', 3838, 'Atlantic Ave', '41O'),
	('Oakland', 'CA', 3939, 'Broadway', '42P'),
	('Minneapolis', 'MN', 4040, 'Nicollet Ave', '43Q'),
	('Tulsa', 'OK', 4141, 'Peoria Ave', '44R'),
	('Arlington', 'TX', 4242, 'Abram St', '45S'),
	('New Orleans', 'LA', 4343, 'Canal St', '46T'),
	('Wichita', 'KS', 4444, 'Douglas Ave', '47U'),
	('Cleveland', 'OH', 4545, 'Euclid Ave', '48V'),
	('Detroit', 'MI', 2121, 'Woodward Ave', '24X'),
	('Oklahoma City', 'OK', 2222, 'Reno Ave', '25Y'),
	('Las Vegas', 'NV', 4646, 'Las Vegas Blvd', '49W'),
	('Portland', 'OR', 4747, 'Burnside St', '50X'),
	('Louisville', 'KY', 4848, 'Bardstown Rd', '51Y'),
	('Baltimore', 'MD', 4949, 'Charles St', '52Z'),
	('Milwaukee', 'WI', 5050, 'Wisconsin Ave', '53A'),
	('Albuquerque', 'NM', 5151, 'Lomas Blvd', '54B'),
	('Tucson', 'AZ', 5252, 'Speedway Blvd', '55C'),
	('Fresno', 'CA', 5353, 'Shaw Ave', '56D'),
	('Sacramento', 'CA', 5454, 'J St', '57E'),
	('Kansas City', 'MO', 5555, 'Main St', '58F'),
	('Mesa', 'AZ', 5656, 'Southern Ave', '59G'),
	('Atlanta', 'GA', 5757, 'Peachtree St', '60H'),
	('Omaha', 'NE', 5858, 'Dodge St', '61I'),
	('Colorado Springs', 'CO', 5959, 'Academy Blvd', '62J'),
	('Raleigh', 'NC', 6060, 'Capital Blvd', '63K'),
	('Miami', 'FL', 6161, 'Flagler St', '64L'),
	('Virginia Beach', 'VA', 6262, 'Virginia Beach Blvd', '65M'),
	('Oakland', 'CA', 6363, 'International Blvd', '66N'),
	('Minneapolis', 'MN', 6464, 'Hennepin Ave', '67O'),
	('Tulsa', 'OK', 6565, '21st St', '68P'),
	('Arlington', 'TX', 6666, 'Cooper St', '69Q'),
	('New Orleans', 'LA', 6767, 'Magazine St', '70R'),
	('Wichita', 'KS', 6868, 'Kellogg Ave', '71S'),
	('Cleveland', 'OH', 6969, 'Lorain Ave', '72T'),
	('Detroit', 'MI', 7070, 'Gratiot Ave', '73U'),
	('Oklahoma City', 'OK', 7171, 'Western Ave', '74V'),
	('Las Vegas', 'NV', 7272, 'Tropicana Ave', '75W'),
	('Portland', 'OR', 7373, 'Division St', '76X'),
	('Louisville', 'KY', 7474, 'Dixie Hwy', '77Y'),
	('Baltimore', 'MD', 7575, 'Eastern Ave', '78Z'),
	('Milwaukee', 'WI', 7676, 'Greenfield Ave', '79A'),
	('Albuquerque', 'NM', 7777, 'Menaul Blvd', '80B'),
	('Oakland', 'CA', 3939, 'Broadway', '42P'),
	('Minneapolis', 'MN', 4040, 'Nicollet Ave', '43Q'),
	('Tulsa', 'OK', 4141, 'Peoria Ave', '44R'),
	('Arlington', 'TX', 4242, 'Abram St', '45S'),
	('New Orleans', 'LA', 4343, 'Canal St', '46T'),
	('Wichita', 'KS', 4444, 'Douglas Ave', '47U'),
	('Cleveland', 'OH', 4545, 'Euclid Ave', '48V'),
	('Detroit', 'MI', 2121, 'Woodward Ave', '24X'),
	('Oklahoma City', 'OK', 2222, 'Reno Ave', '25Y');

INSERT INTO Facilities
	(Address_ID, Is_Branch, Facility_Name)
VALUES
	(1, 1, 'Branch 1'),
	(2, 0, 'Office 1'),
	(3, 1, 'Branch 2'),
	(4, 0, 'office 2'),
	(5, 1, 'Branch 3'),
	(6, 0, 'office 3'),
	(7, 1, 'Branch 4'),
	(8, 0, 'office 4'),
	(9, 1, 'Branch 5'),
	(10, 0, 'office 5');


INSERT INTO Customers
	(Address_ID, First_Name, Last_Name)
VALUES
	(11, 'John', 'Doe'),
	(12, 'Jane', 'Smith'),
	(13, 'Michael', 'Johnson'),
	(14, 'Emily', 'Davis'),
	(15, 'David', 'Brown'),
	(16, 'Sarah', 'Miller'),
	(17, 'James', 'Wilson'),
	(18, 'Jessica', 'Moore'),
	(19, 'Daniel', 'Taylor'),
	(20, 'Laura', 'Anderson'),
	(21, 'Robert', 'Thomas'),
	(22, 'Linda', 'Jackson'),
	(23, 'William', 'White'),
	(24, 'Barbara', 'Harris'),
	(25, 'Charles', 'Martin');

INSERT INTO Bank_Employees
	(Employee_Address_ID, Role, Manager_ID, Start_Date, Employee_First_Name, Employee_Last_Name, Facility_ID)
VALUES
	(26, 'Teller', 1, '2020-01-01', 'Alice', 'Johnson', 1),
	(27, 'Manager', 1, '2019-02-01', 'Bob', 'Smith', 1),
	(28, 'Loan Officer', 2, '2021-03-01', 'Charlie', 'Brown', 2),
	(29, 'Customer Service', 2, '2020-04-01', 'Diana', 'Prince', 2),
	(30, 'Security', 3, '2018-05-01', 'Evan', 'Peters', 3),
	(31, 'IT Support', 3, '2019-06-01', 'Fiona', 'Gallagher', 3),
	(32, 'Accountant', 4, '2020-07-01', 'George', 'Michael', 4),
	(33, 'HR', 4, '2021-08-01', 'Hannah', 'Montana', 4),
	(34, 'Branch Manager', 5, '2017-09-01', 'Ian', 'Curtis', 5),
	(35, 'Assistant Manager', 5, '2018-10-01', 'Jack', 'Sparrow', 5),
	(36, 'Teller', 6, '2019-11-01', 'Karen', 'Walker', 6),
	(37, 'Loan Officer', 6, '2020-12-01', 'Leo', 'DiCaprio', 8),
	(38, 'Customer Service', 7, '2021-01-01', 'Mia', 'Wallace', 9),
	(39, 'Security', 7, '2019-02-01', 'Nina', 'Simone', 1),
	(40, 'IT Support', 8, '2020-03-01', 'Oscar', 'Wilde', 8),
	(41, 'Teller', 1, '2021-04-01', 'Paul', 'Allen', 1),
	(42, 'Loan Officer', 1, '2021-05-01', 'Quincy', 'Adams', 1),
	(43, 'Customer Service', 2, '2021-06-01', 'Rachel', 'Green', 2),
	(44, 'Security', 2, '2021-07-01', 'Steve', 'Rogers', 2),
	(45, 'IT Support', 3, '2021-08-01', 'Tony', 'Stark', 3),
	(46, 'Accountant', 3, '2021-09-01', 'Uma', 'Thurman', 3),
	(47, 'HR', 4, '2021-10-01', 'Victor', 'Frankenstein', 4),
	(48, 'Branch Manager', 4, '2021-11-01', 'Wanda', 'Maximoff', 4),
	(49, 'Assistant Manager', 5, '2021-12-01', 'Xander', 'Cage', 5),
	(50, 'Teller', 5, '2022-01-01', 'Yara', 'Greyjoy', 5),
	(51, 'Loan Officer', 6, '2022-02-01', 'Zara', 'Larsson', 6),
	(52, 'Customer Service', 6, '2022-03-01', 'Aaron', 'Paul', 6),
	(53, 'Security', 7, '2022-04-01', 'Betty', 'White', 7),
	(54, 'IT Support', 7, '2022-05-01', 'Chris', 'Evans', 7),
	(55, 'Accountant', 8, '2022-06-01', 'Daisy', 'Ridley', 8),
	(56, 'HR', 8, '2022-07-01', 'Eddie', 'Redmayne', 8),
	(57, 'Branch Manager', 9, '2022-08-01', 'Felicity', 'Jones', 9),
	(58, 'Assistant Manager', 9, '2022-09-01', 'Gina', 'Rodriguez', 9),
	(59, 'Teller', 10, '2022-10-01', 'Henry', 'Cavill', 10),
	(60, 'Loan Officer', 10, '2022-11-01', 'Isla', 'Fisher', 10),
	(61, 'Customer Service', 10, '2022-12-01', 'Jack', 'Black', 10);



INSERT INTO Account_Types
	(Account_Type_Name)
VALUES
	('Checking'),
	('Savings'),
	('Loan');

INSERT INTO Accounts
	(Account_Type_ID, Facility_ID, Balance, Data_Last_transaction, Check_Number, Interest_rate)
VALUES
	(1, 1, 1000.00, '2023-01-01', 1001, 0.01),
	(1, 2, 1500.00, '2023-02-01', 1002, 0.01),
	(1, 3, 2000.00, '2023-03-01', 1003, 0.01),
	(1, 4, 2500.00, '2023-04-01', 1004, 0.01),
	(1, 5, 3000.00, '2023-05-01', 1005, 0.01),
	(2, 1, 5000.00, '2023-01-01', NULL, 0.02),
	(2, 2, 6000.00, '2023-02-01', NULL, 0.02),
	(2, 3, 7000.00, '2023-03-01', NULL, 0.02),
	(2, 4, 8000.00, '2023-04-01', NULL, 0.02),
	(2, 5, 9000.00, '2023-05-01', NULL, 0.02),
	(3, 1, 10000.00, '2023-01-01', NULL, 0.05),
	(3, 2, 15000.00, '2023-02-01', NULL, 0.05),
	(3, 3, 20000.00, '2023-03-01', NULL, 0.05),
	(3, 4, 25000.00, '2023-04-01', NULL, 0.05),
	(3, 5, 30000.00, '2023-05-01', NULL, 0.05);


	INSERT INTO Customers_Accounts
	(Customer_ID, Account_ID)
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 3),
	(5, 4),
	(6, 5),
	(7, 6),
	(8, 7),
	(9, 8),
	(10, 9),
	(11, 10),
	(12, 11),
	(13, 12),
	(14, 13),
	(15, 14),
	(16, 15),
	(17, 16),
	(18, 17),
	(19, 18),
	(20, 19),
	(21, 20),
	(22, 21),
	(23, 22),
	(24, 23),
	(25, 24),
	(1, 25),
	(2, 25),
	(3, 26),
	(4, 27),
	(5, 28),
	(6, 29),
	(7, 30);
