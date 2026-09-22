# Lab 05: Database Normalization (2NF, 3NF) | 2024-SE-11


## 📖 Overview
This repository covers advanced database normalization, progressing from First Normal Form (1NF) through to Third Normal Form (3NF). It features the systematic decomposition of two datasets: finalizing the **Online Bookstore** scenario and solving the complete **Hospital Management System** assessment from scratch.

## 🧠 Concepts Applied
* **Second Normal Form (2NF):** Eliminated partial dependencies from composite keys, ensuring non-prime attributes rely on the *entire* primary key.
* **Third Normal Form (3NF):** Extracted transitive dependencies into distinct tables, strictly separating independent entities (like Customers, Doctors, and Departments) from transaction records (like Orders and Visits).
* **Anomaly Resolution:** Verified through SQL `JOIN` reconstruction that data redundancy is minimized and structural anomalies are completely eliminated.


## 🚀 How to Run
Execute the script. It operates completely independently—establishing its own databases (`bookstore_norm` and `hospital_norm`), decomposing the tables into 3NF, populating the data, and running the final verification queries automatically.
