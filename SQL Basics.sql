--Source: Google Datasets
--Chicago Crime
--Chicago Public Schools

--Showing all the data from the Chicago Public School Data
SELECT *
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`

-- Showing average safety score for safety score above 10
SELECT AVG(SAFETY_SCORE)
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
WHERE SAFETY_SCORE > 10

-- Showing safety score in descending order for each school
SELECT NAME_OF_SCHOOL, Elementary__Middle__or_High_School, SAFETY_SCORE
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
ORDER BY SAFETY_SCORE DESC

-- Unique Schools Name where School Name doesnt start with 'T'
SELECT DISTINCT NAME_OF_SCHOOL
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
WHERE NAME_OF_SCHOOL NOT LIKE 'T%'

-- Count the number of times the school name shows 
-- Alias it as of occurrence in the school public where the name of the school has 'Academy' in it
SELECT COUNT(NAME_OF_SCHOOL) AS number_of_occurrence
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
WHERE NAME_OF_SCHOOL LIKE '%Academy%'

-- Check the average school attendence for each type of school
-- Group by type of school and having an average student attendance higher than 0.1
-- then order in descending order
SELECT Elementary__Middle__or_High_School AS Type_of_School, AVG(AVERAGE_STUDENT_ATTENDANCE) AS Average_Student_Attendance
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
GROUP BY Type_of_School
HAVING Average_Student_Attendance > 0.1
ORDER BY Average_Student_Attendance DESC, Type_of_School

-- Viewing all columns for all saftey score between the average saftey score at 10% lower and maximum safety score is 25% lower
SELECT *
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`
WHERE SAFETY_SCORE BETWEEN (SELECT AVG(SAFETY_SCORE) * 0.9 FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`) AND (SELECT MAX(SAFETY_SCORE) * 0.75 FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS`)

-- Merge two tables with inner joins using their x and y co-ordinates
SELECT *
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS` CPS
INNER JOIN `Chicago.CHICAGO_CRIME_DATA` CCD
ON CPS.X_COORDINATE = CAST(CCD.X_COORDINATE AS INT64) AND CPS.Y_COORDINATE = CAST(CCD.Y_COORDINATE AS INT64)

-- Finding the unique school name in the merged table
SELECT DISTINCT CPS.NAME_OF_SCHOOL, CPS.Elementary__Middle__or_High_School, CPS.COMMUNITY_AREA_NUMBER
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS` CPS
INNER JOIN `Chicago.CHICAGO_CRIME_DATA` CCD
ON CPS.COMMUNITY_AREA_NUMBER = CAST(CCD.COMMUNITY_AREA_NUMBER AS INT64)

-- Finding the unique school names in a right join between both tables using the locations 
SELECT DISTINCT CPS.NAME_OF_SCHOOL, CCD.LOCATION, CPS.COMMUNITY_AREA_NUMBER
FROM `Chicago.CHICAGO_PUBLIC_SCHOOLS` CPS
RIGHT JOIN `Chicago.CHICAGO_CRIME_DATA` CCD
ON CPS.Location = CCD.LOCATION 
