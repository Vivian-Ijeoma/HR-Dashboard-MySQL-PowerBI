CREATE DATABASE projects;
CREATE DATABASE duplicate_projects;
USE projects;
SELECT * FROM hr;
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20)NULL;

DESCRIBE hr;
SELECT birthdate FROM hr;

SET sql_safe_updates=0;
UPDATE hr
SET birthdate= CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;
SELECT * FROM hr;

UPDATE hr
SET hire_date= CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT * FROM hr;
SELECT termdate FROM hr;

UPDATE hr
SET termdate = '1900-01-01'
WHERE termdate = '' OR termdate = '0000-00-00';


UPDATE hr
SET termdate = DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL 
  AND termdate != '1900-01-01' 
  AND termdate != '0000-00-00';
  
ALTER TABLE hr
MODIFY COLUMN termdate DATE;
SELECT * FROM hr;
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate, CURDATE());
SELECT birthdate,age FROM hr; 
SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;
SELECT count(*) FROM hr WHERE age<18;

-- Questions
-- 1. What is the gender breakdown of employees in the company?
ALTER TABLE hr
MODIFY COLUMN termdate VARCHAR(10);
UPDATE hr
SET termdate = NULL
WHERE termdate = '0000-00-00';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;
SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '1900-01-01'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '1900-01-01'
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?
SELECT 
min(age) AS youngest,
max(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '1900-01-01';
-- Age groups

SELECT
	CASE
		WHEN age>=18 AND age <=24 THEN '18-24'
        WHEN age>=25 AND age <=34 THEN '25-34'
        WHEN age>=35 AND age  <=44 THEN '35-44'
        WHEN age>=45 AND age <=54 THEN '45-54'
        WHEN age>=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '1900-01-01'
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE
		WHEN age>=18 AND age <=24 THEN '18-24'
        WHEN age>=25 AND age <=34 THEN '25-34'
        WHEN age>=35 AND age <=44 THEN '35-44'
        WHEN age>=45 AND age <=54 THEN '45-54'
        WHEN age>=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
    count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '1900-01-01'
GROUP BY age_group, gender
ORDER BY age_group, gender;
       
-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY location;

-- 5. What is the average length of employment fro employees who have  been terminated?
SELECT 
round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_emp
FROM hr
WHERE termdate <= curdate() AND termdate <> '1900-01-01' AND age>=18;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?(how long do employee work before they quit or fired) 
SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
    FROM(
		SELECT department,
        count(*) AS total_count,
        SUM(CASE WHEN termdate <> '1900-01-01'AND 
        termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
        FROM hr
        WHERE age >=18
        GROUP BY department
        ) AS subquery
	ORDER BY termination_rate DESC;
    
-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count change  over time based on hire and term dates?
SELECT 
year,
hires,
terminations,
hires- terminations AS net_change,
round((hires-terminations)/hires *100, 2 ) AS net_change_percent
FROM(
	 SELECT
     YEAR(hire_date) AS year,
     count(*) AS hires,
     SUM(CASE WHEN termdate <> '1990-01-01' AND termdate <= curdate 
     THEN 1 ELSE 0 END) AS terminations
		FROM hr
        WHERE age >=18
        GROUP BY YEAR(hire_date)
        ) AS subquery
	ORDER BY year ASC;
    
-- 11. What is the tenure distribution for each department?


  


