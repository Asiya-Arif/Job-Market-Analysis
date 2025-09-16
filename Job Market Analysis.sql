-- ===============================
-- 1. Select the database
-- ===============================
USE job_market;

-- ===============================
-- 2. Basic Checks
-- ===============================
-- Total rows
SELECT COUNT(*) AS total_jobs FROM ai_job_dataset1;

-- Preview first 10 rows
SELECT * FROM ai_job_dataset1 LIMIT 10;

-- Column structure
DESCRIBE ai_job_dataset1;

-- ===============================
-- 3. Company Insights
-- ===============================
-- Count distinct companies
SELECT COUNT(DISTINCT company_name) AS total_companies
FROM ai_job_dataset1;

-- Top 10 companies by job postings
SELECT company_name, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY company_name
ORDER BY postings DESC
LIMIT 10;

-- Distribution by company size
SELECT company_size, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY company_size
ORDER BY postings DESC;

-- ===============================
-- 4. Location & Remote Work
-- ===============================
-- Top 10 hiring locations
SELECT company_location, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY company_location
ORDER BY postings DESC
LIMIT 10;

-- Remote ratio distribution
SELECT remote_ratio, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY remote_ratio
ORDER BY remote_ratio;

-- Employee residence vs company location (top 10)
SELECT company_location, employee_residence, COUNT(*) AS count_jobs
FROM ai_job_dataset1
GROUP BY company_location, employee_residence
ORDER BY count_jobs DESC
LIMIT 10;

-- ===============================
-- 5. Job Titles & Experience
-- ===============================
-- Top 10 job titles
SELECT job_title, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY job_title
ORDER BY postings DESC
LIMIT 10;

-- Job count by experience level
SELECT experience_level, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY experience_level
ORDER BY postings DESC;

-- Average salary by experience level
SELECT experience_level, ROUND(AVG(salary_usd), 2) AS avg_salary
FROM ai_job_dataset1
GROUP BY experience_level
ORDER BY avg_salary DESC;

-- ===============================
-- 6. Salaries
-- ===============================
-- Overall salary statistics
SELECT 
    MIN(salary_usd) AS min_salary,
    MAX(salary_usd) AS max_salary,
    ROUND(AVG(salary_usd), 2) AS avg_salary,
    ROUND(STD(salary_usd), 2) AS std_dev_salary
FROM ai_job_dataset1;

-- Salary by job title (top 10 highest-paying, at least 5 postings)
SELECT job_title, ROUND(AVG(salary_usd), 2) AS avg_salary, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY job_title
HAVING COUNT(*) > 5
ORDER BY avg_salary DESC
LIMIT 10;

-- Salary by industry
SELECT industry, ROUND(AVG(salary_usd), 2) AS avg_salary, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY industry
HAVING COUNT(*) > 10
ORDER BY avg_salary DESC
LIMIT 10;

-- ===============================
-- 7. Education & Skills
-- ===============================
-- Education requirements distribution
SELECT education_required, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY education_required
ORDER BY postings DESC;

-- Years of experience vs salary
SELECT years_experience, ROUND(AVG(salary_usd), 2) AS avg_salary, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY years_experience
ORDER BY years_experience;

-- Most common skill combinations (top 10)
SELECT required_skills, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY required_skills
ORDER BY postings DESC
LIMIT 10;

-- ===============================
-- 8. Time Trends
-- ===============================
-- Jobs posted per month
SELECT DATE_FORMAT(posted_date, '%Y-%m') AS month, COUNT(*) AS postings
FROM ai_job_dataset1
GROUP BY month
ORDER BY month;

-- Average days between posting and deadline
SELECT AVG(DATEDIFF(application_deadline, posted_date)) AS avg_days_open
FROM ai_job_dataset1;

-- ===============================
-- 9. Benefits & Job Descriptions
-- ===============================
-- Average benefits score by company size
SELECT company_size, ROUND(AVG(benefits_score), 2) AS avg_benefits
FROM ai_job_dataset1
GROUP BY company_size
ORDER BY avg_benefits DESC;

-- Does job description length correlate with salary?
SELECT ROUND(AVG(job_description_length), 0) AS avg_desc_length,
       ROUND(AVG(salary_usd), 2) AS avg_salary
FROM ai_job_dataset1;
