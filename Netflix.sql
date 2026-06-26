USE netflix;

#Database Understanding
#Check Available Tables

SHOW TABLES;

#View Complete Dataset

SELECT *
FROM netflix_titles;

#Count Total Records

SELECT COUNT(*)
FROM netflix_titles;

#Count Total Columns

SHOW COLUMNS
FROM netflix_titles;

#Display Table Structure

DESCRIBE netflix_titles;

#Check Storage Engine (MySQL)

SHOW TABLE STATUS
LIKE 'netflix_titles';

#Check Database

SELECT DATABASE();

#Verify Total Rows

SELECT COUNT(*) AS Total_Records
FROM netflix_titles;

#Verify Unique Show IDs

SELECT COUNT(DISTINCT show_id) AS Unique_Show_IDs
FROM netflix_titles;

#Check Duplicate Show IDs

SELECT show_id, COUNT(*)
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

#Identify Dataset Type

SELECT DISTINCT type
FROM netflix_titles;

#Check Release Year Range

SELECT
MIN(release_year) AS First_Release,
MAX(release_year) AS Latest_Release
FROM netflix_titles;

#Check Ratings Available

SELECT DISTINCT rating
FROM netflix_titles
ORDER BY rating;

#Check Duration Formats

SELECT DISTINCT duration
FROM netflix_titles;

#Count Movies vs TV Shows

SELECT
type,
COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY type;

#Check Country Availability

SELECT
COUNT(DISTINCT country) AS Countries
FROM netflix_titles;

#Check Director Availability

SELECT
COUNT(DISTINCT director) AS Directors
FROM netflix_titles;

#Check Genre Availability

SELECT
COUNT(DISTINCT listed_in) AS Genres
FROM netflix_titles;

#Schema Analysis

#Verify Current Database

SELECT DATABASE() AS Current_Database;

#List All Tables

SHOW TABLES;

#Verify Table Exists

SHOW TABLES LIKE 'netflix_titles';

#Display Complete Table Structure

DESCRIBE netflix_titles;

#Display Column Details

SHOW COLUMNS
FROM netflix_titles;

#Retrieve Schema Information from INFORMATION_SCHEMA

SELECT
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH,
IS_NULLABLE,
COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Count Number of Columns

SELECT
COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Verify Total Rows

SELECT COUNT(*) AS Total_Rows
FROM netflix_titles;

#Identify Candidate Primary Key

SELECT
COUNT(*) AS Total_Rows,
COUNT(DISTINCT show_id) AS Unique_Show_IDs
FROM netflix_titles;

#Check Duplicate show_id

SELECT
show_id,
COUNT(*) AS Duplicate_Count
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

#Check NULL show_id

SELECT
COUNT(*) AS Null_Show_ID
FROM netflix_titles
WHERE show_id IS NULL;

#Check Primary Key Constraint

SELECT
CONSTRAINT_NAME,
CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Check Existing Indexes

SHOW INDEX
FROM netflix_titles;

#Verify Storage Engine

SELECT
ENGINE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Check Table Collation

SELECT
TABLE_COLLATION
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Check Average Row Length

SHOW TABLE STATUS
LIKE 'netflix_titles';

#Data Dictionary

#View Table Structure

DESCRIBE netflix_titles;

#Column Metadata

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'netflix'
AND TABLE_NAME = 'netflix_titles';

#Count Total Columns

SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Character Length of Columns

SELECT
    COLUMN_NAME,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles';

#Numeric Columns

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles'
AND DATA_TYPE IN ('int','bigint','decimal','float','double');

#Text Columns

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles'
AND DATA_TYPE IN ('varchar','text','longtext');

#Date Columns

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='netflix'
AND TABLE_NAME='netflix_titles'
AND DATA_TYPE IN ('date','datetime','timestamp');

#Data Quality Checks

#Total Records
SELECT COUNT(*) AS Total_Records
FROM netflix_titles;

