--
-- This SQL script builds a Freespace database, deleting any pre-existing version.
--
-- For CS262 Team F (Freespace)
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS StatusReport;
DROP TABLE IF EXISTS Location;

-- List of locations shown in the app
CREATE TABLE Location (
    ID SERIAL PRIMARY KEY,
    name varchar(40),
    maxCapacity int
    );

-- List of current status reports made by users
CREATE TABLE StatusReport (
    ID SERIAL PRIMARY KEY,
    status int,
    locationID int references Location(ID),
    reportedTime TIMESTAMP
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Location TO PUBLIC;
GRANT SELECT ON StatusReport TO PUBLIC;

-- Data to set up locations
INSERT INTO Location (name, maxCapacity) VALUES
    ('Commons Dining Hall', 141),
    ('Knollcrest Dining Hall', 120),
    ('Uppercrust', 47),
    ('Johnny''s', 25),
    ('Peet''s', 15)
    ;

-- Data to set up reports (used in client to render locations)
--  We use January 20, 2020 as the date in order to query the base
--  zero-value records from the database (used for averaging purposes).
INSERT INTO StatusReport( status, locationID, reportedTime) VALUES
    (0, 1, '2020-1-20 20:20:20'),
    (0, 2, '2020-1-20 20:20:20'),
    (0, 3, '2020-1-20 20:20:20'),
    (0, 4, '2020-1-20 20:20:20'),
    (0, 5, '2020-1-20 20:20:20')
    ;
