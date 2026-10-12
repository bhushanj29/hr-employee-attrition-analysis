CREATE DATABASE Hr_Attrition;
USE Hr_Attrition;
SELECT * FROM hr_employee_attrition;
SELECT COUNT(*) AS Total_Employees
FROM hr_employee_attrition;

-- how manny employees left
SELECT COUNT(*)AS Employees_Left
FROM hr_employee_attrition
WHERE Attrition = "Yes";

-- Attrition rate

SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM hr_employee_attrition;

-- Department-Wise Employees Count
SELECT Department,count(*) AS Employee_count
FROM hr_employee_attrition
group by Department
ORDER BY Employee_count DESC;

-- Department-Wise Attrition
SELECT Department,count(*)AS Employees_Left
FROM hr_employee_attrition
WHERE Attrition = "Yes"
GROUP BY Department 
ORDER BY  Employees_Left DESC;

-- Average Salary by department
SELECT
    Department,
    ROUND(AVG(Monthly_Income), 2) AS Average_Salary
FROM hr_employee_attrition
GROUP BY Department
ORDER BY Average_Salary DESC;

-- Employees earning more than average salary
SELECT
    Employee_ID,
    Department,
    Job_Role,
    Monthly_Income
FROM hr_employee_attrition
WHERE Monthly_Income > (
    SELECT AVG(Monthly_Income)
    FROM hr_employee_attrition
)
ORDER BY Monthly_Income DESC;

-- Overtime and Attrition 
SELECT Overtime ,Attrition,count(*)AS total_employee
FROM hr_employee_attrition
GROUP BY Overtime ,Attrition
ORDER BY Overtime ,Attrition;

-- Job-role-wise attrition
SELECT
    Job_Role,
    COUNT(*) AS Employees_Left
FROM hr_employee_attrition
WHERE Attrition = 'Yes'
GROUP BY Job_Role
ORDER BY Employees_Left DESC;

-- Low job satisfaction employees who left
SELECT
    Employee_ID,
    Department,
    Job_Role,
    Job_Satisfaction,
    Attrition
FROM hr_employee_attrition
WHERE Job_Satisfaction <= 2
AND Attrition = 'Yes';

-- Employees with high absence
SELECT employee_id , Department,Absence_days,Attrition
FROM hr_employee_attrition
WHERE Absence_Days > 15
ORDER BY Absence_Days DESC;

-- Attrition by Gender
SELECT
    Gender,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left
FROM hr_employee_attrition
GROUP BY Gender;

-- Employees with less than 2 years experience who left
SELECT
    Employee_ID,
    Department,
    Job_Role,
    Years_At_Company,
    Attrition
FROM hr_employee_attrition
WHERE Years_At_Company < 2
AND Attrition = 'Yes'
ORDER BY Years_At_Company;

-- Department with highest attrition rate
SELECT
    Department,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC
LIMIT 1;
 