#Check Complete Duplicate Records
SELECT *,
COUNT(*) AS Duplicate_Count
FROM netflix_titles
GROUP BY
show_id,
type,
title,
director,
cast,
country,
date_added,
release_year,
rating,
duration,
listed_in,
description
HAVING COUNT(*) > 1;

#Duplicate show_id
SELECT
show_id,
COUNT(*) AS Duplicate_ID
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

#NULL Values (All Columns)
SELECT
SUM(show_id IS NULL) AS show_id_null,
SUM(type IS NULL) AS type_null,
SUM(title IS NULL) AS title_null,
SUM(director IS NULL) AS director_null,
SUM(cast IS NULL) AS cast_null,
SUM(country IS NULL) AS country_null,
SUM(date_added IS NULL) AS date_added_null,
SUM(release_year IS NULL) AS release_year_null,
SUM(rating IS NULL) AS rating_null,
SUM(duration IS NULL) AS duration_null,
SUM(listed_in IS NULL) AS listed_in_null,
SUM(description IS NULL) AS description_null
FROM netflix_titles;

#Blank Values
SELECT
SUM(TRIM(show_id)='') AS show_id_blank,
SUM(TRIM(type)='') AS type_blank,
SUM(TRIM(title)='') AS title_blank,
SUM(TRIM(director)='') AS director_blank,
SUM(TRIM(cast)='') AS cast_blank,
SUM(TRIM(country)='') AS country_blank,
SUM(TRIM(date_added)='') AS date_added_blank,
SUM(TRIM(rating)='') AS rating_blank,
SUM(TRIM(duration)='') AS duration_blank,
SUM(TRIM(listed_in)='') AS listed_in_blank,
SUM(TRIM(description)='') AS description_blank
FROM netflix_titles;

#Missing Critical Fields
SELECT *
FROM netflix_titles
WHERE
show_id IS NULL
OR title IS NULL
OR type IS NULL;

#Invalid Content Type
SELECT DISTINCT type
FROM netflix_titles;

#Validation
SELECT *
FROM netflix_titles
WHERE type NOT IN ('Movie','TV Show');

#Invalid Release Year
SELECT *
FROM netflix_titles
WHERE
release_year<1900
OR release_year>YEAR(CURDATE());

#Check Future Release Years
SELECT *
FROM netflix_titles
WHERE release_year>YEAR(CURDATE());

#Invalid Rating
SELECT DISTINCT rating
FROM netflix_titles
ORDER BY rating;

#Missing Rating
SELECT *
FROM netflix_titles
WHERE rating IS NULL;

#Missing Country
SELECT *
FROM netflix_titles
WHERE country IS NULL;

#Missing Director
SELECT *
FROM netflix_titles
WHERE director IS NULL;

#Missing Cast
SELECT *
FROM netflix_titles
WHERE cast IS NULL;

#Missing Date Added
SELECT *
FROM netflix_titles
WHERE date_added IS NULL;

#Missing Duration
SELECT *
FROM netflix_titles
WHERE duration IS NULL;

#Check Invalid Duration Format
SELECT *
FROM netflix_titles
WHERE
(type='Movie' AND duration NOT LIKE '%min%')
OR
(type='TV Show' AND duration NOT LIKE '%Season%');

#Invalid Date Format
SELECT
date_added,
STR_TO_DATE(date_added,'%M %d, %Y')
FROM netflix_titles;

#Check Title Length
SELECT
title,
CHAR_LENGTH(title) AS Length
FROM netflix_titles
ORDER BY Length DESC;

#Leading / Trailing Spaces
SELECT *
FROM netflix_titles
WHERE
title<>TRIM(title)
OR director<>TRIM(director)
OR country<>TRIM(country);

#Check Empty Description
SELECT *
FROM netflix_titles
WHERE
description IS NULL
OR TRIM(description)='';

#Country Consistency
SELECT DISTINCT country
FROM netflix_titles
ORDER BY country;

#Rating Consistency
SELECT
rating,
COUNT(*) AS Total
FROM netflix_titles
GROUP BY rating
ORDER BY Total DESC;

