# Database Systems Lab 9: Advanced Relational Joins & Multi-Table Query Architecture

## 1. Executive Summary & Learning Objectives

This lab extends relational join concepts to complex multi-table structures, self-referential hierarchies, outer-join aggregations, and practical problem solving using the Library relational schema.

### Core Objectives
* Implement **Self Joins** using virtual table aliasing to navigate unary parent-child relationships (e.g., employee-to-manager hierarchies).
* Construct multi-table queries chaining up to four relational entities (`Employee` $\rightarrow$ `Assignment` $\rightarrow$ `Project` $\rightarrow$ `Department`).
* Combine outer joins (`LEFT JOIN`) with aggregation functions (`SUM`, `COUNT`) and `COALESCE` to preserve zero-count and zero-hour entities.
* Master state-preserving conditional filters within `ON` clauses vs post-join evaluation in `WHERE` clauses.
* Solve end-to-end domain problems using the **Library Management System** database.

---

## 2. Technical Architectural Patterns

### 2.1 Self Joins & Hierarchical Aliasing
When a table contains a foreign key that references its own primary key (such as `Employee.ManagerID` $\rightarrow$ `Employee.EmpID`), the engine requires distinct virtual table aliases to distinguish between child and parent contexts.

```sql
SELECT 
    e.EmpName AS Employee, 
    m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmpID;
