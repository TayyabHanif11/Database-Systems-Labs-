-- Name: Tayyab Hanif
-- Roll No: 2024-SE-11

-- =========================================================================
-- KEYS AND QUERIES — MySQL Database Lab 03
-- =========================================================================
-- Topic: Keys and Queries
-- DBMS : MySQL
--
-- Sections in this file:
--   1. Database Creation
--   2. Table Creation (Keys & Constraints)
--   3. Sample Data Insertion
--   4. SELECT Queries
--   5. UPDATE Query
--   6. DELETE Query
--   7. ALTER TABLE Query
--   8. JOIN Queries
--   9. Key Practice / Reference
--  10. TRUNCATE & DROP Practice
-- =========================================================================


-- =========================================================================
-- 1. DATABASE CREATION
-- =========================================================================

CREATE DATABASE IF NOT EXISTS keys_and_queries_db;
USE keys_and_queries_db;


-- =========================================================================
-- 2. TABLE CREATION (KEYS & CONSTRAINTS)
-- =========================================================================

-- 2.1 Table: departments
--     dept_id   -> Primary Key
--     dept_name -> Unique Key
CREATE TABLE departments (
    dept_id    INT PRIMARY KEY,
    dept_name  VARCHAR(100) NOT NULL UNIQUE
);


-- 2.2 Table: students
--     student_id -> Primary Key + Surrogate Key
--     email      -> Unique Key / Candidate Key
--     dept_id    -> Foreign Key
CREATE TABLE students (
    student_id  INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE,
    age         INT,
    dept_id     INT,
    CONSTRAINT fk_students_department
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
);


-- 2.3 Table: courses
--     course_id -> Primary Key
--     dept_id   -> Foreign Key
CREATE TABLE courses (
    course_id    INT PRIMARY KEY,
    course_name  VARCHAR(100) NOT NULL,
    dept_id      INT,
    CONSTRAINT fk_courses_department
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
);


-- 2.4 Table: instructors
--     instructor_id -> Primary Key
--     email         -> Unique Key
--     dept_id       -> Foreign Key
CREATE TABLE instructors (
    instructor_id  INT PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    dept_id        INT,
    CONSTRAINT fk_instructors_department
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
);


-- 2.5 Table: enrollments
--     (student_id, course_id) -> Composite Primary Key
--     student_id             -> Foreign Key
--     course_id              -> Foreign Key
CREATE TABLE enrollments (
    student_id  INT,
    course_id   INT,
    semester    VARCHAR(20) NOT NULL,

    PRIMARY KEY (student_id, course_id),

    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);


-- =========================================================================
-- 3. SAMPLE DATA INSERTION
-- =========================================================================

-- 3.1 Departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'CS'),
(2, 'EE');


-- 3.2 Students
INSERT INTO students (name, email, age, dept_id) VALUES
('Ali',   'ali@gmail.com',   20, 1),
('Sara',  'sara@gmail.com',  21, 1),
('Ahmed', 'ahmed@gmail.com', 22, 2);


-- 3.3 Courses
INSERT INTO courses (course_id, course_name, dept_id) VALUES
(101, 'Database',  1),
(102, 'AI',        1),
(201, 'Circuits',  2);


-- 3.4 Instructors
-- The manual defines the Instructors table but does not provide
-- instructor sample inserts, so these records are added for practice.
INSERT INTO instructors (instructor_id, name, email, dept_id) VALUES
(1, 'Dr. Hassan', 'hassan@example.com', 1),
(2, 'Dr. Fatima', 'fatima@example.com', 2);


-- 3.5 Enrollments
INSERT INTO enrollments (student_id, course_id, semester) VALUES
(1, 101, 'Fall 2025'),
(1, 102, 'Fall 2025'),
(2, 101, 'Fall 2025');


-- =========================================================================
-- 4. SELECT QUERIES
-- =========================================================================

-- 4.1 Display all departments
SELECT * FROM departments;

-- 4.2 Display all students
SELECT * FROM students;

-- 4.3 Display all courses
SELECT * FROM courses;

-- 4.4 Display all instructors
SELECT * FROM instructors;

-- 4.5 Display all enrollments
SELECT * FROM enrollments;


-- =========================================================================
-- 5. UPDATE QUERY
-- =========================================================================

-- Task: Update a student's name.
UPDATE students
SET name = 'Ali Khan'
WHERE student_id = 1;

-- Verify the updated record.
SELECT *
FROM students
WHERE student_id = 1;


-- =========================================================================
-- 6. DELETE QUERY
-- =========================================================================

-- Task: Delete a student record.
-- Student 3 (Ahmed) has no enrollment, so this DELETE does not
-- violate the enrollments -> students foreign key relationship.
DELETE FROM students
WHERE student_id = 3;

-- Verify remaining students.
SELECT * FROM students;


-- =========================================================================
-- 7. ALTER TABLE QUERY
-- =========================================================================

-- Task: Add a new column to the Students table.
ALTER TABLE students
ADD phone VARCHAR(20);

-- Verify the modified table structure.
DESCRIBE students;


-- =========================================================================
-- 8. JOIN QUERIES
-- =========================================================================

-- 8.1 Students with their enrolled courses
--     Students -> Enrollments -> Courses
SELECT
    s.student_id,
    s.name AS student_name,
    c.course_id,
    c.course_name,
    e.semester
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;


-- 8.2 Students with their departments
SELECT
    s.student_id,
    s.name AS student_name,
    d.dept_id,
    d.dept_name
FROM students AS s
INNER JOIN departments AS d
    ON s.dept_id = d.dept_id
ORDER BY s.student_id;


-- 8.3 Courses with their departments
SELECT
    c.course_id,
    c.course_name,
    d.dept_name
FROM courses AS c
INNER JOIN departments AS d
    ON c.dept_id = d.dept_id
ORDER BY c.course_id;


-- 8.4 Complete student-course-department view
SELECT
    s.student_id,
    s.name AS student_name,
    d.dept_name,
    c.course_name,
    e.semester
FROM students AS s
INNER JOIN departments AS d
    ON s.dept_id = d.dept_id
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;


-- =========================================================================
-- 9. KEY PRACTICE / REFERENCE
-- =========================================================================

-- 9.1 Candidate Key
-- In the Students table, student_id and email can serve as
-- candidate keys in this design because both uniquely identify
-- a student. student_id is selected as the Primary Key.

-- 9.2 Alternate Key
-- email is an Alternate Key because it is a candidate key that
-- was not selected as the Primary Key.

-- 9.3 Surrogate Key
-- student_id is a Surrogate Key because it is system-generated
-- using AUTO_INCREMENT rather than representing a real-world value.

-- 9.4 Composite Key
-- enrollments uses (student_id, course_id) as its Composite
-- Primary Key. Together, the two columns identify an enrollment.

-- 9.5 Foreign Keys
-- students.dept_id       -> departments.dept_id
-- courses.dept_id        -> departments.dept_id
-- instructors.dept_id    -> departments.dept_id
-- enrollments.student_id -> students.student_id
-- enrollments.course_id  -> courses.course_id


-- =========================================================================
-- 10. TRUNCATE & DROP PRACTICE
-- =========================================================================
-- These commands are intentionally COMMENTED OUT.
-- We can run them only when specifically required because they remove data
-- or database objects.

-- 10.1 TRUNCATE
-- TRUNCATE TABLE instructors;

-- 10.2 DROP
-- DROP TABLE instructors;


------------------