#Type Distribution
SELECT
type,
COUNT(*) AS Total
FROM netflix_titles
GROUP BY type;

#Exploratory Analysis

#View Complete Dataset
SELECT *
FROM netflix_titles;

#Display First 10 Records
SELECT *
FROM netflix_titles
LIMIT 10;

#Total Number of Records
SELECT COUNT(*) AS Total_Records
FROM netflix_titles;

#Total Movies and TV Shows
SELECT
type,
COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY type;

#List All Available Content Types
SELECT DISTINCT type
FROM netflix_titles;

#Total Unique Directors
SELECT COUNT(DISTINCT director) AS Total_Directors
FROM netflix_titles;

#Total Unique Countries
SELECT COUNT(DISTINCT country) AS Total_Countries
FROM netflix_titles;

#Total Unique Ratings
SELECT COUNT(DISTINCT rating) AS Total_Ratings
FROM netflix_titles;

#Display Available Ratings
SELECT DISTINCT rating
FROM netflix_titles
ORDER BY rating;

#Total Release Years
SELECT COUNT(DISTINCT release_year) AS Total_Years
FROM netflix_titles;

#Release Year Range
SELECT
MIN(release_year) AS First_Release,
MAX(release_year) AS Latest_Release
FROM netflix_titles;

#Distinct Genres
SELECT DISTINCT listed_in
FROM netflix_titles;

#Total Genre Categories
SELECT COUNT(DISTINCT listed_in) AS Total_Genres
FROM netflix_titles;

#Distinct Duration Values
SELECT DISTINCT duration
FROM netflix_titles
ORDER BY duration;

#Count Missing Directors
SELECT COUNT(*) AS Missing_Directors
FROM netflix_titles
WHERE director IS NULL;

#Count Missing Countries
SELECT COUNT(*) AS Missing_Countries
FROM netflix_titles
WHERE country IS NULL;

#Count Missing Cast
SELECT COUNT(*) AS Missing_Cast
FROM netflix_titles
WHERE cast IS NULL;

#Count Missing Ratings
SELECT COUNT(*) AS Missing_Rating
FROM netflix_titles
WHERE rating IS NULL;

#Count Missing Date Added
SELECT COUNT(*) AS Missing_Date
FROM netflix_titles
WHERE date_added IS NULL;

#Longest Movie Duration
SELECT duration
FROM netflix_titles
WHERE type='Movie'
ORDER BY CAST(REPLACE(duration,' min','') AS UNSIGNED) DESC
LIMIT 1;

#Maximum TV Show Seasons
SELECT duration
FROM netflix_titles
WHERE type='TV Show'
ORDER BY CAST(REPLACE(REPLACE(duration,' Seasons',''),' Season','') AS UNSIGNED) DESC
LIMIT 1;

#Top 20 Oldest Released Titles
SELECT
title,
release_year
FROM netflix_titles
ORDER BY release_year
LIMIT 20;

#op 20 Latest Released Titles
SELECT
title,
release_year
FROM netflix_titles
ORDER BY release_year DESC
LIMIT 20;

#Movie Sample
SELECT *
FROM netflix_titles
WHERE type='Movie'
LIMIT 10;

#TV Show Sample
SELECT *
FROM netflix_titles
WHERE type='TV Show'
LIMIT 10;

#Titles Without Director
SELECT
show_id,
title
FROM netflix_titles
WHERE director IS NULL;

#Titles Without Country
SELECT
show_id,
title
FROM netflix_titles
WHERE country IS NULL;

#Titles Without Rating
SELECT
show_id,
title
FROM netflix_titles
WHERE rating IS NULL;

#Movies Released After 2020
SELECT
title,
release_year
FROM netflix_titles
WHERE release_year > 2020;

#TV Shows Released After 2020
SELECT
title,
release_year
FROM netflix_titles
WHERE type='TV Show'
AND release_year > 2020;


#KPI Analysis

