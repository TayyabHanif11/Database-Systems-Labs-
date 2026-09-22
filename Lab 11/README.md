# Lab 11: Scalar SQL Functions (Numeric & Date/Time) | Roll No: 202-SE-11


## 📖 Overview
This repository advances scalar operations by focusing heavily on numeric calculation and temporal logic. It completes the second half of the scalar functions module (Part B) and culminates in a comprehensive, graded assessment applied to an **Employee Database**.

## 🧠 Concepts Applied
* **Mathematical Adjustments:** Used `ROUND()`, `FLOOR()`, `CEIL()`, and `MOD()` to dynamically compute discounts, taxes, and structured salary brackets.
* **Temporal Extractions:** Applied `YEAR()`, `QUARTER()`, and `MONTHNAME()` to strip out meaningful segments from backend datetime columns.
* **Date Arithmetic:** Calculated precise intervals, ages, and tenures using `DATEDIFF()` and `TIMESTAMPDIFF()`, alongside forecasting future milestone dates via `DATE_ADD()`.
* **Deep Function Nesting:** Seamlessly combined formatting (`DATE_FORMAT`), string sanitization (`TRIM`, `UPPER`), calculation, and null-handling (`COALESCE`) into single, complex execution lines.


## 🚀 How to Run
Execute the `.sql` script. It is entirely self-contained; it will establish the required databases (`scalar_lab_b` and `emp_lab`), insert all necessary testing data, and automatically output the results of all 25 operations.