-- ==============================================================================
-- LAB 6: SQL Filters - Comparison, Logical Operators, Ranges, Patterns & Sorting
-- Name: Tayyab Hanif Awan
-- Roll Number: 2024-SE-11
-- Department: Software Engineering
-- University: The University of Azad Jammu & Kashmir
-- Description: Executing filtered queries using WHERE, comparison operators,
--              logical conditions (AND/OR/NOT), BETWEEN, IN, LIKE, IS NULL, 
--              ORDER BY, and LIMIT on Employee and Bookstore databases.
-- ==============================================================================

-- ==============================================================================
-- SECTION 1: EMPLOYEE DATABASE SETUP & DATA INITIALIZATION
-- ==============================================================================
CREATE DATABASE IF NOT EXISTS filters_lab;
USE filters_lab;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    JobTitle VARCHAR(40),
    DeptName VARCHAR(40)
);

INSERT INTO Employee VALUES
(101, 'Ali Khan', 'M', 120000, '2018-03-15', 'Lahore', 'Senior Engineer', 'Engineering'),
(102, 'Sara Iqbal', 'F', 95000, '2019-06-01', 'Lahore', 'Software Engineer', 'Engineering'),
(103, 'Hamza Raza', 'M', 85000, '2020-01-20', 'Karachi', 'Software Engineer', 'Engineering'),
(104, 'Ayesha Noor', 'F', 110000, '2017-11-10', 'Karachi', 'Marketing Lead', 'Marketing'),
(105, 'Bilal Ahmed', 'M', 70000, '2021-04-05', 'Karachi', 'Marketing Exec', 'Marketing'),
(106, 'Fatima Sheikh', 'F', 90000, '2019-09-12', 'Islamabad', 'Accountant', 'Finance'),
(107, 'Usman Tariq', 'M', 78000, '2022-02-18', 'Islamabad', 'Accountant', 'Finance'),
(108, 'Maira Javed', 'F', 115000, '2016-07-22', 'Lahore', 'Research Lead', 'Research'),
(109, 'Zain Abbas', 'M', 60000, '2023-01-09', 'Lahore', 'Research Analyst', 'Research'),
(110, 'Nida Yousaf', 'F', 72000, '2022-08-30', NULL, 'Research Analyst', 'Research'),
(111, 'Adeel Akhtar', 'M', 88000, '2020-05-14', 'Lahore', 'QA Engineer', 'Engineering'),
(112, 'Sana Malik', 'F', 102000, '2018-12-01', 'Karachi', 'Sales Manager', 'Sales'),
(113, 'Talha Hussain', 'M', 65000, '2023-07-18', 'Islamabad', 'Sales Exec', 'Sales'),
(114, 'Mehwish Anwar', 'F', 80000, '2021-10-25', 'Lahore', 'HR Officer', 'HR'),
(115, 'Imran Shafi', 'M', 125000, '2015-04-30', NULL, 'Director', 'Engineering');


-- ==============================================================================
-- SECTION 2: PART A - BASIC FILTERS AND LOGICAL OPERATORS
-- ==============================================================================

-- Task A1: List EmpID, EmpName, and Salary of all employees who earn more than 90,000.
SELECT EmpID, EmpName, Salary 
FROM Employee 
WHERE Salary > 90000;

-- Task A2: Show all employees with salary less than or equal to 75,000. Display EmpName and Salary.
SELECT EmpName, Salary 
FROM Employee 
WHERE Salary <= 75000;

-- Task A3: Find every employee who works in Lahore and earns more than 90,000.
SELECT * 
FROM Employee 
WHERE City = 'Lahore' AND Salary > 90000;

-- Task A4: List employees in Karachi or Islamabad. Show EmpName and City.
SELECT EmpName, City 
FROM Employee 
WHERE City = 'Karachi' OR City = 'Islamabad';

-- Task A5: Find female employees who are not in the Engineering department.
SELECT * 
FROM Employee 
WHERE Gender = 'F' AND DeptName != 'Engineering';

