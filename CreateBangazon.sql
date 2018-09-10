DELETE FROM TRAINING_REGISTRATION;
DELETE FROM COMPUTER_ASSIGNMENT;
DELETE FROM EMPLOYEE;
DELETE FROM TRAINING;
DELETE FROM DEPARTMENT;
DELETE FROM COMPUTER;
DELETE FROM ORDER_ITEM;
DELETE FROM [ORDER];
DELETE FROM PAYMENT;
DELETE FROM PRODUCT;
DELETE FROM CUSTOMER;
DELETE FROM PRODUCT_TYPE;

DROP TABLE TRAINING_REGISTRATION;
DROP TABLE COMPUTER_ASSIGNMENT;
DROP TABLE EMPLOYEE;
DROP TABLE TRAINING;
DROP TABLE DEPARTMENT;
DROP TABLE COMPUTER;
DROP TABLE ORDER_ITEM;
DROP TABLE [ORDER];
DROP TABLE PAYMENT;
DROP TABLE PRODUCT;
DROP TABLE CUSTOMER;
DROP TABLE PRODUCT_TYPE;


CREATE TABLE `PRODUCT_TYPE` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) 
);
CREATE TABLE `CUSTOMER` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`LastName` VARCHAR(30) NOT NULL,
	`FirstName` VARCHAR(30) NOT NULL,
	`Email` Varchar(50) NOT NULL UNIQUE,
	`Active` Boolean NOT NULL,
	`DateCreated` date NOT NULL
);
CREATE TABLE `PRODUCT` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` Varchar(30) NOT NULL,
	`ProductTypeId` INTEGER NOT NULL ,
	`Description` Varchar(100),
	`CustomerId` INTEGER NOT NULL,
	`Price` Numeric NOT NULL,
	`Quantity` Integer NOT NULL,
	FOREIGN KEY(`ProductTypeId`) REFERENCES `PRODUCT_TYPE`(`Id`),
	FOREIGN KEY(`CustomerId`) REFERENCES `CUSTOMER`(`Id`)
);
CREATE TABLE `PAYMENT` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`AccountNumber` INTEGER NOT NULL,
	`PaymentType` varchar(20) NOT NULL,
	`CustomerId` INTEGER NOT NULL,
	FOREIGN KEY(`CustomerId`) REFERENCES `CUSTOMER`(`Id`)
);
CREATE TABLE `ORDER` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Date` Date Not Null,
	`CustomerId` Integer NOT NULL,
	`PaymentId` INTEGER NOT NULL,
	FOREIGN KEY(`CustomerId`) REFERENCES `CUSTOMER`(`Id`),
	FOREIGN KEY(`PaymentId`) REFERENCES `PAYMENT`(`Id`)
);

CREATE TABLE `ORDER_ITEM` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`OrderId` INTEGER NOT NULL,
	`ProductId` INTEGER NOT NULL,
	FOREIGN KEY(`OrderId`) REFERENCES `ORDER`(`Id`),
	FOREIGN KEY(`ProductId`) REFERENCES `PRODUCT`(`Id`)
);

CREATE TABLE `COMPUTER` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`DatePurchased` Date NOT NULL,
	`DateDecomissioned` DATE,
	`ComputerStatus` Varchar(20)
);


CREATE TABLE `DEPARTMENT` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`DepartmentName` Varchar(30) NOT NULL,
	`Budget` Numeric Default 0.00
);
CREATE TABLE `TRAINING` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` Varchar(30) NOT NULL,
	`StartDate` DateTime NOT NULL,
	`Location` Varchar(30),
	`MaxAttendees` Integer
);
CREATE TABLE `EMPLOYEE` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`LastName` Varchar(30) NOT NULL,
	`FirstName` Varchar(30) NOT NULL,
	`IsSupervisor` Boolean NOT NULL DEFAULT False,
	`DepartmentId` Integer NOT NULL,
	FOREIGN KEY(`DepartmentId`) REFERENCES `DEPARTMENT`(`Id`)
);
CREATE TABLE `COMPUTER_ASSIGNMENT` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`EmployeeId` INTEGER NOT NULL,
	`ComputerId` INTEGER NOT NULL,
	`DateAssigned` DATETIME NOT NULL,
	`DateReturned` DATETIME,
	FOREIGN KEY(`EmployeeId`) REFERENCES `EMPLOYEE`(`Id`),
	FOREIGN KEY(`ComputerId`) REFERENCES `COMPUTER`(`Id`)
);

CREATE TABLE `TRAINING_REGISTRATION` (
	`Id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`EmployeeId` INTEGER NOT NULL,
	`TrainingId` INTEGER NOT NULL,
	FOREIGN KEY(`EmployeeId`) REFERENCES `EMPLOYEE`(`Id`),
	FOREIGN KEY(`TrainingId`) REFERENCES `TRAINING`(`Id`)
);

INSERT INTO PRODUCT_TYPE (Name, Description) VALUES 
("Ball", "These are things that bounce")
,("Yo-Yo", "Spinning Things Tied to Strings")
,("Shoes", "Things You Wear on your feel")
,("Bikes", "Pedal Vehicle with 2 Wheels")
,("Guns", "Deadly but fun to shoot");

INSERT INTO CUSTOMER (LastName, FirstName, Email, Active, DateCreated) VALUES 
("Smith", "Tom", "tom@gmail.com", 0, "2017-01-01")
,("Johnson", "Jill", "jill@gmail.com", 1, "2018-01-01")
,("Williams", "Bill", "bill@gmail.com", 1, "2018-01-02")
,("Erickson", "Sue", "sue@gmail.com", 1, "2018-01-03")
,("Haluska", "Emily", "emily@gmail.com", 1, "2018-01-04");