#KPI 1 — Total Content
SELECT COUNT(*) AS Total_Content
FROM netflix_titles;

#KPI 2 — Total Movies
SELECT COUNT(*) AS Total_Movies
FROM netflix_titles
WHERE type = 'Movie';

#KPI 3 — Total TV Shows
SELECT COUNT(*) AS Total_TV_Shows
FROM netflix_titles
WHERE type = 'TV Show';

#KPI 4 — Movie Percentage
SELECT
ROUND(
COUNT(CASE WHEN type='Movie' THEN 1 END)*100.0/
COUNT(*),2
) AS Movie_Percentage
FROM netflix_titles;

#KPI 5 — TV Show Percentage
SELECT
ROUND(
COUNT(CASE WHEN type='TV Show' THEN 1 END)*100.0/
COUNT(*),2
) AS TV_Show_Percentage
FROM netflix_titles;

#KPI 6 — Total Unique Countries
SELECT COUNT(DISTINCT country) AS Total_Countries
FROM netflix_titles;

#KPI 7 — Total Unique Directors
SELECT COUNT(DISTINCT director) AS Total_Directors
FROM netflix_titles;

#KPI 8 — Total Unique Ratings
SELECT COUNT(DISTINCT rating) AS Total_Ratings
FROM netflix_titles;

#KPI 9 — Total Unique Genres
SELECT COUNT(DISTINCT listed_in) AS Total_Genres
FROM netflix_titles;

#KPI 10 — Earliest Release Year
SELECT MIN(release_year) AS Earliest_Release
FROM netflix_titles;

#KPI 11 — Latest Release Year
SELECT MAX(release_year) AS Latest_Release
FROM netflix_titles;

#KPI 12 — Number of Release Years Covered
SELECT COUNT(DISTINCT release_year) AS Release_Years
FROM netflix_titles;

#KPI 13 — Total Movies Longer Than 120 Minutes
SELECT COUNT(*) AS Movies_Above_120_Min
FROM netflix_titles
WHERE type='Movie'
AND CAST(REPLACE(duration,' min','') AS UNSIGNED)>120;

#KPI 14 — Total TV Shows With More Than 3 Seasons
SELECT COUNT(*) AS TV_Shows_Above_3_Seasons
FROM netflix_titles
WHERE type='TV Show'
AND CAST(
REPLACE(
REPLACE(duration,' Seasons',''),
' Season',''
) AS UNSIGNED
)>3;

#KPI 15  — Total Content Released After 2015
SELECT COUNT(*) AS Content_After_2015
FROM netflix_titles
WHERE release_year>=2015;

#KPI 16 — Total Movies Released After 2015
SELECT COUNT(*) AS Movies_After_2015
FROM netflix_titles
WHERE type='Movie'
AND release_year>=2015;

#KPI 17 — Total TV Shows Released After 2015
SELECT COUNT(*) AS TVShows_After_2015
FROM netflix_titles
WHERE type='TV Show'
AND release_year>=2015;


#Basic SQL Queries

#Display All Records
SELECT *
FROM netflix_titles;

#Display Required Columns Only
SELECT
title,
type,
release_year,
rating
FROM netflix_titles;

#Find All Movies
SELECT *
FROM netflix_titles
WHERE type = 'Movie';

#Movies Released After 2020
SELECT
title,
release_year
FROM netflix_titles
WHERE release_year > 2020;

#Find Family-Friendly Content
SELECT
title,
rating
FROM netflix_titles
WHERE rating IN ('G', 'PG', 'TV-G', 'TV-PG');

#Find Missing Directors
SELECT
title
FROM netflix_titles
WHERE director IS NULL;

#Search Titles Containing "Love"
SELECT
title
FROM netflix_titles
WHERE title LIKE '%Love%';

#Count Movies and TV Shows
SELECT
type,
COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY type;

#Ratings Having More Than 100 Titles
SELECT
rating,
COUNT(*) AS Total
FROM netflix_titles
GROUP BY rating
HAVING COUNT(*) > 100;

