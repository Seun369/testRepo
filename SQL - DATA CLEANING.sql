-- Source: Kaggle
-- Data: Uncleaned Data
-- Software Used: Microsoft SQL Server
-- Link: https://www.kaggle.com/datasets/justin8452/cleaned-vs-uncleaned-datasets?select=uncleaned_computer_jobs_original.xlsx
-- Acknowledgement: Justin

----------------------------------------------------------------------------------------------------------------------
-- View all
SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]

----------------------------------------------------------------------------------------------------------------------
-- Group by Job Title
SELECT DISTINCT [Job Title], COUNT([Job Title])
FROM [Portfolio].[dbo].[data_scientist_jobs]
GROUP BY [Job Title]

----------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH CTE([Job Title], [Company Name], [Salary Estimate], [Job Description], DuplicateCount)
	AS (SELECT [Job Title], [Company Name], [Salary Estimate], [Job Description], 
		ROW_NUMBER() OVER(PARTITION BY [Job Title], [Salary Estimate], [Company Name], [Job Description]
		ORDER BY [Job Title]) AS DuplicateCount
	FROM [Portfolio].[dbo].[data_scientist_jobs])
DELETE FROM CTE
WHERE DuplicateCount > 1;

WITH CTE([Job Title], [Company Name], [Job Description], DuplicateCount)
	AS (SELECT [Job Title], [Company Name], [Job Description], 
		ROW_NUMBER() OVER(PARTITION BY [Job Title], [Company Name], [Job Description]
		ORDER BY [Job Title]) AS DuplicateCount
	FROM [Portfolio].[dbo].[data_scientist_jobs])
DELETE FROM CTE
WHERE DuplicateCount > 1;

----------------------------------------------------------------------------------------------------------------------
-- Create New Columns
SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]

ALTER TABLE [Portfolio].[dbo].[data_scientist_jobs]
DROP COLUMN [index], COLUMN [Competitors]

ALTER TABLE [Portfolio].[dbo].[data_scientist_jobs]
ADD [Minimum Salary Estimate] FLOAT, [Maximum Salary Estimate] FLOAT, [Source] FLOAT

----------------------------------------------------------------------------------------------------------------------
-- Replace and update 'Sr' and 'Sr.' to 'Senior' for all jobs

SELECT REPLACE([Job Title],'Sr', 'Senior') as senior_positions
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Sr%'

UPDATE [data_scientist_jobs]
SET [Job Title] = REPLACE([Job Title],'Sr', 'Senior')
WHERE [Job Title] LIKE '%Sr%'

SELECT REPLACE([Job Title],'Sr.', 'Senior') as senior_positions
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Sr.%'

UPDATE [data_scientist_jobs]
SET [Job Title] = REPLACE([Job Title],'Sr.', 'Senior')
WHERE [Job Title] LIKE '%Sr.%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Senior.%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Data Analyst'
WHERE [Job Title] LIKE '%Senior.%'
----------------------------------------------------------------------------------------------------------------------
-- Replace and update 'Jr' and 'Jr.' to 'Junior' for all jobs

SELECT REPLACE([Job Title],'Jr', 'Junior') as junior_positions
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Jr%'

UPDATE [data_scientist_jobs]
SET [Job Title] = REPLACE([Job Title],'Jr', 'Junior')
WHERE [Job Title] LIKE '%Jr%'

SELECT REPLACE([Job Title],'Jr.', 'Junior') as junior_positions
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Jr.%'

UPDATE [data_scientist_jobs]
SET [Job Title] = REPLACE([Job Title],'Jr.', 'Junior')
WHERE [Job Title] LIKE '%Jr.%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Junior.%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Junior Data Engineer'
WHERE [Job Title] LIKE '%Junior.%'

