 use techforallwithpriya
 select * from employee
 
 -- For each location, what is the count of each employee and avg salary of the employee in those location
 
  -- For each location, what is the count of each employee and avg salary of the employee in those location  
  -- But also display firstname and lastname corresponding to each record
select location, firstname, lastname, count(location) as Total, AVG(salary) as avg_salary
FROM employee
GROUP BY location, firstname, lastname
 -- This is not correct as this gives us 1, us 1, us 1 while i want us and total as 3
 
 select firstname, lastname, employee.location, total, avg_salary
 from employee
 join
 (select location, count(location) as Total, AVG(salary) as avg_salary
FROM employee
GROUP BY location) as temp
on employee.location = temp.location
 -- this is computationally expensive 
 
 -- group by kind of result is required but we wanna display non aggregated columns as result too but because of that we are not able to perform grouping properly, partition by came into picture, it allows non-aggregation columns to display which was not the possibility in GROUP BY
 -- optimize the above queries via window function
 
--   select firstname, lastname, location, 
--  count(location) over (partition by location) as Total,
--  avg(salary) over (partition by location) as avg_salary
--  from employee
--  ORDER BY location desc;

 INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES
  ("Anuj", "Dhole", 20, 75000, "India"),
  ("Jane", "Williams", 25, 80000, "US");
  
  DESC employee
  
-- ALTER Table employee MODIFY column EID AUTO_INCREMENT this does not work
ALTER TABLE employee
MODIFY COLUMN EID INT AUTO_INCREMENT;

-- Difference between ROW_NUMBER() vs RANK() vs DENSE_RANK()
SELECT firstname, lastname, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS priority_emp
FROM employee;
-- similar salary ones get diff priority, row_number() provides unique priority

SELECT firstname, lastname, salary,
RANK() OVER (ORDER BY salary DESC) AS priority_emp
FROM employee;
-- similar salary gets same priority but it skips next priority internally, gives another number on the go

SELECT firstname, lastname, salary,
dense_rank() OVER (ORDER BY salary DESC) AS priority_emp
FROM employee;
-- perfect one

-- Give the record of the employee having tenth highest salary, will go for rank or dense rank, and if 3rd highest is asked, will go for dense rank

Select * FROM
(SELECT firstname, lastname, salary,
dense_rank() OVER (ORDER BY salary DESC) AS priority_emp
FROM employee) as temp
where priority_emp =10;

-- Give the record of the first employee having tenth highest salary, will go for row number

Select * FROM
(SELECT firstname, lastname, salary,
row_number() OVER (ORDER BY salary DESC) AS priority_emp
FROM employee) as temp
where priority_emp =10;

-- Specify the details of highest salary people in each location

Select * FROM
(SELECT firstname, lastname, salary, location,
row_number() OVER (PARTITION BY LOCATION ORDER BY salary DESC) AS priority_emp
FROM employee) as temp
where priority_emp =1;

-- ChatGPT
-- SELECT 
--     firstname,
--     lastname,
--     location,
--     salary
-- FROM (
--     SELECT 
--         firstname,
--         lastname,
--         location,
--         salary,
--         ROW_NUMBER() OVER (PARTITION BY location ORDER BY salary DESC) AS rn
--     FROM employee
-- ) subquery
-- WHERE rn = 1;
