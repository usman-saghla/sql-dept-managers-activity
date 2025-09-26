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
