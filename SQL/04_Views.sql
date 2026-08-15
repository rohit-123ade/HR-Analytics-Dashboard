USE hr_analytics;

-- =====================================================
-- VIEWS
-- =====================================================

----------------------------------------------------------
-- View 1: Department Salary Summary
----------------------------------------------------------

CREATE OR REPLACE VIEW vw_department_salary AS
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    ROUND(AVG(MonthlyIncome),2) AS AverageSalary,
    MAX(MonthlyIncome) AS HighestSalary,
    MIN(MonthlyIncome) AS LowestSalary
FROM employees
GROUP BY Department;

SELECT * FROM vw_department_salary;

----------------------------------------------------------
-- View 2: Department Attrition Summary
----------------------------------------------------------

CREATE OR REPLACE VIEW vw_department_attrition AS
SELECT
    Department,
    COUNT(*) AS EmployeesLeft
FROM employees
WHERE Attrition='Yes'
GROUP BY Department;

SELECT * FROM vw_department_attrition;

----------------------------------------------------------
-- View 3: Employee Performance Summary
----------------------------------------------------------

CREATE OR REPLACE VIEW vw_employee_performance AS
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    PerformanceRating,
    JobSatisfaction,
    WorkLifeBalance,
    MonthlyIncome
FROM employees;

SELECT * FROM vw_employee_performance;