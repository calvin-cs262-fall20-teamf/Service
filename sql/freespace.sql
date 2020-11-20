--
-- This SQL script builds a Freespace database, deleting any pre-existing version.
--
-- For CS262 Team F (Freespace)
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS CurrentStatus;
DROP TABLE IF EXISTS CurrentPopulation;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Users;

-- List of locations shown in the app
CREATE TABLE Locations (
    IdNumber SERIAL PRIMARY KEY,
    LocationName varchar(40),
    MaxCapacity int,
    imageLocation varchar(50)
    );

-- List of current status reports made by users
CREATE TABLE CurrentStatus (
    IdNumber SERIAL PRIMARY KEY,
    ActivityStatus varchar(15),
    LocationID int references Locations(IdNumber),
    ReportedTime TIMESTAMP
    );

-- List of actual card swipe number reports from dining halls
CREATE TABLE CurrentPopulation (
    IdNumber SERIAL PRIMARY KEY,
    LocationID int references Locations(IdNumber),
    -- We will come up with an algorithm to calculate estimated number of people currently at the dining hall
    EstimatedPopulation int,
    ReportedTime TIME,
    ReportedDay varchar(10),
    CardSwipeNumber int
    );

-- List of users registered to system
CREATE TABLE Users (
    UserId varchar(25) PRIMARY KEY,
    UserPassword varchar(50),
    UserType varchar(20)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Locations TO PUBLIC;
GRANT SELECT ON CurrentStatus TO PUBLIC;
GRANT SELECT ON CurrentPopulation TO PUBLIC;
GRANT SELECT ON Users TO PUBLIC;

-- Sample data to populate the tables
INSERT INTO Locations (LocationName, MaxCapacity, imageLocation) VALUES
    ('Commons Dining Hall', 500, '../assets/locations/commons.jpg'),
    ('Knollcrest Dining Hall', 400, '../assets/locations/knollcrest.jpg'),
    ('Uppercrust', 100, '../assets/locations/uppercrust.jpg'),
    ('Johnny''s', 100, '../assets/locations/johnnys2.jpg'),
    ('Peet''s', 50, '../assets/locations/peets.jpg')
    ;

INSERT INTO Users (UserId, UserPassword, UserType) VALUES 
    ('Id_1', 'Password_1', 'Dining Hall Faculty'),
    ('Id_2', 'Password_2', 'Dining Hall Faculty'),
    ('UserId_1', 'Password_3', 'Calvin User')
    ;


INSERT INTO CurrentStatus( ActivityStatus, LocationID, ReportedTime) VALUES
    ('Busy',  1, '2020-10-16 13:30:00'),
    ('Slightly Busy', 2, '2020-10-16 14:20:00'),
    ('Very Busy', 3, '2020-10-16 15:10:00'),
    ('Busy',  1, '2020-10-16 13:40:00')
    ;


INSERT INTO CurrentPopulation(LocationId, EstimatedPopulation, ReportedTime, ReportedDay, CardSwipeNumber)VALUES
    (1, 200, '13:30:00', 'Monday', 100),
    (1, 150, '13:45:00', 'Monday', 50),
    (2, 150,  '13:30:00', 'Monday', 60),
    (2, 160,  '13:45:00', 'Monday', 100),
    (3, 140,  '13:30:00', 'Monday', 80),
    (3, 200,'13:45:00', 'Monday', 120)
    ;
