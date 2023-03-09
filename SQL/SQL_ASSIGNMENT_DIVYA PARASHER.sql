create database if not exists hrdb;
use hrdb;

drop table emp_db;


-- 1.	Write SQL command to create a database named hremployeeDB and a table named HR_Employee 
-- with columns for EmployeeID, Department, JobRole, Attrition, Gender, Age, MaritalStatus, 
-- Education, EducationField, BusinessTravel, JobInvolvement, JobLevel, JobSatisfaction, 
-- Hourlyrate, Income, Salaryhike, OverTime, Workex, YearsSinceLastPromotion, EmpSatisfaction, 
-- TrainingTimesLastYear, WorkLifeBalance, Performance_Rating, and set EmployeeID as the primary key.


create table if not exists emp_db(
EmployeeID int,
Department varchar(30),
JobRole	varchar(30),
Attrition varchar(30),
Gender	varchar(30),
Age	int,
MaritalStatus varchar(30),	
Education varchar(30),
EducationField varchar(30),
BusinessTravel varchar(30),
JobInvolvement varchar(30),
JobLevel int,
JobSatisfaction	varchar(30),
Hourlyrate	int,
Income	int,
Salaryhike	int,
OverTime varchar(30),
Workex	int,
YearsSinceLastPromotion int,
EmpSatisfaction	varchar(30),
TrainingTimesLastYear int,
WorkLifeBalance	varchar(30),
Performance_Rating varchar(30),
primary key(EmployeeID)
);

select *from emp_db;

-- 2.	Return the shape of the table 

desc emp_db;

-- 3.	Show the count of Employee & percentage Workforce in each Department.

SELECT Department, COUNT(Department)/(SELECT COUNT(Department) FROM emp_db)*100 as Workforce_Per 
FROM emp_db
GROUP BY Department;

-- 4.	Which gender have higher strength as workforce in each department.

SELECT Department, Gender, COUNT(Department) as Emp_Count FROM emp_db
GROUP BY Gender, Department;

-- 5.	Show the workforce in each Job Role

SELECT JobRole, COUNT(JobRole) as WorkForce FROM emp_db
GROUP BY JobRole;

-- 6.	Show Distribution of Employee's Age Group.

select Age, count(Age) as Distribution from emp_db
group by JobRole;

SET SQL_SAFE_UPDATES = 1;

alter table emp_db add column age_range varchar(20);
update emp_db
set age_range = if( age < 30 ,'<25', if (age > 50,'>50', '30-50'));

select age_range, count(age) from emp_db
group by age_range;

-- 7.	Compare all marital status of employee and find the most frequent marital status

SELECT MaritalStatus, COUNT(MaritalStatus) as Frequency FROM emp_db
GROUP BY MaritalStatus
ORDER BY Frequency desc;

-- 8.	What is Job satisfaction level of employee?

SELECT JobSatisfaction, COUNT(JobSatisfaction) as Frequency FROM emp_db
GROUP BY JobSatisfaction
ORDER BY Frequency DESC;

-- 9.	How frequently employee is going on Business Trip.
SELECT BusinessTravel, COUNT(BusinessTravel) as Frequency FROM emp_db
GROUP BY BusinessTravel;

-- 10.	Show the Department with Highest Attrition Rate (Percentage)

select Department, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by Department;

-- 11.	Show the Job Role with Highest Attrition Rate (Percentage)

select JobRole, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by JobRole;

-- 12.	Show Distribution of Employee's Promotion, Find the maximum chances of employee getting promoted

SELECT YearsSinceLastPromotion, COUNT(YearsSinceLastPromotion) AS Frequency FROM emp_db
GROUP BY YearsSinceLastPromotion
ORDER BY Frequency DESC;

-- 13.	Find the Attrition Rate for Marital Status.
select MaritalStatus, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by MaritalStatus;
 
 -- 14.	Find the Attrition Count & Percentage for Different Education Levels
 select Education, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by Education;
 
 -- 15.	Find the Attrition & Percentage Attrition for Business Travel.
 
 select BusinessTravel, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by BusinessTravel;
 
 -- 16.	Find the Attrition & Percentage Attrition for Various JobInvolvement
 
 select JobInvolvement, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by JobInvolvement;
 
 -- 17.	Show Attrition Rate for Different JobSatisfaction.
 
 select JobSatisfaction, COUNT(*) as Total_Count,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by JobSatisfaction;
 
 -- 18.	Find key reasons for Attrition in Company.
 
 select JobSatisfaction,MaritalStatus,Education,Salaryhike,WorkLifeBalance, 
 (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
 from emp_db
 group by JobSatisfaction,MaritalStatus,Education,Salaryhike,WorkLifeBalance
 order by attrition_rate DESC limit 1;
 
 
 -- 19.	Return all employee where WorkEx greater than 10, provided that they travel
 -- frequently, WorkLifeBalance as Good and JobSatisfaction is Very High.
 
 SELECT EmployeeID FROM emp_db
WHERE WorkEx > 10 and WorkLifeBalance = 'Good' and JobSatisfaction = 'Very High' and BusinessTravel = 'Travel_Frequently';
 
 
 -- 20.	 Write query to display who has better WorkLifeBalance , Married, 
 -- Single or Divorced provided that Performace_Rating is Outstanding. 
 
SELECT MaritalStatus, WorkLifeBalance, COUNT(WorkLifeBalance) FROM emp_db
where Performance_Rating = 'Outstanding'
GROUP BY WorkLifeBalance, MaritalStatus
ORDER BY MaritalStatus;
 
 
 
 