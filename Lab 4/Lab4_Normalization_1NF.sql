-- =========================================================================
-- DATABASE SYSTEMS — LAB 4
-- NORMALIZATION: OVERVIEW AND 1NF
-- Name: Tayyab Hanif
-- Roll no: 2024-SE-11
-- =========================================================================

CREATE DATABASE IF NOT EXISTS normalization_lab4;
USE normalization_lab4;

-- =========================================================================
-- 1. UNNORMALIZED DATA
-- =========================================================================
-- Example: Online Bookstore
-- Repeating groups are present in the OrderDetails column.

-- Example of UNF:
-- OrderID | CustomerName | CustomerPhone | OrderDetails
-- O101    | Ali Khan     | 0300-1111111  | Book A, Book B, Book C
-- O102    | Sara Ahmed   | 0301-2222222  | Book D

-- Problems in UNF:
-- 1. Repeating groups
-- 2. Difficult searching and updating
-- 3. Data redundancy
-- 4. Possible insertion, update and deletion anomalies


-- =========================================================================
-- 2. FIRST NORMAL FORM (1NF)
-- =========================================================================
-- 1NF requires:
-- - Atomic values
-- - No repeating groups
-- - Each row represents one record
-- - A primary key identifies each row

CREATE TABLE OrderDetails_1NF (
    OrderID VARCHAR(10),
    CustomerName VARCHAR(100),
    CustomerPhone VARCHAR(20),
    BookID VARCHAR(10),
    BookTitle VARCHAR(150),
    Quantity INT,
    Price DECIMAL(10,2),

    PRIMARY KEY (OrderID, BookID)
);


-- =========================================================================
-- 3. INSERT SAMPLE DATA
-- =========================================================================

INSERT INTO OrderDetails_1NF
(OrderID, CustomerName, CustomerPhone, BookID, BookTitle, Quantity, Price)
VALUES
('O101', 'Ali Khan', '0300-1111111', 'B101', 'Database Systems', 1, 2500.00),
('O101', 'Ali Khan', '0300-1111111', 'B102', 'SQL Fundamentals', 2, 1500.00),
('O101', 'Ali Khan', '0300-1111111', 'B103', 'Web Development', 1, 2000.00),
('O102', 'Sara Ahmed', '0301-2222222', 'B104', 'Python Programming', 1, 3000.00);


-- =========================================================================
-- 4. VERIFY 1NF
-- =========================================================================

SELECT * 
FROM OrderDetails_1NF;

SELECT OrderID, BookID, BookTitle, Quantity, Price
FROM OrderDetails_1NF
ORDER BY OrderID, BookID;


-- =========================================================================
-- 5. OBSERVATION
-- =========================================================================
-- The table is in 1NF because:
-- 1. All values are atomic.
-- 2. There are no repeating groups.
-- 3. Each row represents one ordered book.
-- 4. The composite primary key (OrderID, BookID) uniquely identifies
--    each order item.