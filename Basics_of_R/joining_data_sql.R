SELECT c.name AS city, cc.name AS country, cc.region 
FROM cities AS c
INNER JOIN countries AS cc
ON cc.code = c.country_code




SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
INNER JOIN economies AS e
ON c.code = e.code




SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code AND e.year = p.year;




SELECT c.name AS country, continent, l.name AS language, official
FROM countries AS c
INNER JOIN languages AS l
USING(code);





SELECT p1.country_code, 
p1.size AS size2010,
p2.size as size2015,
((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code
AND p1.year = p2.year - 5






SELECT name, continent, code, surface_area,
-- first case
CASE WHEN surface_area > 2000000 THEN 'large'
-- second case
WHEN surface_area > 350000 THEN 'medium'
-- else clause + end
ELSE 'small' END
AS geosize_group
FROM countries;









SELECT country_code, size,
CASE WHEN size > 50000000
THEN 'large'
WHEN size > 1000000
THEN 'medium'
ELSE 'small' END
AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

SELECT name, continent, geosize_group, popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus AS p
ON c.code = p.country_code
ORDER BY geosize_group;






-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
INNER JOIN countries AS c2
-- how should the tables be matched?
  ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;


-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
LEFT JOIN countries AS c2
-- how should the tables be matched?
  ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;





-- Select region, average gdp_percapita (alias avg_gdp)
SELECT AVG(gdp_percapita) AS avg_gdp, region
-- from countries (alias c) on the left
FROM countries AS c
-- left join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE year = 2010
-- Group by region
GROUP BY region;






-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
  SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
indep_year, languages.name AS language, percent
FROM cities
LEFT JOIN countries
ON cities.country_code = countries.code
LEFT JOIN languages
ON countries.code = languages.code
ORDER BY city, language;
*/
  
  SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
indep_year, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
ON countries.code = languages.code
RIGHT JOIN cities
ON cities.country_code = countries.code
ORDER BY city, language;





SELECT c.name AS country, region, l.name AS language,
basic_unit, frac_unit
FROM countries AS c
FULL JOIN languages AS l
USING (code)
FULL JOIN currencies AS cu
USING (code)
WHERE region LIKE 'M%esia';




SELECT DISTINCT(name) FROM languages 
WHERE code IN (SELECT code FROM countries WHERE region = 'Middle East')
ORDER BY name




-- select the city name
SELECT name
-- alias the table where city name resides
FROM cities AS c1
-- choose only records matching the result of multiple set theory clauses
WHERE country_code IN
(
  -- select appropriate field from economies AS e
  SELECT e.code
  FROM economies AS e
  -- get all additional (unique) values of the field from currencies AS c2  
  UNION
  SELECT DISTINCT(c2.code)
  FROM currencies AS c2
  -- exclude those appearing in populations AS p
  EXCEPT
  SELECT p.country_code
  FROM populations AS p
);