----------------------------------------------------------------------------------------------------------------------
--Filter for Data Scientist and update for Data Scientist

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data Scientist%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Junior%' AND [Job Title] NOT LIKE '%Principal%'
AND [Job Title] NOT LIKE '%Lead%' AND [Job Title] NOT LIKE '%Chief%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Scientist'
WHERE [Job Title] LIKE '%Data Scientist%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Junior%' AND [Job Title] NOT LIKE '%Principal%'
AND [Job Title] NOT LIKE '%Lead%' AND [Job Title] NOT LIKE '%Chief%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Environmental%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Scientist'
WHERE [Job Title] LIKE '%Environmental%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data Scientist%' AND [Job Title] LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Data Scientist'
WHERE [Job Title] LIKE '%Data Scientist%' AND [Job Title] LIKE '%Senior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Principal%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Principal Data Scientist'
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Principal%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Lead%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Lead Data Scientist'
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Lead%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Chief%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Chief Data Scientist'
WHERE [Job Title] LIKE '%Chief%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Machine Learning Engineers and update for Machine Learning Engineers

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE ([Job Title] LIKE '%ML%' OR [Job Title] LIKE '%Machine%' OR [Job Title] LIKE '%Learning%'
OR [Job Title] LIKE '%AI%') AND [Job Title] NOT LIKE '%Data%' AND [Job Title] NOT LIKE '%Principal%'
AND [Job Title] NOT LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Machine Learning Engineer'
WHERE ([Job Title] LIKE '%ML%' OR [Job Title] LIKE '%Machine%' OR [Job Title] LIKE '%Learning%'
OR [Job Title] LIKE '%AI%') AND [Job Title] NOT LIKE '%Data%' AND [Job Title] NOT LIKE '%Principal%'
AND [Job Title] NOT LIKE '%Senior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Data%'
AND [Job Title] NOT LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Machine Learning Engineer'
WHERE [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Data%'
AND [Job Title] NOT LIKE '%Senior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Data%'
AND [Job Title] LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Machine Learning Engineer'
WHERE [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Data%'
AND [Job Title] LIKE '%Senior%'
----------------------------------------------------------------------------------------------------------------------
-- Filter for Analyst and update for Data Analyst

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Analyst%' AND [Job Title] NOT LIKE '%Engineer%'
AND [Job Title] NOT LIKE '%Business%' AND [Job Title] NOT LIKE '%Senior%'


UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Analyst'
WHERE [Job Title] LIKE '%Analyst%' AND [Job Title] NOT LIKE '%Engineer%'
AND [Job Title] NOT LIKE '%Business%' AND [Job Title] NOT LIKE '%Senior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Health%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Data Analyst'
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Health%'
AND [Job Title] LIKE '%Analyst%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Finance%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Data Analyst'
WHERE [Job Title] LIKE '%Finance%'
----------------------------------------------------------------------------------------------------------------------
-- Filter for Business Intelligence Analyst and update for Business Intelligence Data Analyst

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Business%' AND [Job Title] LIKE '%Intelligence%'
AND [Job Title] NOT LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Business Intelligence Analyst'
WHERE [Job Title] LIKE '%Business%' AND [Job Title] LIKE '%Intelligence%'
AND [Job Title] NOT LIKE '%Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Analytics Manager and update for Analytics Manager

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Analytics%' AND [Job Title] LIKE '%Manager%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Analytics Manager'
WHERE [Job Title] LIKE '%Analytics%' AND [Job Title] LIKE '%Manager%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Business Assurance Analyst and update for Business Assurance Analyst

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Assurance%' 

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Business Assurance Analyst'
WHERE [Job Title] LIKE '%Assurance%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Business Analyst and update for Business Analyst

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Business Data Analyst%' AND [Job Title] NOT LIKE '%Junior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Business Analyst'
WHERE [Job Title] LIKE '%Business Data Analyst%' AND [Job Title] NOT LIKE '%Junior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Business Data Analyst%' AND [Job Title] LIKE '%Junior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Junior Business Analyst'
WHERE [Job Title] LIKE '%Business Data Analyst%' AND [Job Title] LIKE '%Junior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for 'Computer' and delete Computer Scientist as its not Data Science

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Computer%' OR [Job Title] LIKE '%Computational%'

DELETE
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Computer%' OR [Job Title] LIKE '%Computational%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Data & Software Engineers and update for Data & Software Engineers

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Engineer%' AND [Job Title] LIKE '%Data%'
AND [Job Title] NOT LIKE '%Software%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Junior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Engineer'
WHERE [Job Title] LIKE '%Engineer%' AND [Job Title] LIKE '%Data%'
AND [Job Title] NOT LIKE '%Software%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Junior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Engineer%'  AND [Job Title] LIKE '%Machine%'
AND [Job Title] NOT LIKE '%Senior%' AND [Job Title] LIKE '%Software%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Engineer'
WHERE [Job Title] LIKE '%Engineer%'  AND [Job Title] LIKE '%Machine%'
AND [Job Title] NOT LIKE '%Senior%' AND [Job Title] LIKE '%Software%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Engineer%'  AND [Job Title] LIKE '%Data%' 
AND [Job Title] LIKE '%Software%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Software Engineer'
WHERE [Job Title] LIKE '%Engineer%'  AND [Job Title] LIKE '%Data%' 
AND [Job Title] LIKE '%Software%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Data Modeler and update for Data Modeler

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Modeler%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Modeler'
WHERE [Job Title] LIKE '%Modeler%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Data Manager and update as Data Manager

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Manager%' AND [Job Title] LIKE '%Data%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Manager'
WHERE [Job Title] LIKE '%Manager%' AND [Job Title] LIKE '%Data%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Decision Scientist and delete Decision Scientist as its not Data Science

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Decision%'

DELETE
FROM [data_scientist_jobs]
WHERE [Job Title] LIKE '%Decision%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Business Intelligence Developer and update for Business Intelligence Developer

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Developer%' AND [Job Title] NOT LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Business Intelligence Developer'
WHERE [Job Title] LIKE '%Developer%' AND [Job Title] NOT LIKE '%Senior%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Developer%'  AND [Job Title] LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Business Intelligence Developer'
WHERE [Job Title] LIKE '%Developer%' AND [Job Title] LIKE '%Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Research Scientist and update for Research Scientist
SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Development%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Research Scientist'
WHERE [Job Title] LIKE '%Development%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Research%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Associate%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Research Scientist'
WHERE [Job Title] LIKE '%Research%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Associate%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Scientist%' AND [Job Title] NOT LIKE '%Data%'
AND [Job Title] NOT LIKE '%Machine%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Principal%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Research Scientist'
WHERE [Job Title] LIKE '%Scientist%' AND [Job Title] NOT LIKE '%Data%'
AND [Job Title] NOT LIKE '%Machine%' AND [Job Title] NOT LIKE '%Senior%'
AND [Job Title] NOT LIKE '%Principal%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Research%' AND [Job Title] LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Research Scientist'
WHERE [Job Title] LIKE '%Research%' AND [Job Title] LIKE '%Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Principal Machine Learning Engineer and update for Principal Machine Learning Engineer

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Scientist%'
AND [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Principal%' 

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Principal Machine Learning Engineer'
WHERE [Job Title] LIKE '%Scientist%'
AND [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Principal%'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Scientist%'
AND [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Principal Machine Learning Engineer'
WHERE [Job Title] LIKE '%Scientist%'
AND [Job Title] LIKE '%Machine%' AND [Job Title] LIKE '%Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Vice President of Data Science and update as Vice President of Data Science

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Vice President,%'--'%VP,%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Vice President of Data Science'
WHERE [Job Title] LIKE '%VP,%'
----------------------------------------------------------------------------------------------------------------------
-- Filter for Data Science Partner and update for Data Science Partner
SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Partner%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Data Science Partner'
WHERE [Job Title] LIKE '%Partner%'
----------------------------------------------------------------------------------------------------------------------
-- Filter for Senior Machine Learning Engineer and update for Senior Machine Learning Engineer

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Machine Learning Engineer%' AND [Job Title] LIKE '%, Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Machine Learning Engineer'
WHERE [Job Title] LIKE '%Machine Learning Engineer%' AND [Job Title] LIKE '%, Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Business Assurance Analyst and update as 'Business Assurance Analyst'

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Intelligence Data Analyst%' AND [Job Title] LIKE '%, Senior%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Intelligence Data Analyst'
WHERE [Job Title] LIKE '%Intelligence Data Analyst%' AND [Job Title] LIKE '%, Senior%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Associate Director of Data Science and update for Associate Director of Data Science

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Associate%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Associate Director of Data Science'
WHERE [Job Title] LIKE '%Data%' AND [Job Title] LIKE '%Associate%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Senior Research Scientist and update for Senior Research Scientist

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Senior Scientist%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Research Scientist'
WHERE [Job Title] LIKE '%Senior Scientist%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Senior Intelligence Analyst and update for Senior Intelligence Analyst

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Senior Intelligence Data%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Senior Intelligence Analyst'
WHERE [Job Title] LIKE '%Senior Intelligence Data%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Principal Data Scientist and update for Principal Data Scientist

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Principal Scientist/Associate%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Principal Data Scientist'
WHERE [Job Title] LIKE '%Principal Scientist/Associate%'

----------------------------------------------------------------------------------------------------------------------
-- Filter for Vice President of Data Management and update for Vice President of Data Management

SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Job Title] LIKE '%Vice President,%'

UPDATE [data_scientist_jobs]
SET [Job Title] = 'Vice President of Data Management'
WHERE [Job Title] LIKE '%Vice President,%'
----------------------------------------------------------------------------------------------------------------------
-- Cast Salary Information Columns to NVARCHAR from FLOAT

ALTER TABLE [data_scientist_jobs]
ALTER COLUMN [Minimum Salary Estimate] NVARCHAR(255)

ALTER TABLE [data_scientist_jobs]
ALTER COLUMN [Maximum Salary Estimate] NVARCHAR(255)

ALTER TABLE [data_scientist_jobs]
ALTER COLUMN [Source] NVARCHAR(255)
----------------------------------------------------------------------------------------------------------------------
-- Split Salary Information - Employer Source - 26 Char
SELECT [Salary Estimate], SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1) AS newSalaryRange,
SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1) AS minSalary,
SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate])) AS  maxSalary
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Employer%'

