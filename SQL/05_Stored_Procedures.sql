USE hr_analytics;

-- =====================================================
-- STORED PROCEDURES
-- =====================================================

----------------------------------------------------------
-- Procedure 1 : Employees by Department
----------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeesByDepartment;

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(100))
BEGIN
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        YearsAtCompany
    FROM employees
    WHERE Department = dept_name
    ORDER BY MonthlyIncome DESC;
END $$

DELIMITER ;

CALL GetEmployeesByDepartment('Sales');

----------------------------------------------------------
-- Procedure 2 : Employees Above Given Salary
----------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeesAboveSalary;

DELIMITER $$

CREATE PROCEDURE GetEmployeesAboveSalary(IN salary_amount INT)
BEGIN
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome
    FROM employees
    WHERE MonthlyIncome >= salary_amount
    ORDER BY MonthlyIncome DESC;
END $$

DELIMITER ;

CALL GetEmployeesAboveSalary(10000);

----------------------------------------------------------
-- Procedure 3 : Attrition Summary by Department
----------------------------------------------------------

DROP PROCEDURE IF EXISTS GetDepartmentAttrition;

DELIMITER $$

CREATE PROCEDURE GetDepartmentAttrition(IN dept_name VARCHAR(100))
BEGIN
    SELECT
        Department,
        COUNT(*) AS EmployeesLeft
    FROM employees
    WHERE Department = dept_name
      AND Attrition='Yes'
    GROUP BY Department;
END $$

DELIMITER ;

CALL GetDepartmentAttrition('Research & Development');