INSERT INTO PRODUCT (Name, ProductTypeId, Description, CustomerId, Price, Quantity) VALUES 
("Football", (SELECT Id FROM PRODUCT_TYPE WHERE NAME="Ball"), "Sick Football", (SELECT Id FROM CUSTOMER WHERE Email="tom@gmail.com"), 47.5, 7)
,("RazorYo", (SELECT Id FROM PRODUCT_TYPE WHERE NAME="Yo-Yo"), "Sweet Yo Yo", (SELECT Id FROM CUSTOMER WHERE Email="jill@gmail.com"), 44.98, 6)
,("AirJordans", (SELECT Id FROM PRODUCT_TYPE WHERE NAME="Shoes"), "Really nice shoes", (SELECT Id FROM CUSTOMER WHERE Email="bill@gmail.com"), 5000.48, 5)
,("Huffy", (SELECT Id FROM PRODUCT_TYPE WHERE NAME="Bikes"), "Great bike bro", (SELECT Id FROM CUSTOMER WHERE Email="sue@gmail.com"), 746.12, 4)
,("Colt 45", (SELECT Id FROM PRODUCT_TYPE WHERE NAME="Guns"), "Deadly Weapon", (SELECT Id FROM CUSTOMER WHERE Email="emily@gmail.com"), 1222.56, 3);

INSERT INTO PAYMENT (AccountNumber, PaymentType, CustomerId) VALUES 
(461898165, "Visa", (SELECT Id FROM CUSTOMER WHERE Email="tom@gmail.com"))
,(498354815, "MasterCard", (SELECT Id FROM CUSTOMER WHERE Email="jill@gmail.com"))
,(645987456, "Visa", (SELECT Id FROM CUSTOMER WHERE Email="bill@gmail.com"))
,(623145284, "AmericanExpress", (SELECT Id FROM CUSTOMER WHERE Email="sue@gmail.com"))
,(561862348, "Visa", (SELECT Id FROM CUSTOMER WHERE Email="emily@gmail.com"));

INSERT INTO 'ORDER' (Date, CustomerId, PaymentId) VALUES 
("2018-01-01", (SELECT Id FROM CUSTOMER WHERE EMAIL="tom@gmail.com"), (SELECT Id FROM PAYMENT WHERE AccountNumber=461898165))
,("2018-01-02", (SELECT Id FROM CUSTOMER WHERE EMAIL="jill@gmail.com"), (SELECT Id FROM PAYMENT WHERE AccountNumber=498354815))
,("2018-01-03", (SELECT Id FROM CUSTOMER WHERE EMAIL="bill@gmail.com"), (SELECT Id FROM PAYMENT WHERE AccountNumber=645987456))
,("2018-01-04", (SELECT Id FROM CUSTOMER WHERE EMAIL="sue@gmail.com"), (SELECT Id FROM PAYMENT WHERE AccountNumber=623145284))
,("2018-01-05", (SELECT Id FROM CUSTOMER WHERE EMAIL="emily@gmail.com"), (SELECT Id FROM PAYMENT WHERE AccountNumber=561862348));

INSERT INTO ORDER_ITEM (OrderId, ProductId) VALUES 
(1, 1)
,(2, 2)
,(3, 3)
,(4, 4)
,(5, 5);

INSERT INTO COMPUTER (DatePurchased, DateDecomissioned, ComputerStatus) VALUES 
("2018-01-01", "2018-01-01", "Broken")
,("2018-01-02", "2018-01-02", "Working")
,("2018-01-03", "2018-01-03", "Broken")
,("2018-01-04", "2018-01-04", "Working")
,("2018-01-05", "2018-01-05", "Broken");

INSERT INTO DEPARTMENT (DepartmentName, Budget) VALUES 
("Finance", "4000")
,("Maintenance", "5000")
,("HR", "6000")
,("Accounting", "7000")
,("Marketing", "80000");

INSERT INTO TRAINING (Name, StartDate, Location , MaxAttendees) VALUES 
("Safety", "2018-05-05", "Cafeteria", "10")
,("Anti-Terrorism", "2018-05-06", "Cafeteria", "10")
,("Write Better Code", "2018-05-07", "Conference Room", "12")
,("Spelling Training", "2018-05-08", "Conference Room", "12")
,("Physical Training", "2018-05-09", "Conference Room", "12");

INSERT INTO EMPLOYEE (LastName, FirstName, IsSupervisor, DepartmentId) VALUES 
("Smith", "Tom", 1, 1)
,("Johnson", "Sarah", 1, 2)
,("Williams", "Bill", 1, 3)
,("Erickson", "Sue", 1, 4)
,("Haluska", "Emily", 1, 5);

INSERT INTO COMPUTER_ASSIGNMENT (EmployeeId, ComputerId, DateAssigned, DateReturned) VALUES 
("1", "5", "2018-06-06", null)
,("2", "4", "2018-06-07", null)
,("3", "3", "2018-06-08", null)
,("4", "2", "2018-06-09", null)
,("5", "1", "2018-06-10", null);

INSERT INTO TRAINING_REGISTRATION (EmployeeId, TrainingId) VALUES 
(1, 2)
,(2, 3)
,(3, 1)
,(4, 5)
,(5, 4);