-- Task A6: Show employees who are male and earn between 70,000 and 90,000 (using AND and comparison operators only).
SELECT * 
FROM Employee 
WHERE Gender = 'M' AND Salary >= 70000 AND Salary <= 90000;

-- Task A7: List employees who are either Software Engineers or earn more than 100,000.
SELECT * 
FROM Employee 
WHERE JobTitle = 'Software Engineer' OR Salary > 100000;

-- Task A8: Find employees who are not in Marketing and not in Sales.
SELECT * 
FROM Employee 
WHERE DeptName != 'Marketing' AND DeptName != 'Sales';


-- ==============================================================================
-- SECTION 3: PART B - BETWEEN, IN, LIKE, IS NULL, ORDER BY, AND LIMIT
-- ==============================================================================

-- Task B1: List employees with salary between 75,000 and 100,000 (inclusive). Sort by salary ascending.
SELECT * 
FROM Employee 
WHERE Salary BETWEEN 75000 AND 100000 
ORDER BY Salary ASC;

-- Task B2: List employees hired between January 2020 and December 2022.
SELECT * 
FROM Employee 
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';

-- Task B3: Show employees whose salary is not between 80,000 and 100,000.
SELECT * 
FROM Employee 
WHERE Salary NOT BETWEEN 80000 AND 100000;

-- Task B4: List employees whose city is one of: Lahore, Islamabad. Sort by city, then by salary descending.
SELECT * 
FROM Employee 
WHERE City IN ('Lahore', 'Islamabad') 
ORDER BY City ASC, Salary DESC;

-- Task B5: Find employees in any department except Engineering, Sales, and HR.
SELECT * 
FROM Employee 
WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');

-- Task B6: Show all employees whose name starts with the letter 'M'. Display EmpName.
SELECT EmpName 
FROM Employee 
WHERE EmpName LIKE 'M%';

-- Task B7: Find employees whose name contains the letter 'a' anywhere (case-insensitive).
SELECT * 
FROM Employee 
WHERE EmpName LIKE '%a%';

-- Task B8: Find employees whose name ends with 'an'.
SELECT * 
FROM Employee 
WHERE EmpName LIKE '%an';

-- Task B9: Show employees whose job title contains 'Engineer' but who do not work in Engineering.
SELECT * 
FROM Employee 
WHERE JobTitle LIKE '%Engineer%' AND DeptName != 'Engineering';

-- Task B10: List the names of employees who do not have a recorded city.
SELECT EmpName 
FROM Employee 
WHERE City IS NULL;

-- Task B11: List employees who have a recorded city, sorted alphabetically by city.
SELECT * 
FROM Employee 
WHERE City IS NOT NULL 
ORDER BY City ASC;

-- Task B12: Display the 3 highest paid employees. Show EmpName and Salary.
SELECT EmpName, Salary 
FROM Employee 
ORDER BY Salary DESC 
LIMIT 3;

-- Task B13: Display the 5 most recently hired employees.
SELECT * 
FROM Employee 
ORDER BY HireDate DESC 
LIMIT 5;

-- Task B14: List the bottom 3 salaries in the company (lowest first).
SELECT EmpName, Salary 
FROM Employee 
ORDER BY Salary ASC 
LIMIT 3;

-- Task B15: Show all employees, sorted by department ascending, then by hire date ascending within each department.
SELECT * 
FROM Employee 
ORDER BY DeptName ASC, HireDate ASC;


-- ==============================================================================
-- SECTION 4: ASSESSMENT PROBLEM - ONLINE BOOKSTORE DATABASE
-- ==============================================================================
CREATE DATABASE IF NOT EXISTS bookstore_lab;
USE bookstore_lab;

DROP TABLE IF EXISTS Book;

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(80) NOT NULL,
    Author VARCHAR(60),
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    StockQty INT,
    PublishedYear INT,
    Publisher VARCHAR(40),
    Language VARCHAR(20)
);

