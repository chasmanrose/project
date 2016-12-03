SPOOL project.out
SET ECHO ON
/******************************************************************************************
* CIS 353 - Database Design Project
* Authors: Mark Jannenga, 
*	   Chasman Rose, 
*	   Amanda Malaric, 
*	   Devon Ozogo, 
*	   Eric Zienstra
********************************************************************************************

--Orders Table details order information 
----------------------------------------------------------------------------------------------------
CREATE TABLE Orders(
	OrderID String, -- Made this change to avoid aggregation issues; PK
	PayMethod String,
	ShippingAddress String,
	cID String, -- foreign key to Customers Table

	ActualShipDate datetime,
	ExpectedShipDate datetime,
	ReceivedDate datetime,

	Pickup Boolean,
	
	Discount Float,
	PRIMARY KEY(OrderID)
	
	-- Every Order must have a customer
	CONSTRAINT ORD_IC1 FOREIGN KEY, (cID),
	CONSTRAINT ORD_IC2 CHECK (ExpectedShipDate => ReceivedDate),
	CONSTRAINT ORD_IC3 CHECK (ActualShipDate +. ReceivedDate),
	CONSTRAINT ORD_IC4 CHECK (PayMethod IN 'credit', 'check', 'NEFT', 'IMPS', 'RTGS');
	CONSTRAINT ORD_IC5 CHECK (Discount <= 1 AND Discount >= 0)
);
---------------------------------------------------------------------------------------------------------------
CREATE TABLE Customers(
	Class String,
	cName String,
	cID String,
	cLocation String, 
	PRIMARY KEY(cID)

	Cust_IC1 CHECK (class IN 'individual', 'company', 'wholesale'),
);
----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Location(
	LocationID String,
	LocationName String,
	Address String,
	City String,

	ZipCode Integer,
	Latitude Integer, -- Wanted to add these just for functionality, map building!
	Longitude Integer,
	PRIMARY KEY(LocationID)
);
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Line(
	LineNumber String,
	OrderID String,	
	OrderID String, -- FK -> Order
	EmployeeID String, -- FK -> Employee 

	LinePrice Integer, -- MV?
	QuantityRequested Integer,
	QuantitySelected Integer,
	PRIMARY KEY(OrderID, LineNumber)
	
	LN_IC1 CHECK (QuantityRequested > 0),
	LN_IC2 CHECK (QuantitySelected >= 0),
	LN_IC3 CHECK (LinePrice >= 0),
);

--------------------------------------------------------------------------------------------------------------------
CREATE TABLE Part(
	PartID String,
	VendorID String,
	
	QuantityAvailable Integer,
	PartPrice Float,
	PRIMARY KEY(PartID)
);
--------------------------------------------------------------------------------------------------------------------
CREATE TABLE CompatibleCar(
	PartID String,
	Make String,
	Model String,
	FromYear Integer,
	ToYear Integer

	PartPrice Float,
	PRIMARY KEY(PartID)
);
------------------------------------------------------------------------------------------------------------------
CREATE TABLE Bin(
	BinID String,
	LocationID String,
	
	QuantityInStock Integer,
	PRIMARY KEY(BinID)
);
-------------------------------------------------------------------------------------------------------------
CREATE TABLE Vendors(
	vID String,
	vName String,
	vAddress String,
	vCity String,
	vState String,
	vZip Integer,
	--vPhone Integer,
	PRIMARY KEY(vID)
);
--------------------------------------------------------------------------------------------------------------
SET FEEDBACK OFF
INSERT INTO Vendors VALUES ('V01', 'Paulstra CRC', '6500 Divison St E,' 'Grand Rapids', 'MI', 49504);
INSERT INTO Vendors VALUES('V02', 'Thireka', '520 Plainfield Ave NE,' 'Grand Rapids', 'MI', 49504);
INSERT INTO Vendors VALUES('V03', 'Plasan Carbons', '9000 3 Mile Ave NW,' 'Grand Rapids', 'MI', 49504);
INSERT INTO Vendors VALUES('V04' 'Denco Distributing Inc.', '1300 Euclid Ctd. SE,' 'Grand Rapids', 'MI', 49504);
INSERT INTO Vendors VALUES('V05', 'Berco Inc', '2936 S Wilson Ct', 'Grand Rapids', 'MI', 49534)

INSERT INTO Parts VALUES('Windshield Wipers', 'Toyota', 'Tocoma', 1991, 2000)


SET FEEDBACK ON
COMMIT;
COMMIT;
SPOOL OFF
