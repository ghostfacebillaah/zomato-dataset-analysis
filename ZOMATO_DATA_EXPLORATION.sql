-- Check Datatype of table
DESCRIBE ZomatoData1;

-- Check tables in all the databases
SELECT DISTINCT(TABLE_SCHEMA), TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS;

-- List all columns in all tables
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- Select all records from ZomatoData1
SELECT * FROM ZomatoData1;

-- Checking for duplicate RestaurantIDs
SELECT RestaurantID, COUNT(RestaurantID)
FROM ZomatoData1
GROUP BY RestaurantID
ORDER BY 2 DESC;

-- Checking data from ZOMATO_COUNTRY table
SELECT * FROM ZOMATO_COUNTRY;

-- Removing unwanted rows
DELETE FROM ZomatoData1
WHERE CountryCode IN (' Bar', ' Grill', ' Bakers & More', ' Chowringhee Lane', ' Grill & Bar', ' Chinese');

DELETE FROM ZomatoData1
WHERE RestaurantID = '18306543';

-- Country Code column
SELECT A.CountryCode, B.COUNTRY
FROM ZomatoData1 A 
JOIN ZOMATO_COUNTRY B ON A.CountryCode = B.COUNTRYCODE;

-- Add Country Name column
ALTER TABLE ZomatoData1 ADD COLUMN COUNTRY_NAME VARCHAR(50);

-- Update Country Name column
UPDATE ZomatoData1 A
JOIN ZOMATO_COUNTRY B ON A.CountryCode = B.COUNTRYCODE
SET A.COUNTRY_NAME = B.COUNTRY;

-- City column
SELECT DISTINCT City 
FROM ZomatoData1
WHERE City LIKE '%?%'; -- Identifying misspelled words

-- Replacing misspelled words
UPDATE ZomatoData1
SET City = REPLACE(City, '?', 'i')
WHERE City LIKE '%?%';

-- Counting total restaurants in each city of a particular country
SELECT COUNTRY_NAME, City, COUNT(City) AS TOTAL_REST
FROM ZomatoData1
GROUP BY COUNTRY_NAME, City
ORDER BY 1, 2, 3 DESC;

-- Locality column: Rolling count
SELECT City, Locality, COUNT(Locality) AS COUNT_LOCALITY,
SUM(COUNT(Locality)) OVER(PARTITION BY City ORDER BY City, Locality) AS ROLL_COUNT
FROM ZomatoData1
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY Locality, City
ORDER BY 1, 2, 3 DESC;

-- Drop columns Address and LocalityVerbose
ALTER TABLE ZomatoData1 DROP COLUMN Address;
ALTER TABLE ZomatoData1 DROP COLUMN LocalityVerbose;

-- Cuisines column: Counting null or empty entries
SELECT Cuisines, COUNT(Cuisines)
FROM ZomatoData1
WHERE Cuisines IS NULL OR Cuisines = ''
GROUP BY Cuisines
ORDER BY 2 DESC;

-- Count cuisines
SELECT Cuisines, COUNT(Cuisines)
FROM ZomatoData1
GROUP BY Cuisines
ORDER BY 2 DESC;

-- Currency column: Count occurrences
SELECT Currency, COUNT(Currency)
FROM ZomatoData1
GROUP BY Currency
ORDER BY 2 DESC;

-- Yes/No columns
SELECT DISTINCT Has_Table_booking FROM ZomatoData1;
SELECT DISTINCT Has_Online_delivery FROM ZomatoData1;
SELECT DISTINCT Is_delivering_now FROM ZomatoData1;
SELECT DISTINCT Switch_to_order_menu FROM ZomatoData1;

-- Drop column Switch_to_order_menu
ALTER TABLE ZomatoData1 DROP COLUMN Switch_to_order_menu;

-- Price Range column: Distinct values
SELECT DISTINCT Price_range FROM ZomatoData1;

-- Votes column: Checking min, max, and average of votes
SELECT MIN(CAST(Votes AS INT)) AS MIN_VT, AVG(CAST(Votes AS INT)) AS AVG_VT, MAX(CAST(Votes AS INT)) AS MAX_VT
FROM ZomatoData1;

-- Cost column: Min, avg, and max of average cost for two
SELECT Currency, MIN(CAST(Average_Cost_for_two AS INT)) AS MIN_CST,
AVG(CAST(Average_Cost_for_two AS INT)) AS AVG_CST,
MAX(CAST(Average_Cost_for_two AS INT)) AS MAX_CST
FROM ZomatoData1
GROUP BY Currency;

-- Rating column: Min, avg, and max ratings
SELECT MIN(Rating), ROUND(AVG(CAST(Rating AS DECIMAL)), 1) AS AVG_RATING, MAX(Rating)
FROM ZomatoData1;

SELECT CAST(Rating AS DECIMAL) AS NUM FROM ZomatoData1 WHERE CAST(Rating AS DECIMAL) >= 4;

-- Update Rating column type to DECIMAL
ALTER TABLE ZomatoData1 MODIFY COLUMN Rating DECIMAL;

-- Select ratings greater than or equal to 4
SELECT Rating FROM ZomatoData1 WHERE Rating >= 4;

-- Add Rate_Category column based on Rating
ALTER TABLE ZomatoData1 ADD COLUMN Rate_Category VARCHAR(20);

SELECT Rating,
CASE
    WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
    WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
    WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
    WHEN Rating >= 4.5 THEN 'EXCELLENT'
END AS Rate_Category
FROM ZomatoData1;

-- Update Rate_Category based on Rating
UPDATE ZomatoData1
SET Rate_Category = CASE
    WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
    WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
    WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
    WHEN Rating >= 4.5 THEN 'EXCELLENT'
END;
