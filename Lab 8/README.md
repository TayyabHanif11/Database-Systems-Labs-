# Database Systems Lab 8: SQL Joins (Part 1 — INNER, LEFT, RIGHT, and FULL OUTER Joins)

## 1. Overview & Learning Objectives

This lab focuses on combining datasets across relational tables using explicit ANSI SQL join syntax.

### Key Objectives
* Master table relational navigation using Primary Key (PK) and Foreign Key (FK) constraints.
* Differentiate operational behavior between `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `SELF JOIN`.
* Implement the **Anti-Join Pattern** (`LEFT JOIN ... WHERE right_key IS NULL`) to identify unlinked data records.
* Emulate `FULL OUTER JOIN` functionality in MySQL using `LEFT JOIN`, `RIGHT JOIN`, and the `UNION` operator.
* Prevent **Cartesian Products** by properly scoping join matching predicates.

---

## 2. Theoretical Background & Join Rules

### 2.1 The Cartesian Product Problem
Omitting explicit join predicates creates an unconstrained cross product ($A \times B$).
* **Formula:** $\text{Total Rows} = \vert{}A\vert{} \times \vert{}B\vert{}$
* **Prevention:** Always enforce `$FK = PK$` inside the `ON` clause.

### 2.2 Summary of Relational Joins

| Join Type | Result Criteria | Unmatched Records |
| :--- | :--- | :--- |
| **`INNER JOIN`** | Row exists in **both** tables matching `ON` predicate. | Excluded from output |
| **`LEFT JOIN`** | All rows from Left table + matching Right table rows. | Unmatched Right columns set to `NULL` |
| **`RIGHT JOIN`**| All rows from Right table + matching Left table rows. | Unmatched Left columns set to `NULL` |
| **`FULL OUTER JOIN`** | All records from both tables. | Unmatched side populated with `NULL` |
| **`SELF JOIN`** | Table joined to an instance of itself (e.g., hierarchy). | Handled via unique table aliases |

---

## 3. Key Implementation Strategies

### 3.1 The Anti-Join Pattern
Isolates records in Table A that lack any matching record in Table B.
```sql
SELECT e.EmpID, e.EmpName
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
WHERE a.EmpID IS NULL;