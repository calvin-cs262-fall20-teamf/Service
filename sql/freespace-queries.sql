--
-- This SQL script implements sample queries on the Freespace database.
--

-- Get the list of user reports
SELECT *
  FROM StatusReport
  ;

-- Get the list of number of card swipes report
SELECT * 
  FROM CurrentPopulation
  ;

-- Get the list of Calvin locations registered in the system
SELECT *
  FROM Location
 ;


-- Get the list of locations with capacity greater than 300
SELECT name
  FROM Location
  WHERE MaxCapacity > 300
   ;
