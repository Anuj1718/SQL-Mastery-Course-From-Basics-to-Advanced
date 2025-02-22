-- DDL : CARDT (DROP) , DML : SIDUM 

-- | **Feature**        | **DROP**               | **TRUNCATE**          | **DELETE**              |
-- |---------------------|------------------------|------------------------|-------------------------|
-- | **Action**         | Deletes structure & data | Deletes data only     | Deletes specific rows   |
-- | **Condition**      | Not applicable          | Not applicable         | Supported (`WHERE`)     |
-- | **Speed**          | Fast                   | Very fast             | Slower for large data   |
-- | **Rollback**       | Not possible           | Not possible (generally) | Possible in a transaction |
-- | **Triggers**       | Not activated          | Not activated          | Activated               |
-- | **Usage**          | Removing table or database | Clearing entire table | Removing selective rows |

-- MySQL supports a wide range of operators, which can be classified into different categories based on their functionality. Here's a breakdown of the common operators in MySQL:

-- ### 1. **Arithmetic Operators**
-- Used for mathematical calculations.

-- | Operator  | Description                | Example               |
-- |-----------|----------------------------|-----------------------|
-- | `+`       | Addition                   | `SELECT 5 + 3;`       |
-- | `-`       | Subtraction                | `SELECT 5 - 3;`       |
-- | `*`       | Multiplication             | `SELECT 5 * 3;`       |
-- | `/`       | Division                   | `SELECT 6 / 3;`       |
-- | `%`       | Modulo (remainder)         | `SELECT 5 % 3;`       |

-- ### 2. **Comparison Operators**
-- Used to compare two values.

-- | Operator  | Description                | Example                          |
-- |-----------|----------------------------|----------------------------------|
-- | `=`       | Equal to                   | `SELECT * FROM employees WHERE age = 30;` |
-- | `!=` or `<>` | Not equal to             | `SELECT * FROM employees WHERE age != 30;` |
-- | `<`       | Less than                  | `SELECT * FROM employees WHERE age < 30;` |
-- | `>`       | Greater than               | `SELECT * FROM employees WHERE age > 30;` |
-- | `<=`      | Less than or equal to      | `SELECT * FROM employees WHERE age <= 30;` |
-- | `>=`      | Greater than or equal to   | `SELECT * FROM employees WHERE age >= 30;` |
-- | `BETWEEN` | Between two values         | `SELECT * FROM employees WHERE age BETWEEN 20 AND 30;` |
-- | `LIKE`    | Pattern matching           | `SELECT * FROM employees WHERE name LIKE 'J%';` |
-- | `IN`      | Matches any value in a list | `SELECT * FROM employees WHERE age IN (25, 30, 35);` |
-- | `IS NULL` | Check for NULL values      | `SELECT * FROM employees WHERE age IS NULL;` |

-- ### 3. **Logical Operators**
-- Used to combine multiple conditions.

-- | Operator  | Description                | Example                             |
-- |-----------|----------------------------|-------------------------------------|
-- | `AND`     | Returns true if both conditions are true | `SELECT * FROM employees WHERE age > 30 AND salary > 50000;` |
-- | `OR`      | Returns true if at least one condition is true | `SELECT * FROM employees WHERE age > 30 OR salary > 50000;` |
-- | `NOT`     | Negates a condition         | `SELECT * FROM employees WHERE NOT age > 30;` |

-- ### 4. **Bitwise Operators**
-- Used for bitwise operations on integer values.

-- | Operator  | Description                | Example                          |
-- |-----------|----------------------------|----------------------------------|
-- | `&`       | Bitwise AND                | `SELECT 5 & 3;` (result: 1)      |
-- | `|`       | Bitwise OR                 | `SELECT 5 | 3;` (result: 7)      |
-- | `^`       | Bitwise XOR                | `SELECT 5 ^ 3;` (result: 6)      |
-- | `<<`      | Left shift                 | `SELECT 5 << 1;` (result: 10)    |
-- | `>>`      | Right shift                | `SELECT 5 >> 1;` (result: 2)     |

-- ### 5. **String Operators**
-- Used for string manipulation.

-- | Operator  | Description                | Example                          |
-- |-----------|----------------------------|----------------------------------|
-- | `CONCAT()`| Concatenate strings        | `SELECT CONCAT('Hello', ' ', 'World');` |
-- | `LIKE`    | Pattern matching           | `SELECT * FROM employees WHERE name LIKE 'J%';` |
-- | `LENGTH()`| Length of string           | `SELECT LENGTH('Hello');` (result: 5) |
-- | `SUBSTRING()` | Extract part of a string | `SELECT SUBSTRING('Hello', 1, 3);` (result: 'Hel') |



-- ### 6. **Null-safe Operators**
-- Used for handling `NULL` values.

