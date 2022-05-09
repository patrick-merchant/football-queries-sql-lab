-- RUN COMMAND: psql -d football -f football_queries.sql
-- OR use postico.


-- 1. Find all the matches from 2017.
SELECT * FROM matches WHERE season = 2017;

-- 2. Find all the matches featuring Barcelona.
SELECT * FROM matches WHERE hometeam = 'Barcelona' OR awayteam = 'Barcelona';

-- 3. What are the names of the Scottish divisions included?
SELECT name FROM divisions WHERE country = 'Scotland';

-- 4. Find the division code for the Bundesliga. 
SELECT code FROM divisions WHERE name = 'Bundesliga';
-- Use that code to find out how many matches Freiburg have played in the Bundesliga 
-- since the data started being collected.
SELECT COUNT(*) FROM matches WHERE division_code = 'D1' AND (awayteam = 'Freiburg' OR hometeam = 'Freiburg');

-- 5. Find the unique names of the teams which include the word "City" in their name (as entered in the database).
Select awayteam FROM matches WHERE awayteam LIKE '%City%' GROUP BY awayteam;

-- 6. How many different teams have played in matches recorded in a French division?
-- FIRST find division_code(s) for all French divisions:
SELECT code FROM divisions WHERE country = 'France';
-- returns 'F1' and 'F2'.
-- THEN count number of different teams:
SELECT COUNT(DISTINCT hometeam) FROM matches WHERE (division_code = 'F1' OR division_code = 'F2');

-- 7. Have Huddersfield played Swansea in the period covered?
-- Yes!
-- List all matches:
SELECT * FROM matches WHERE (hometeam = 'Huddersfield' AND awayteam = 'Swansea') OR (hometeam = 'Swansea' AND awayteam = 'Huddersfield');
-- Count matches:
SELECT COUNT(*) FROM matches WHERE (hometeam = 'Huddersfield' AND awayteam = 'Swansea') OR (hometeam = 'Swansea' AND awayteam = 'Huddersfield');

-- 8. How many draws were there in the Eredivisie between 2010 and 2015?
SELECT COUNT(*) FROM matches WHERE division_code = 'N1' AND ftr = 'D' AND season BETWEEN 2010 AND 2015;

-- 9. Select the matches played in the Premier League in order of total goals scored from highest to lowest. 
-- Where there is a tie the match with more home goals should come first.
SELECT * from MATCHES WHERE division_code = 'E0' ORDER BY (fthg + ftag) DESC, fthg DESC;

-- 10. In which division and which season were the most goals scored?
SELECT SUM(fthg + ftag) AS TotalGoalsPerSeason, division_code, season from MATCHES GROUP BY division_code, season ORDER BY SUM(fthg + ftag) DESC;
-- National League (EC), 2013!