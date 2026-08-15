USE hr_analytics;

-- =====================================================
-- COMMON TABLE EXPRESSIONS (CTEs)
-- =====================================================

-- 1. Top 3 Highest Paid Employees in Each Department

WITH SalaryRank AS
(
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS SalaryRank
    FROM employees
)

SELECT *
FROM SalaryRank
WHERE SalaryRank <= 3;

----------------------------------------------------------

-- 2. Employees Earning Above Department Average Salary

WITH DepartmentAverage AS
(
    SELECT
        Department,
        AVG(MonthlyIncome) AS AvgSalary
    FROM employees
    GROUP BY Department
)

SELECT
    e.EmployeeNumber,
    e.Department,
    e.JobRole,
    e.MonthlyIncome
FROM employees e
JOIN DepartmentAverage d
ON e.Department = d.Department
WHERE e.MonthlyIncome > d.AvgSalary;

----------------------------------------------------------

-- 3. Employees With Above Average Experience

WITH CompanyAverage AS
(
    SELECT AVG(TotalWorkingYears) AS AvgExperience
    FROM employees
)

SELECT
EmployeeNumber,
JobRole,
TotalWorkingYears
FROM employees
WHERE TotalWorkingYears >
(
SELECT AvgExperience
FROM CompanyAverage
);

----------------------------------------------------------

-- 4. Attrition Employees Only

WITH AttritionEmployees AS
(
SELECT *
FROM employees
WHERE Attrition='Yes'
)

SELECT
Department,
COUNT(*) AS EmployeesLeft
FROM AttritionEmployees
GROUP BY Department
ORDER BY EmployeesLeft DESC;

----------------------------------------------------------

-- 5. Highest Salary of Every Department

WITH HighestSalary AS
(
SELECT
Department,
MAX(MonthlyIncome) AS HighestSalary
FROM employees
GROUP BY Department
)

SELECT *
FROM HighestSalary;

----------------------------------------------------------

-- 6. Average Salary By Job Role

WITH JobRoleSalary AS
(
SELECT
JobRole,
ROUND(AVG(MonthlyIncome),2) AS AverageSalary
FROM employees
GROUP BY JobRole
)

SELECT *
FROM JobRoleSalary
ORDER BY AverageSalary DESC;

----------------------------------------------------------

-- 7. Employees Working Overtime

WITH OvertimeEmployees AS
(
SELECT *
FROM employees
WHERE OverTime='Yes'
)

SELECT
Department,
COUNT(*) AS OvertimeEmployees
FROM OvertimeEmployees
GROUP BY Department
ORDER BY OvertimeEmployees DESC;

----------------------------------------------------------

-- 8. Employees Having Maximum Job Satisfaction

WITH HighSatisfaction AS
(
SELECT *
FROM employees
WHERE JobSatisfaction=4
)

SELECT
Department,
COUNT(*) AS HighlySatisfiedEmployees
FROM HighSatisfaction
GROUP BY Department;

----------------------------------------------------------

-- 9. Salary Categories

WITH SalaryBands AS
(
SELECT
EmployeeNumber,
MonthlyIncome,
CASE
WHEN MonthlyIncome < 5000 THEN 'Low'
WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium'
ELSE 'High'
END AS SalaryCategory
FROM employees
)

SELECT
SalaryCategory,
COUNT(*) AS Employees
FROM SalaryBands
GROUP BY SalaryCategory;

----------------------------------------------------------

-- 10. Employees Having More Than 10 Years At Company

WITH ExperiencedEmployees AS
(
SELECT *
FROM employees
WHERE YearsAtCompany > 10
)

SELECT
Department,
COUNT(*) AS ExperiencedEmployees
FROM ExperiencedEmployees
GROUP BY Department
ORDER BY ExperiencedEmployees DESC;