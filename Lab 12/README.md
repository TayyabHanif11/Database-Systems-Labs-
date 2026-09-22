# 📊 Database Systems - Lab 12: Aggregate Functions, GROUP BY & HAVING

**Lab Task 12** of the **Database Systems (CS-2204)** 
**Name:** Tayyab Hanif 
**Roll no:** 2024-SE-11 

---

## 📌 Objectives
- Master the 5 core aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`[cite: 2].
- Implement categorical data grouping using `GROUP BY` and group-level filtering using `HAVING`[cite: 2].
- Combine aggregate queries with `INNER JOIN` and `LEFT JOIN` to analyze complex relational datasets[cite: 2].
- Resolve real-world reporting tasks across both Retail Store and University database domain schemas[cite: 2].

---

## 🛠️ Key Topics Covered
1. **Whole-Table Aggregates:** Summarizing metrics across full tables (`COUNT(*)`, `COUNT(col)`, `COUNT(DISTINCT)`)[cite: 2].
2. **Categorical Analysis (`GROUP BY`):** Grouping datasets to compute per-category totals, averages, and extremes[cite: 2].
3. **Filtered Aggregations (`HAVING` vs `WHERE`):** Distinguishing row-level pre-filtering from group-level post-filtering[cite: 2].
4. **Relational Aggregations with Joins:** Computing lifetime spend, revenue per department, and zero-activity entity preservation using `LEFT JOIN`[cite: 2].

---

## 🚀 Execution Instructions

1. Open **MySQL Workbench** or MySQL Command Line Client[cite: 2].
2. Execute the script [`2024-SE-11_Aggregates.sql`](./2024-SE-11_Aggregates.sql).
3. The script automatically sets up two databases:
   - `agg_lab` (Retail Store Schema)[cite: 2]
   - `uni_lab` (University Database Assessment Schema)[cite: 2]

---