#Latest 10 Released Titles
SELECT
title,
release_year
FROM netflix_titles
ORDER BY release_year DESC
LIMIT 10;

#Intermediate SQL Queries

#Categorize Content Using CASE WHEN
SELECT
    title,
    type,
    CASE
        WHEN type = 'Movie' THEN 'Film'
        WHEN type = 'TV Show' THEN 'Series'
    END AS Content_Category
FROM netflix_titles;

#Extract Movie Duration (Minutes)
SELECT
    title,
    CAST(REPLACE(duration,' min','') AS UNSIGNED) AS Duration_Minutes
FROM netflix_titles
WHERE type='Movie';

#Extract Number of Seasons
SELECT
    title,
    CAST(
        REPLACE(
            REPLACE(duration,' Seasons',''),
            ' Season',''
        ) AS UNSIGNED
    ) AS Total_Seasons
FROM netflix_titles
WHERE type='TV Show';

#Convert date_added into SQL Date
SELECT
    title,
    STR_TO_DATE(date_added,'%M %d, %Y') AS Date_Added
FROM netflix_titles;

#Extract Year Added to Netflix
SELECT
    title,
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year
FROM netflix_titles;

#Titles Added in 2020
SELECT
    title,
    date_added
FROM netflix_titles
WHERE YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) = 2020;

#Average Movie Duration
SELECT
    ROUND(
        AVG(
            CAST(REPLACE(duration,' min','') AS UNSIGNED)
        ),2
    ) AS Avg_Movie_Duration
FROM netflix_titles
WHERE type='Movie';

#Longest Movie
SELECT
    title,
    duration
FROM netflix_titles
WHERE type='Movie'
ORDER BY CAST(REPLACE(duration,' min','') AS UNSIGNED) DESC
LIMIT 1;

#Titles Released Above Overall Average Release Year
SELECT
    title,
    release_year
FROM netflix_titles
WHERE release_year >
(
    SELECT AVG(release_year)
    FROM netflix_titles
);

#Year-wise Content Distribution
SELECT
    release_year,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

#Advanced SQL Queries

#Movies Longer Than Average Movie Duration
SELECT
    title,
    duration
FROM netflix_titles
WHERE type='Movie'
AND CAST(REPLACE(duration,' min','') AS UNSIGNED) >
(
    SELECT AVG(
        CAST(REPLACE(duration,' min','') AS UNSIGNED)
    )
    FROM netflix_titles
    WHERE type='Movie'
);

#Directors Who Directed More Than 5 Titles
SELECT
    director,
    COUNT(*) AS Total_Titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 5
ORDER BY Total_Titles DESC;

#Countries Having Both Movies and TV Shows
SELECT
    country
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
HAVING COUNT(DISTINCT type)=2;

#Titles Released Before Average Release Year
SELECT
    title,
    release_year
FROM netflix_titles
WHERE release_year <
(
SELECT AVG(release_year)
FROM netflix_titles
);

#Most Common Rating
SELECT
    rating,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY Total_Content DESC
LIMIT 1;

#Year With Highest Number of Releases
SELECT
    release_year,
    COUNT(*) AS Total_Releases
FROM netflix_titles
GROUP BY release_year
ORDER BY Total_Releases DESC
LIMIT 1;

#Find Titles Added After Their Release Year
SELECT
    title,
    release_year,
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year
FROM netflix_titles
WHERE YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) >
release_year;

#Directors With Movies Only
SELECT
    director
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(DISTINCT type)=1
AND MAX(type)='Movie';

#Countries With More Than 100 Titles
SELECT
    country,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
HAVING COUNT(*)>100
ORDER BY Total_Content DESC;

#Longest Running TV Show
SELECT
    title,
    duration
FROM netflix_titles
WHERE type='TV Show'
ORDER BY
CAST(
REPLACE(
REPLACE(duration,' Seasons',''),
' Season',''
) AS UNSIGNED) DESC
LIMIT 1;


#Window Functions

