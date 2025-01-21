use techforallwithpriya;
show tables;
desc employee
desc employee1

CREATE TABLE employees (  	
    employee_id INT (11) UNSIGNED NOT NULL,  
	first_name VARCHAR(20),  	
    last_name VARCHAR(25) NOT NULL,  	
    email VARCHAR(25) NOT NULL,  
	phone_number VARCHAR(20), 
 	hire_date DATE NOT NULL,  
	job_id VARCHAR(10) NOT NULL,  
	salary DECIMAL(8, 2) NOT NULL,  
	commission_pct DECIMAL(2, 2),  
	manager_id INT (11) UNSIGNED,  
	department_id INT (11) UNSIGNED, 
 	PRIMARY KEY (employee_id) 
 	); 
    alter table employees modify email varchar(50)
    
    INSERT INTO employees 
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
VALUES
(301, 'Jethalal', 'Gada', 'jethalal.gada@example.com', '9876543210', '2023-01-15', 'DEV01', 50000.00, NULL, 300, 10),
(302, 'Taarak', 'Mehta', 'taarak.mehta@example.com', '9876543211', '2022-05-10', 'HR02', 60000.00, 0.10, 300, 20),
(303, 'Champaklal', 'Gada', 'champaklal.gada@example.com', '9876543212', '2021-07-20', 'MKT03', 40000.00, 0.20, 301, 30),
(304, 'Dayaben', 'Gada', 'dayaben.gada@example.com', '9876543213', '2020-03-25', 'ACC04', 45000.00, NULL, 302, 40),
(305, 'Babita', 'Iyer', 'babita.iyer@example.com', '9876543214', '2019-11-30', 'ENG05', 70000.00, 0.15, 303, 50),
(306, 'Aatmaram', 'Bhide', 'aatmaram.bhide@example.com', '9876543215', '2018-08-14', 'IT06', 35000.00, 0.05, 304, 60),
(307, 'Popatlal', 'Pandey', 'popatlal.pandey@example.com', '9876543216', '2023-02-01', 'DEV02', 30000.00, NULL, 301, 10),
(308, 'Madhavi', 'Bhide', 'madhavi.bhide@example.com', '9876543217', '2021-06-20', 'HR03', 40000.00, 0.08, 302, 20),
(309, 'Sodhi', 'Singh', 'sodhi.singh@example.com', '9876543218', '2020-01-30', 'MKT04', 75000.00, 0.12, 303, 30),
(310, 'Roshan', 'Kaur', 'roshan.kaur@example.com', '9876543219', '2019-10-10', 'ENG06', 55000.00, 0.10, 304, 40);

-- MYSQL CASE STATEMENTS

SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 30000 THEN 'Low'
        WHEN salary BETWEEN 30000 AND 70000 THEN 'Medium'
        WHEN salary > 70000 THEN 'High'
        ELSE 'Undefined'
    END AS salary_category
FROM 
    employees;
    
    -- CURSORS
    
-- A cursor in MySQL is a database object used to retrieve data row by row from a result set. Cursors are especially useful when you need to process individual rows of a query result sequentially instead of processing the entire result set at once.

-- Cursors are typically used in stored procedures, where operations need to be performed for each row in a result set.

-- How Cursors Work:
-- Declare: A cursor is declared with a DECLARE statement and is associated with a query.
-- Open: The cursor is opened using the OPEN statement, initializing the result set.
-- Fetch: Rows are fetched one by one using the FETCH statement.
-- Close: The cursor is closed using the CLOSE statement when processing is complete.

-- Types of Cursors in MySQL
-- Cursors in MySQL can be broadly categorized based on their behavior:

-- Read-Only Cursors:

-- These cursors allow you to fetch data but do not allow updates to the rows fetched.
-- In MySQL, all cursors are read-only by default.
-- They are efficient because they do not allow manipulation of data in the result set.
-- Non-Scrollable Cursors:

-- These cursors allow you to fetch rows sequentially (one at a time) in the result set.
-- In MySQL, all cursors are non-scrollable, meaning you cannot move backward or jump to a specific row in the result set.

-- MySQL only supports read-only and non-scrollable cursors.

-- Types of Cursors:
-- Implicit Cursor: Automatically created by MySQL when you run a SELECT query.
-- Explicit Cursor: Defined by the user within a stored procedure or function, providing more control over the iteration process
-- MYSQL has only explicit cursors
-- An "asensitive cursor" is a type of cursor that can reflect any changes made to the underlying data while the cursor is open. In simpler terms, asensitive cursors are cursors that can detect updates, inserts, or deletes in the result set during the execution of the cursor, meaning the data the cursor is working with can change during the cursor’s operation.-- 

 DELIMITER //

CREATE PROCEDURE process_employees()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(8, 2);

    -- Declare a cursor for a query
    DECLARE emp_cursor CURSOR FOR
        SELECT first_name, salary FROM employees;

    -- Declare a handler for the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN emp_cursor;

    -- Fetch rows from the cursor
    FETCH emp_cursor INTO emp_name, emp_salary;

    WHILE done = 0 DO
        -- Process each row (for example, print values)
        SELECT CONCAT('Employee: ', emp_name, ' | Salary: ', emp_salary);

        FETCH emp_cursor INTO emp_name, emp_salary;
    END WHILE;

    -- Close the cursor
    CLOSE emp_cursor;
END;
//

DELIMITER ;

CALL process_employees();

drop procedure process_employees;

 DELIMITER //

CREATE PROCEDURE process_employees1()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(8, 2);

    -- Declare a cursor for a query
    DECLARE emp_cursor CURSOR FOR
        SELECT first_name, salary FROM employees;

    -- Declare a handler for the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN emp_cursor;

    -- Start the loop, labeled 'read_loop'
    read_loop: LOOP
        -- Fetch the next row from the cursor into the variables
        FETCH emp_cursor INTO emp_name, emp_salary;

        -- If no more rows are found, exit the loop
        IF done THEN 
            LEAVE read_loop;  -- Exit the loop labeled 'read_loop'
        END IF;
        
        -- Process the fetched data (e.g., output employee information)
        SELECT CONCAT('Employee Name: ', emp_name, ', Salary: ', emp_salary);
    END LOOP;

    -- Close the cursor
    CLOSE emp_cursor;
END;
//

DELIMITER ;

call process_employees1();

-- In MySQL, REF CURSOR is not supported directly. REF CURSOR is typically a feature associated with other database systems like Oracle and PL/SQL, where it is used to reference or pass a cursor to another PL/SQL block, function, or procedure.

-- However, in MySQL, you can use regular cursors (as we've discussed earlier), but they do not have the same ability to pass cursors as references to other programs or procedures. MySQL handles cursors by explicitly declaring them within a procedure or function, and the cursor itself can be used only within the procedure where it is declared.