-- 1: Get the cities with a name starting with "ping" sorted by their population with the least populated cities first
SELECT * FROM city WHERE Name LIKE 'Ping%' ORDER BY Population ASC;

-- 2: Get the cities with a name starting with "ran" sorted by their population with the most populated cities first
SELECT * FROM city WHERE Name LIKE 'Ran%' ORDER BY Population DESC;

-- 3: Count all cities
SELECT COUNT(*) AS CityCount FROM city;

-- 4: Get the average population of all cities
SELECT AVG(Population) AS AvgPopulation FROM city;

-- 5: Get the biggest population found in any of the cities
SELECT MAX(Population) AS MaxPopulation FROM city;

-- 6: Get the smallest population found in any of the cities
SELECT MIN(Population) AS MinPopulation FROM city;

-- 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) AS SumPopulation FROM city WHERE Population < 10000;

-- 8: Count the cities with the country codes "MOZ" and "VNM"
SELECT COUNT(*) AS CityCount FROM city WHERE CountryCode IN ('MOZ', 'VNM');

-- 9: Get individual count of cities for the country codes "MOZ" and "VNM"
SELECT CountryCode, COUNT(*) AS CityCount FROM city WHERE CountryCode IN ('MOZ', 'VNM') GROUP BY CountryCode;

-- 10: Get average population of cities in "MOZ" and "VNM"
SELECT CountryCode, AVG(Population) AS AvgPopulation FROM city WHERE CountryCode IN ('MOZ', 'VNM') GROUP BY CountryCode;

-- 11: Get the country codes with more than 200 cities
SELECT CountryCode FROM city GROUP BY CountryCode HAVING COUNT(*) > 200;

-- 12: Get the country codes with more than 200 cities ordered by city count
SELECT CountryCode, COUNT(*) AS CityCount FROM city GROUP BY CountryCode HAVING COUNT(*) > 200 ORDER BY CityCount DESC;

-- 13: What language(s) is spoken in the city with a population between 400 and 500?
SELECT DISTINCT Language FROM countrylanguage WHERE CountryCode IN (SELECT CountryCode FROM city WHERE Population BETWEEN 400 AND 500);

-- 14: What are the names of the cities with a population between 500 and 600 people and the language(s) spoken in them?
SELECT city.Name, countrylanguage.Language FROM city
                                                    JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE city.Population BETWEEN 500 AND 600;

-- 15: What names of the cities are in the same country as the city with a population of 122199 (including that city itself)?
SELECT Name FROM city WHERE CountryCode = (SELECT CountryCode FROM city WHERE Population = 122199);

-- 16: What names of the cities are in the same country as the city with a population of 122199 (excluding that city itself)?
SELECT Name FROM city WHERE CountryCode = (SELECT CountryCode FROM city WHERE Population = 122199) AND Population != 122199;

-- 17: What are the city names in the country where Luanda is capital?
SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Capital = (SELECT ID FROM city WHERE Name = 'Luanda'));

-- 18: What are the names of the capital cities in countries in the same region as the city named Yaren?
SELECT city.Name FROM city
                          JOIN country ON city.ID = country.Capital
WHERE country.Region = (SELECT Region FROM country WHERE Capital = (SELECT ID FROM city WHERE Name = 'Yaren'));

-- 19: What unique languages are spoken in the countries in the same region as the city named Riga?
SELECT DISTINCT Language FROM countrylanguage
WHERE CountryCode IN (SELECT Code FROM country WHERE Region = (SELECT Region FROM country WHERE Capital = (SELECT ID FROM city WHERE Name = 'Riga')));

-- 20: Get the name of the most populous city
SELECT Name FROM city ORDER BY Population DESC LIMIT 1;