#ROW_NUMBER() — Unique Row Number
SELECT
    title,
    release_year,
    ROW_NUMBER() OVER(ORDER BY release_year DESC) AS Row_Num
FROM netflix_titles;

#RANK() — Ranking with Gaps
SELECT
    title,
    release_year,
    RANK() OVER(ORDER BY release_year DESC) AS Rank_No
FROM netflix_titles;

#DENSE_RANK() — Ranking Without Gaps
SELECT
    title,
    release_year,
    DENSE_RANK() OVER(ORDER BY release_year DESC) AS release_year
FROM netflix_titles;

#ROW_NUMBER() Partition By Type
SELECT
    title,
    type,
    release_year,
    ROW_NUMBER() OVER(
        PARTITION BY type
        ORDER BY release_year DESC
    ) AS Row_Num
FROM netflix_titles;

#RANK() Partition By Rating
SELECT
    title,
    rating,
    release_year,
    RANK() OVER(
        PARTITION BY rating
        ORDER BY release_year DESC
    ) AS Rating_Rank
FROM netflix_titles;

#LAG() — Previous Release Year
SELECT
    title,
    release_year,
    LAG(release_year)
    OVER(ORDER BY release_year) AS Previous_Year
FROM netflix_titles;

#LEAD() — Next Release Year
SELECT
    title,
    release_year,
    LEAD(release_year)
    OVER(ORDER BY release_year) AS Next_Year
FROM netflix_titles;

#FIRST_VALUE() — Earliest Release
SELECT
    title,
    release_year,
    FIRST_VALUE(release_year)
    OVER(ORDER BY release_year) AS First_Release
FROM netflix_titles;

#NTILE(4) — Divide into Quartiles
SELECT
    title,
    release_year,
    NTILE(4)
    OVER(ORDER BY release_year DESC) AS Quartile
FROM netflix_titles;

#CUME_DIST() — Cumulative Distribution
SELECT
    title,
    release_year,
    CUME_DIST()
    OVER(ORDER BY release_year) AS Cumulative_Distribution
FROM netflix_titles;

