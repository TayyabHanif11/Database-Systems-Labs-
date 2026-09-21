# Lab 13 – Open-Ended Lab: Car Rental Management System

**Course:** DBMS | **Semester:** 4th (Software Engineering)
**Submitted by:** Tayyab Hanif (2024-SE-11)
**Submitted to:** Engr. Awais Rathore

## Objective
Design and implement a complete relational database for a car rental company (CarGo Rentals), covering normalized schema design, JOIN queries, a view, triggers, and a stored procedure — enforcing the core rule that a vehicle cannot be rented while it is already rented.

## Database Structure
| Table | Purpose |
|---|---|
| `customers` | Customer details (name, phone, CNIC, address) |
| `vehicles` | Vehicle details, daily rate, and live availability `status` |
| `rentals` | Each rental transaction (customer, vehicle, dates) |
| `returns` | Actual return date and billed days per rental (1:1 with rentals) |
| `payments` | Payment(s) recorded against each rental |

## Relationships
- `customers` → `rentals` (1:N)
- `vehicles` → `rentals` (1:N)
- `rentals` → `returns` (1:1)
- `rentals` → `payments` (1:N)

## Key Features Implemented
1. **Normalization** – flat sample record decomposed from 1NF → 2NF → 3NF into the 5-table schema above.
2. **JOIN Queries** – 4 business questions answered using INNER/LEFT joins (rental history, customers with no rentals, vehicles not currently rented, total rentals per customer).
3. **View** – `rental_summary`, a consolidated report joining customer, vehicle, rental, and payment data.
4. **Triggers**
   - `trg_before_rental_insert` – blocks a new rental if the vehicle is already `Rented`.
   - `trg_after_return_insert` – releases the vehicle back to `Available` on return.
5. **Stored Procedure** – `RegisterRental`, registers a rental and calculates the total charge from the vehicle's daily rate and rental period.
6. **Optimization** – indexed foreign key columns and a maintained `status` column to avoid full-table scans when checking vehicle availability.

## Files in this Folder
- `car_rental.sql` – full schema, sample data, JOIN queries, view, triggers, and stored procedure (numbered sections match the report)
- `Lab13_Report.docx` – full report: introduction, design justification, normalization analysis, all queries/screenshots, and optimization analysis
- `README.md` – this file

## How to Run
1. Start Apache + MySQL in XAMPP and open phpMyAdmin.
2. Go to **Import**, select `car_rental.sql`, and click **Go** — this creates the database, tables, sample data, view, triggers, and procedure in one step.
3. Run the JOIN queries (Section 5 of the file) directly from the **SQL** tab to reproduce the report's results.
4. Test the triggers by inserting a rental for an already-rented vehicle (Section 7.3) or running a full rent → return cycle (Section 7.4).
5. Test the stored procedure with: `CALL RegisterRental(12, 3, '2026-09-20', '2026-09-23', @charge); SELECT @charge;`
