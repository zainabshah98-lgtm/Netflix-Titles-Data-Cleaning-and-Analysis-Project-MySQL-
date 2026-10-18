# Netflix Titles — Data Cleaning and Analysis Project (MySQL)

## Overview
Cleaned the public Netflix Movies and TV Shows dataset (`netflix_titles`) in MySQL, producing a standardized, analysis-ready table (`netflix_cleaned`). The raw dataset contains ~8,800 rows covering titles, cast, director, country, date added, release year, rating, duration, genre, and description.

## Objective
Prepare the dataset for downstream analysis (e.g. content trends by genre, country, or release year) by resolving missing values, inconsistent formatting, and structural issues in the source data.

## Process

**1. Duplicate check**
Verified no duplicate records existed at the row level, using both a `show_id` grouping check and a `ROW_NUMBER()` window function across all columns.

**2. ID standardization**
Reformatted `show_id` values into a consistent, readable format (e.g. `S1`, `S2`, `S3`).

**3. Date formatting**
Original `date_added` values were stored as text (e.g. `"January 1, 2021"`). Converted this to a proper SQL `DATE` type using `STR_TO_DATE()`, added as a new column, then dropped and renamed to replace the original — repositioned after `country` for logical column ordering.

**4. Missing value handling**
`director`, `cast`, and `country` had a significant number of missing values — a known characteristic of this dataset (many titles, especially stand-up specials and international shows, don't list a director in the traditional sense).
- Flagged missing values as `'Not Specified'` rather than deleting rows, to preserve row count for other analysis dimensions (genre, release year, etc.) without fabricating data.
- For a targeted subset of high-visibility titles, researched and manually filled in accurate director/cast values instead of leaving them flagged, improving completeness where feasible.

**5. Data corrections**
Cross-checked and corrected several `title` values (e.g. franchise entries that were mislabeled or incomplete) against verified sources.

**6. Text/escaping issues**
Handled apostrophes within free-text `description` fields (contractions, possessives) using SQL string escaping to prevent syntax errors during updates.

## Exploratory Data Analysis (EDA)
After cleaning, ran a separate EDA pass (`netflix_eda`, built from `netflix_cleaned`) to explore content patterns. Key findings:

**Content breakdown**
- Catalog splits roughly 55% Movies / 45% TV Shows.
- The United States leads in both categories (17 movies, 8 TV Shows), followed by Japan for movies (13) and the United Kingdom for TV Shows (6).
- Oldest movie in the catalog: *Jaws* (1975). Oldest TV show: 1994.

**Growth over time**
- Content additions spiked on 2021-09-15 and 2021-09-16, with 22 titles added on each date — the two largest single-day additions in the dataset.

**Content age (release year vs. date added)**
- *Jaws* also has the longest gap between release and being added to Netflix: 17,060 days.
- *Sankofa* (1993) was added 10,493 days after its release.
- *Saved by the Bell* (1994) was added 10,119 days after its release — the largest gap among TV shows.

**Genre**
- The most common genre combination is "Action & Adventure, Anime Features, International Movies" (12 titles). Note: genres are stored as comma-separated combinations rather than single tags, so this reflects the top *combination*, not necessarily the single most common genre overall.

**Duration**
- Longest movie: *Jeans* (166 min). Shortest: *My Heroes Were Cowboys* (23 min).
- Most seasons among TV shows: *Saved by the Bell* and *The Great British Baking Show*, both at 9 seasons.

**Directors**
- Toshiya Shinohara is the most prolific director in the catalog with 4 movies, followed by Masahiko Murata with 3.

**Data integrity check**
- Confirmed 0 duplicate titles in the raw dataset (checked by title, type, and release year).

## Key Learnings
- `LOAD DATA INFILE` vs. row-by-row inserts: dramatic performance difference for bulk loading (seconds vs. minutes).
- Reserved words (`cast`) require backtick escaping when used as column names.
- Partitioning/grouping logic requires actual column references, not quoted string literals — an easy mistake that silently produces meaningless results instead of an error.
- Deciding *how* to handle missing data (flag vs. drop vs. fill) depends on the analysis goal, not a single "correct" answer — and that reasoning is worth documenting.

## Tools Used
MySQL 8.0, MySQL Workbench

## Project Status - Completed