#LAST_VALUE()
SELECT
    title,
    release_year,
    LAST_VALUE(release_year) OVER (
        ORDER BY release_year
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS Latest_Release
FROM netflix_titles;

#NTH_VALUE()
SELECT
    title,
    release_year,
    NTH_VALUE(release_year,3) OVER (
        ORDER BY release_year
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS Third_Oldest_Release
FROM netflix_titles;

#PERCENT_RANK()
SELECT
    title,
    release_year,
  ROUND(percent_rank()OVER(
  ORDER BY release_year
  )*100,2)AS percentage_rank
  FROM netflix_titles;
  
  #CTE (Common Table Expressions)
  
  #Basic CTE
  WITH Movie_List AS
(
    SELECT *
    FROM netflix_titles
    WHERE type='Movie'
)

SELECT *
FROM Movie_List;

#Count Movies and TV Shows
WITH Content_Count AS
(
    SELECT
        type,
        COUNT(*) AS Total_Content
    FROM netflix_titles
    GROUP BY type
)

SELECT *
FROM Content_Count;

#Movies Released After 2020
WITH Recent_Movies AS
(
    SELECT
        title,
        release_year
    FROM netflix_titles
    WHERE type='Movie'
    AND release_year>2020
)

SELECT *
FROM Recent_Movies;

#Average Movie Duration
WITH Movie_Duration AS
(
    SELECT
        CAST(REPLACE(duration,' min','') AS UNSIGNED) AS Minutes
    FROM netflix_titles
    WHERE type='Movie'
)

SELECT
ROUND(AVG(Minutes),2) AS Avg_Duration
FROM Movie_Duration;

#Above Average Release Year
WITH Avg_Year AS
(
    SELECT AVG(release_year) AS Avg_Release
    FROM netflix_titles
)

SELECT
title,
release_year
FROM netflix_titles, Avg_Year
WHERE release_year>Avg_Release;

#Multiple CTEs
WITH Movies AS
(
    SELECT COUNT(*) AS Movie_Count
    FROM netflix_titles
    WHERE type='Movie'
),

TVShows AS
(
    SELECT COUNT(*) AS TV_Count
    FROM netflix_titles
    WHERE type='TV Show'
)

SELECT *
FROM Movies, TVShows;

#Top Directors
WITH Director_Count AS
(
    SELECT
        director,
        COUNT(*) AS Total_Content
    FROM netflix_titles
    WHERE director IS NOT NULL
    GROUP BY director
)

SELECT *
FROM Director_Count
ORDER BY Total_Content DESC
LIMIT 10;

#Latest Content
WITH Latest_Content AS
(
    SELECT *
    FROM netflix_titles
    WHERE release_year=
    (
        SELECT MAX(release_year)
        FROM netflix_titles
    )
)

SELECT *
FROM Latest_Content;

#Year-wise Content
WITH Yearly_Content AS
(
    SELECT
        release_year,
        COUNT(*) AS Total_Content
    FROM netflix_titles
    GROUP BY release_year
)

SELECT *
FROM Yearly_Content
ORDER BY release_year;

#CTE + Window Function
WITH Ranked_Content AS
(
    SELECT
        title,
        release_year,
        ROW_NUMBER() OVER(
            ORDER BY release_year DESC
        ) AS Row_Num
    FROM netflix_titles
)

SELECT *
FROM Ranked_Content
WHERE Row_Num<=10;


#Ranking Analysis

#Top 10 Countries by Content
SELECT
    country,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY Total_Content DESC
LIMIT 10;

#Top 10 Directors
SELECT
    director,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY Total_Content DESC
LIMIT 10;

#Top 10 Ratings
SELECT
    rating,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY Total_Content DESC
LIMIT 10;

#Top 10 Movie Durations
SELECT
    title,
    CAST(REPLACE(duration,' min','') AS UNSIGNED) AS Duration_Minutes
FROM netflix_titles
WHERE type='Movie'
ORDER BY Duration_Minutes DESC
LIMIT 10;

#Top 10 TV Shows by Seasons
SELECT
    title,
    CAST(
        REPLACE(
            REPLACE(duration,' Seasons',''),
            ' Season',''
        ) AS UNSIGNED
    ) AS Total_Seasons
FROM netflix_titles
WHERE type='TV Show'
ORDER BY Total_Seasons DESC
LIMIT 10;

#Top 10 Recently Released Titles
SELECT
    title,
    release_year
FROM netflix_titles
ORDER BY release_year DESC
LIMIT 10;

#Top 10 Oldest Titles
SELECT
    title,
    release_year
FROM netflix_titles
ORDER BY release_year
LIMIT 10;

#Top 10 Countries with Movies Only
SELECT
    country,
    COUNT(*) AS Total_Movies
FROM netflix_titles
WHERE type='Movie'
AND country IS NOT NULL
GROUP BY country
ORDER BY Total_Movies DESC
LIMIT 10;

#Top 10 Countries with TV Shows Only
SELECT
    country,
    COUNT(*) AS Total_TV_Shows
FROM netflix_titles
WHERE type='TV Show'
AND country IS NOT NULL
GROUP BY country
ORDER BY Total_TV_Shows DESC
LIMIT 10;


#Time Series Analysis

#Content Added Per Year
SELECT
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(date_added,'%M %d, %Y'))
ORDER BY Added_Year;

#Content Added Per Month
SELECT
    MONTHNAME(STR_TO_DATE(date_added,'%M %d, %Y')) AS Month_Name,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY MONTH(STR_TO_DATE(date_added,'%M %d, %Y')),
         MONTHNAME(STR_TO_DATE(date_added,'%M %d, %Y'))
ORDER BY MONTH(STR_TO_DATE(date_added,'%M %d, %Y'));

#Year-wise Movies vs TV Shows
SELECT
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year,
    type,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY Added_Year, type
ORDER BY Added_Year;

#Latest 5 Years Content Growth
SELECT
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY Added_Year
ORDER BY Added_Year DESC
LIMIT 5;

#Releases by Original Release Year
SELECT
    release_year,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

#Average Gap Between Release and Netflix Addition
SELECT
    ROUND(
        AVG(
            YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) - release_year
        ),
        2
    ) AS Avg_Years_To_Arrive
