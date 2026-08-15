CREATE DATABASE hr_analytics;
USE hr_analytics;
CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(30),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);
SHOW DATABASES;
USE hr_analytics;

SHOW TABLES;
SELECT COUNT(*) AS Total_Employees
FROM employees;
SELECT *
FROM employees
LIMIT 5;
SELECT *
FROM employees
WHERE
Age IS NULL
OR Department IS NULL
OR JobRole IS NULL
OR MonthlyIncome IS NULL;
SELECT EmployeeNumber,
COUNT(*) AS Duplicate_Count
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;
SELECT DISTINCT Department
FROM employees;
SELECT DISTINCT JobRole
FROM employees;
SELECT DISTINCT Attrition
FROM employees;
SELECT
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM employees;
SELECT
    Department,
    COUNT(*) AS Employees_Left
FROM employees
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Employees_Left DESC;
SELECT
    Department,
    COUNT(*) AS Total_Employees
FROM employees
GROUP BY Department
ORDER BY Total_Employees DESC;
SELECT
    Gender,
    COUNT(*) AS Total
FROM employees
GROUP BY Gender;
SELECT
    Department,
    ROUND(AVG(MonthlyIncome),2) AS Average_Salary
FROM employees
GROUP BY Department
ORDER BY Average_Salary DESC;
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM employees
ORDER BY MonthlyIncome DESC
LIMIT 10;
SELECT
    OverTime,
    Attrition,
    COUNT(*) AS Employees
FROM employees
GROUP BY OverTime, Attrition;
SELECT
    ROUND(AVG(YearsAtCompany),2) AS Average_Years
FROM employees;
SELECT
    JobSatisfaction,
    COUNT(*) AS Employees
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

    