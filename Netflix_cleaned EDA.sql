

CREATE TABLE netflix_eda AS SELECT * FROM netflix_cleaned;

SELECT * FROM netflix_eda;

-- 1- CONTENT BREAKDOWN - MOVIES VS TV SHOWS
						-- data available from 09-07-2021 to 09-25-21
                        -- USA has the most - 17 movies and 8 TV Shows
                        -- Followed by Japan - 13 movies 
                        -- Whereas United States has 8 TV Shows followed by United Kingdom having 6 TV shows  
                        -- type by rating -  TV shows are rated differently than movies 
                        -- The oldest movie showing is Jaws  released in 1975 where as 1994 is the oldest TV Show released in 1994.
-- 2 - GROWTH OVER TIME 
						-- On the 2021-09-15 and 21-09-16 saw the highest number of additions which were 22 and we respectively
-- 3- CONTENT AGE - RELEASE YEAR VS DATE ADDED
						-- Already established The Jaws Franchise has the longest number of days between the release and then added, 17060 days
						-- Whereas the movie, Sankofa 1993 was added after 10493 days after its release. 
                        -- Saved by the Bell 1994, the TV Show, was added after 10119 days after its release date
                        -- Yowamushi, the TV Show, has the second highest number of days, 3178 days after its release in 2013.
-- 4- GENRE ANALYSIS
						-- genre type - 12 Action & Adventure, Anime Features, International movies is the hightest number of movies
                        -- where as 5 is the highest genre kind which is Kid's TV 
-- 5- DURATION PATTERNS
						-- Movie, Jeans 166 min - longest movie 
						-- Movie, My Heroes Were Cowboys 23 min - shortest movie
						-- TV Show 9 Seasons Saved By the Bell 
						-- TV Shows 9 Season The Great British Baking Show 
-- 7- MOST PROLIFIC DIRECTORS/ACTORS
						-- Toshiya Shinohara has directed 4 movies where as Masahiko Murata as directed 3 movies

-- CONTENT BREAKDOWN - MOVIES VS TV SHOWS (FINDINGS 55 VS 45)

SELECT title, `type`, release_year, COUNT(*) AS cnt 
FROM netflix_titles
GROUP BY title, `type`, release_year
HAVING COUNT(*) > 1;


SELECT `type`, COUNT(*) FROM netflix_eda GROUP BY `type`;

SELECT * FROM netflix_eda;

SELECT YEAR(date_added) AS year_added, `type`, COUNT(*) 
FROM netflix_eda 
GROUP BY YEAR(date_added), `type`
ORDER BY year_added;


SELECT COUNT(*) 
FROM netflix_eda 
WHERE date_added IS NULL;

SELECT MIN(date_added) AS oldest_date, MAX(date_added) AS newest_date
FROM netflix_eda;

SELECT MIN(date_added) AS oldest_date, MAX(date_added) AS newest_date
FROM netflix_titles;

SELECT country, `type`, COUNT(*) 
FROM netflix_eda 
WHERE country != 'Not Specified'
GROUP BY country, `type`
ORDER BY `type`;

SELECT * FROM netflix_eda;

WITH RECURSIVE split_countries AS (
    SELECT 
        show_id,
        `type`,
        TRIM(SUBSTRING_INDEX(country, ',', 1)) AS single_country,
        TRIM(SUBSTRING(country, LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2)) AS remaining
    FROM netflix_eda
    WHERE country != 'Not Specified'
    
    UNION ALL
    
    SELECT 
        show_id,
        `type`,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)),
        TRIM(SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2))
    FROM split_countries
    WHERE remaining != ''
)
SELECT single_country, `type`, COUNT(*) AS total
FROM split_countries
GROUP BY single_country, `type`
ORDER BY total DESC;

SELECT * FROM netflix_eda;

SELECT `type`, rating, COUNT(*) 
FROM netflix_eda 
GROUP BY `type`, rating
ORDER BY `type`, COUNT(*) DESC;

SELECT `type`, listed_in, COUNT(*) 
FROM netflix_eda 
GROUP BY `type`, listed_in
ORDER BY `type`, COUNT(*) DESC;

DESCRIBE netflix_eda;

SELECT type, release_year, COUNT(*) FROM netflix_eda
GROUP BY type, release_year
ORDER BY release_year DESC;

SELECT type, release_year, COUNT(*) FROM netflix_eda
GROUP BY type, release_year
ORDER BY release_year ASC;

SELECT title, type, release_year, COUNT(*) FROM netflix_eda
GROUP BY title, type, release_year
ORDER BY release_year ASC;

SELECT title, date_added, COUNT(*)
FROM netflix_eda 
GROUP BY title, date_added
ORDER BY date_added;

SELECT date_added, COUNT(*)
FROM netflix_eda 
GROUP BY date_added
ORDER BY date_added DESC;

SELECT title, release_year, date_added, 
DATEDIFF(date_added, MAKEDATE(release_year,1)) 
FROM netflix_eda;


SELECT title, type, release_year, date_added, 
DATEDIFF(date_added, MAKEDATE(release_year,1)) 
FROM netflix_eda
ORDER BY type;

SELECT * FROM netflix_eda;

SELECT title, type, listed_in FROM netflix_eda;

SELECT listed_in, COUNT(*) 
FROM netflix_eda 
GROUP BY listed_in 
ORDER BY COUNT(*) DESC 
;


SELECT listed_in, COUNT(*) 
FROM netflix_eda 
GROUP BY listed_in 
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT * FROM netflix_eda;