--Update Minimum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Minimum Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Employer%'

--Update Maximum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Maximum Salary Estimate] = SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate]))
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Employer%'

--Update Source
UPDATE [data_scientist_jobs]
SET [Source] = 'Employer'
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Employer%'

--Update Salary Estimates
UPDATE [data_scientist_jobs]
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Employer%'

----------------------------------------------------------------------------------------------------------------------
-- Split Salary Information - Glassdoor Source - 26 Char

SELECT [Salary Estimate], SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1) AS newSalaryRange,
SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1) AS minSalary,
SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate])) AS  maxSalary
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Minimum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Minimum Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Maximum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Maximum Salary Estimate] = SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate]))
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Source
UPDATE [data_scientist_jobs]
SET [Source] = 'Glassdoor'
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Salary Estimates
UPDATE [data_scientist_jobs]
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 26 AND [Salary Estimate] LIKE '%Glassdoor%'

----------------------------------------------------------------------------------------------------------------------
-- Split Salary Information - Glassdoor Source - 27 Char

SELECT [Salary Estimate], SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1) AS newSalaryRange,
SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1) AS minSalary,
SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate])+1) AS  maxSalary
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE LEN([Salary Estimate]) = 27 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Minimum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Minimum Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 27 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Maximum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Maximum Salary Estimate] = SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate])+1)
WHERE LEN([Salary Estimate]) = 27 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Source
UPDATE [data_scientist_jobs]
SET [Source] = 'Glassdoor'
WHERE LEN([Salary Estimate]) = 27 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Salary Estimates
UPDATE [data_scientist_jobs]
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 27 AND [Salary Estimate] LIKE '%Glassdoor%'