INSERT INTO Book VALUES
(1, 'Pride and Prejudice', 'Jane Austen', 'Fiction', 850, 12, 1813, 'Penguin', 'English'),
(2, 'Emma', 'Jane Austen', 'Fiction', 900, 8, 1815, 'Penguin', 'English'),
(3, 'Things Fall Apart', 'Chinua Achebe', 'Fiction', 1100, 5, 1958, 'Heinemann', 'English'),
(4, 'Norwegian Wood', 'Haruki Murakami', 'Fiction', 1500, 3, 1987, 'Vintage', 'English'),
(5, 'Kafka on the Shore', 'Haruki Murakami', 'Fiction', 1700, 0, 2002, 'Vintage', 'English'),
(6, 'Ice-Candy-Man', 'Bapsi Sidhwa', 'Fiction', 1200, 15, 1988, 'Penguin', 'English'),
(7, 'The Reluctant Fundamentalist', 'Mohsin Hamid', 'Fiction', 1300, 9, 2007, 'Penguin', 'English'),
(8, 'Exit West', 'Mohsin Hamid', 'Fiction', 1450, 6, 2017, 'Riverhead', 'English'),
(9, 'Atomic Habits', 'James Clear', 'Self-help', 1800, 20, 2018, 'Avery', 'English'),
(10, 'The Power of Habit', 'Charles Duhigg', 'Self-help', 1600, 11, 2012, 'Random House', 'English'),
(11, 'Sapiens', 'Yuval Harari', 'History', 2200, 7, 2011, 'Harper', 'English'),
(12, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 1100, 25, 1997, 'Plata', 'English'),
(13, 'Aab-e-Hayat', 'Ibn-e-Safi', 'Mystery', 650, 18, 1955, 'Asrar', 'Urdu'),
(14, 'Raja Gidh', 'Bano Qudsia', 'Fiction', 900, 14, 1981, 'Sang-e-Meel', 'Urdu'),
(15, 'Mystery Title', NULL, 'Mystery', 950, 4, 2020, NULL, 'English');

-- Q1: List all books with a price greater than 1500. Show Title and Price.
SELECT Title, Price 
FROM Book 
WHERE Price > 1500;

-- Q2: Find all books published between 1900 and 2000. Show Title and PublishedYear, sorted by year.
SELECT Title, PublishedYear 
FROM Book 
WHERE PublishedYear BETWEEN 1900 AND 2000 
ORDER BY PublishedYear ASC;

-- Q3: List books in Fiction or Mystery genre with stock greater than 5.
SELECT * 
FROM Book 
WHERE Genre IN ('Fiction', 'Mystery') AND StockQty > 5;

-- Q4: Find books whose title contains the word 'the' anywhere (case-insensitive). Show Title and Author.
SELECT Title, Author 
FROM Book 
WHERE Title LIKE '%the%';

-- Q5: List books whose title starts with the letter 'A' or ends with 't'.
SELECT * 
FROM Book 
WHERE Title LIKE 'A%' OR Title LIKE '%t';

-- Q6: Find books with no recorded author. Show Title.
SELECT Title 
FROM Book 
WHERE Author IS NULL;

-- Q7: List books that are out of stock (StockQty = 0) or have unknown publisher.
SELECT * 
FROM Book 
WHERE StockQty = 0 OR Publisher IS NULL;

-- Q8: Show the 3 most expensive books in stock (StockQty > 0).
SELECT * 
FROM Book 
WHERE StockQty > 0 
ORDER BY Price DESC 
LIMIT 3;

-- Q9: Display all books written in Urdu, sorted by published year ascending.
SELECT * 
FROM Book 
WHERE Language = 'Urdu' 
ORDER BY PublishedYear ASC;

-- Q10: List books published before the year 2000 with a price under 1200, sorted by genre and then by title.
SELECT * 
FROM Book 
WHERE PublishedYear < 2000 AND Price < 1200 
ORDER BY Genre ASC, Title ASC;
