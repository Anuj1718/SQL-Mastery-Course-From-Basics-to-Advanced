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


-- ### Function and Procedure in MySQL: Syntax, Usage, and Differences

-- ---

-- #### **Stored Function**
-- A stored function in MySQL is used to perform a calculation or return a single value based on input parameters.

-- **Syntax**:
-- ```sql
-- DELIMITER $$

-- CREATE FUNCTION function_name (parameter_name datatype, ...)
-- RETURNS datatype
-- DETERMINISTIC
-- BEGIN
--     -- Function logic
--     RETURN some_value;
-- END $$

-- DELIMITER ;
-- ```

-- **Key Points**:
-- - **`RETURNS datatype`** specifies the return type (e.g., INT, VARCHAR).
-- - **Deterministic/Non-deterministic**:
--   - **`DETERMINISTIC`**: Always returns the same result for the same input.
--   - **`NOT DETERMINISTIC`**: May return different results for the same input.
-- - Must include a **`RETURN`** statement.

-- **Usage**:
-- - Called in **queries** (e.g., `SELECT` statement) or other procedures/functions.
-- - Example:
--   ```sql
--   SELECT function_name(arg1, arg2);
--   ```

-- **Example**:
-- ```sql
-- DELIMITER $$

-- CREATE FUNCTION GetAge(dob DATE)
-- RETURNS INT
-- DETERMINISTIC
-- BEGIN
--     RETURN TIMESTAMPDIFF(YEAR, dob, CURDATE());
-- END $$

-- DELIMITER ;
-- ```
-- Usage:
-- ```sql
-- SELECT GetAge('2000-01-01');
-- ```

-- ---

-- #### **Stored Procedure**
-- A stored procedure performs a task or a series of operations, such as inserting or updating data, and may or may not return a value.

-- **Syntax**:
-- ```sql
-- DELIMITER $$

-- CREATE PROCEDURE procedure_name (parameter_name [IN | OUT | INOUT] datatype, ...)
-- BEGIN
--     -- Procedure logic
-- END $$

-- DELIMITER ;
-- ```

-- **Key Points**:
-- - Can have **`IN`**, **`OUT`**, or **`INOUT`** parameters:
--   - **`IN`**: Input only.
--   - **`OUT`**: Output only.
--   - **`INOUT`**: Both input and output.
-- - Does not require a **`RETURN`** statement but may use output parameters.

-- **Usage**:
-- - Called using the **`CALL`** statement.
-- - Example:
--   ```sql
--   CALL procedure_name(arg1, @output_param);
--   ```

-- **Example**:
-- ```sql
-- DELIMITER $$

-- CREATE PROCEDURE AddEmployee(
--     IN empID INT,
--     IN empName VARCHAR(100),
--     IN empSalary INT
-- )
-- BEGIN
--     INSERT INTO employees (EID, firstname, Salary)
--     VALUES (empID, empName, empSalary);
-- END $$

-- DELIMITER ;
-- ```
-- Usage:
-- ```sql
-- CALL AddEmployee(1, 'Alice', 50000);
-- ```

-- ---

-- #### **Key Differences Between Functions and Procedures**
-- | Aspect                     | **Function**                                                 | **Procedure**                                                 |
-- |----------------------------|-------------------------------------------------------------|-------------------------------------------------------------|
-- | **Purpose**                | Returns a single value.                                     | Performs a task; may or may not return a value.             |
-- | **Call Syntax**            | Used in queries: `SELECT function_name(arg1, arg2);`        | Called with `CALL procedure_name(arg1, arg2);`              |
-- | **Return Value**           | Must return a single value.                                 | Can use output parameters for multiple values or none.      |
-- | **Parameter Types**        | Only **`IN`** parameters.                                   | Supports **`IN`**, **`OUT`**, and **`INOUT`** parameters.   |
-- | **Use in Queries**         | Can be used in **`SELECT`**, **`WHERE`**, etc.              | Cannot be used in queries; must be invoked directly.        |
-- | **Transaction Handling**   | Cannot perform transaction controls (e.g., `COMMIT`).       | Can perform transaction controls.                          |
-- | **Performance**            | Generally lightweight; designed for calculations.           | More robust, used for complex operations.                  |

-- ---

-- #### **When to Use Which?**
-- - **Use Functions**:
--   - When you need to compute a value and return it.
--   - When the result is used directly in queries.
--   - Example: Calculating age, salary, or tax.

