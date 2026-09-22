# 🗄️ Database Systems - Lab 7: Advanced SQL Filtering & Data Presentation

---

## 🎯 Lab Objectives
- Query continuous numerical and temporal ranges using `BETWEEN ... AND ...` and `NOT BETWEEN`.
- Filter discrete item lists cleanly using `IN (...)` and `NOT IN (...)` operators.
- Execute string pattern matching using `LIKE` with `%` (zero or more characters) and `_` (single character) wildcards.
- Correctly handle missing/unknown data using Three-Valued Logic (`IS NULL` and `IS NOT NULL`).
- Sort single- and multi-column result sets in ascending/descending order using `ORDER BY`.
- Restrict result set size for top/bottom reporting using the `LIMIT` clause.

---

## 📖 Key Concepts & Syntax Notes

### 1. Range Filtering (`BETWEEN`)
`BETWEEN low AND high` is **inclusive** on both boundaries.
- **Salary Check:** `WHERE Salary BETWEEN 75000 AND 100000` includes both `75000.00` and `100000.00`.
- **Date Check:** `WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31'` evaluates full ISO-8601 date ranges.

### 2. List Membership (`IN` / `NOT IN`)
Replaces multiple chained `OR` conditions for cleaner syntax and engine optimization.
- `WHERE City IN ('Lahore', 'Islamabad')` is equivalent to `City = 'Lahore' OR City = 'Islamabad'`.

### 3. Pattern Matching (`LIKE`)
- `%` matches any string of zero or more characters.
- `_` matches exactly one character.
- By default in MySQL, `LIKE` is case-insensitive (e.g., `LIKE '%the%'` matches `The`, `THE`, or `the`).

### 4. Handling Missing Data (`NULL`)
In SQL, `NULL` represents an unknown or unassigned value. Standard comparison operators (`=`, `!=`) return `UNKNOWN` when compared against `NULL`.
- Correct syntax to find missing records: `WHERE City IS NULL`
- Correct syntax to exclude missing records: `WHERE City IS NOT NULL`

### 5. Sorting & Limiting (`ORDER BY` + `LIMIT`)
- SQL processes `ORDER BY` and `LIMIT` after the `WHERE` clause filters the rows.
- Multi-column sorting evaluates primary order first, then secondary order for ties (e.g., `ORDER BY DeptName ASC, HireDate ASC`).

---

## 🛠️ Execution Instructions

1. Launch **MySQL Workbench** or **MySQL Command Line Client**.
2. Run the script.
3. The script automatically creates and populates two separate database environments:
   - `lab7_company` — Used for Lab 7 Practice Tasks (B1 to B15).
   - `lab7_bookstore` — Used for Assessment Questions (Q1 to Q10).

---
