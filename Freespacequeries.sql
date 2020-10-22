
/*
CREATE DATABASE Freespace
GO
 
USE Freespace
GO
 
--CREATE SCHEMA ActiveStudents
 
CREATE TABLE Locations (
IdNumber int IDENTITY(1,1) PRIMARY KEY,
LocationName varchar(40),
MaxCapacity int,
)
GO
 
 
CREATE TABLE  StatusReport(
IdNumber int IDENTITY(1,1),
ReportedDateTime DATETIME,
LocationID int references Locations(IdNumber),
-- UserId int,
CurrentStatus varchar(15) PRIMARY KEY
)
GO
 
-- Should we make separate tables for each dining hall?
CREATE TABLE PopulationReport (
IdNumber int IDENTITY (1,1),
LocationID int,
ReportedTime TIME,
-- use DAY(date) function
ReportedDay varchar(20),
PopulationReported int,
EstimatedPopulation int PRIMARY KEY,
)
GO
 
CREATE TABLE CalvinLocation (
IdNumber int IDENTITY(1,1) references Locations(IdNumber),
CurrentStatus varchar(15) references StatusReport(CurrentStatus),
EstimatedPopulation int references PopulationReport(EstimatedPopulation),
)
GO
 
CREATE TABLE Users (
IdNumber int IDENTITY (1,1) PRIMARY KEY,
UserType varchar(20),
UserId varchar(25),
UserPassword varchar(50)
)
GO


INSERT INTO Locations (LocationName, MaxCapacity)
VALUES
('Commons Dining Hall',
500),
('Knollcrest Dining Hall',
400),
('Uppercrust',
100)
GO

INSERT INTO Users (
	UserType, UserId, UserPassword) 
VALUES 
('Dining Hall Faculty', 'Id_1', 'Password_1'),
('Dining Hall Faculty', 'Id_2', 'Password_2'),
('Student', 'StudentId_1', 'Password_3')
GO 


INSERT INTO StatusReport(
	ReportedDateTime, LocationID, CurrentStatus)
VALUES
	('2020-10-16 13:33:33', 1, 'Busy'),
	('2020-10-16 14:22:22', 2, 'Normal'),
	('2020-10-16 15:11:11', 3, 'Very Busy')
GO


INSERT INTO PopulationReport(
	LocationId,ReportedTime, ReportedDay, PopulationReported, EstimatedPopulation)
VALUES
	(1, '13:33:33', 'Monday', 350, 350),
	(2, '14:22:22', 'Tuesday', 200, 200),
	(3, '15:11:11', 'Wednesday', 80, 80)
GO

INSERT INTO CalvinLocation(
	CurrentStatus, EstimatedPopulation)
Values 
	('Busy', 350),
	('Normal', 200),
	('Very Busy', 80)
GO
	
*/

SELECT * FROM Locations
SELECT * FROM StatusReport
SELECT * FROM PopulationReport
SELECT * FROM CalvinLocation
SELECT * FROM Users



