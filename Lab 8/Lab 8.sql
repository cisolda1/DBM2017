DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS ActorWork;
DROP TABLE IF EXISTS DirectorWork;
DROP TABLE IF EXISTS Movies;

CREATE TABLE People(
	pid char(4) not null,
	fname text not null,
	lname text not null,
	address text not null,
	spouseName text,
	PRIMARY KEY (pid)
);

CREATE TABLE Actors(
	actorID char(4) not null,
	pid char(4) not null references People(pid),
	birthdate date not null,
	haircolor text not null,
	eyecolor text not null,
	heightInches int not null,
	weight int not null,
	favColor text,
	SAGAnnDate date,
	PRIMARY KEY (actorID)
);

CREATE TABLE ActorWork(
	actorID char(4) not null references Actors(actorID),
	mpaaNum int not null references Movies(mpaaNum),
	PRIMARY KEY (actorID, mpaaNum)
);

CREATE TABLE Directors(
	directorID char(4) not null,
	pid char(4) not null references People(pid),
	filmSchool text,
	DGAnnDate date,
	favLensMaker text,
	PRIMARY KEY (directorID)
);

CREATE TABLE DirectorWork(
	directorID char(4) not null references Directors(directorID),
	mpaaNum int not null references Movies(mpaaNum),
	PRIMARY KEY(directorID, mpaaNum)
);

CREATE TABLE Movies(
	mpaaNum int not null,
	name text not null,
	yearReleased,
	domesticSales int,
	foreignSales int,
	dvdBluRaySales int,
	PRIMARY KEY(mpaaNum)
);

-- Insert statements

-- Insert Sean Connery and Test Cases
INSERT INTO People(pid, fname, lname, address, spouseName)
	VALUES(0001, 'Sean', 'Connery' '123 Hello Rd', 'Diane Broke'),
	VALUES(0002, 'Blake', 'Snake', '123 Hello Ave', 'Broke Diane'),
	VALUES(0003, 'Snake', 'Blake', '123 Hello St', 'Briane Doke'),
	VALUES(0004, 'Slake', 'Bake', '123 Hello Ct', 'Hi Diane');
		
INSERT INTO Actors(actorID, pid, birthdate, haircolor, eyecolor, heightInches, weight, favColor, SAGAnnDate)
	VALUES(0100, 0001, 4/7/1997, 'brown', 'hazel', 72, 165, 'blue', 4/8/1997),
	VALUES(0101, 0004, 4/20/1997, 'black', 'brown', 80, 150, 'green', 4/21/1997);
	
INSERT INTO Directors(directorID, pid, DGAnnDATE)
	VALUES(1000,0002, 4/9/1997),
	VALUES(1001,0003, 4/10/1997),
	VALUES(1002,0004, 4/11/1997);

INSERT INTO Movies(mpaaNum, name)
	VALUES(2000, 'Test1'),
	VALUES(2001, 'Test2'),
	VALUES(2002, 'Test3');
	