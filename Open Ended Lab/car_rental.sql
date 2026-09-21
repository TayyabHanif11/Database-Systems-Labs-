-- =========================================================================
-- CAR RENTAL MANAGEMENT SYSTEM — CarGo Rentals
-- DBMS Lab 13 (Open-Ended Lab)
-- =========================================================================
-- Sections in this file:
--   1. Database Creation
--   2. Table Creation (Schema, Keys, Constraints)
--   3. Sample Data Insertion
--   4. Task 2 Support — Normalization reference (see report for analysis)
--   5. Task 3 — JOIN Queries
--   6. Task 4 — View
--   7. Task 5 — Triggers
--   8. Task 6 — Stored Procedure
--   9. Task 7 — Optimization (Indexes + EXPLAIN comparison)
-- =========================================================================


-- =========================================================================
-- 1. DATABASE CREATION
-- =========================================================================

CREATE DATABASE IF NOT EXISTS car_rental_db;
USE car_rental_db;


-- =========================================================================
-- 2. TABLE CREATION (SCHEMA, KEYS, CONSTRAINTS)
-- =========================================================================

-- 2.1 Table: customers
CREATE TABLE customers (
    customer_id  INT PRIMARY KEY AUTO_INCREMENT,
    full_name    VARCHAR(100) NOT NULL,
    phone        VARCHAR(15)  NOT NULL UNIQUE,
    cnic         VARCHAR(15)  UNIQUE,
    address      VARCHAR(150)
);

-- 2.2 Table: vehicles
CREATE TABLE vehicles (
    vehicle_id      INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_number  VARCHAR(20) NOT NULL UNIQUE,
    model           VARCHAR(50) NOT NULL,
    daily_rate      DECIMAL(10,2) NOT NULL CHECK (daily_rate > 0),
    status          VARCHAR(15) NOT NULL DEFAULT 'Available'
                    CHECK (status IN ('Available','Rented'))
);

-- 2.3 Table: rentals
CREATE TABLE rentals (
    rental_id            INT PRIMARY KEY AUTO_INCREMENT,
    customer_id          INT NOT NULL,
    vehicle_id           INT NOT NULL,
    rental_date          DATE NOT NULL,
    expected_return_date DATE NOT NULL,
    CHECK (expected_return_date > rental_date),
    CONSTRAINT fk_rentals_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_rentals_vehicle  FOREIGN KEY (vehicle_id)  REFERENCES vehicles(vehicle_id)
);

