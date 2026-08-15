USE hr_analytics;

-- ===============================
-- WINDOW FUNCTIONS
-- ===============================

-- 1. Rank Employees by Salary
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome,
RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS SalaryRank
FROM employees;

-- 2. Dense Rank Employees by Salary
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS SalaryDenseRank
FROM employees;

-- 3. Row Number
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS RowNum
FROM employees;

-- 4. Department Average Salary
SELECT EmployeeNumber, Department, MonthlyIncome,
ROUND(AVG(MonthlyIncome) OVER(PARTITION BY Department),2) AS DepartmentAverage
FROM employees;

-- 5. Maximum Salary in Department
SELECT EmployeeNumber, Department, MonthlyIncome,
MAX(MonthlyIncome) OVER(PARTITION BY Department) AS MaxSalary
FROM employees;

-- 6. Minimum Salary in Department
SELECT EmployeeNumber, Department, MonthlyIncome,
MIN(MonthlyIncome) OVER(PARTITION BY Department) AS MinSalary
FROM employees;

-- 7. Total Salary of Department
SELECT EmployeeNumber, Department, MonthlyIncome,
SUM(MonthlyIncome) OVER(PARTITION BY Department) AS TotalDepartmentSalary
FROM employees;

-- 8. Employee Count in Department
SELECT EmployeeNumber, Department,
COUNT(*) OVER(PARTITION BY Department) AS DepartmentEmployees
FROM employees;

-- 9. Previous Employee Salary
SELECT EmployeeNumber, MonthlyIncome,
LAG(MonthlyIncome) OVER(ORDER BY MonthlyIncome) AS PreviousSalary
FROM employees;

-- 10. Next Employee Salary
SELECT EmployeeNumber, MonthlyIncome,
LEAD(MonthlyIncome) OVER(ORDER BY MonthlyIncome) AS NextSalary
FROM employees;

-- 11. Difference from Previous Salary
SELECT EmployeeNumber, MonthlyIncome,
MonthlyIncome - LAG(MonthlyIncome) OVER(ORDER BY MonthlyIncome) AS SalaryDifference
FROM employees;

-- 12. Running Total Salary
SELECT EmployeeNumber, MonthlyIncome,
SUM(MonthlyIncome) OVER(ORDER BY EmployeeNumber) AS RunningSalary
FROM employees;

-- 13. Running Average Salary
SELECT EmployeeNumber, MonthlyIncome,
AVG(MonthlyIncome) OVER(ORDER BY EmployeeNumber) AS RunningAverage
FROM employees;

-- 14. Highest Salary in Department
SELECT EmployeeNumber, Department, MonthlyIncome,
FIRST_VALUE(MonthlyIncome) OVER(
PARTITION BY Department
ORDER BY MonthlyIncome DESC
) AS HighestSalary
FROM employees;

-- 15. Lowest Salary in Department
SELECT EmployeeNumber, Department, MonthlyIncome,
LAST_VALUE(MonthlyIncome) OVER(
PARTITION BY Department
ORDER BY MonthlyIncome
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS LowestSalary
FROM employees;

-- 16. Salary Percent Rank
SELECT EmployeeNumber, Department, MonthlyIncome,
PERCENT_RANK() OVER(
PARTITION BY Department
ORDER BY MonthlyIncome
) AS PercentRank
FROM employees;

-- 17. Salary Quartiles
SELECT EmployeeNumber, Department, MonthlyIncome,
NTILE(4) OVER(
PARTITION BY Department
ORDER BY MonthlyIncome
) AS SalaryQuartile
FROM employees;

-- 18. Experience Rank
SELECT EmployeeNumber, Department, YearsAtCompany,
RANK() OVER(
PARTITION BY Department
ORDER BY YearsAtCompany DESC
) AS ExperienceRank
FROM employees;

-- 19. Running Average Years at Company
SELECT EmployeeNumber, YearsAtCompany,
AVG(YearsAtCompany) OVER(
ORDER BY EmployeeNumber
) AS RunningYearsAverage
FROM employees;

-- 20. Highest Income by Job Role
SELECT EmployeeNumber, JobRole, MonthlyIncome,
RANK() OVER(
PARTITION BY JobRole
ORDER BY MonthlyIncome DESC
) AS JobRoleSalaryRank
FROM employees;