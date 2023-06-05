CREATE DATABASE projects;
select * from sys.tables 
USE projects;


SELECT * FROM [Human Resources];

ALTER TABLE [Human Resources]
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE [Human Resources];

SELECT birthdate FROM [Human Resources];

SET sql_safe_updates = 0;

BEGIN TRAN 
UPDATE [Human Resources]
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN REPLACE (convert(varchar, birthdate, 23),'/'	,'-')
 --   WHEN birthdate LIKE '%-%' THEN (convert(varchar, birthdate, 23),'-'	,'-')
    ELSE birthdate
END;

--COMMIT TRAN 
--ROLLBACK TRAN 

SELECT name , * FROM sys.time_zone_info;
SELECT 
termdate,
DATEADD(MI, DATEDIFF(MI, GETUTCDATE(), GETDATE()), termdate) 
AS LOCAL_IST
FROM [Human Resources]
;

ALTER TABLE HR_Data
ALTER COLUMN birthdate  DATE;

SELECT CONVERT(datetime, '2014-11-02 07:29:37 UTC') AT TIME ZONE 'UTC+12' AT TIME ZONE 'Pacific Standard Time'

SELECT hire_date DA, * FROM [Human Resources] ORder by Hire_date desc 

bEGIN TRAN
UPDATE [Human Resources]
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN  REPLACE (convert(varchar, birthdate, 23),'/'	,'-')
    WHEN hire_date LIKE '%-%' THEN  REPLACE (convert(varchar, birthdate, 23),'-'	,'-')
    ELSE hire_date
END;

ALTER TABLE [Human Resources]
ALTER COLUMN hire_date  DATE;


SELECT SUM(CASE WHEN termdate IS NOT NULL AND termdate <= getdate() THEN 1 ELSE 0 END) FROM [Human Resources] where  termdate <> '' 

BEGIN TRAN
UPDATE Hr_data
SET termdate =  (REPLACE(termdate , 'UTC', ''))
WHERE termdate IS NOT NULL AND termdate != ' ';
--COMMIT TRAN
--ROLLBACK TRAN 

SELECT  CONVERT(varchar(50),termdate, 111), * FROM [Human Resources]

UPDATE [Human Resources]
SET termdate = CONVERT(varchar(50),termdate, 23)
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE [Human Resources]
ALTER COLUMN termdate  DATE ISDATE(termdate) = 0;

SELECT termdate
FROM [Human Resources]
WHERE ISDATE(termdate) = 0;



BEGIN TRAN 
UPDATE [Human Resources] set Termdate= NULL
where Termdate= '0000-00-00'



SELECT birthdate, age,* FROM [Human Resources]

ALTER TABLE HR_Data ADD  age INT;


BEGIN TRAN
UPDATE HR_Data
SET age = dateDIFF(YEAR, birthdate, GETDATE());


COMMIT TRAN 



SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM [Human Resources];

SELECT count(*) FROM [Human Resources] WHERE age < 18;

SELECT COUNT(*) FROM [Human Resources] WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM [Human Resources]
WHERE termdate = '0000-00-00';

SELECT location FROM [Human Resources];