-- - **Use Procedures**:
--   - When you need to perform operations like insert, update, or delete.
--   - When the task involves multiple steps or affects data.
--   - Example: Adding employees, updating salaries, managing transactions.


select * from employee

DELIMITER $$

CREATE PROCEDURE GetAllEmployees() -- procedure without parameters
BEGIN
    SELECT * FROM employee;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllEmployees;

call getallemployees();

DELIMITER $$

CREATE PROCEDURE AddEmployee(
    IN empID INT,
    IN empFirstName VARCHAR(40),
    IN empLastName VARCHAR(50),
    IN empAge INT,
    IN empSalary INT,
    IN empLocation VARCHAR(50),
    IN empJobPosition VARCHAR(50)
)
BEGIN
    INSERT INTO employee (EID, firstname, LastName, Age, Salary, Location, jobPosition)
    VALUES (empID, empFirstName, empLastName, empAge, empSalary, empLocation, empJobPosition);
END $$

DELIMITER ;

CALL AddEmployee(101, 'John', 'Doe', 30, 60000, 'New York', 'Developer');



-- ### Explanation of `IN`, `OUT`, and `INOUT` Parameters in MySQL Stored Procedures

-- 1. **`IN` Parameter**:
--    - Used to pass input values to the procedure.
--    - The value of an `IN` parameter cannot be modified within the procedure.
--    - It acts like a constant.

--    **Example**:
--    Procedure to fetch employee details based on their ID:
--    ```sql
--    DELIMITER $$

--    CREATE PROCEDURE GetEmployeeByID(IN empID INT)
--    BEGIN
--        SELECT * FROM employees WHERE EID = empID;
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    CALL GetEmployeeByID(101);
--    ```

-- ---

-- 2. **`OUT` Parameter**:
--    - Used to return a value from the procedure to the caller.
--    - The value is set within the procedure and can be accessed outside.

--    **Example**:
--    Procedure to calculate the bonus of an employee based on their salary:
--    ```sql
--    DELIMITER $$

--    CREATE PROCEDURE CalculateBonus(IN empID INT, OUT bonus INT)
--    BEGIN
--        SELECT Salary * 0.1 INTO bonus FROM employees WHERE EID = empID;
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    SET @bonusValue = 0;
--    CALL CalculateBonus(101, @bonusValue);
--    SELECT @bonusValue;
--    ```

-- ---

-- 3. **`INOUT` Parameter**:
--    - Combines the functionalities of `IN` and `OUT`.
--    - Passes an initial value to the procedure and allows the procedure to modify and return it.

--    **Example**:
--    Procedure to update the salary of an employee and return the new salary:
--    ```sql
--    DELIMITER $$

--    CREATE PROCEDURE UpdateSalary(INOUT empSalary INT, IN percentageIncrease DECIMAL(5,2))
--    BEGIN
--        SET empSalary = empSalary + (empSalary * percentageIncrease / 100);
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    SET @currentSalary = 50000;
--    CALL UpdateSalary(@currentSalary, 10);
--    SELECT @currentSalary; -- Updated salary
--    ```

-- ---

-- ### Summary of Differences:

-- | Parameter Type | Input Value from Caller | Modified by Procedure | Returns Value to Caller |
-- |----------------|--------------------------|------------------------|--------------------------|
-- | `IN`           | Yes                      | No                     | No                       |
-- | `OUT`          | No                       | Yes                    | Yes                      |
-- | `INOUT`        | Yes                      | Yes                    | Yes                      |


-- IF-THEN statement
-- IF-THEN-ELSE statement
-- IF-THEN-ELSEIF statement


Yes, **`IF-THEN`**, **`IF-THEN-ELSE`**, and **`IF-THEN-ELSEIF`** statements are commonly used in both **functions** and **procedures** in MySQL for implementing conditional logic.

-- ### **Usage in Functions and Procedures**

-- 1. **`IF-THEN` Statement**:
--    - Executes a block of code if a specified condition is `TRUE`.
--    - Syntax:
--      ```sql
--      IF condition THEN
--          -- Code to execute
--      END IF;
--      ```

--    **Example** in a Procedure:
--    ```sql
--    DELIMITER $$

--    CREATE PROCEDURE CheckAge(IN empAge INT)
--    BEGIN
--        IF empAge < 18 THEN
--            SELECT 'Employee is a minor.';
--        END IF;
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    CALL CheckAge(16); -- Output: 'Employee is a minor.'
--    ```