----------------------------------------------------------------------------------------------------------------------
-- Split Salary Information - Glassdoor Source - 28 Char

SELECT [Salary Estimate], SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1) AS newSalaryRange,
SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1) AS minSalary,
SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate])) AS  maxSalary
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE LEN([Salary Estimate]) = 28 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Minimum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Minimum Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('-', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 28 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Maximum Salary Estimate
UPDATE [data_scientist_jobs]
SET [Maximum Salary Estimate] = SUBSTRING([Salary Estimate], CHARINDEX('-', [Salary Estimate])+1,CHARINDEX('K', [Salary Estimate]))
WHERE LEN([Salary Estimate]) = 28 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Source
UPDATE [data_scientist_jobs]
SET [Source] = 'Glassdoor'
WHERE LEN([Salary Estimate]) = 28 AND [Salary Estimate] LIKE '%Glassdoor%'

--Update Salary Estimates
UPDATE [data_scientist_jobs]
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1,CHARINDEX('(', [Salary Estimate])-1)
WHERE LEN([Salary Estimate]) = 28 AND [Salary Estimate] LIKE '%Glassdoor%'

---------------------------------------------------------------------------
-- Change Salary figures back to float

SELECT REPLACE(REPLACE([Minimum Salary Estimate], '$', ''),  'K','000')
FROM [dbo].[data_scientist_jobs]

