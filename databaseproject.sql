--------------------------------------------------
-- Database Management Spring 2017
-- EzPark Database Final Project
-- Developer: Christian Isolda
-- Date: 5/2/17
--------------------------------------------------

--------------------------------------------------
-- Drop Statements --
--------------------------------------------------

DROP FUNCTION IF EXISTS update_town();
DROP FUNCTION IF EXISTS update_parking_area();
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Slots;
DROP TABLE IF EXISTS ParkingArea;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS AreaType;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Bank;
DROP TABLE IF EXISTS Towns;

--------------------------------------------------
-- Create Statements --
--------------------------------------------------
CREATE TABLE Towns (
    townID char(6) not null,
    townName text not null,
    zipcode int not null,
primary key(townID)
);

CREATE TABLE Bank (
    bankID char(6) not null,
    bankName text not null,
    routingNumber int not null,
    accountNumber int not null,
primary key(bankID)
);

CREATE TABLE CreditCard (
    ccID char(6) not null,
    cardCompany text not null,
    nameOnCard text not null,
    ccNum varchar(16) not null,
    expirationDate varchar(5) not null,
    securityCode int not null,
primary key(ccID)
);

CREATE TABLE AreaType (
    areaID char(6) not null,
    capacity int not null,
    isGarage boolean not null,
    isLot boolean not null,
    isOutside boolean not null,
    isInside boolean not null,
primary key(areaID)
);

CREATE TABLE Payment (
    paymentID char(6) not null,
    ccID char(6) references CreditCard(ccID),
    bankID char(6) references Bank(bankID),
primary key(paymentID)
);

CREATE TABLE Users (
    userID char(6) not null,
    paymentID char(6) not null references Payment(paymentID),
    townID char(6) not null references Towns(townID),
    firstName text not null,
    lastName text not null,
    email text not null,
    phoneNumber varchar(10) not null,
    password varchar(25) not null,
primary key(userID)
);

CREATE TABLE ParkingArea (
    parkingID char(6) not null,
    townID char(6) not null references Towns(townID),
    areaID char(6) not null references AreaType(areaID),
primary key(parkingID)
);

CREATE TABLE Slots (
    slotID char(6) not null,
    parkingID char(6) not null references ParkingArea(parkingID),
    slotNum int not null,
    isHandicap BOOLEAN not null,
    floorNumber int not null,
    carCharger BOOLEAN not null,
    isAvailable BOOLEAN DEFAULT TRUE,
CONSTRAINT check_handicap CHECK ( isHandicap = 'True' OR isHandicap = 'False'),
primary key(slotID)
);

CREATE TABLE Transactions(
    transID char(6) not null,
    parkingID char(6) not null references ParkingArea(parkingID),
    slotID char(6) not null references Slots(slotID),
    userID char(6) not null references Users(userID),
    amount int not null,
    time_paid_for varchar(8) not null,
primary key(transID)
);

--------------------------------------------------
-- Stored Procedures/Trigger --
--------------------------------------------------
CREATE OR REPLACE FUNCTION update_slot_status()
RETURNS TRIGGER AS
$$
BEGIN
IF NEW.transID is NOT NULL THEN
UPDATE Slots
SET isAvailable = FALSE
WHERE NEW.slotID = Slots.slotID;
END IF;
RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


CREATE TRIGGER update_slot_status_trigger
BEFORE INSERT ON Transactions
FOR EACH ROW
EXECUTE PROCEDURE update_slot_status();


--------------------------------------------------
-- Reports/Interesting Queries --
--------------------------------------------------
SELECT SUM(amount) AS totAmount
FROM transactions
WHERE parkingID = 'PA001'


SELECT u.userID,
       SUM(amount) AS userTotal
FROM Users u INNER JOIN Transactions t
    ON u.userID = t.userID
GROUP BY u.userID
ORDER BY userTotal DESC;
  
  
SELECT COUNT(ccID) AS totalCC,
       COUNT(bankID) as totalBank
FROM Payment;



--------------------------------------------------
-- Views --
--------------------------------------------------
        
DROP VIEW IF EXISTS availableSlots;
CREATE VIEW availableSlots as (
SELECT pa.parkingID,
        slotID
    FROM parkingArea pa INNER JOIN Slots s
        ON pa.parkingID = s.parkingID
    WHERE s.isAvailable = TRUE
);

DROP VIEW IF EXISTS townParkingAreas;
CREATE VIEW townParkingAreas as (
SELECT t.townName,
        pa.parkingID
    FROM parkingArea pa INNER JOIN Towns t
        ON pa.townID = t.townID
);
    



--------------------------------------------------
-- Insert Statements --
--------------------------------------------------

