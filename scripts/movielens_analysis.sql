CREATE EXTERNAL TABLE IF NOT EXISTS movielens.users (
    user_id INT,
    age INT,
    gender STRING,
    occupation STRING,
    zip_code STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/hive/warehouse/movielens/users';


CREATE EXTERNAL TABLE IF NOT EXISTS movielens.movies (
    movie_id INT,
    title STRING,
    release_date STRING,
    video_release_date STRING,
    imdb_url STRING,
    unknown INT,
    action INT,
    adventure INT,
    animation INT,
    children INT,
    comedy INT,
    crime INT,
    documentary INT,
    drama INT,
    fantasy INT,
    film_noir INT,
    horror INT,
    musical INT,
    mystery INT,
    romance INT,
    sci_fi INT,
    thriller INT,
    war INT,
    western INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/hive/warehouse/movielens/movies';


CREATE EXTERNAL TABLE IF NOT EXISTS movielens.genres (
    genre_name STRING,
    genre_id INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/hive/warehouse/movielens/genres';


CREATE EXTERNAL TABLE IF NOT EXISTS movielens.occupations (
    occupation STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/hive/warehouse/movielens/occupations';


CREATE TABLE movielens.ratings_orc (
    user_id INT,
    movie_id INT,
    rating INT,
    timestamp STRING
)
STORED AS ORC;

INSERT INTO TABLE movielens.ratings_orc
SELECT * FROM movielens.ratings;


CREATE TABLE movielens.movies_orc (
    movie_id INT,
    title STRING,
    release_date STRING,
    video_release_date STRING,
    imdb_url STRING,
    unknown INT,
    action INT,
    adventure INT,
    animation INT,
    children INT,
    comedy INT,
    crime INT,
    documentary INT,
    drama INT,
    fantasy INT,
    film_noir INT,
    horror INT,
    musical INT,
    mystery INT,
    romance INT,
    sci_fi INT,
    thriller INT,
    war INT,
    western INT
)
STORED AS ORC;

INSERT INTO TABLE movielens.movies_orc
SELECT * FROM movielens.movies;


CREATE TABLE movielens.users_orc (
    user_id INT,
    age INT,
    gender STRING,
    occupation STRING,
    zip_code STRING
)
STORED AS ORC;

INSERT INTO TABLE movielens.users_orc
SELECT * FROM movielens.users;


CREATE TABLE movielens.genres_orc (
    genre_name STRING,
    genre_id INT
)
STORED AS ORC;

INSERT INTO TABLE movielens.genres_orc
SELECT * FROM movielens.genres;


CREATE TABLE movielens.occupations_orc (
    occupation STRING
)
STORED AS ORC;

INSERT INTO TABLE movielens.occupations_orc
SELECT * FROM movielens.occupations;


INSERT INTO movielens.ratings_orc VALUES (999, 100, 5, '1707500000');

INSERT OVERWRITE TABLE movielens.ratings_orc
SELECT 
    CASE 
        WHEN user_id = 999 AND movie_id = 100 THEN 4  -- Change rating from 5 → 4
        ELSE rating
    END AS rating,
    user_id, movie_id, timestamp
FROM movielens.ratings_orc;


INSERT OVERWRITE TABLE movielens.ratings_orc
SELECT * FROM movielens.ratings_orc WHERE rating >= 2;


SELECT m.title, 
       COUNT(r.rating) AS review_count, 
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM movielens.ratings_orc r
JOIN movielens.movies_orc m 
    ON r.movie_id = m.movie_id
GROUP BY m.title
HAVING COUNT(r.rating) >= 50
ORDER BY avg_rating DESC, review_count DESC
LIMIT 5;


SELECT g.genre_name, COUNT(*) AS total_ratings
FROM movielens.ratings_orc r
JOIN movielens.movies_orc m ON r.movie_id = m.movie_id
JOIN movielens.genres_orc g ON g.genre_id = 
    CASE 
        WHEN m.unknown = 1 THEN 0
        WHEN m.action = 1 THEN 1
        WHEN m.adventure = 1 THEN 2
        WHEN m.animation = 1 THEN 3
        WHEN m.children = 1 THEN 4
        WHEN m.comedy = 1 THEN 5
        WHEN m.crime = 1 THEN 6
        WHEN m.documentary = 1 THEN 7
        WHEN m.drama = 1 THEN 8
        WHEN m.fantasy = 1 THEN 9
        WHEN m.film_noir = 1 THEN 10
        WHEN m.horror = 1 THEN 11
        WHEN m.musical = 1 THEN 12
        WHEN m.mystery = 1 THEN 13
        WHEN m.romance = 1 THEN 14
        WHEN m.sci_fi = 1 THEN 15
        WHEN m.thriller = 1 THEN 16
        WHEN m.war = 1 THEN 17
        WHEN m.western = 1 THEN 18
    END
WHERE g.genre_id IS NOT NULL
GROUP BY g.genre_name
ORDER BY total_ratings DESC;

SELECT g.genre_name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM movielens.ratings_orc r
JOIN movielens.movies_orc m ON r.movie_id = m.movie_id
JOIN movielens.genres_orc g ON g.genre_id = 
    CASE 
        WHEN m.unknown = 1 THEN 0
        WHEN m.action = 1 THEN 1
        WHEN m.adventure = 1 THEN 2
        WHEN m.animation = 1 THEN 3
        WHEN m.children = 1 THEN 4
        WHEN m.comedy = 1 THEN 5
        WHEN m.crime = 1 THEN 6
        WHEN m.documentary = 1 THEN 7
        WHEN m.drama = 1 THEN 8
        WHEN m.fantasy = 1 THEN 9
        WHEN m.film_noir = 1 THEN 10
        WHEN m.horror = 1 THEN 11
        WHEN m.musical = 1 THEN 12
        WHEN m.mystery = 1 THEN 13
        WHEN m.romance = 1 THEN 14
        WHEN m.sci_fi = 1 THEN 15
        WHEN m.thriller = 1 THEN 16
        WHEN m.war = 1 THEN 17
        WHEN m.western = 1 THEN 18
    END
GROUP BY g.genre_name
ORDER BY avg_rating DESC;


SELECT user_id, COUNT(rating) AS total_ratings
FROM movielens.ratings_orc
GROUP BY user_id
ORDER BY total_ratings DESC
LIMIT 5;

SELECT u.age, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(r.rating) AS total_ratings
FROM movielens.ratings_orc r
JOIN movielens.users_orc u ON r.user_id = u.user_id
GROUP BY u.age
ORDER BY u.age ASC;

SELECT u.occupation, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(r.rating) AS total_ratings
FROM movielens.ratings_orc r
JOIN movielens.users_orc u ON r.user_id = u.user_id
GROUP BY u.occupation
ORDER BY avg_rating DESC;

SELECT YEAR(FROM_UNIXTIME(UNIX_TIMESTAMP(m.release_date, 'dd-MMM-yyyy'))) AS release_year, 
       m.title, 
       ROUND(AVG(r.rating), 2) AS avg_rating, 
       COUNT(r.rating) AS total_ratings
FROM movielens.ratings_orc r
JOIN movielens.movies_orc m ON r.movie_id = m.movie_id
WHERE m.release_date IS NOT NULL
GROUP BY YEAR(FROM_UNIXTIME(UNIX_TIMESTAMP(m.release_date, 'dd-MMM-yyyy'))), m.title
HAVING COUNT(r.rating) >= 50  -- Ensures at least 50 ratings for reliability
ORDER BY release_year ASC, avg_rating DESC;

SELECT MONTH(FROM_UNIXTIME(CAST(r.timestamp AS BIGINT))) AS month,
       ROUND(AVG(r.rating), 2) AS avg_rating,
       COUNT(r.rating) AS total_ratings
FROM movielens.ratings_orc r
GROUP BY MONTH(FROM_UNIXTIME(CAST(r.timestamp AS BIGINT)))
ORDER BY month ASC;


SELECT YEAR(FROM_UNIXTIME(CAST(r.timestamp AS BIGINT))) AS rating_year,
       ROUND(AVG(r.rating), 2) AS avg_rating,
       COUNT(r.rating) AS total_ratings
FROM movielens.ratings_orc r
GROUP BY YEAR(FROM_UNIXTIME(CAST(r.timestamp AS BIGINT)))
ORDER BY rating_year ASC;


SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;


CREATE TABLE movielens.ratings_partitioned (
    user_id INT,
    movie_id INT,
    rating INT,
    timestamp STRING
)
PARTITIONED BY (year INT, month INT)
STORED AS ORC;


INSERT INTO movielens.ratings_partitioned
PARTITION (year, month)
SELECT user_id, movie_id, rating, timestamp,
       YEAR(FROM_UNIXTIME(CAST(timestamp AS BIGINT))) AS year,
       MONTH(FROM_UNIXTIME(CAST(timestamp AS BIGINT))) AS month
FROM movielens.ratings_orc;



CREATE TABLE movielens.users_bucketed (
    user_id INT,
    age INT,
    gender STRING,
    occupation STRING,
    zip_code STRING
)
CLUSTERED BY (user_id) INTO 10 BUCKETS
STORED AS ORC;

INSERT INTO movielens.users_bucketed
SELECT * FROM movielens.users_orc;


SET hive.execution.engine=mr;
SET hive.mapred.mode=STRICT;
SELECT COUNT(*) FROM movielens.ratings_orc WHERE YEAR(FROM_UNIXTIME(CAST(timestamp AS BIGINT))) = 1997;


SET hive.execution.engine=mr;
SET hive.mapred.mode=STRICT;
SELECT COUNT(*) FROM movielens.ratings_partitioned WHERE year = 1997;


SET hive.execution.engine=mr;
SET hive.mapred.mode=STRICT;
SELECT COUNT(*) FROM movielens.users_orc WHERE user_id = 500;


SET hive.execution.engine=mr;
SET hive.mapred.mode=STRICT;
SELECT COUNT(*) FROM movielens.users_bucketed WHERE user_id = 500;