-- 2.4 Table: returns
CREATE TABLE returns (
    return_id          INT PRIMARY KEY AUTO_INCREMENT,
    rental_id          INT NOT NULL UNIQUE,
    actual_return_date DATE NOT NULL,
    total_days         INT NOT NULL CHECK (total_days > 0),
    CONSTRAINT fk_returns_rental FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

-- 2.5 Table: payments
CREATE TABLE payments (
    payment_id      INT PRIMARY KEY AUTO_INCREMENT,
    rental_id       INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    payment_method  VARCHAR(20) DEFAULT 'Cash',
    CONSTRAINT fk_payments_rental FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);


-- =========================================================================
-- 3. SAMPLE DATA INSERTION
-- =========================================================================

-- 3.1 Customers (10 with rental history + 2 with none, to demonstrate LEFT JOINs)
INSERT INTO customers (full_name, phone, cnic, address) VALUES
('Ali Raza',        '0300-1234567', '35202-1111111-1', 'Muzaffarabad'),
('Bilal Ahmed',     '0301-2345678', '35202-2222222-2', 'Rawalakot'),
('Sana Tariq',      '0302-3456789', '35202-3333333-3', 'Mirpur'),
('Hina Malik',      '0303-4567890', '35202-4444444-4', 'Bagh'),
('Usman Ghani',     '0304-5678901', '35202-5555555-5', 'Muzaffarabad'),
('Ayesha Noor',     '0305-6789012', '35202-6666666-6', 'Kotli'),
('Zainab Fatima',   '0306-7890123', '35202-7777777-7', 'Neelum'),
('Omar Sheikh',     '0307-8901234', '35202-8888888-8', 'Hattian Bala'),
('Farhan Iqbal',    '0308-9012345', '35202-9999999-9', 'Muzaffarabad'),
('Mahnoor Aslam',   '0309-0123456', '35202-1010101-0', 'Bhimber'),
('Kamran Yousaf',   '0311-1122334', '35202-1112223-4', 'Muzaffarabad'),  -- no rentals initially
('Rabia Sultana',   '0312-2233445', '35202-2223334-5', 'Kotli');        -- no rentals initially

-- 3.2 Vehicles (status reflects the snapshot below: 3 currently rented)
INSERT INTO vehicles (vehicle_number, model, daily_rate, status) VALUES
('ABC-123', 'Toyota Corolla',  5000.00, 'Available'),
('XYZ-456', 'Honda Civic',     5500.00, 'Rented'),
('LEA-789', 'Suzuki Cultus',   3000.00, 'Available'),
('GJ-321',  'Toyota Hiace',    8000.00, 'Available'),
('BC-654',  'Honda City',      4500.00, 'Rented'),
('KL-987',  'Suzuki Alto',     2500.00, 'Available'),
('MN-159',  'Toyota Fortuner', 12000.00,'Available'),
('OP-753',  'Honda BR-V',      6000.00, 'Rented'),
('QR-246',  'Suzuki Wagon R',  2800.00, 'Available'),
('ST-864',  'Toyota Yaris',    4200.00, 'Available');

-- 3.3 Rentals (rental_id 2, 5, 8 are active -> no matching row in returns)
INSERT INTO rentals (customer_id, vehicle_id, rental_date, expected_return_date) VALUES
(1,  1,  '2026-09-01', '2026-09-05'),  -- rental_id 1  (returned)
(2,  2,  '2026-09-18', '2026-09-25'),  -- rental_id 2  (active)
(3,  3,  '2026-09-02', '2026-09-06'),  -- rental_id 3  (returned)
(4,  4,  '2026-09-03', '2026-09-07'),  -- rental_id 4  (returned)
(5,  5,  '2026-09-19', '2026-09-22'),  -- rental_id 5  (active)
(6,  6,  '2026-09-04', '2026-09-08'),  -- rental_id 6  (returned)
(7,  7,  '2026-09-05', '2026-09-11'),  -- rental_id 7  (returned)
(8,  8,  '2026-09-17', '2026-09-24'),  -- rental_id 8  (active)
(9,  9,  '2026-09-06', '2026-09-09'),  -- rental_id 9  (returned)
(10, 10, '2026-09-07', '2026-09-10'); -- rental_id 10 (returned)

-- 3.4 Returns (only for the 7 rentals that have been closed out)
INSERT INTO returns (rental_id, actual_return_date, total_days) VALUES
(1,  '2026-09-04', 3),
(3,  '2026-09-05', 3),
(4,  '2026-09-06', 3),
(6,  '2026-09-07', 3),
(7,  '2026-09-10', 5),
(9,  '2026-09-08', 2),
(10, '2026-09-09', 2);

-- 3.5 Payments (full payment for closed rentals, advance/deposit for active ones)
INSERT INTO payments (rental_id, amount, payment_date, payment_method) VALUES
(1,  15000.00, '2026-09-04', 'Cash'),
(2,  5500.00,  '2026-09-18', 'Card'),
(3,  9000.00,  '2026-09-05', 'Cash'),
(4,  24000.00, '2026-09-06', 'Online Transfer'),
(5,  4500.00,  '2026-09-19', 'Cash'),
(6,  7500.00,  '2026-09-07', 'Cash'),
(7,  60000.00, '2026-09-10', 'Card'),
(8,  6000.00,  '2026-09-17', 'Online Transfer'),
(9,  5600.00,  '2026-09-08', 'Cash'),
(10, 8400.00,  '2026-09-09', 'Cash');


-- =========================================================================
-- 4. NORMALIZATION (TASK 2) — REFERENCE NOTE
-- =========================================================================
-- Task 2 is a written analysis, not a runnable query. The five tables above
-- (customers, vehicles, rentals, returns, payments) ARE the 3NF result of
-- decomposing the flat RentalID/CustomerName/.../PaymentAmount record given
-- in the lab manual. Full 1NF -> 2NF -> 3NF reasoning is documented in the
-- accompanying report (Lab13_Report.docx, Section 3).


-- =========================================================================
-- 5. TASK 3 — JOIN QUERIES
-- =========================================================================

-- 5.1 Query 1: Customer, vehicle, rental date, and return date for every rental
SELECT c.full_name, v.vehicle_number, v.model,
       r.rental_date, ret.actual_return_date
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles v  ON r.vehicle_id  = v.vehicle_id
LEFT JOIN returns ret ON ret.rental_id = r.rental_id;

-- 5.2 Query 2: All customers and the vehicles they rented (incl. zero-rental customers)
SELECT c.full_name, v.vehicle_number, v.model
FROM customers c
LEFT JOIN rentals r  ON c.customer_id = r.customer_id
LEFT JOIN vehicles v ON r.vehicle_id  = v.vehicle_id
ORDER BY c.full_name;

-- 5.3 Query 3: All vehicles and current rental info (incl. vehicles not rented)
SELECT v.vehicle_number, v.model, v.status,
       c.full_name AS current_customer,
       r.rental_date, r.expected_return_date
FROM vehicles v
LEFT JOIN rentals r   ON v.vehicle_id = r.vehicle_id
                     AND v.status = 'Rented'
LEFT JOIN customers c ON r.customer_id = c.customer_id
ORDER BY v.vehicle_number;

-- 5.4 Query 4: Total rentals per customer (incl. customers with zero rentals)
SELECT c.full_name, COUNT(r.rental_id) AS total_rentals
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_rentals DESC;


-- =========================================================================
-- 6. TASK 4 — VIEW
-- =========================================================================

CREATE VIEW rental_summary AS
SELECT r.rental_id,
       c.full_name       AS customer_name,
       c.phone           AS customer_phone,
       v.vehicle_number,
       v.model           AS vehicle_model,
       v.daily_rate,
       r.rental_date,
       r.expected_return_date,
       ret.actual_return_date,
       p.amount          AS amount_paid,
       p.payment_date
FROM rentals r
JOIN customers c      ON r.customer_id = c.customer_id
JOIN vehicles v       ON r.vehicle_id  = v.vehicle_id
LEFT JOIN returns ret ON ret.rental_id = r.rental_id
LEFT JOIN payments p  ON p.rental_id   = r.rental_id;

-- Example usage:
-- SELECT * FROM rental_summary ORDER BY rental_date DESC;


-- =========================================================================
-- 7. TASK 5 — TRIGGERS
-- =========================================================================

-- 7.1 Trigger 1: Block a new rental if the vehicle is already Rented
DELIMITER $$
CREATE TRIGGER trg_before_rental_insert
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(15);

    SELECT status INTO v_status
    FROM vehicles
    WHERE vehicle_id = NEW.vehicle_id;

    IF v_status = 'Rented' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This vehicle is already rented and unavailable.';
    ELSE
        UPDATE vehicles
        SET status = 'Rented'
        WHERE vehicle_id = NEW.vehicle_id;
    END IF;
END$$
DELIMITER ;

-- 7.2 Trigger 2: Release the vehicle back to Available when it is returned
DELIMITER $$
CREATE TRIGGER trg_after_return_insert
AFTER INSERT ON returns
FOR EACH ROW
BEGIN
    UPDATE vehicles v
    JOIN rentals r ON r.vehicle_id = v.vehicle_id
    SET v.status = 'Available'
    WHERE r.rental_id = NEW.rental_id;
END$$
DELIMITER ;

-- 7.3 Test 1 (expected to fail — vehicle_id 2 is already Rented):
-- INSERT INTO rentals (customer_id, vehicle_id, rental_date, expected_return_date)
-- VALUES (3, 2, '2026-09-20', '2026-09-23');

-- 7.4 Test 2 (full rent -> return cycle on vehicle_id 1, an Available vehicle):
-- SELECT vehicle_id, status FROM vehicles WHERE vehicle_id = 1;                 -- Available
-- INSERT INTO rentals (customer_id, vehicle_id, rental_date, expected_return_date)
--   VALUES (11, 1, '2026-09-20', '2026-09-23');                                 -- becomes rental_id 11
-- SELECT vehicle_id, status FROM vehicles WHERE vehicle_id = 1;                 -- Rented
-- INSERT INTO returns (rental_id, actual_return_date, total_days) VALUES (11, '2026-09-23', 3);
-- SELECT vehicle_id, status FROM vehicles WHERE vehicle_id = 1;                 -- Available again


-- =========================================================================
-- 8. TASK 6 — STORED PROCEDURE
-- =========================================================================

DELIMITER $$
CREATE PROCEDURE RegisterRental (
    IN  p_customer_id INT,
    IN  p_vehicle_id  INT,
    IN  p_rental_date DATE,
    IN  p_expected_return_date DATE,
    OUT p_total_charge DECIMAL(10,2)
)
BEGIN
    DECLARE v_rate DECIMAL(10,2);
    DECLARE v_days INT;

    SELECT daily_rate INTO v_rate
    FROM vehicles
    WHERE vehicle_id = p_vehicle_id;

    SET v_days = DATEDIFF(p_expected_return_date, p_rental_date);
    SET p_total_charge = v_rate * v_days;

    INSERT INTO rentals (customer_id, vehicle_id, rental_date, expected_return_date)
    VALUES (p_customer_id, p_vehicle_id, p_rental_date, p_expected_return_date);
END$$
DELIMITER ;

-- Example call (registers customer 12 on vehicle 3 -> rental_id 12):
-- CALL RegisterRental(12, 3, '2026-09-20', '2026-09-23', @charge);
-- SELECT @charge AS total_charge;


-- =========================================================================
-- 9. TASK 7 — OPTIMIZATION (INDEXES + EXPLAIN COMPARISON)
-- =========================================================================

-- 9.1 Supporting indexes on frequently joined/filtered foreign key columns
-- (Note: InnoDB auto-creates an index for FOREIGN KEY columns, so these are
--  primarily for explicit documentation of intent — see report Section 8.3.)
CREATE INDEX idx_rentals_vehicle  ON rentals(vehicle_id);
CREATE INDEX idx_rentals_customer ON rentals(customer_id);
CREATE INDEX idx_payments_rental  ON payments(rental_id);

-- 9.2 EXPLAIN comparison: unoptimized availability check vs. status-column lookup
-- Unoptimized (scans rental/return history):
-- EXPLAIN SELECT * FROM vehicles v
-- WHERE v.vehicle_id = 3
-- AND NOT EXISTS (
--     SELECT 1 FROM rentals r
--     LEFT JOIN returns ret ON ret.rental_id = r.rental_id
--     WHERE r.vehicle_id = v.vehicle_id AND ret.return_id IS NULL
-- );

-- Optimized (direct indexed lookup using the status column):
-- EXPLAIN SELECT * FROM vehicles WHERE vehicle_id = 3 AND status = 'Available';

-- =========================================================================
-- END OF FILE
-- =========================================================================