-- Towns --
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0034', 'Scotch Plains', 07076);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0045', 'Westfield', 07090);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0002', 'Cranford', 07080);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0047', 'Summit', 07680);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0123', 'Fanwood', 07079);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0684', 'Livingston', 07987);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0007', 'Florham Park', 07060);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0347', 'Short Hills', 07690);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN1234', 'Millburn', 07567);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0235', 'Wayne', 07897);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0281', 'Randolph', 07967);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN1243', 'Vernon', 07643);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0225', 'Ridgewood', 07264);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0124', 'Ramsey', 07827);
    
INSERT INTO Towns(townID, townName, zipcode)
    VALUES('TN0212', 'Trenton', 07176);
    
-- Bank --
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk001', 'TDBANK', 189879876, 189876543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk002', 'CHASE', 189271276, 1898832543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk003', 'Bank of America', 199829576, 129871543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk004', 'Wells Fargo', 182859676, 129176543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk005', 'TDBANK', 189834576, 189123543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk006', 'Bank of America', 189958276, 189341253);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk007', 'Sovereign', 199119576, 123371543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk008', 'Hudson Central', 182259676, 129176543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk009', 'CITI', 219879876, 182276543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk010', 'TDBANK', 189651276, 1898982543);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk011', 'CHASE', 199479576, 129879143);
    
INSERT INTO Bank(bankID, bankName, routingNumber, accountNumber)
    VALUES('bk012', 'Wells Fargo', 182129676, 179176543);
    
-- CreditCard --
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc001', 'visa', 'Chris Sheil', '143234568765', '04/19', 467);

INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc002', 'master card', 'Davey Leong', '213254568765', '05/18', 962);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc003', 'discover', 'Felix Nodarse', '827234576465', '08/18', 726);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc004', 'visa', 'Jeff Lieblich', '147234124765', '02/20', 277);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc005', 'american express', 'James Bond', '007234527765', '07/17', 007);

INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc006', 'master card', 'Vallery Chosen', '873219568765', '04/21', 891);

INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc007', 'discover', 'Alan Labouseur', '219257668765', '09/18', 182);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc008', 'visa', 'Christian Mastroianni', '721729476495', '04/19', 407);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc009', 'american express', 'Christian Mastroianni', '897231224765', '01/20', 987);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc010', 'visa', 'Michael Santana', '987234177615', '10/18', 254);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc011', 'master card', 'Tony Stark', '987464227615', '11/18', 792);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc012', 'discover', 'Derek Jeter', '987234271645', '4/19', 299);
    
INSERT INTO CreditCard(ccID, cardCompany, nameOnCard, ccNum, expirationDate, securityCode)
    VALUES('cc013', 'visa', 'Addison Karambit', '887234187615', '3/18', 887);
    
-- AreaType --
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A001', 600, 'True', 'False', 'False', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A002', 900, 'False', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A003', 100, 'True', 'True', 'True', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A004', 300, 'True', 'False', 'True', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A005', 200, 'False', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A006', 700, 'True', 'False', 'False', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A007', 150, 'True', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A008', 350, 'False', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A009', 900, 'True', 'False', 'False', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A010', 200, 'False', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A011', 900, 'True', 'False', 'False', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A012', 1200, 'True', 'True', 'True', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A013', 700, 'True', 'False', 'False', 'True');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A014', 150, 'False', 'True', 'True', 'False');
    
INSERT INTO AreaType(areaID, capacity, isGarage, isLot, isOutside, isInside)
    VALUES('A015', 350, 'True', 'True', 'True', 'True');
    
-- Payment --
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P001', 'cc001', 'bk001');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P002', 'cc002', 'bk002');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P003', NULL , 'bk003');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P004', 'cc003', NULL);
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P005', 'cc004', 'bk005');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P006', NULL, 'bk006');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P007', 'cc005', NULL);
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P008', 'cc006', NULL);
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P009', 'cc007', 'bk007');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P010', 'cc008', 'bk008');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P011', 'cc009', NULL);
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P012', NULL, 'bk009');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P013', 'cc010', 'bk010');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P014', 'cc011', 'bk011');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P015', 'cc012', 'bk012');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P016', 'cc013', NULL);

