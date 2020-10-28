-- List of locations shown in the app
CREATE TABLE Locations (
IdNumber int PRIMARY KEY,
LocationName varchar(40),
MaxCapacity int);

-- List of current status reports made by users
CREATE TABLE CurrentStatus (
IdNumber int PRIMARY KEY,
ActivityStatus varchar(15),
LocationID int references Locations(IdNumber),
ReportedTime TIMESTAMP);

-- List of actual card swipe number reports from dining halls
CREATE TABLE CurrentPopulation (
IdNumber int PRIMARY KEY,
LocationID int,
-- We will come up with an algorithm to calculate estimated number of people currently at the dining hall
EstimatedPopulation int,
ReportedTime TIME,
ReportedDay varchar(10),
CardSwipeNumber int);

-- List of users registered to system
CREATE TABLE Users (
UserId varchar(25) PRIMARY KEY,
UserPassword varchar(50),
UserType varchar(20));


-- Sample data to populate the tables
INSERT INTO Locations (IdNumber, LocationName, MaxCapacity)
VALUES
(1, 'Commons Dining Hall', 500),
(2, 'Knollcrest Dining Hall', 400),
(3, 'Uppercrust', 100);

INSERT INTO Users (
    UserId, UserPassword, UserType) 
VALUES 
('Id_1', 'Password_1', 'Dining Hall Faculty'),
('Id_2', 'Password_2', 'Dining Hall Faculty'),
('UserId_1', 'Password_3', 'Calvin User');


INSERT INTO CurrentStatus(
    IdNumber, ActivityStatus, LocationID, ReportedTime )
VALUES
    (1, 'Busy',  1, '2020-10-16 13:33:33'),
    (2, 'Normal', 2, '2020-10-16 14:22:22'),
    (3, 'Very Busy', 3, '2020-10-16 15:11:11'),
    (4, 'Busy',  1, '2020-10-16 13:40:33');


INSERT INTO CurrentPopulation(
    IdNumber, LocationId, EstimatedPopulation, ReportedTime, ReportedDay, CardSwipeNumber )
VALUES
    (1, 1, 200, '13:30:00', 'Monday', 100),
    (2, 1, 150, '13:45:00', 'Monday', 50),
    (3, 2, 150,  '13:30:00', 'Monday', 60),
    (4, 2, 160,  '13:45:00', 'Monday', 100),
    (5, 3, 140,  '13:30:00', 'Monday', 80),
    (6, 3, 200,'13:45:00', 'Monday', 120);





