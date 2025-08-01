# 🎬 MovieLens Analytics with HiveQL  
**Scalable Movie & User Behavior Analysis using Apache Hive and Big Data Concepts**

---

## 🧠 Overview

As part of my hands-on learning in Big Data & MLOps, I built this project to simulate how streaming platforms like Netflix might analyze movies, genres, and user behavior at scale. Using Apache Hive, I created a structured analytics pipeline from raw MovieLens data — performing everything from schema design to partitioning and performance tuning.

This wasn’t just about running SQL — it was about building a scalable analytics process and understanding how data engineers turn large datasets into useful insights.

---

## 📊 Dataset: MovieLens 100K

Source: [MovieLens 100K](https://grouplens.org/datasets/movielens/100k/)

- 🎬 100,000 ratings  
- 👤 943 users  
- 🎞️ 1,682 movies  
- 💾 5 structured CSVs: `u.data`, `u.item`, `u.user`, `u.genre`, `u.occupation`

Ideal for Hive-based modeling and analytics due to its real-world schema and variety of joinable dimensions.

---

## ⚙️ Technologies & Concepts Used

| Tool / Concept     | Purpose                                          |
|--------------------|--------------------------------------------------|
| **Apache Hive**     | DDL/DML and analytical queries                   |
| **ORC Format**      | Optimized table storage                          |
| **External Tables** | Maintain separation of storage and compute      |
| **Partitioning**    | Filter-level optimization (by year & month)     |
| **Bucketing**       | Faster joins & filtering (by user_id)           |
| **HiveQL**          | Joins, groupings, aggregations, subqueries      |

---

## 🛠️ Key Tasks Completed

### 1. 🏗️ Schema Creation (DDL)
- Defined external Hive tables for:
  - `movies`, `ratings`, `users`, `genres`, `occupations`
- Used **ORC format** for compression and performance

### 2. ✍️ Data Manipulation (DML)
- Inserted and updated movie ratings
- Deleted poor-quality ratings (less than 2 stars)

### 3. 📈 Analytics & Aggregations
- Top-rated movies (min 50 reviews)
- Genre-wise average scores and popularity
- Most active users and occupation-based rating behavior
- Temporal rating trends (monthly patterns)

### 4. 🚀 Optimization
- Partitioned ratings table by `year-month`
- Bucketed users table by `user_id` into 10 buckets
- Compared performance with and without optimization

---

## 🔍 Sample Insights

- 🎬 **Film-Noir** and **Documentary** genres had the highest average ratings  
- 👥 **Executives** and **students** were the most active reviewers  
- 🕒 Ratings showed **seasonal trends**, spiking during holidays  
- ⏱️ Partitioned queries showed **~28% faster** execution in time-based filters  
- 📉 Bucketing improved join performance on user_id significantly

---

## 🗂️ Project Structure

```
scripts/
└── movielens_analysis.sql # Full HiveQL script: DDL, DML, queries, optimization

report/
└── analysis_findings.md # Summary of insights and learnings from the assignment

screenshots/
├── movie_genre_analysis/
├── user_behaviour_analysis/
├── temporal_trends/
└── query_performance_comparision/

README.md # Project overview and technical summary

```
---

## 💬 Why This Project Matters

This assignment helped me build foundational skills in:
- Structuring multi-table datasets for analytical workflows
- Writing efficient, real-world HiveQL
- Optimizing performance using **partitioning and bucketing**
- Thinking like a **data engineer** supporting product analysts

Even with a small dataset like MovieLens 100K, I gained valuable experience in scaling SQL thinking to big data systems.

---

## 👩‍💻 Author

**Nandini Priya Devalla**  
Graduate Student – Business Analytics, Purdue University  
[LinkedIn](https://www.linkedin.com/in/nandini-devalla)

