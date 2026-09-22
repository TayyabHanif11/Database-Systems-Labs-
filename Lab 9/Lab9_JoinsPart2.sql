-- =============================================================================
-- DATABASE SYSTEMS | LAB #9: SQL JOINS (PART 2 - SELF JOINS & MULTI-TABLE JOINS)l
-- Description: Self Joins, Multi-Table Joins, Part B Tasks, and Assessment Questions.
-- Engine: MySQL 8.x
-- =============================================================================

-- =============================================================================
-- SECTION 1: COMPANY DATABASE SETUP
-- =============================================================================
CREATE DATABASE IF NOT EXISTS joins_lab;
USE joins_lab;

DROP TABLE IF EXISTS Assignment, Project, Employee, Department;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(40) NOT NULL,
    Location VARCHAR(30),
    Budget DECIMAL(12,2)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    ManagerID INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID)
);

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Assignment (
    EmpID INT,
    ProjectID INT,
    HoursPerWeek INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Sample Data Insertion
INSERT INTO Department VALUES
(10, 'Engineering', 'Lahore', 5000000.00),
(20, 'Marketing', 'Karachi', 2000000.00),
(30, 'Finance', 'Islamabad', 3000000.00),
(40, 'Research', 'Lahore', 4000000.00),
(50, 'Sales', 'Karachi', NULL);

INSERT INTO Employee VALUES
(101, 'Ali Khan', 'M', 120000.00, '2018-03-15', 'Lahore', NULL, 10),
(102, 'Sara Iqbal', 'F', 95000.00, '2019-06-01', 'Lahore', 101, 10),
(103, 'Hamza Raza', 'M', 85000.00, '2020-01-20', 'Karachi', 101, 10),
(104, 'Ayesha Noor', 'F', 110000.00, '2017-11-10', 'Karachi', NULL, 20),
(105, 'Bilal Ahmed', 'M', 70000.00, '2021-04-05', 'Karachi', 104, 20),
(106, 'Fatima Sheikh', 'F', 90000.00, '2019-09-12', 'Islamabad', NULL, 30),
(107, 'Usman Tariq', 'M', 78000.00, '2022-02-18', 'Islamabad', 106, 30),
(108, 'Maira Javed', 'F', 115000.00, '2016-07-22', 'Lahore', NULL, 40),
(109, 'Zain Abbas', 'M', 60000.00, '2023-01-09', 'Lahore', 108, 40),
(110, 'Nida Yousaf', 'F', 72000.00, '2022-08-30', 'Lahore', 108, 40);

INSERT INTO Project VALUES
(1001, 'Website Revamp', '2024-01-10', '2024-06-30', 10),
(1002, 'Mobile App', '2024-03-01', '2024-12-31', 10),
(1003, 'Brand Campaign', '2024-02-15', '2024-05-15', 20),
(1004, 'Audit System', '2024-04-01', NULL, 30),
(1005, 'AI Research', '2024-05-01', '2025-04-30', 40),
(1006, 'Internal Tool', '2024-06-01', '2024-09-30', NULL);

INSERT INTO Assignment VALUES
(101, 1001, 10),
(102, 1001, 20),
(102, 1002, 15),
(103, 1002, 30),
(104, 1003, 25),
(105, 1003, 40),
(106, 1004, 35),
(108, 1005, 20),
(109, 1005, 30);


-- =============================================================================
-- SECTION 2: CLASS DEMONSTRATION EXAMPLES (MANUAL SECTIONS 10 & 11)
-- =============================================================================

-- Class Example 7: Each employee with their manager's name (SELF JOIN)
SELECT e.EmpName AS Employee, m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmpID;

-- Class Example 8: Employees who earn more than their direct manager
SELECT e.EmpName AS Employee, e.Salary AS EmpSalary,
       m.EmpName AS Manager, m.Salary AS MgrSalary
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Section 11 Example: Chaining 4 tables together
SELECT e.EmpName, p.ProjectName, d.DeptName, a.HoursPerWeek
FROM Employee e
JOIN Assignment a ON e.EmpID = a.EmpID
JOIN Project p ON a.ProjectID = p.ProjectID
JOIN Department d ON p.DeptID = d.DeptID
ORDER BY e.EmpName;


-- =============================================================================
-- SECTION 3: LAB TASKS - PART B (SELF JOINS & MULTI-TABLE JOINS)
-- =============================================================================

-- Task B1: Show employee name and manager's name (top-level managers stay via LEFT JOIN).
SELECT e.EmpName AS Employee, m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmpID;

-- Task B2: List employees who earn more than their direct manager.
SELECT e.EmpName AS Employee, e.Salary AS EmpSalary,
       m.EmpName AS Manager, m.Salary AS MgrSalary
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Task B3: List employees whose manager works in a different department.
SELECT e.EmpName AS Employee, ed.DeptName AS EmployeeDept,
       m.EmpName AS Manager, md.DeptName AS ManagerDept
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID
LEFT JOIN Department ed ON e.DeptID = ed.DeptID
LEFT JOIN Department md ON m.DeptID = md.DeptID
WHERE e.DeptID <> m.DeptID OR (e.DeptID IS NULL XOR m.DeptID IS NULL);

-- Task B4: Show every employee with project name and weekly hours. (3-table join)
SELECT e.EmpName, p.ProjectName, a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID;

-- Task B5: List assignment with employee name, project name, and project's department name. (4-table join)
SELECT e.EmpName, p.ProjectName, d.DeptName AS ProjectDepartment, a.HoursPerWeek
FROM Assignment a
INNER JOIN Employee e ON a.EmpID = e.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
LEFT JOIN Department d ON p.DeptID = d.DeptID;

-- Task B6: List names and weekly hours of employees working on 'Mobile App'.
SELECT e.EmpName, a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';

-- Task B7: List Lahore employees and assigned projects (include Lahore staff without assignments).
SELECT e.EmpName, p.ProjectName, a.HoursPerWeek
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
LEFT JOIN Project p ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore';

-- Task B8: List employees working on a project run by a department different from their own.
SELECT e.EmpName, ed.DeptName AS EmployeeDept, p.ProjectName, pd.DeptName AS ProjectDept
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
LEFT JOIN Department ed ON e.DeptID = ed.DeptID
LEFT JOIN Department pd ON p.DeptID = pd.DeptID
WHERE e.DeptID <> p.DeptID OR (e.DeptID IS NULL XOR p.DeptID IS NULL);

-- Task B9: For each department, list projects started in 2024 (include departments with no projects).
SELECT d.DeptID, d.DeptName, p.ProjectName, p.StartDate
FROM Department d
LEFT JOIN Project p ON d.DeptID = p.DeptID AND YEAR(p.StartDate) = 2024;

-- Task B10: List every employee with total weekly hours across all projects (include zero hours).
SELECT e.EmpID, e.EmpName, COALESCE(SUM(a.HoursPerWeek), 0) AS TotalHours
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
GROUP BY e.EmpID, e.EmpName;


-- =============================================================================
-- SECTION 4: ASSESSMENT - LIBRARY DATABASE SETUP
-- =============================================================================
CREATE DATABASE IF NOT EXISTS library_lab;
USE library_lab;

DROP TABLE IF EXISTS Loan, Book, Member, Author;

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(60) NOT NULL,
    Country VARCHAR(30)
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(80) NOT NULL,
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    AuthorID INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    MemberName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    JoinDate DATE
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Assessment Data Population
INSERT INTO Author VALUES
(1, 'Jane Austen', 'UK'),
(2, 'Chinua Achebe', 'Nigeria'),
(3, 'Haruki Murakami', 'Japan'),
(4, 'Bapsi Sidhwa', 'Pakistan'),
(5, 'Mohsin Hamid', 'Pakistan'),
(6, 'Anonymous Writer', NULL);

INSERT INTO Book VALUES
(101, 'Pride and Prejudice', 'Fiction', 850.00, 1, 1813),
(102, 'Emma', 'Fiction', 900.00, 1, 1815),
(103, 'Things Fall Apart', 'Fiction', 1100.00, 2, 1958),
(104, 'Norwegian Wood', 'Fiction', 1500.00, 3, 1987),
(105, 'Kafka on the Shore', 'Fiction', 1700.00, 3, 2002),
(106, 'Ice-Candy-Man', 'Fiction', 1200.00, 4, 1988),
(107, 'The Reluctant Fundamentalist', 'Fiction', 1300.00, 5, 2007),
(108, 'Exit West', 'Fiction', 1450.00, 5, 2017),
(109, 'Mystery Title', 'Mystery', 950.00, NULL, 2020);

INSERT INTO Member VALUES
(201, 'Ahmad Raza', 'Lahore', '2023-01-15'),
(202, 'Sara Imran', 'Karachi', '2023-03-20'),
(203, 'Bilal Khan', 'Lahore', '2024-02-10'),
(204, 'Fatima Ali', 'Islamabad', '2022-09-05'),
(205, 'Hira Yousaf', NULL, '2024-05-01');

INSERT INTO Loan VALUES
(1, 201, 101, '2024-03-01', '2024-03-15'),
(2, 201, 104, '2024-04-10', NULL),
(3, 202, 103, '2024-02-20', '2024-03-05'),
(4, 202, 107, '2024-05-01', NULL),
(5, 203, 105, '2024-04-25', '2024-05-15'),
(6, 204, 102, '2024-01-10', '2024-01-30'),
(7, 204, 108, '2024-06-01', NULL);


-- =============================================================================
-- SECTION 5: ASSESSMENT GRADED QUESTIONS (Q1 TO Q10)
-- =============================================================================

-- Q1: Show every book with its author's name and country. (INNER JOIN) [10 Marks]
SELECT b.BookID, b.Title, a.AuthorName, a.Country
FROM Book b
INNER JOIN Author a ON b.AuthorID = a.AuthorID;

-- Q2: Show every author with their books (include authors with no books). (LEFT JOIN) [10 Marks]
SELECT a.AuthorID, a.AuthorName, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID;

-- Q3: List members who have never borrowed any book. (LEFT JOIN + IS NULL) [10 Marks]
SELECT m.MemberID, m.MemberName, m.City
FROM Member m
LEFT JOIN Loan l ON m.MemberID = l.MemberID
WHERE l.MemberID IS NULL;

-- Q4: List every loan with member name, book title, and author name. (3-table join) [15 Marks]
SELECT l.LoanID, m.MemberName, b.Title, a.AuthorName, l.LoanDate, l.ReturnDate
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID
INNER JOIN Book b ON l.BookID = b.BookID
LEFT JOIN Author a ON b.AuthorID = a.AuthorID;

-- Q5: List currently borrowed books (ReturnDate IS NULL) with borrower name and city. [10 Marks]
SELECT b.Title, m.MemberName, m.City, l.LoanDate
FROM Loan l
INNER JOIN Book b ON l.BookID = b.BookID
INNER JOIN Member m ON l.MemberID = m.MemberID
WHERE l.ReturnDate IS NULL;

-- Q6: List Pakistani authors and titles of their books (include Pakistani authors with no books). [15 Marks]
SELECT a.AuthorName, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
WHERE a.Country = 'Pakistan';

-- Q7: List every book together with members who borrowed it (include unborrowed books). [10 Marks]
SELECT b.BookID, b.Title, m.MemberName
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
LEFT JOIN Member m ON l.MemberID = m.MemberID;

-- Q8: Find authors whose books have never been borrowed. [10 Marks]
SELECT a.AuthorID, a.AuthorName
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
LEFT JOIN Loan l ON b.BookID = l.BookID
GROUP BY a.AuthorID, a.AuthorName
HAVING COUNT(l.LoanID) = 0;

-- Q9: FULL OUTER JOIN of Author and Book using UNION. [5 Marks]
SELECT a.AuthorName, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
UNION
SELECT a.AuthorName, b.Title
FROM Author a
RIGHT JOIN Book b ON a.AuthorID = b.AuthorID;

-- Q10: Members who borrowed books written by Pakistani authors. [5 Marks]
SELECT DISTINCT m.MemberName, b.Title, a.AuthorName
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID
INNER JOIN Book b ON l.BookID = b.BookID
INNER JOIN Author a ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Pakistan';