FROM netflix_titles
WHERE date_added IS NOT NULL;

#Titles Added in the Same Year They Were Released
SELECT
    COUNT(*) AS Same_Year_Content
FROM netflix_titles
WHERE YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) = release_year;

#Oldest Content Added to Netflix
SELECT
    title,
    release_year,
    date_added
FROM netflix_titles
ORDER BY release_year
LIMIT 10;

#Newest Content Added to Netflix
SELECT
    title,
    release_year,
    date_added
FROM netflix_titles
ORDER BY release_year DESC
LIMIT 10;

#Year with Maximum Content Added
SELECT
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY Added_Year
ORDER BY Total_Content DESC
LIMIT 1;

#Content Segmentation Analysis

#Segment by Content Type
SELECT
    type,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY type;

#Segment Movies by Duration
SELECT
    CASE
        WHEN CAST(REPLACE(duration,' min','') AS UNSIGNED) < 60 THEN 'Short Movie'
        WHEN CAST(REPLACE(duration,' min','') AS UNSIGNED) BETWEEN 60 AND 120 THEN 'Medium Movie'
        ELSE 'Long Movie'
    END AS Movie_Segment,
    COUNT(*) AS Total_Movies
FROM netflix_titles
WHERE type='Movie'
GROUP BY Movie_Segment;

#Segment TV Shows by Seasons
SELECT
    CASE
        WHEN CAST(REPLACE(REPLACE(duration,' Seasons',''),' Season','') AS UNSIGNED)=1
            THEN 'Mini Series'
        WHEN CAST(REPLACE(REPLACE(duration,' Seasons',''),' Season','') AS UNSIGNED) BETWEEN 2 AND 4
            THEN 'Regular Series'
        ELSE 'Long Running Series'
    END AS TV_Show_Segment,
    COUNT(*) AS Total_TV_Shows
FROM netflix_titles
WHERE type='TV Show'
GROUP BY TV_Show_Segment;

#Segment by Content Age
SELECT
    CASE
        WHEN release_year>=2020 THEN 'Recent'
        WHEN release_year BETWEEN 2010 AND 2019 THEN 'Modern'
        ELSE 'Classic'
    END AS Content_Age,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY Content_Age;

#Segment by Audience Rating
SELECT
    rating,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY Total_Content DESC;

#Segment by Decade
SELECT
    CONCAT(FLOOR(release_year/10)*10,'s') AS Decade,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY Decade
ORDER BY Decade;

#Segment by Year Added to Netflix
SELECT
    YEAR(STR_TO_DATE(date_added,'%M %d, %Y')) AS Added_Year,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY Added_Year
ORDER BY Added_Year;

#Segment by Country Availability
SELECT
    CASE
        WHEN country IS NULL THEN 'Unknown'
        ELSE 'Country Available'
    END AS Country_Status,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY Country_Status;

#Segment by Director Availability
SELECT
    CASE
        WHEN director IS NULL THEN 'Director Missing'
        ELSE 'Director Available'
    END AS Director_Status,
    COUNT(*) AS Total_Content
FROM netflix_titles
GROUP BY Director_Status;

#Segment by Netflix Addition Delay
SELECT
    CASE
        WHEN YEAR(STR_TO_DATE(date_added,'%M %d, %Y'))-release_year<=1
            THEN 'Added Within 1 Year'
        WHEN YEAR(STR_TO_DATE(date_added,'%M %d, %Y'))-release_year<=5
            THEN 'Added Within 5 Years'
        ELSE 'Added After 5+ Years'
    END AS Addition_Delay,
    COUNT(*) AS Total_Content
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY Addition_Delay;

