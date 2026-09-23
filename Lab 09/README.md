# Database Systems Lab 9: Advanced Relational Joins & Multi-Table Query Architecture

## 1. Executive Summary & Learning Objectives

This lab extends relational join concepts to complex multi-table structures, self-referential hierarchies, and outer-join aggregations, then applies them to a full graded assessment using a Library Management System database.

### Core Objectives
* Implement **Self Joins** using virtual table aliasing to navigate parent-child relationships (e.g., employee-to-manager hierarchies).
* Construct multi-table queries chaining up to four relational entities (`Employee` → `Assignment` → `Project` → `Department`).
* Combine outer joins (`LEFT JOIN`) with aggregation functions (`SUM`, `COUNT`) and `COALESCE` to preserve zero-count and zero-hour entities.
* Master conditional filters placed inside `ON` clauses vs. filters applied after the join in `WHERE` clauses.
* Solve end-to-end domain problems using a **Library Management System** database.

---

## 2. Technical Architectural Patterns

### 2.1 Self Joins & Hierarchical Aliasing
When a table contains a foreign key that references its own primary key (such as `Employee.ManagerID` → `Employee.EmpID`), the engine requires two distinct aliases of the same table to distinguish between the child (employee) and parent (manager) context.

```sql
SELECT
    e.EmpName AS Employee,
    m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmpID;
```

A `LEFT JOIN` is used here (rather than `INNER JOIN`) so that top-level employees with no manager still appear in the results, with `Manager` shown as `NULL`.

### 2.2 Filtering Inside ON vs. WHERE
Task B9 demonstrates the difference between filtering *during* the join (`ON ... AND YEAR(p.StartDate) = 2024`) versus filtering *after* it. Placing the year condition inside the `ON` clause keeps departments with no matching 2024 project in the result (as `NULL`); putting the same condition in `WHERE` would incorrectly remove them.

---

## 3. Database Structure

**Company database (`joins_lab`)** — reused from Lab 8:

| Table | Purpose |
|---|---|
| `Department` | Department name, location, and budget |
| `Employee` | Employee details, including a self-referencing `ManagerID` |
| `Project` | Projects, each linked to an owning department |
| `Assignment` | Junction table linking employees to projects, with weekly hours |

**Library Management System (`library_lab`)** — the assessment database:

| Table | Purpose |
|---|---|
| `Author` | Author name and country |
| `Book` | Book title, genre, price, and linked author |
| `Member` | Library member details |
| `Loan` | Links members to borrowed books, with loan/return dates |

---

## 4. Tasks Covered

* **Part B (B1–B10):** Self joins for manager lookup, employees earning more than their manager, cross-department manager checks, 3- and 4-table joins chaining Employee → Assignment → Project → Department, filtering by project name/city, and `LEFT JOIN` + `COALESCE` to include employees with zero assigned hours.
* **Assessment (Q1–Q10, on `library_lab`):** Books with author details, authors with no books, members who never borrowed, full loan history joins, currently-borrowed books (`ReturnDate IS NULL`), Pakistani authors and their books, unborrowed books, authors whose books were never borrowed (`LEFT JOIN` + `HAVING COUNT = 0`), an emulated `FULL OUTER JOIN` via `UNION`, and members who borrowed books by Pakistani authors.

---

## 🚀 Execution Instructions

1. Open **MySQL Workbench** or the **MySQL Command Line Client** (or phpMyAdmin's SQL tab).
2. Run [`Lab9_JoinsPart2.sql`](./Lab9_JoinsPart2.sql).
3. The script sets up two databases in sequence:
   - `joins_lab` — Company schema, used for the Part B self-join and multi-table join tasks.
   - `library_lab` — Library Management System schema, used for the graded Q1–Q10 assessment.
