# Database Systems - Lab 6: SQL Filters (Comparison & Logical Operators)

**Lab Task 6** of the **Database Systems**. 
**Name:** Tayyab Hanif. 
**Roll No:** 2024-SE-11

---

## 📌 Objectives
- Filter database records using the `WHERE` clause with standard comparison operators (`=`, `!=`, `<`, `>`, `<=`, `>=`).
- Combine complex search conditions using logical operators (`AND`, `OR`, `NOT`) while maintaining proper operator precedence.
- Apply inclusive numerical and date range checks with `BETWEEN ... AND ...`
- Match membership lists cleanly using `IN (...)` and `NOT IN (...)`.
- Execute string pattern matching with wildcards (`%` and `_`) via the `LIKE` operator.
- Correctly handle missing values using `IS NULL` and `IS NOT NULL` to avoid three-valued logic traps.
- Sort result sets single- and multi-column wise using `ORDER BY` and restrict output volumes with `LIMIT`.

---

## 🛠️ Key Topics Covered
1. **WHERE Clause & Logical Operators:** Operator precedence rules (`NOT` > `AND` > `OR`) and explicit parenthesizing.
2. **Range & List Membership:** Efficient querying with `BETWEEN` and `IN`.
3. **Pattern Matching (`LIKE`):** Matching start, end, sub-strings, and exact character counts.
4. **Three-Valued Logic (`NULL` Handling):** Understanding why `= NULL` or `!= 'City'` fails on `NULL` values and applying `IS NULL`.
5. **Execution Order:** How MySQL evaluates `FROM` ➔ `WHERE` ➔ `SELECT` ➔ `ORDER BY` ➔ `LIMIT`.

---

## 🚀 Execution Instructions

1. Open **MySQL Workbench** or the **MySQL Command Line Client**[cite: 3].
2. Run the provided SQL script.
3. The script initializes two distinct databases:
   - `filters_lab` (Employee Database for Parts A & B)[cite: 3]
   - `bookstore_lab` (Online Bookstore Database for Assessment)[cite: 3]

---
