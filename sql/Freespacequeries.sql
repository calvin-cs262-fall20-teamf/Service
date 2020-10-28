-- List of locations shown in the app
CREATE TABLE Locations (
IdNumber int SERIAL PRIMARY KEY,
LocationName varchar(40),
MaxCapacity int);


-- List of current status reports made by users
CREATE TABLE CurrentStatus (
ActivityStatus varchar(15) PRIMARY KEY,
LocationID int references Locations(IdNumber),
ReportedTime TIMESTAMP);


-- List of actual card swipe number reports from dining halls
CREATE TABLE CurrentPopulation (
-- We will come up with an algorithm to calculate estimated number of people currently at the dining hall
LocationID int,
EstimatedPopulation int,
ReportedTime TIME,
ReportedDay varchar(10),
CardSwipeNumber int);


CREATE TABLE Users (
UserId varchar(25),
UserPassword varchar(50),
UserType varchar(20),
PRIMARY KEY (UserID, UserType));

    
INSERT INTO Locations (LocationName, MaxCapacity)
VALUES
('Commons Dining Hall', 500),
('Knollcrest Dining Hall', 400),
('Uppercrust', 100);

INSERT INTO Users (
    UserId, UserPassword, UserType) 
VALUES 
('Id_1', 'Password_1', 'Dining Hall Faculty'),
('Id_2', 'Password_2', 'Dining Hall Faculty'),
('UserId_1', 'Password_3', 'User');


INSERT INTO CurrentStatus(
    Status, LocationID, ReportedTime )
VALUES
    ('Busy',  1, '2020-10-16 13:33:33'),
    ('Normal', 2, '2020-10-16 14:22:22'),
    ('Very Busy', 3, '2020-10-16 15:11:11');



INSERT INTO CurrentPopulation(
    EstimatedPopulation, LocationId, ReportedTime, ReportedDay, CardSwipeNumber )
VALUES
    (1, 200, '13:30:00', 'Monday', 100),
    (1, 150, '13:45:00', 'Monday', 50),
    (2, 150,  '13:30:00', 'Monday', 60),
    (2, 160,  '13:45:00', 'Monday', 100),
    (3, 140,  '13:30:00', 'Monday', 80),
    (3, 200,'13:45:00', 'Monday', 120);