-- ---

-- 2. **`IF-THEN-ELSE` Statement**:
--    - Provides an alternative block of code to execute if the condition is `FALSE`.
--    - Syntax:
--      ```sql
--      IF condition THEN
--          -- Code to execute if condition is TRUE
--      ELSE
--          -- Code to execute if condition is FALSE
--      END IF;
--      ```

--    **Example** in a Function:
--    ```sql
--    DELIMITER $$

--    CREATE FUNCTION CheckSalary(salary INT) RETURNS VARCHAR(50)
--    BEGIN
--        DECLARE result VARCHAR(50);
--        IF salary > 50000 THEN
--            SET result = 'High salary';
--        ELSE
--            SET result = 'Average salary';
--        END IF;
--        RETURN result;
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    SELECT CheckSalary(60000); -- Output: 'High salary'
--    ```

-- ---

-- 3. **`IF-THEN-ELSEIF` Statement**:
--    - Evaluates multiple conditions sequentially. If one condition is `TRUE`, it executes the corresponding block and skips the rest.
--    - Syntax:
--      ```sql
--      IF condition1 THEN
--          -- Code for condition1
--      ELSEIF condition2 THEN
--          -- Code for condition2
--      ELSE
--          -- Default code if none match
--      END IF;
--      ```

--    **Example** in a Procedure:
--    ```sql
--    DELIMITER $$

--    CREATE PROCEDURE CategorizeEmployee(IN salary INT)
--    BEGIN
--        IF salary > 80000 THEN
--            SELECT 'Executive';
--        ELSEIF salary > 50000 THEN
--            SELECT 'Manager';
--        ELSE
--            SELECT 'Staff';
--        END IF;
--    END $$

--    DELIMITER ;
--    ```

--    **Usage**:
--    ```sql
--    CALL CategorizeEmployee(60000); -- Output: 'Manager'
--    ```

-- ---

-- ### Where Can These Be Used?

-- | Statement                  | Functions | Procedures |
-- |----------------------------|-----------|------------|
-- | `IF-THEN`                  | ✅        | ✅         |
-- | `IF-THEN-ELSE`             | ✅        | ✅         |
-- | `IF-THEN-ELSEIF`           | ✅        | ✅         |

-- ### Key Notes:
-- - **Functions** are typically used when you need to compute and return a value based on logic.
-- - **Procedures** are used for more general tasks, such as interacting with tables or performing complex operations.

desc employee


DELIMITER $$

CREATE PROCEDURE CheckRetirementEligibility(IN empID INT)
BEGIN
    DECLARE empAge INT;

    -- Fetch employee's age
    SELECT Age INTO empAge 
    FROM employee 
    WHERE EID = empID;

    -- Check eligibility
    IF empAge >= 60 THEN
        SELECT CONCAT('Employee with ID ', empID, ' is eligible for retirement benefits.') AS Result;
    END IF;
END $$

DELIMITER ;

CALL CheckRetirementEligibility(2);

select * from employee

DELIMITER $$

CREATE PROCEDURE CategorizeSalary(IN empID INT)
BEGIN
    DECLARE empSalary INT;

    -- Fetch employee's salary
    SELECT Salary INTO empSalary 
    FROM employee 
    WHERE EID = empID;

    -- Categorize salary
    IF empSalary > 75000 THEN
        SELECT CONCAT('Employee with ID ', empID, ' has a High salary.') AS Result;
    ELSE
        SELECT CONCAT('Employee with ID ', empID, ' has an Average salary.') AS Result;
    END IF;
END $$

DELIMITER ;

CALL CategorizeSalary(1);

DELIMITER $$

CREATE PROCEDURE AssignRank(IN empID INT)
BEGIN
    DECLARE empSalary INT;

    -- Fetch employee's salary
    SELECT Salary INTO empSalary 
    FROM employee 
    WHERE EID = empID;

    -- Assign rank based on salary
    IF empSalary > 100000 THEN
        SELECT CONCAT('Employee with ID ', empID, ' is an Executive.') AS `EmployeeRank`;
    ELSEIF empSalary > 50000 THEN
        SELECT CONCAT('Employee with ID ', empID, ' is a Manager.') AS `EmployeeRank`;
    ELSE
        SELECT CONCAT('Employee with ID ', empID, ' is a Staff member.') AS `EmployeeRank`;
    END IF;
END $$

DELIMITER ;

CALL AssignRank(3);