-- Users --
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U001', 'P001', 'TN0034', 'Chris', 'Sheil', 'c.sheil@gmail.com', 9088121821, 'hello123');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U002', 'P002', 'TN0045', 'Davey', 'Leong', 'd.leong@gmail.com', 9088762918, 'medaveyleong');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U003', 'P003', 'TN0002', 'Ryan', 'Pilliego', 'r.pilliego@gmail.com', 9085746182, 'rbutchman');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U004', 'P004', 'TN0047', 'Felix', 'Nodarse', 'f.nodarse@gmail.com', 9088122121, 'memer123');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U005', 'P005', 'TN0123', 'Jeff', 'Lieblich', 'j.lieblich@gmail.com', 9081901920, 'hahmefedge');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U006', 'P006', 'TN0684', 'Darren', 'Jones', 'd.jones@gmail.com', 9088422918, 'idkdarren');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U007', 'P007', 'TN0007', 'James', 'Bond', '007@bond.com', 9081829823, 'shakeitnotstirred');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U008', 'P008', 'TN0347', 'Vallery', 'Chosen', 'v.chosen@gmail.com', 9088872121, 'frenchie123');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U009', 'P009', 'TN1234', 'Alan', 'Labouseur', 'bestprofessor@marist.edu', 9088131821, 'alpaca');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U010', 'P010', 'TN0235', 'Christian', 'Mastroianni', 'c.mastroianni@gmail.com', 9088762456, 'maiden123');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U011', 'P012', 'TN0281', 'Aria', 'Wester', 'a.wester@gmail.com', 9088122131, 'perf678');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U012', 'P013', 'TN1243', 'Michael', 'Santana', 'm.santana@gmail.com', 9088561821, 'imaqtpie');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U013', 'P014', 'TN0225', 'Tony', 'Stark', 't.stark@yahoo.com', 9081237189, 'ironmanstart');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U014', 'P015', 'TN0124', 'Derek', 'Jeter', 'd.jeter@yankees.com', 9088761456, 'goat123');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U015', 'P016', 'TN0212', 'Addison', 'Karambit', 'a.karambit@gmail.com', 9088572131, 'dopplerphase4');
    
    
-- Parking Area --
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA001','TN0034', 'A001');

INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA002','TN0045', 'A002');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA003','TN0002', 'A003');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA004','TN0047', 'A004');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA005','TN0123', 'A005');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA006','TN0684', 'A006');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA007','TN0007', 'A007');

INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA008','TN0347', 'A008');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA009','TN1234', 'A009');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA010','TN0235', 'A010');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA011','TN0281', 'A011');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA012','TN1243', 'A012');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA013','TN0225', 'A013');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA014','TN0124', 'A014');
    
INSERT INTO ParkingArea(parkingID, townID, areaID)
    VALUES('PA015','TN0212', 'A015');
    
-- Slots --
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S021', 'PA001', 001, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S022', 'PA001', 002, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S023', 'PA001', 003, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S024', 'PA001', 004, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S025', 'PA001', 005, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S026', 'PA001', 006, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S027', 'PA001', 007, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S028', 'PA001', 008, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S029', 'PA001', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S020', 'PA001', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S031', 'PA001', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S032', 'PA001', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S033', 'PA001', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S231', 'PA002', 001, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S232', 'PA002', 002, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S233', 'PA002', 003, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S034', 'PA002', 004, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S035', 'PA002', 005, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S036', 'PA002', 006, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S037', 'PA002', 007, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S038', 'PA002', 008, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S039', 'PA002', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S030', 'PA002', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S041', 'PA002', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S042', 'PA002', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S043', 'PA002', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S050', 'PA003', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S051', 'PA003', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S052', 'PA003', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S053', 'PA003', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S054', 'PA003', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S060', 'PA004', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S061', 'PA004', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S062', 'PA004', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S063', 'PA004', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S064', 'PA004', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S070', 'PA005', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S071', 'PA005', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S072', 'PA005', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S073', 'PA005', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S074', 'PA005', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S080', 'PA006', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S081', 'PA006', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S082', 'PA006', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S083', 'PA006', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S084', 'PA006', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S090', 'PA007', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S091', 'PA007', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S092', 'PA007', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S093', 'PA007', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S094', 'PA007', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S100', 'PA008', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S101', 'PA008', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S102', 'PA008', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S103', 'PA008', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S104', 'PA008', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S105', 'PA009', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S106', 'PA009', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S107', 'PA009', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S108', 'PA009', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S109', 'PA009', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S110', 'PA010', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S111', 'PA010', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S112', 'PA010', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S113', 'PA010', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S114', 'PA010', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S115', 'PA011', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S116', 'PA011', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S117', 'PA011', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S118', 'PA011', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S119', 'PA011', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S120', 'PA012', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S121', 'PA012', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S122', 'PA012', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S123', 'PA012', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S124', 'PA012', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S125', 'PA013', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S126', 'PA013', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S127', 'PA013', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S128', 'PA013', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S129', 'PA013', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S130', 'PA014', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S131', 'PA014', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S132', 'PA014', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S133', 'PA014', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S134', 'PA014', 013, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S135', 'PA015', 009, 'False', 1, 'False');

INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S136', 'PA015', 010, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S137', 'PA015', 011, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S138', 'PA015', 012, 'False', 1, 'False');
    
INSERT INTO Slots(slotID, parkingID, slotNum, isHandicap, floorNumber, carCharger)
    VALUES('S139', 'PA015', 013, 'False', 1, 'False');