/*
SELECT SUM(CASE WHEN termdate IS NOT NULL AND termdate <= getdate() THEN 1 ELSE 0 END) FROM [Human Resources] where  termdate <> '' 

select termdate, * from HR_data where termdate <>  '1900-01-01'        IS NULL
  termdate = ' '
 select (22214-18285)

BEGIN TRAN
UPDATE HR_data
SET termdate =  REPLACE(termdate , 'UTC', '')
WHERE termdate IS NOT NULL AND termdate != ' ';
--COMMIT TRAN
--ROLLBACK TRAN 

SELECT  CONVERT(varchar(50),termdate, 111), * FROM HR_data
BEGIN TRAN
UPDATE [Human Resources]
SET termdate = CAST(termdate as date)
WHERE termdate IS NOT NULL AND termdate != ' ';

BEGIN TRAN
ALTER TABLE HR_data
ALTER COLUMN termdate  DATE ;

SELECT termdate
FROM [Human Resources]
WHERE ISDATE(termdate) = 0;


BEGIN TRAN 
UPDATE [Human Resources] 
SET Termdate = NULL
WHERE Termdate = '1900-01-01'



ROLLBACK TRAN 


SELECT AVG(ABS(datediff(DAY,termdate, hire_date)))/365 AS avg_length_of_employment
FROM [Human Resources]
WHERE termdate <= '2023-05-04' and  termdate <> '1900-01-01'   AND age>= 18;


select ABS(datediff(DAY,'2008-12-05','1996-12-13'))

SELECT *
FROM [Human Resources]
WHERE termdate <> '1900-01-01' AND termdate <= '2023-05-04' AND age >= 18;


SELECT SUM(ABS(datediff(DAY,termdate, hire_date)))/ 2334/365 AS [avg_length_of_employment] 
FROM [Human Resources]
WHERE termdate <> '1900-01-01' AND termdate <= dateadd (month , -1, getdate()) AND age >= 18
GROUP BY ABS(datediff(YEAR,termdate, hire_date))



SELECT department, COUNT(*) as [total_count], 
    SUM(CASE WHEN termdate <= Getdate() AND termdate IS NOT NULL THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '1900-01-01' THEN 1 ELSE 0 END) as active_count,
    
	SUM(CASE WHEN termdate <= Getdate() AND termdate IS NOT NULL THEN 1 ELSE 0 END)/ count(1) as termination_rate
FROM [Human Resources]
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;





SELECT department, COUNT(1) as total_count,
  ( SUM( CASE WHEN termdate <= Getdate() THEN 1 ELSE 0 END)/	COUNT(1) ) as termination_rate

	FROM [Human Resources]
WHERE age >= 18
GROUP BY department,
CASE WHEN termdate <= Getdate() THEN 1 ELSE 0 END
ORDER BY termination_rate DESC;



SELECT department,  total_count,terminated_count,
((CAST(terminated_count  AS DECIMAL (5, 1))/ total_count)*100) AS Termination_rate

  FROM (
 SELECT department, COUNT(1) as total_count,
   SUM( CASE WHEN termdate <> '1900-01-01' and termdate <= getdate() THEN 1 ELSE 0 END) as Terminated_count
FROM HR_DATA
WHERE age >= 18
GROUP BY department
) AS Subquery 
Order by Termination_rate desc 






SELECT department, COUNT(*) as [total_count], 
    SUM(CASE WHEN termdate <= Getdate() AND termdate IS NOT NULL THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '1900-01-01' THEN 1 ELSE 0 END) as active_count,
    
	CAST(SUM(CASE WHEN termdate <= Getdate() AND termdate IS NOT NULL THEN 1 ELSE 0 END)/ count(1) AS DECIMAL(10,2)) as termination_rate
FROM [Human Resources]
WHERE age >= 18
GROUP BY department






-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END))
	/ CAST(COUNT(*) AS DECIMAL(4,0) )  * 100),2)  AS net_change_percent
FROM 
    HR_data
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;



	SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END) AS net_change,
    FORMAT(ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '1900-01-01' and termdate <= '2023-05-04' THEN 1 ELSE 0 END))
	/ CAST(COUNT(*) AS DECIMAL(4,0) )  * 100),2), '0.00')  AS net_change_percent
FROM 
    HR_data
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;


	select count(*), YEAR(hire_date )from HR_data
	group by YEAR (hire_date)
	ORDER BY YEAR (hire_date)










	
SELECT termdate, *
FROM HR_data
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;





	
SELECT department, COUNT(1) as total_count, 
    SUM(CASE WHEN termdate <= GETDATE()  AND termdate <> '1900-01-01' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '1900-01-01' THEN 1 ELSE 0 END) as active_count,
    ROUND(CAST(SUM(CASE WHEN termdate <= GETDATE() THEN 1 ELSE 0 END) AS FLOAT ) / COUNT(1), 4) as termination_rate
FROM HR_data
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;









DECLARE @DATE DATE
SET @DATE = GETDATE()
SELECT @DATE

SELECT department,  AVG(DATEDIFF(YEAR,@DATE,termdate )) as avg_tenure
FROM [HR_DATA]
WHERE termdate <= getdate() AND termdate <>  '1900-01-01'  AND age >= 18
GROUP BY department
order by avg_tenure desc



SELECT department, TermDate , Hire_Date , Getdate()
FROM Hr_data
WHERE termdate <= getdate() AND termdate <>  '1900-01-01'  AND age >= 18




SELECT department,  AVG(DATEDIFF(YEAR,termdate ,Getdate())) as avg_tenure
FROM [HR_DATA]
WHERE termdate <= getdate() AND termdate <>  '1900-01-01'  AND age >= 18
GROUP BY department
order by avg_tenure desc

*/