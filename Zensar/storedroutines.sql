-- Stored Routines : Stored Functions and Stored Procedures
-- In PL/SQL (or MySQL procedural SQL), you can use **`DELIMITER`** and **`CREATE FUNCTION`** to create a deterministic function for adding two numbers. Here's how you can do it in MySQL:

-- ### Example: Creating a Deterministic Function

DELIMITER //

CREATE FUNCTION add_numbers(num1 DOUBLE, num2 DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN num1 + num2; -- Add the two numbers and return the result
END;
//

DELIMITER ;

show function status -- to check if function is created or not

-- ### Explanation:
-- 1. **`DELIMITER //`**:
--    - By default, the MySQL delimiter is `;`. Changing it to `//` allows you to define multi-line functions or procedures without conflict.

-- 2. **`CREATE FUNCTION`**:
--    - Defines a function named `add_numbers` that takes two arguments (`num1` and `num2`) of type `DOUBLE`.

-- 3. **`RETURNS DOUBLE`**:
--    - Specifies the data type of the value returned by the function.

-- 4. **`DETERMINISTIC`**:
--    - Indicates the function will always return the same result for the same input values (important for optimization and replication).

-- 5. **`RETURN num1 + num2`**:
--    - Performs the addition and returns the result.

-- 6. **`DELIMITER ;`**:
--    - Resets the delimiter back to the default `;`.


-- ### Using the Function
-- Once the function is created, you can use it in queries.

-- #### Example Query:

 SELECT add_numbers(10, 20) AS Sum; -- 30

-- #### Example with a Table:
-- If you have a table `numbers`:

CREATE TABLE numbers (num1 DOUBLE, num2 DOUBLE);
INSERT INTO numbers VALUES (10, 20), (5, 15), (100, 200);

-- You can use the function in a query like this:

SELECT num1, num2, add_numbers(num1, num2) AS Sum FROM numbers;

### **Summary Table for function vs procedure :

-- | Feature                 | Function                          | Procedure                          |
-- |-------------------------|-----------------------------------|------------------------------------|
-- | **Return Value**        | Single value                     | Zero, one, or multiple values     |
-- | **Call Method**         | Part of SQL query                | `CALL` statement                  |
-- | **Parameters**          | Only `IN`                       | `IN`, `OUT`, `INOUT`              |
-- | **Database Modifications** | Not allowed                   | Allowed                           |
-- | **Transaction Control** | Not allowed                     | Allowed                           |
-- | **Usage**               | Calculations/transformations     | Complex business logic            |

-- write a function which returns total experience of the employee in the company in employee1 table

CREATE TABLE employee1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_joining DATE
);
INSERT INTO employee1 (id, name, date_of_joining) 
VALUES 
(1, 'Alice', '2018-05-15'),
(2, 'Bob', '2019-08-20'),
(3, 'Charlie', '2020-02-10');

DELIMITER $$

CREATE FUNCTION total_experience(employee_id INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE doj DATE;
    DECLARE years INT;
    DECLARE months INT;
    DECLARE days INT;
    DECLARE current_date_value DATE;  -- Renaming to avoid conflict with the MySQL keyword

    -- Get the date of joining for the employee
    SELECT date_of_joining INTO doj 
    FROM employee1 
    WHERE id = employee_id;

    -- Get the current date
    SET current_date_value = CURDATE();

    -- Calculate the difference in years
    SET years = TIMESTAMPDIFF(YEAR, doj, current_date_value);

    -- Calculate the difference in months
    SET months = TIMESTAMPDIFF(MONTH, doj, current_date_value) - (years * 12);

    -- Get the date after adding full years
    SET doj = DATE_ADD(doj, INTERVAL years YEAR);

    -- Get the date after adding the remaining months
    SET doj = DATE_ADD(doj, INTERVAL months MONTH);

    -- Calculate the remaining days
    SET days = DATEDIFF(current_date_value, doj);

    -- Return total experience in the format: "X years Y months Z days"
    RETURN CONCAT(years, ' years ', months, ' months ', days, ' days');
END $$

DELIMITER ;

SELECT total_experience(1);  -- Replace 1 with the employee_id for which you want to check the total experience



