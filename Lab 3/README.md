# Lab 03 – Keys and Queries

**Course:** Database Systems / DBMS Lab  
**Lab:** 03  
**Topic:** **KEYS_AND_QUERIES**  
**DBMS:** MySQL  
**Implementation:** MySQL / phpMyAdmin

---

## Objective

The objective of this lab is to practice fundamental **database keys, table constraints, SQL queries, CRUD operations, table modification, and JOIN operations** using MySQL.

The lab implements the university database example from the Lab 03 manual using five related tables: `departments`, `students`, `courses`, `instructors`, and `enrollments`.

---

## Database Structure

| Table | Purpose |
|---|---|
| `departments` | Stores department information |
| `students` | Stores student information and department association |
| `courses` | Stores course information and department association |
| `instructors` | Stores instructor information and department association |
| `enrollments` | Connects students with courses using a composite key |

### Relationships

```text
departments
    │
    ├───────────────┐
    │               │
    ▼               ▼
students        courses
    │               │
    └───────┐   ┌───┘
            ▼   ▼
         enrollments

departments ─────────► instructors
```

---

## Keys & Constraints

### `departments`

- `dept_id` — **Primary Key**
- `dept_name` — **Unique Key**

### `students`

- `student_id` — **Primary Key / Surrogate Key**
- `email` — **Unique Key / Candidate Key**
- `dept_id` — **Foreign Key** → `departments(dept_id)`

### `courses`

- `course_id` — **Primary Key**
- `dept_id` — **Foreign Key** → `departments(dept_id)`

### `instructors`

- `instructor_id` — **Primary Key**
- `email` — **Unique Key**
- `dept_id` — **Foreign Key** → `departments(dept_id)`

### `enrollments`

- `(student_id, course_id)` — **Composite Primary Key**
- `student_id` — **Foreign Key** → `students(student_id)`
- `course_id` — **Foreign Key** → `courses(course_id)`

---

## Key Concepts Practiced

### Primary Key

Uniquely identifies a record in a table and cannot be `NULL`.

### Foreign Key

Creates a relationship between tables by referencing a key in another table.

### Unique Key

Ensures that values in a column are unique.

### Composite Key

A key made up of more than one column. The `enrollments` table uses:

```text
(student_id, course_id)
```

as its composite primary key.

### Candidate Key

A column that can potentially be selected as a primary key. In the `students` table, `student_id` and `email` are treated as candidate keys in this design.

### Alternate Key

A candidate key that was not selected as the primary key. Here, `email` serves as the alternate key.

### Surrogate Key

An artificial/system-generated identifier. `student_id` uses `AUTO_INCREMENT` and therefore serves as a surrogate key.

---

## SQL Operations Implemented

### 1. Database Creation

A dedicated database is created:

```text
keys_and_queries_db
```

### 2. Table Creation

All five tables are created with their required keys, relationships, and constraints.

### 3. Sample Data

Sample records from the lab manual are inserted into:

- Departments
- Students
- Courses
- Enrollments

Instructor records are also included for practice because the manual defines the `instructors` table but does not provide sample instructor inserts.

### 4. SELECT Queries

`SELECT` statements are used to retrieve and verify records from all tables.

### 5. UPDATE

The student's name is updated from:

```text
Ali → Ali Khan
```

using an `UPDATE` query.

### 6. DELETE

The student record with `student_id = 3` is deleted. This record has no enrollment, so the deletion does not conflict with the enrollment foreign key.

### 7. ALTER TABLE

A new `phone` column is added to the `students` table using:

```sql
ALTER TABLE students
ADD phone VARCHAR(20);
```

### 8. JOIN Queries

The lab includes JOIN queries for:

- Students and their enrolled courses
- Students and their departments
- Courses and their departments
- A combined student-course-department result

The main relationship used for student/course queries is:

```text
Students → Enrollments → Courses
```

### 9. TRUNCATE & DROP

Examples of `TRUNCATE TABLE` and `DROP TABLE` are included as commented practice commands.

They are intentionally not executed automatically because both operations can remove existing data or database objects.

---

## Files in This Folder

```text
Lab-03/
│
├── Lab_03_SQL_Solutions.sql
└── README.md
```

### `Lab_03_SQL_Solutions.sql`

Contains the complete MySQL implementation for **KEYS_AND_QUERIES**, including:

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Unique keys
- Composite key
- Sample data
- `SELECT`
- `UPDATE`
- `DELETE`
- `ALTER TABLE`
- JOIN queries
- Key references
- `TRUNCATE` and `DROP` practice

### `README.md`

Provides the lab description, database structure, relationships, concepts, implemented operations, and execution information.

---

## How to Run

1. Start **MySQL** through XAMPP or use another MySQL installation.
2. Open **phpMyAdmin**.
3. Go to the **SQL** tab.
4. Open or paste `Lab_03_SQL_Solutions.sql`.
5. Execute the complete script.
6. Select `keys_and_queries_db` to inspect the created tables.
7. Run the individual query sections again when checking their results.

> **Note:** The SQL script is designed as a complete lab implementation. The `TRUNCATE` and `DROP` examples remain commented out intentionally.

---

## Lab Tasks Covered

The implementation covers the tasks specified in the Lab 03 manual:

1. Create the tables with constraints.
2. Insert data and query it using `SELECT`.
3. Update a student's name.
4. Delete a student record.
5. Practice `TRUNCATE` and `DROP`.
6. Add a new column using `ALTER TABLE`.
7. Practice JOINs between Students and Courses.
8. Explore candidate keys, alternate keys, and composite keys.

---

## Lab Status

**Completed — Lab 03: KEYS_AND_QUERIES**

---

> **Note:** Screenshots and execution evidence are intentionally not included at this stage. They will be considered separately at the end for labs where the submission requirements require implementation screenshots.