UPDATE [dbo].[data_scientist_jobs]
SET [Minimum Salary Estimate] = REPLACE(REPLACE([Minimum Salary Estimate], '$', ''),  'K','000')

SELECT REPLACE(REPLACE([Maximum Salary Estimate], '$', ''),  'K','000')
FROM [dbo].[data_scientist_jobs]

UPDATE [dbo].[data_scientist_jobs]
SET [Maximum Salary Estimate] = REPLACE(REPLACE([Maximum Salary Estimate], '$', ''),  'K','000')

ALTER TABLE [data_scientist_jobs]
ALTER COLUMN [Minimum Salary Estimate] FLOAT

ALTER TABLE [data_scientist_jobs]
ALTER COLUMN [Maximum Salary Estimate] FLOAT

----------------------------------------------------------------------------------------------------------------------
-- Update Ratings to Average Ratings
SELECT AVG([Rating]) as averageRating
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Rating] > 0

SELECT [Rating]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Rating] < 0

UPDATE [data_scientist_jobs]
SET [Rating] = 3.8
WHERE [Rating] < 0
----------------------------------------------------------------------------------------------------------------------
-- Update Headquarters with a '-1' to the Location
SELECT [Location], [Headquarters]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Headquarters] LIKE '%-1%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Headquarters] = [Location]
WHERE [Headquarters] LIKE '%-1%'

----------------------------------------------------------------------------------------------------------------------
-- Change '-1' to '1 to 50 employees' as most company would have atleast one person in the business
-- Update Unknown to the median Size which is 201 to 500 employees
SELECT DISTINCT [Size], COUNT([Size]) as countSize
FROM [Portfolio].[dbo].[data_scientist_jobs]
GROUP BY [Size]

SELECT [Size]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Size] LIKE '%Unknown%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Size] = '201 to 500 employees'
WHERE [Size] LIKE '%Unknown%'

----------------------------------------------------------------------------------------------------------------------
-- Resolve other column and add them as Unknown
SELECT [Type of ownership] 
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Type of ownership] LIKE '%-1%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Type of ownership] = 'Unknown'
WHERE [Type of ownership] LIKE '%-1%' 

SELECT [Industry] 
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Industry] LIKE '%-1%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Industry] = 'Unknown'
WHERE [Industry] LIKE '%-1%' 

SELECT [Sector]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Sector] LIKE '%-1%'  

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Sector] = 'Unknown'
WHERE [Sector] LIKE '%-1%' 

SELECT [Revenue]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Revenue] LIKE '%-1%'  

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Revenue] = 'Unknown / Non-Applicable'
WHERE [Revenue] LIKE '%-1%' 

----------------------------------------------------------------------------------------------------------------------
-- Update -1 Founded date to NULL
SELECT [Founded]
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Founded] LIKE '%-1%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Founded] = NULL
WHERE [Founded] LIKE '%-1%'

----------------------------------------------------------------------------------------------------------------------
-- Remove Rating from Company Name

SELECT [Rating], [Company Name], REPLACE([Company Name], [Rating], '') AS removedRating
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Company Name] LIKE '%[Rating]%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Company Name] = REPLACE([Company Name], [Rating], '')
WHERE [Company Name] LIKE '%[Rating]%'

SELECT [Rating], [Company Name], REPLACE([Company Name], '.0', '') AS removedZero
FROM [Portfolio].[dbo].[data_scientist_jobs]
WHERE [Company Name] LIKE '%.0%'

UPDATE [Portfolio].[dbo].[data_scientist_jobs]
SET [Company Name] = REPLACE([Company Name], '.0', '')
WHERE [Company Name] LIKE '%.0%'

----------------------------------------------------------------------------------------------------------------------
-- Checking all columns
SELECT *
FROM [Portfolio].[dbo].[data_scientist_jobs]