-- | Operator   | Description                | Example                          |
-- |------------|----------------------------|----------------------------------|
-- | `IS NULL`  | Check for NULL value        | `SELECT * FROM employees WHERE age IS NULL;` |
-- | `IS NOT NULL` | Check if not NULL         | `SELECT * FROM employees WHERE age IS NOT NULL;` |
-- | `<=>`      | Null-safe equality         | `SELECT * FROM employees WHERE age <=> NULL;` |

-- In MySQL, the null-safe equality operator is written as <=>. It is used to compare two values, including NULL, and ensures that the comparison behaves predictably even when NULL is involved.

-- Behavior of <=>
-- It returns 1 (true) if both operands are equal or if both are NULL.
-- It returns 0 (false) if the operands are not equal.
-- Unlike the = operator, <=> does not return NULL when one or both operands are NULL.
-- Key Differences Between = and <=>
-- = operator: If either operand is NULL, the comparison result is NULL.
-- <=> operator: It explicitly considers NULL as a comparable value.


-- ### 7. **Other Operators**

-- | Operator   | Description                | Example                             |
-- |------------|----------------------------|-------------------------------------|
-- | `=`        | Equality                   | `SELECT * FROM employees WHERE id = 1;` |
-- | `!=`       | Not equal to               | `SELECT * FROM employees WHERE id != 1;` |
-- | `COUNT()`  | Count number of rows        | `SELECT COUNT(*) FROM employees;` |
-- | `SUM()`    | Sum of column values        | `SELECT SUM(salary) FROM employees;` |
-- | `MAX()`    | Maximum value in a column   | `SELECT MAX(salary) FROM employees;` |
-- | `MIN()`    | Minimum value in a column   | `SELECT MIN(salary) FROM employees;` |
-- | `AVG()`    | Average value in a column   | `SELECT AVG(salary) FROM employees;` |

-- ### 8. **Aggregate Functions**
-- These are used to perform calculations on multiple rows of a table.

-- | Function  | Description                | Example                          |
-- |-----------|----------------------------|----------------------------------|
-- | `COUNT()` | Returns the number of rows  | `SELECT COUNT(*) FROM employees;` |
-- | `SUM()`   | Returns the sum of a column | `SELECT SUM(salary) FROM employees;` |
-- | `AVG()`   | Returns the average value   | `SELECT AVG(salary) FROM employees;` |
-- | `MAX()`   | Returns the maximum value   | `SELECT MAX(salary) FROM employees;` |
-- | `MIN()`   | Returns the minimum value   | `SELECT MIN(salary) FROM employees;` |

-- ---

-- ### Summary:
-- MySQL provides a variety of operators to work with different data types, such as numbers, strings, and boolean values, allowing you to filter, manipulate, and compute results in your SQL queries.

-- Interview Que : Can you use multiple distinct clauses in one query? 
-- Yes, you can use more than one `DISTINCT` in an SQL query, but not in a single 'SELECT' query and the way you apply it depends on what you're trying to achieve. Here are common scenarios:

-- ---

-- ### 1. **Using Multiple `DISTINCT` in Different Columns**
-- If you want to apply `DISTINCT` to different columns independently, you need to use subqueries or derived tables because `DISTINCT` applies to the entire row by default.

-- #### Example:
-- Suppose you have a table `orders` with columns `customer_id`, `product_id`, and `order_date`.

-- - **Requirement**: Find distinct customer IDs and distinct product IDs.
--   
-- ```sql
-- SELECT DISTINCT customer_id FROM orders
-- UNION
-- SELECT DISTINCT product_id FROM orders;
-- ```

-- In this case:
-- - The first `DISTINCT` retrieves unique customer IDs.
-- - The second `DISTINCT` retrieves unique product IDs, and the `UNION` combines the results.

-- ---

-- ### 2. **Using `DISTINCT` on Combined Columns**
-- When you use `DISTINCT` in the `SELECT` statement, it considers the combination of all selected columns.

-- #### Example:
-- Find unique combinations of `customer_id` and `product_id`:

-- ```sql
-- SELECT DISTINCT customer_id, product_id 
-- FROM orders;
-- ```

-- ---

-- ### 3. **Using `DISTINCT` with Aggregates**
-- You can use `DISTINCT` with aggregate functions, such as `COUNT`, `SUM`, etc.

-- #### Example:
-- Count the distinct `product_id` for each `customer_id`:

-- ```sql
-- SELECT customer_id, COUNT(DISTINCT product_id) AS distinct_products
-- FROM orders
-- GROUP BY customer_id;
-- ```

-- ---

-- ### Notes:
-- - Using multiple `DISTINCT` keywords in a single `SELECT` statement (e.g., `SELECT DISTINCT col1, DISTINCT col2`) is **not allowed** directly.
-- - To handle complex scenarios, leverage subqueries, `UNION`, or derived tablE

-- Whatever non-aggregated columns you write after select, you must write them in group by, but vice versa is not true. If you write something after group by, it does not necessarily have to be after select.
-- order by is the last clause of select statement, cannot write it before group by

-- Query for showing jobs having 3 letters

SELECT JobTitle
FROM Jobs
WHERE LENGTH(JobTitle) = 3;

