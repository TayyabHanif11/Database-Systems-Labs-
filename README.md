# 🗄️ Database Systems Labs — CS-2204

**Name:** Tayyab Hanif Awan | **Roll No:** 2024-SE-11
**Course:** Database Systems (CS-2204) | **Semester:** 4th
**Instructor:** Engr. Awais Rathore

---

## 📖 About This Repository

This repository contains the complete lab work for the **Database Systems (CS-2204)** course — from initial environment setup through relational keys, normalization theory, SQL filtering, joins, scalar functions, aggregate reporting, and a full open-ended database project.

Each lab lives in its own folder and follows the same pattern:
- A **`.sql`** file containing the complete, runnable implementation (schema, sample data, and all required queries)
- A **`README.md`** describing that lab's objective, concepts, and how to run it
- A **PDF report** where the lab required one (installation walkthroughs or full written analysis with screenshots)

---

## 🗂️ Repository Structure

| Lab | Topic | Key Files | Highlights |
|---|---|---|---|
| [Lab 01](./Lab%2001) | XAMPP Installation & Setup | `Lab1_XAMPP_INS.pdf` | Installing XAMPP, launching Apache/MySQL, verifying phpMyAdmin access |
| [Lab 02](./Lab%2002) | Point of Sale (POS) Database | `Lab2_POS_SCHEMA.sql` | 10-table schema (RBAC roles/permissions, inventory, orders) + 10 analytical reporting queries |
| [Lab 03](./Lab%2003) | Keys and Queries | `Lab_03_KEYS_AND_QUERIES.sql` | Primary, foreign, composite, candidate, alternate & surrogate keys; SELECT, UPDATE, DELETE, ALTER, JOIN, TRUNCATE/DROP |
| [Lab 04](./Lab%2004) | Normalization — 1NF | `Lab4_Normalization_1NF.sql` | Converting an unnormalized bookstore order table into First Normal Form |
| [Lab 05](./Lab%2005) | Normalization — 2NF & 3NF | `Lab5_2NF_3NF.sql` | Completing the bookstore decomposition to 3NF + a full Hospital Management System normalized from scratch |
| [Lab 06](./Lab%2006) | SQL Filters — Comparison & Logical Operators | `Lab6_FiltersPart1_...sql` | `WHERE`, `AND`/`OR`/`NOT`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`, `ORDER BY`, `LIMIT` |
| [Lab 07](./Lab%2007) | SQL Filters — Advanced Filtering & Presentation | `LAB7_FILTERS_PART2.sql` | Continued filtering practice + a full graded assessment (`lab7_bookstore`) |
| [Lab 08](./Lab%2008) | SQL Joins — Part 1 | `Lab8_JoinsPart1.sql` | `INNER`, `LEFT`, `RIGHT`, emulated `FULL OUTER` joins, anti-join pattern, avoiding Cartesian products |
| [Lab 09](./Lab%2009) | SQL Joins — Part 2 | `Lab9_JoinsPart2.sql` | Self joins (employee–manager hierarchy), 4-table joins, outer joins + aggregation on a Library Management System |
| [Lab 10](./Lab%2010) | Scalar Functions — String Operations | `Lab10_SCALAR_Part1.sql` | `TRIM`, `UPPER`/`LOWER`, `SUBSTRING_INDEX`, `LOCATE`, `CONCAT`, `LEFT`, `REPLACE`, `LPAD` |
| [Lab 11](./Lab%2011) | Scalar Functions — Numeric & Date/Time | `Lab11_SCALAR_PART2.sql` | `ROUND`, `FLOOR`, `CEIL`, `MOD`, `DATEDIFF`, `TIMESTAMPDIFF`, `DATE_ADD`, `DATE_FORMAT`, `COALESCE` |
| [Lab 12](./Lab%2012) | Aggregate Functions, GROUP BY & HAVING | `Lab12_Aggregates.sql` | `COUNT`/`SUM`/`AVG`/`MIN`/`MAX`, `GROUP BY`, `HAVING` vs `WHERE`, aggregates combined with joins |
| [Open Ended Lab](./Open%20Ended%20Lab) | Car Rental Management System | `car_rental.sql`, `DBMS_OEL_2024_SE_11.pdf` | Full normalized design (1NF→3NF), JOIN queries, a VIEW, 2 TRIGGERs, a STORED PROCEDURE, and an optimization analysis |

---

## 🛠️ Tools & Environment

- **XAMPP** (Apache + MySQL/MariaDB) with **phpMyAdmin**
- **MySQL Workbench** / MySQL Command Line Client (used interchangeably across labs)
- Pure **SQL** — no external frameworks or languages

## 📌 A Note on Multiple Databases per Lab

Several labs (05, 06, 07, 09, 11, 12) create **two separate databases** in a single script — one for guided practice and one for a standalone graded assessment on a different domain (e.g. a Hospital, Library, or University system). This is intentional: each script is fully self-contained and can be run start-to-finish without needing data from any other lab.

## 🚀 How to Use This Repository

1. Start **Apache** and **MySQL** from the XAMPP Control Panel.
2. Open **phpMyAdmin** (`http://localhost/phpmyadmin`) or MySQL Workbench.
3. Open the lab folder you need, and run its `.sql` file — either via the **Import** tab (phpMyAdmin) or by pasting it into the **SQL** tab.
4. Each script creates its own database(s) automatically (`CREATE DATABASE IF NOT EXISTS ...`), so scripts can be run independently and in any order.
5. Refer to each lab's own `README.md` for that lab's specific objectives, concepts, and any manual testing steps (e.g. trigger tests in the Open Ended Lab).

---

## 📂 Labs Requiring a Written Report

- **Lab 01** — installation walkthrough with screenshots (`Lab1_XAMPP_INS.pdf`)
- **Open Ended Lab** — full report covering design justification, normalization analysis, all query outputs, and optimization analysis (`DBMS_OEL_2024_SE_11.pdf`)

All other labs are fully documented through their SQL comments and per-lab README.
