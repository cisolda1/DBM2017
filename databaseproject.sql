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

CREATE TABLE ParkingGarages (
    parkingID char(6) not null,
    townID char(6) not null references Towns(townID),
primary key(parkingID)
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