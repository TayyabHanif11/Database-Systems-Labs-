# 🔍 Database Systems - Lab 6: SQL Filters (Comparison & Logical Operators)

Welcome to the repository for **Lab Task 6** of the **Database Systems** course at **The University of Azad Jammu & Kashmir**.

---

## 📌 Objectives
- Filter database records using the `WHERE` clause with standard comparison operators (`=`, `!=`, `<`, `>`, `<=`, `>=`)[cite: 3].
- Combine complex search conditions using logical operators (`AND`, `OR`, `NOT`) while maintaining proper operator precedence[cite: 3].
- Apply inclusive numerical and date range checks with `BETWEEN ... AND ...`[cite: 3].
- Match membership lists cleanly using `IN (...)` and `NOT IN (...)`[cite: 3].
- Execute string pattern matching with wildcards (`%` and `_`) via the `LIKE` operator[cite: 3].
- Correctly handle missing values using `IS NULL` and `IS NOT NULL` to avoid three-valued logic traps[cite: 3].
- Sort result sets single- and multi-column wise using `ORDER BY` and restrict output volumes with `LIMIT`[cite: 3].

---

## 🛠️ Key Topics Covered
1. **WHERE Clause & Logical Operators:** Operator precedence rules (`NOT` > `AND` > `OR`) and explicit parenthesizing[cite: 3].
2. **Range & List Membership:** Efficient querying with `BETWEEN` and `IN`[cite: 3].
3. **Pattern Matching (`LIKE`):** Matching start, end, sub-strings, and exact character counts[cite: 3].
4. **Three-Valued Logic (`NULL` Handling):** Understanding why `= NULL` or `!= 'City'` fails on `NULL` values and applying `IS NULL`[cite: 3].
5. **Execution Order:** How MySQL evaluates `FROM` ➔ `WHERE` ➔ `SELECT` ➔ `ORDER BY` ➔ `LIMIT`[cite: 3].

---

## 🚀 Execution Instructions

1. Open **MySQL Workbench** or the **MySQL Command Line Client**[cite: 3].
2. Run the provided script [`2024-SE-11_Filters.sql`](./2024-SE-11_Filters.sql).
3. The script initializes two distinct databases:
   - `filters_lab` (Employee Database for Parts A & B)[cite: 3]
   - `bookstore_lab` (Online Bookstore Database for Assessment)[cite: 3]

---

## 👤 Author Information

- **Name:** Tayyab Hanif Awan
- **Roll No:** 2024-SE-11
- **Session:** 2024–2028
- **Department:** Software Engineering, The University of Azad Jammu & Kashmir