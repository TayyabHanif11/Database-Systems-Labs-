# Database Systems Lab 8: SQL Joins (Part 1 — INNER, LEFT, RIGHT, and FULL OUTER Joins)

## 1. Overview & Learning Objectives

This lab focuses on combining datasets across relational tables using explicit ANSI SQL join syntax, using a Company database (`Department`, `Employee`, `Project`, `Assignment`).

### Key Objectives
* Master table relational navigation using Primary Key (PK) and Foreign Key (FK) constraints.
* Differentiate operational behavior between `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`.
* Implement the **Anti-Join Pattern** (`LEFT JOIN ... WHERE right_key IS NULL`) to identify unlinked data records.
* Emulate `FULL OUTER JOIN` functionality in MySQL using `LEFT JOIN`, `RIGHT JOIN`, and the `UNION` operator.
* Prevent **Cartesian Products** by properly scoping join matching predicates.

---

## 2. Theoretical Background & Join Rules

### 2.1 The Cartesian Product Problem
Omitting explicit join predicates creates an unconstrained cross product: every row in Table A is paired with every row in Table B, giving `Total Rows = |A| × |B|`.
* **Prevention:** Always enforce `FK = PK` inside the `ON` clause.

### 2.2 Summary of Relational Joins

| Join Type | Result Criteria | Unmatched Records |
| :--- | :--- | :--- |
| **`INNER JOIN`** | Row exists in **both** tables matching the `ON` predicate. | Excluded from output |
| **`LEFT JOIN`** | All rows from the left table + matching right table rows. | Unmatched right columns set to `NULL` |
| **`RIGHT JOIN`** | All rows from the right table + matching left table rows. | Unmatched left columns set to `NULL` |
| **`FULL OUTER JOIN`** | All records from both tables. | Unmatched side populated with `NULL` |

---

## 3. Key Implementation Strategies

### 3.1 The Anti-Join Pattern
Isolates records in Table A that lack any matching record in Table B — used here to find "benched" employees with no project assignment, and "dormant" projects with no staff assigned.
```sql
SELECT e.EmpName
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
WHERE a.ProjectID IS NULL;
```

### 3.2 Emulating FULL OUTER JOIN
MySQL has no native `FULL OUTER JOIN`, so it is built from a `LEFT JOIN` and a `RIGHT JOIN` combined with `UNION` (which also removes duplicate rows):
```sql
SELECT e.EmpName, d.DeptName
FROM Employee e
LEFT JOIN Department d ON e.DeptID = d.DeptID
UNION
SELECT e.EmpName, d.DeptName
FROM Employee e
RIGHT JOIN Department d ON e.DeptID = d.DeptID;
```

---

## 4. Database Structure

| Table | Purpose |
|---|---|
| `Department` | Department name, location, and budget |
| `Employee` | Employee details, including a self-referencing `ManagerID` |
| `Project` | Projects, each linked to an owning department |
| `Assignment` | Junction table linking employees to the projects they work on, with weekly hours |

## 5. Tasks Covered (A1–A10)

The script includes 10 tasks demonstrating: department/employee mapping (INNER and LEFT), departments with zero employees, projects with no department, benched employees, dormant projects, filtered + sorted INNER JOINs, headcount per department with `COUNT`, and the emulated `FULL OUTER JOIN`.

---

## 🚀 Execution Instructions

1. Open **MySQL Workbench** or the **MySQL Command Line Client** (or phpMyAdmin's SQL tab).
2. Run [`Lab8_JoinsPart1.sql`](./Lab8_JoinsPart1.sql).
3. The script creates and populates a single database, `joins_lab`, then runs all 10 tasks (A1–A10) in sequence.
