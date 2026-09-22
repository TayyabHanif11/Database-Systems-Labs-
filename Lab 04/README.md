# Lab 4 – Normalization: Overview and 1NF

## Course
Database Systems

## Topic
Normalization: Overview and First Normal Form (1NF)

## Objective
The objective of this lab is to understand database normalization,
data redundancy, anomalies, and the requirements of First Normal Form (1NF).

## Normalization Overview

Normalization is the process of organizing data to:

- Reduce data redundancy
- Avoid update anomalies
- Avoid insertion anomalies
- Avoid deletion anomalies
- Improve database structure

## 1NF

A relation is in First Normal Form (1NF) when:

- All values are atomic.
- There are no repeating groups.
- Each row represents one record.
- A primary key uniquely identifies each row.

## Example

An unnormalized online bookstore order may contain multiple books
inside one field.

In 1NF, each book is stored in a separate row.

### Primary Key

The table uses a composite primary key:

`(OrderID, BookID)`

This uniquely identifies each book within an order.

## Database Structure

| Table | Purpose |
|---|---|
| `OrderDetails_1NF` | Stores bookstore order details in 1NF |

## Files

- `Lab4_Normalization_1NF.sql` – SQL implementation
- `README.md` – Lab description

## How to Run

1. Open MySQL Workbench.
2. Open `Lab4_Normalization_1NF.sql`.
3. Execute the complete script.
4. Run the SELECT queries to verify the 1NF table.

## Result

The bookstore order data has been successfully converted from
an unnormalized form into First Normal Form (1NF).