SELECT JobTitle
FROM Jobs
WHERE JobTitle LIKE '___';

-- LIKE '___': This pattern matches any job title that has exactly three characters:
-- Each underscore (_) represents one character.
-- The pattern '___' ensures that the job title has exactly three characters.

-- show data of employees who have e as third letter in their last name

SELECT *
FROM Employees
WHERE SUBSTRING(LastName, 3, 1) = 'e';
  
-- So in the case of SUBSTRING(LastName, 3, 1):

-- The first parameter (LastName) is the column from which to extract the substring.
-- The second parameter (3) indicates the starting position in the string (the third character in this case).
-- The third parameter (1) indicates how many characters to extract, starting from the third character.

SELECT *
FROM Employees
WHERE LastName LIKE '__e%';

-- LIKE '__e%': This pattern matches any last name where:
-- __: The first two characters can be anything (denoted by two underscores).
-- e: The third character must be "e".
-- %: The remaining characters (if any) after the third position can be anything

-- number functions 
SELECT 
    ABS(-15.78) AS Absolute_Value,      -- Absolute value of -15.78: Returns 15.78 because ABS removes the negative sign.
    CEIL(7.3) AS Ceil_Value,            -- Ceiling value of 7.3: Returns 8 because CEIL rounds the number up to the nearest integer.(smallest integer greater than or equal to the number.)
    FLOOR(7.9) AS Floor_Value,          -- Floor value of 7.9: Returns 7 because FLOOR rounds the number down to the nearest integer. (largest integer less than or equal to the number.)
    SQRT(16) AS Square_Root,            -- Square root of 16: Returns 4 because the square root of 16 is 4.
    ROUND(15.678, 2) AS Rounded_Value,  -- Rounded value of 15.678 to 2 decimal places: Returns 15.68 because it rounds to the nearest 2 decimal places.
    TRUNCATE(15.678, 2) AS Truncated_Value, -- Truncates 15.678 to 2 decimal places: Returns 15.67 because TRUNCATE cuts off extra decimal places without rounding.
    POWER(2, 3) AS Power_Value;         -- 2 raised to the power of 3: Returns 8 because 2^3 equals 8.

-- Built-In String functions
SELECT 
    LENGTH('Hello World') AS Length,  -- Returns the length of the string 'Hello World' (output: 11)
    CONCAT('Hello', ' ', 'World') AS Concatenated,  -- Concatenates 'Hello', ' ', and 'World' (output: 'Hello World')
    LOWER('HELLO') AS Lowercase,  -- Converts 'HELLO' to lowercase (output: 'hello')
    UPPER('hello') AS Uppercase,  -- Converts 'hello' to uppercase (output: 'HELLO')
    LEFT('Hello World', 5) AS LeftSubstring,  -- Returns the leftmost 5 characters of 'Hello World' (output: 'Hello')
    RIGHT('Hello World', 5) AS RightSubstring,  -- Returns the rightmost 5 characters of 'Hello World' (output: 'World')
    SUBSTRING('Hello World', 7, 5) AS Substring;  -- Extracts 5 characters starting from the 7th position (output: 'World')

-- Padding functions: LPAD and RPAD
SELECT LPAD('123', 5, '0');  -- Pads '123' to the left to make the string 5 characters long by adding '0's (output: '00123')

SELECT RPAD('123', 5, '0');  -- Pads '123' to the right to make the string 5 characters long by adding '0's (output: '12300')

-- TRIM function
SELECT TRIM('  Hello World  ');  -- Removes leading and trailing spaces from '  Hello World  ' (output: 'Hello World')


SELECT TRIM(LEADING 'A' FROM 'AAHello World'),
TRIM(TRAILING 'A' FROM 'Hello WorldAAA'),
TRIM(BOTH 'A' FROM 'AHello WorldA'),
TRIM('A' FROM 'AHello WorldA'); -- by default, both


    -- System functions
    SELECT VERSION(), USER(), current_user()  
    
--  VERSION(): This is a system function that returns the version of the MySQL server.
-- USER(): This is a system function that returns the current MySQL user name and host name.
-- CURRENT_USER(): This is a system function that returns the authenticated user for the current MySQL connection (the user who logged in)

-- create table which has sum,max,min,avg count of employee salaries for the employee working in age other than 30 to 50
CREATE TABLE DER_DATA 
AS
SELECT 
    SUM(salary) AS Total_Salary,         -- Sum of all employee salaries
    MAX(salary) AS Max_Salary,           -- Maximum salary
    MIN(salary) AS Min_Salary,           -- Minimum salary
    AVG(salary) AS Avg_Salary,           -- Average salary
    COUNT(salary) AS Employee_Count      -- Total count of employees
FROM 
    employee
WHERE 
    age NOT BETWEEN 30 AND 50;  -- Exclude employees working in age 30 to 50

drop table der_data

select concat(upper("anuj"), substr("helloworld",6,5)) -- nested functions