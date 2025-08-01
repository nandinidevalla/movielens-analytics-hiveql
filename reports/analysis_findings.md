# 📝 Analysis Findings: MovieLens HiveQL Analytics

This document summarizes the key insights and performance benchmarks from analyzing the [MovieLens 100K dataset](https://grouplens.org/datasets/movielens/100k/) using Apache Hive. The goal was to simulate real-world big data workflows: managing data in Hive, writing analytical queries, and evaluating query performance through partitioning and bucketing.

---

## 🎬 Movie & Genre Insights

### Top 5 Highest-Rated Movies (min 50 reviews)
- Animated and critically acclaimed films (e.g. Schindler’s List) scored the highest.
- Films like *Wallace & Gromit* showed niche but high-quality appeal.
- High-rated movies don't always correlate with highest viewership.

📷 [screenshots/movie_genre_analysis/1_movie_genre_insights.png](../screenshots/movie_genre_analysis/1_movie_genre_insights.png)

---

### Most Popular Genres by Ratings Count
- Drama, Comedy, and Action received the highest engagement.
- Adventure and Animation appealed more to younger/family audiences.
- War and Western genres had lower engagement — suggesting selective recommendation.

📷 [screenshots/movie_genre_analysis/2_movie_genre_insights.png](../screenshots/movie_genre_analysis/2_movie_genre_insights.png)

---

### Average Rating per Genre
- Top-scoring genres: **Film-Noir**, **Documentary**, and **Crime**
- Drama is widely viewed but should be recommended more selectively.
- Children’s and Horror genres need audience targeting due to polarized ratings.

📷 [screenshots/movie_genre_analysis/3_movie_genre_insights.png](../screenshots/movie_genre_analysis/3_movie_genre_insights.png)

---

## 👥 User Behavior Insights

### Most Active Users
- Top 5 users contributed disproportionately high number of ratings.
- Their preferences should be weighted heavily in collaborative filtering models.

### Ratings by Occupation
- **Executives, Lawyers, Artists** gave the most generous ratings.
- **Programmers and Engineers** showed preference for Sci-Fi and logic-driven genres.
- **Homemakers and Retired** users gave lower ratings, suggesting different taste calibration.

📷 [screenshots/user_behaviour_analysis/1_user_behaviour_analysis.png](../screenshots/user_behaviour_analysis/1_user_behaviour_analysis.png)  
📷 [screenshots/user_behaviour_analysis/2_user_behaviour_analysis.png](../screenshots/user_behaviour_analysis/2_user_behaviour_analysis.png)

---

### Ratings by Age Group
- Users aged **18–24** rated the most movies but gave lower scores.
- **35–50** age group gave the highest average ratings.
- Younger age groups (7–14) tended to rate very positively.

📷 [screenshots/user_behaviour_analysis/3_user_behaviour_analysis.png](../screenshots/user_behaviour_analysis/3_user_behaviour_analysis.png)

---

## 📅 Temporal & Seasonal Trends

### Seasonal Trends in Ratings
- Ratings peaked around:
  - **Valentine’s Day (Feb)**, **Halloween (Oct)**, and **Holidays (Dec)**
- **January** showed a dip — ideal for pushing new content.

📷 [screenshots/temporal_trends/1_temporal_trends.png](../screenshots/temporal_trends/1_temporal_trends.png)

---

### Year-wise Movie Ratings
- Classics like *Casablanca*, *Citizen Kane*, and *The Maltese Falcon* received consistently high ratings.
- Disney and animated films remained strong across years.

📷 [screenshots/temporal_trends/2_temporal_trends.png](../screenshots/temporal_trends/2_temporal_trends.png)  
📷 [screenshots/temporal_trends/3_temporal_trends.png](../screenshots/temporal_trends/3_temporal_trends.png)

---

## ⚙️ Performance Benchmarking

### Partitioned vs Non-Partitioned Queries
- **Partitioned queries** (by year/month) showed **~28% speed improvement**.
- Non-partitioned tables scanned the full dataset, increasing latency.

📷 [screenshots/query_performance_comparision/partitioned.png](../screenshots/query_performance_comparision/partitioned.png)  
📷 [screenshots/query_performance_comparision/non_partitioned.png](../screenshots/query_performance_comparision/non_partitioned.png)

---

### Bucketed vs Non-Bucketed Tables
- Surprisingly, bucketed tables were slower for simple WHERE queries.
- Reason:
  - Hive scanned all buckets instead of targeting specific ones.
  - Bucketing is more effective for **joins**, not single-record lookups.
  - Performance improves with `TABLESAMPLE` and sorted inserts.

📷 [screenshots/query_performance_comparision/bucketed.png](../screenshots/query_performance_comparision/bucketed.png)  
📷 [screenshots/query_performance_comparision/non_bucketed.png](../screenshots/query_performance_comparision/non_bucketed.png)

---

## ✅ Final Takeaways

- Hive is effective for structuring and querying large datasets using SQL-like syntax.
- Partitioning improves performance on time-based filtering.
- Bucketing is beneficial in join-heavy workloads but needs careful configuration.
- The MovieLens dataset offers rich insight into genre trends, user habits, and rating patterns — making it a great testbed for recommender system design.

---

## 👩‍💻 Author

**Nandini Priya Devalla**  
Graduate Student – Business Analytics, Purdue University  
[LinkedIn](https://www.linkedin.com/in/nandini-devalla)
