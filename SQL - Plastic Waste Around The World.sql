-- Source: Kaggle
-- Data: Cleaned Data
-- Software Used: https://sqliteonline.com/
-- Link: https://www.kaggle.com/datasets/prajwaldongre/global-plastic-waste-2023-a-country-wise-analysis
-- Acknowledgement: Prajwal Dongre

----------------------------------------------------------------------------------------------------------------------
-- View all

SELECT *
FROM PlasticWasteAroundtheWorld

----------------------------------------------------------------------------------------------------------------------
-- View country, total plastic waste, recycling rate and per capita waste in kg

SELECT country, total_plastic_waste_mt, recycling_rate, per_capita_waste_kg
FROM PlasticWasteAroundtheWorld

----------------------------------------------------------------------------------------------------------------------
-- Find distinct country

SELECT DISTINCT country
FROM PlasticWasteAroundtheWorld

----------------------------------------------------------------------------------------------------------------------
-- View average plastic waste per country and name "average_plastic_waste_per_country"

SELECT country, AVG(total_plastic_waste_mt) AS average_plastic_waste_per_country
FROM PlasticWasteAroundtheWorld
GROUP BY country

----------------------------------------------------------------------------------------------------------------------
-- View country and per capital waste per kg with the lowest first. 

SELECT country, per_capita_waste_kg
FROM PlasticWasteAroundtheWorld
ORDER BY per_capita_waste_kg 

----------------------------------------------------------------------------------------------------------------------
-- View all where the country is China. 

SELECT *
FROM PlasticWasteAroundtheWorld
WHERE country LIKE 'China'

----------------------------------------------------------------------------------------------------------------------
-- View all where country starts with "c", "o", "u", "n", "t", "r" and "y" is China. 

SELECT *
FROM PlasticWasteAroundtheWorld
WHERE country LIKE '[country]%'

----------------------------------------------------------------------------------------------------------------------
-- View all where country starts from range "a" to "c"

SELECT *
FROM PlasticWasteAroundtheWorld
WHERE country LIKE '[a-c]%'

----------------------------------------------------------------------------------------------------------------------
-- View country, coastal waste risk, recycling rate where country does not include "in"

SELECT country, coastal_waste_risk, recycling_rate
FROM PlasticWasteAroundtheWorld
WHERE country NOT LIKE '%in%'

----------------------------------------------------------------------------------------------------------------------
-- View country, total per capital waste and group by country and order total per capital waste with the most first

SELECT country, SUM(per_capita_waste_kg)
FROM PlasticWasteAroundtheWorld
GROUP BY country
ORDER BY SUM(per_capita_waste_kg) DESC;

----------------------------------------------------------------------------------------------------------------------
-- View all where recycling_rate is between 10 and 30 and order by per capita waste in kg starting with the highest first

SELECT *
FROM PlasticWasteAroundtheWorld
WHERE recycling_rate BETWEEN 10 AND 30
ORDER BY per_capita_waste_kg DESC

----------------------------------------------------------------------------------------------------------------------
-- View coastal waste risk and the correspondent average per capita waste kg

SELECT coastal_waste_risk, AVG(per_capita_waste_kg) AS average_per_capita_waste_kg
FROM PlasticWasteAroundtheWorld
GROUP BY coastal_waste_risk
ORDER BY average_per_capita_waste_kg DESC

----------------------------------------------------------------------------------------------------------------------
-- View country, recycling rate, total place waste and per capita waste where recycling is above the average and the total plastic waste is above the average

SELECT country, recycling_rate, total_plastic_waste_mt, per_capita_waste_kg
FROM PlasticWasteAroundtheWorld
WHERE recycling_rate > (SELECT AVG(recycling_rate)
       FROM PlasticWasteAroundtheWorld)       
       AND        
       total_plastic_waste_mt > (SELECT AVG(total_plastic_waste_mt) 
       FROM PlasticWasteAroundtheWorld)
       AND        
       per_capita_waste_kg > (SELECT AVG(per_capita_waste_kg) 
       FROM PlasticWasteAroundtheWorld)


