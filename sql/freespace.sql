--
-- This SQL script builds a Freespace database, deleting any pre-existing version.
--
-- For CS262 Team F (Freespace)
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS StatusReport;
DROP TABLE IF EXISTS CurrentPopulation;
DROP TABLE IF EXISTS Location;

-- List of locations shown in the app
CREATE TABLE Location (
    ID SERIAL PRIMARY KEY,
    name varchar(40),
    maxCapacity int,
    imageLocation varchar(50)
    );

-- List of current status reports made by users
CREATE TABLE StatusReport (
    ID SERIAL PRIMARY KEY,
    status int,
    locationID int references Location(ID),
    reportedTime TIMESTAMP
    );

-- List of actual card swipe number reports from dining halls
CREATE TABLE CurrentPopulation (
    ID SERIAL PRIMARY KEY,
    locationID int references Location(ID),
    estimatedPopulation int,
    reportedTime TIME,
    reportedDay varchar(10),
    cardSwipeNumber int
    );


-- Allow users to select data from the tables.
GRANT SELECT ON Location TO PUBLIC;
GRANT SELECT ON StatusReport TO PUBLIC;
GRANT SELECT ON CurrentPopulation TO PUBLIC;

-- Sample data to populate the tables
INSERT INTO Location (name, maxCapacity, imageLocation) VALUES
    ('Commons Dining Hall', 500, '../assets/locations/commons.jpg'),
    ('Knollcrest Dining Hall', 400, '../assets/locations/knollcrest.jpg'),
    ('Uppercrust', 100, '../assets/locations/uppercrust.jpg'),
    ('Johnny''s', 100, '../assets/locations/johnnys2.jpg'),
    ('Peet''s', 50, '../assets/locations/peets.jpg')
    ;


INSERT INTO StatusReport( status, locationID, reportedTime) VALUES
    (3,  1, '2020-10-16 13:30:00'),
    (2, 2, '2020-10-16 14:20:00'),
    (4, 3, '2020-10-16 15:10:00'),
    (5,  1, '2020-10-16 13:40:00')
    ;


INSERT INTO CurrentPopulation(locationID, estimatedPopulation, reportedTime, reportedDay, cardSwipeNumber) VALUES
    (1, 200, '13:30:00', 'Monday', 100),
    (1, 150, '13:45:00', 'Monday', 50),
    (2, 150,  '13:30:00', 'Monday', 60),
    (2, 160,  '13:45:00', 'Monday', 100),
    (3, 140,  '13:30:00', 'Monday', 80),
    (3, 200,'13:45:00', 'Monday', 120)
    ;
