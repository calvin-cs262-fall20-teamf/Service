--
-- This SQL script implements sample queries on the Freespace database.
--

-- Get the list of user reports
SELECT *
  FROM CurrentStatus
  ;

-- Get the list of number of card swipes report
SELECT * 
  FROM CurrentPopulation
  ;

-- Get the list of Calvin locations registered in the system
SELECT *
  FROM Locations
 ;

 -- Get all the users registered to the app
SELECT *
  FROM Users
 ;

-- Get the list of locations with capacity greater than 300
SELECT LocationName
  FROM Locations
  WHERE MaxCapacity > 300
   ;

-- Get the cross-product of all the tables.
SELECT UserId
  FROM Users
  WHERE UserType = 'Dining Hall Faculty'
  ;