CREATE DATABASE IF NOT EXISTS test_db;
USE test_db;

--------------------------------------------------------------------------------
-- 2) Create Tables
--------------------------------------------------------------------------------
CREATE TABLE departments (
    dept_id   INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id     INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    dept_id    INT,
    salary     DECIMAL(10,2),
    hire_date  DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

--------------------------------------------------------------------------------
-- 3) Insert Data
--------------------------------------------------------------------------------
INSERT INTO departments (dept_name) VALUES
('Sales'),
('Engineering'),
('HR'),
('Finance');

INSERT INTO employees (first_name, last_name, dept_id, salary, hire_date) VALUES
('Alice',   'Smith',    1, 60000.00, '2020-01-15'),
('Bob',     'Johnson',  1, 65000.00, '2019-03-10'),
('Charlie', 'Brown',    2, 70000.00, '2021-06-01'),
('Diana',   'Williams', 2, 72000.00, '2018-11-23'),
('Ethan',   'Jones',    3, 45000.00, '2022-02-12'),
('Fiona',   'Miller',   4, 50000.00, '2020-05-05');

--------------------------------------------------------------------------------
-- 4) Basic SELECT & JOIN
--------------------------------------------------------------------------------
SELECT 
    e.emp_id, 
    e.first_name, 
    e.last_name, 
    d.dept_name, 
    e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 50000
ORDER BY e.salary DESC;

--------------------------------------------------------------------------------
-- 5) Subquery
--------------------------------------------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE dept_id = (
    SELECT dept_id
    FROM departments
    WHERE dept_name = 'Engineering'
);

--------------------------------------------------------------------------------
-- 6) GROUP BY and HAVING
--------------------------------------------------------------------------------
SELECT 
    d.dept_name, 
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 50000;

--------------------------------------------------------------------------------
-- 7) Window Function (in MySQL 8+ / standard SQL)
--------------------------------------------------------------------------------
SELECT 
    emp_id,
    first_name,
    salary,
    AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary_by_dept
FROM employees;

--------------------------------------------------------------------------------
-- 8) INSERT with Sub-Select
--------------------------------------------------------------------------------
INSERT INTO employees (first_name, last_name, dept_id, salary, hire_date)
SELECT 'Greg', 'Hughes', dept_id, 55000.00, '2023-01-01'
FROM departments
WHERE dept_name = 'Finance';

--------------------------------------------------------------------------------
-- 9) UPDATE
--------------------------------------------------------------------------------
UPDATE employees
SET salary = salary * 1.05
WHERE dept_id = 1;

--------------------------------------------------------------------------------
-- 10) DELETE
--------------------------------------------------------------------------------
DELETE FROM employees
WHERE first_name = 'Ethan';

--------------------------------------------------------------------------------
-- 11) Transactions
--------------------------------------------------------------------------------
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
-- oops ... forget that and use Wally's account
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;
--------------------------------------------------------------------------------
-- 12) Create a View
--------------------------------------------------------------------------------
CREATE VIEW high_earning_engineers AS
SELECT 
    e.emp_id, 
    e.first_name, 
    e.last_name, 
    e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Engineering'
  AND e.salary > 70000;

--------------------------------------------------------------------------------
-- 13) Create an Index
--------------------------------------------------------------------------------
CREATE INDEX idx_salary ON employees(salary);

--------------------------------------------------------------------------------
-- 14) Create a Stored Procedure
--------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE give_raise(IN dept INT, IN increase_pct DECIMAL(4,2))
BEGIN
    UPDATE employees
    SET salary = salary + (salary * increase_pct / 100)
    WHERE dept_id = dept;
END$$
DELIMITER ;

--------------------------------------------------------------------------------
-- 15) Create a Trigger
--------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER before_employee_insert 
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SET NEW.salary = 30000;
    END IF;
END$$
DELIMITER ;

--------------------------------------------------------------------------------
-- 16) Use the Stored Procedure
--------------------------------------------------------------------------------
CALL give_raise(2, 10);

--------------------------------------------------------------------------------
-- 17) Final SELECT to Check Results
--------------------------------------------------------------------------------
SELECT * 
FROM employees;