SELECT title, type, `duration` FROM netflix_eda WHERE `type` = 'Movie'
ORDER BY duration ASC;

-- Movie, Jeans 166 min - longest movie 
-- Movie, My Heroes Were Cowboys 23 min - shortest movie

SELECT title, type, `duration` FROM netflix_eda WHERE `type` = 'TV Show'
ORDER BY duration ASC;

-- TV Show 9 Seasons Saved By the Bell 
-- TV Shows 9 Season The Great British Baking Show 

SELECT * FROM netflix_eda;

SELECT type, title, director FROM netflix_eda;

SELECT director, COUNT(*) 
FROM netflix_eda 
WHERE director != 'Not Specified'
GROUP BY director 
ORDER BY COUNT(*) DESC ;

SELECT type, director, COUNT(*) 
FROM netflix_eda 
WHERE director != 'Not Specified'
GROUP BY type, director 
ORDER BY COUNT(*) DESC ;

SELECT * FROM netflix_eda;
 


 
-- # Netflix Titles — Data Cleaning Project (MySQL)

-- ## Overview
-- Cleaned the public Netflix Movies and TV Shows dataset (`netflix_titles`) in MySQL, producing a standardized, analysis-ready table (`netflix_cleaned`). The raw dataset contains ~8,800 rows covering titles, cast, director, country, date added, release year, rating, duration, genre, and description.

-- ## Objective
-- Prepare the dataset for downstream analysis (e.g. content trends by genre, country, or release year) by resolving missing values, inconsistent formatting, and structural issues in the source data.

-- ## Process

-- **1. Duplicate check**
-- Verified no duplicate records existed at the row level, using both a `show_id` grouping check and a `ROW_NUMBER()` window function across all columns.

-- **2. ID standardization**
-- Reformatted `show_id` values into a consistent, readable format (e.g. `S1`, `S2`, `S3`).

 -- **3. Date formatting**
-- Original `date_added` values were stored as text (e.g. `"January 1, 2021"`). Converted this to a proper SQL `DATE` type using `STR_TO_DATE()`, added as a new column, then dropped and renamed to replace the original — repositioned after `country` for logical column ordering.

-- **4. Missing value handling**
-- `director`, `cast`, and `country` had a significant number of missing values — a known characteristic of this dataset (many titles, especially stand-up specials and international shows, don't list a director in the traditional sense).
-- Flagged missing values as `'Not Specified'` rather than deleting rows, to preserve row count for other analysis dimensions (genre, release year, etc.) without fabricating data.
-- For a targeted subset of high-visibility titles, researched and manually filled in accurate director/cast values instead of leaving them flagged, improving completeness where feasible.

-- **5. Data corrections**
-- Cross-checked and corrected several `title` values (e.g. franchise entries that were mislabeled or incomplete) against verified sources.

-- **6. Text/escaping issues**
-- Handled apostrophes within free-text `description` fields (contractions, possessives) using SQL string escaping to prevent syntax errors during updates.

-- ## Exploratory Data Analysis (EDA)
-- After cleaning, ran a separate EDA pass (`netflix_eda`, built from `netflix_cleaned`) to explore content patterns. Key findings:

-- **Content breakdown**
-- Catalog splits roughly 55% Movies / 45% TV Shows.
-- The United States leads in both categories (17 movies, 8 TV Shows), followed by Japan for movies (13) and the United Kingdom for TV Shows (6).
-- Oldest movie in the catalog: *Jaws* (1975). Oldest TV show: 1994.

-- **Growth over time**
-- Content additions spiked on 2021-09-15 and 2021-09-16, with 22 titles added on each date — the two largest single-day additions in the dataset.

-- **Content age (release year vs. date added)**
-- *Jaws* also has the longest gap between release and being added to Netflix: 17,060 days.
-- *Sankofa* (1993) was added 10,493 days after its release.
-- *Saved by the Bell* (1994) was added 10,119 days after its release — the largest gap among TV shows.

-- **Genre**
-- The most common genre combination is "Action & Adventure, Anime Features, International Movies" (12 titles). Note: genres are stored as comma-separated combinations rather than single tags, so this reflects the top *combination*, not necessarily the single most common genre overall.

-- **Duration**
-- Longest movie: *Jeans* (166 min). Shortest: *My Heroes Were Cowboys* (23 min).
-- Most seasons among TV shows: *Saved by the Bell* and *The Great British Baking Show*, both at 9 seasons.

-- **Directors**
-- Toshiya Shinohara is the most prolific director in the catalog with 4 movies, followed by Masahiko Murata with 3.

-- **Data integrity check**
-- Confirmed 0 duplicate titles in the raw dataset (checked by title, type, and release year).

-- ## Key Learnings
-- `LOAD DATA INFILE` vs. row-by-row inserts: dramatic performance difference for bulk loading (seconds vs. minutes).
-- Reserved words (`cast`) require backtick escaping when used as column names.
-- Partitioning/grouping logic requires actual column references, not quoted string literals — an easy mistake that silently produces meaningless results instead of an error.
-- Deciding *how* to handle missing data (flag vs. drop vs. fill) depends on the analysis goal, not a single "correct" answer — and that reasoning is worth documenting.

-- ## Tools Used
-- MySQL 8.0, MySQL Workbench

-- ## Files
-- `netflix_titles.csv` — raw source data
-- `netflix_cleaned.sql` — full cleaning script
-- `netflix_eda.sql` — exploratory data analysis queries
