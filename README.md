# HR-Dashboard-MySQL-PowerBI
### Project Overview
This project uses SQL and Power BI to create an interactive dashboard that analyzes key aspects of a company’s workforce, including demographics, job roles, and employment trends. The dashboard provides a comprehensive view of employee diversity, departmental distributions, tenure, and turnover, offering valuable insights for strategic workforce planning and HR decision-making.

### Objective
The primary objective is to transform raw employee data into actionable insights that inform business decisions on workforce diversity, retention, and resource allocation. By analyzing data across gender, age, race/ethnicity, job roles, and locations, this dashboard enables HR leaders to track patterns in employee distribution, tenure, and headcount changes over time. The result is a powerful tool that supports informed decision-making to improve recruitment, retention, and overall workforce engagement.

### Data Used
Data - HR Data with over 22000 rows from the year 2000 to 2020.

Data Cleaning & Analysis - MySQL Workbench

Data Visualization - PowerBI


### Data Cleaning and Preparation
In the initial data preparation phase, we performed the following tasks:
1. Data loading and inspection
2. Handling missing values
3. Data cleaning and formatting


### Questions
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by state?
10. How has the company's employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

### Key Insights
- The company has a higher proportion of male employees overall.
- White employees make up the largest racial group, while Native Hawaiian and American Indian employees are the least represented.
- Employee ages range from 20 to 57, with the majority falling between 25-34, followed by 35-44. The smallest age group is 55-64.
- Most employees are based at the headquarters, with fewer working remotely.
- Terminated employees have an average tenure of approximately 7 years.
- Gender distribution is generally balanced across departments, though there is a slightly higher number of male employees.
- The Marketing department has the highest turnover rate, followed by Training, while Research and Development, Support, and Legal departments have the lowest turnover rates.
- Ohio has the largest number of employees among all states.
- The company’s employee headcount has increased over time.
- Average tenure by department is around 8 years, with the longest tenures in Legal and Auditing, and the shortest in Services, Sales, and Marketing.

### Limitations
- Negative Age Values: Records with negative age values (967 records) were excluded during data processing. Only ages 18 years and older were considered in the analysis.
- Future Termination Dates: Termination dates that were set in the future (1599 records) were excluded from the analysis. Only termination dates on or before the current date were included.
