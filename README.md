# Department Managers Activity (SQL)

This project provides an SQL query to analyze **department managers' activity across calendar years** using the `employees_mod` database.  
The query produces a timeline showing whether a manager was active in a given year based on their `from_date` and `to_date` ranges.

---

## 📂 Structure
- `queries/manager_activity.sql` → Main SQL query
- `schema/` → (Optional) schema or table creation scripts if needed
- `samples/` → Example data and outputs

---

## 🛠️ Setup & Usage

1. Make sure you have the `employees_mod` schema available.  
   (This is a modified version of the standard MySQL Employees sample database.)

2. Run the query:

   ```sql
   USE employees_mod;

   SELECT
       d.dept_name,
       ee.gender,
       dm.emp_no,
       dm.from_date,
       dm.to_date,
       e.calendar_year,
       CASE
           WHEN YEAR(dm.to_date) >= e.calendar_year
                AND YEAR(dm.from_date) <= e.calendar_year
           THEN 1
           ELSE 0
       END AS active
   FROM
       (
           SELECT YEAR(hire_date) AS calendar_year
           FROM t_employees
           GROUP BY calendar_year
       ) e
   JOIN t_dept_manager dm
       ON e.calendar_year BETWEEN YEAR(dm.from_date) AND YEAR(dm.to_date)
   JOIN t_departments d
       ON dm.dept_no = d.dept_no
   JOIN t_employees ee
       ON dm.emp_no = ee.emp_no
   ORDER BY
       dm.emp_no,
       e.calendar_year;
