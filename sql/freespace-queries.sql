--
-- This SQL script implements sample queries on the Freespace database.
--

-- Get the list of user reports
SELECT *
  FROM StatusReport
  ;

-- Get the list of Calvin locations registered in the system
SELECT *
  FROM Locations
  ;

-- Get the list of locations with capacity greater than 100
SELECT LocationName
  FROM Locations
  WHERE MaxCapacity > 100
  ;

-- Get the reports that have been submitted within the past two hours
SELECT *
  FROM StatusReport
  WHERE reportedTime >= NOW() - INTERVAL '2 hours'
  AND 
  ;

-- Join the StatusReport and Location tables and return a table specifying the average status for each location.
--  Ordered by the locations' ID numbers.
SELECT LocationID as key, LocationID, name, AVG(status) as statusAverage 
  FROM StatusReport, Location
  WHERE LocationID = Location.ID
  GROUP BY name, LocationID
  ORDER BY LocationID
;

-- Similar to the above query, but only takes the reports that have been submitted 
--  within the last two hours OR the reports that have been submitted on January 20, 2020
-- (we use this date for the initial zero-value records in the StatusReport table).
SELECT LocationID as key, LocationID, name, maxCapacity, AVG(status) as statusAverage 
  FROM
  (
    SELECT *
    FROM StatusReport
    WHERE reportedTime >= NOW() - INTERVAL '2 hours' 
    OR date(reportedTime) = '2020-1-20'
  ) AS FilterQuery, Location
  WHERE LocationID = Location.ID
  GROUP BY name, LocationID, maxCapacity
  ORDER BY LocationID
;