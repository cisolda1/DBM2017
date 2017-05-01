DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Bank;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Towns;
DROP TABLE IF EXISTS ParkingArea;
DROP TABLE IF EXISTS AreaType;
DROP TABLE IF EXISTS Slots;

--------------------------------------------------
-- Create Statements --
--------------------------------------------------

CREATE TABLE Users (
    userID char(6) not null,
    paymentID char(6) not null references Payment(paymentID),
    townID char(6) not null refrences Towns(townID),
    firstName text not null,
    lastName text not null,
    email text not null,
    phoneNumber varchar(10) not null,
    password varchar(25) not null,
primary key(userID)
);

CREATE TABLE Payment (
    paymentID char(6) not null,
    ccID char(6) references CreditCard(ccID),
    bankID char(6) references Bank(bankID),
primary key(paymentID)
);

CREATE TABLE Bank (
    bankID char(6) not null,
    bankName text not null,
    routingNumber int not null,
    accountingNumber int not null,
primary key(bankID)
);

CREATE TABLE CreditCard (
    ccID char(6) not null,
    cardCompany text not null,
    nameOnCard text not null,
    ccNum int not null,
    expirationDate varchar(5) not null,
    securityCode int(3) not null,
CONSTRAINT check_company CHECK ( cardCompany = 'visa' OR cardCompany = 'mastercard' OR cardCompany = 'american express' OR cardCompany = 'discover' ),
primary key(ccID)
)

CREATE TABLE Towns (
    townID char(6) not null,
    parkingID char(6) not null references ParkingGarages(parkingID),
    townName text not null,
    zipcode int not null,
primary key(townID)
)

CREATE TABLE ParkingArea (
    parkingID char(6) not null,
    townID char(6) not null references Towns(townID),
primary key(parkingID)
)

CREATE TABLE AreaType (
    areaID char(6) not null,
    capacity int not null,
    isGarage boolean not null,
    isLot boolean not null,
    isOutside boolean not null,
    isInside boolean not null,
primary key(areaID)
)

CREATE TABLE Slots (
    slotID char(6) not null,
    parkingID char(6) not null references ParkingGarages(parkingID),
    slotNum int not null,
    isHandicap BOOLEAN not null,
    floorNumber int not null,
    carCharger BOOLEAN not null,
CONSTRAINT check_handicap CHECK ( isHandicap = 'true' OR isHandicap = 'false'),
primary key(slotID)
)

--------------------------------------------------
-- Insert Statements --
--------------------------------------------------

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
    VALUES('U009', 'P009', 'TN1234', 'Faker', 'Senpai', 'f.senpai@gmail.com', 9088131821, 'sktt1');
    
INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U010', 'P010', 'TN0235', 'Christian', 'Mastroianni', 'c.mastroianni@gmail.com', 9088762456, 'maiden123');

INSERT INTO Users(userID, paymentID, townID, firstName, lastName, email, phoneNumber, password)
    VALUES('U010', 'P011', 'TN0235', 'Christian', 'Mastroianni', 'c.mastroianni@gmail.com', 9088762456, 'maiden123');

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
    
-- Payment --
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P001', 'cc001', 'bk001');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P002', 'cc002', 'bk002');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P003', '', 'bk003');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P004', 'cc003', '');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P005', 'cc004', 'bk005');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P006', '', 'bk006');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P007', 'cc005', '');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P008', 'cc006', '');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P009', 'cc007', 'bk007');

INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P010', 'cc08', 'bk008');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P011', 'cc009', '');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P012', '', 'bk009');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P013', 'cc010', 'bk010');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P014', 'cc011', 'bk011');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P015', 'cc012', 'bk012');
    
INSERT INTO Payment(paymentID, ccID, bankID)
    VALUES('P016', 'cc013', '');
    
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
    VALUES()