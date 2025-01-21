An Exception : PL/SQL error raised during program execution

An exception can be raised :
Implicitly by oracle server 
or Explicitly by program

An Exception can be handled : 
By trapping with a handler
By propagating it to the calling environment

If execution is  trapped, execute statements in the EXCEPTION block, if not trapped , it is propagated

Syntax :

EXCEPTION
	WHEN exception1 [ OR exception2.....]
		statement1:
        statement2:
        
ERROR HANDLINE IN MYSQL :

DECLARE handler_action HANDLER FOR condition_value
[,condition_value]...statement

handker_action:
[CONTINUE|EXIT]

condition_value:
{
mysql_error_code | SQLSTATE[VALUE] sqlstate_value | condition_name | SQLWARNING | NOT FOUND | SQLEXCEPTION
}

mysql_error_code -> integer literal indicating error code -- priority is given to this

Sqlstate_value -> 5 character string literal specifying the SQLSTATE value

Condition_name -> name of the user defined condition specified with DECLARE... condition

SQLWARNING -> shorthand value for SQLSTATE starts with '01'

NOT FOUND -> shorthand value for SQLSTATE starts with '02'

SQLEXCEPTION : shorthand values for SQLSTATE that do not start with '00', '01', or '02'

use zensar;
show tables;

CREATE TABLE EMP(
ID INT PRIMARY KEY,
NAME VARCHAR(30),
CITY VARCHAR(20)
);

TRUNCATE TABLE emp;
DROP PROCEDURE IF EXISTS insert_emp;

-- PROCEDURE WITH EXCEPTION HANDLING 
DELIMITER //
CREATE PROCEDURE insert_emp
(IN empid INT, IN dept VARCHAR(10), IN CITY VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR 1062 -- first, we declared continue handler, check output on terminal to see the difference
# error code 1062 is for duplicate entries
BEGIN
SELECT CONCAT("duplicate entry for the employee id", empid) AS errorMessage ;
END;
INSERT INTO emp VALUES(empid, dept, city);
SELECT * FROM emp WHERE ID = empid;
END;
//
DELIMITER ;

CALL insert_emp(1, 'Alice', 'New York');
CALL insert_emp(1, 'Bob', 'Los Angeles');
SELECT * from emp;

-- Create the EMP table with a PRIMARY KEY on ID
CREATE TABLE EMP(
    ID INT PRIMARY KEY,
    NAME VARCHAR(30),
    CITY VARCHAR(20)
);

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS insert_emp;

-- PROCEDURE WITHOUT EXCEPTION HANDLING

DELIMITER //
CREATE PROCEDURE insert_emp1
(IN empid INT,  IN dept VARCHAR(10), IN empcity VARCHAR(20))
BEGIN
  
    INSERT INTO EMP (ID, NAME, CITY) VALUES (empid, dept, empcity);
    
    SELECT * FROM EMP WHERE ID = empid;
END;
//
DELIMITER ;


CALL insert_emp1(4, 'Alice', 'New York');
CALL insert_emp1(4, 'Bob', 'Los Angeles');
SELECT * from emp;

-- EXIT HANDLER  VS CONTINUE HANDLER
-- Flow After Error	Terminates the procedure or block.	Resumes execution of the procedure after the error.
-- Error Recovery	Stops processing after handling the error.	Allows recovery and continuation.
-- In Your Procedure	Skips the SELECT * FROM emp statement after error.	Executes SELECT * FROM emp even after the error.

DELIMITER //
CREATE PROCEDURE insert_emp
(IN empid INT, IN dept VARCHAR(10), IN CITY VARCHAR(20))
BEGIN
    -- Handler for duplicate entry (error code 1062)
    DECLARE EXIT HANDLER FOR 1062 
    BEGIN
        SELECT CONCAT("Duplicate entry for the employee ID: ", empid) AS errorMessage;
    END;

    -- Handler for general SQL exceptions
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        SELECT "SQL Exception occurred" AS errorMessage;
    END;

    -- Handler for SQLSTATE "23000" (integrity constraint violation)
    DECLARE EXIT HANDLER FOR SQLSTATE '23000' 
    BEGIN
        SELECT "SQLSTATE 23000 - Integrity constraint violation" AS errorMessage;
    END;

    -- Insert the record
    INSERT INTO emp VALUES(empid, dept, city);

    -- Select the inserted record
    SELECT * FROM emp WHERE ID = empid;
END;
//
DELIMITER ;


CALL insert_emp(1, 'Alice', 'New York'); -- First call, inserts the record.
CALL insert_emp(1, 'Bob', 'Los Angeles'); -- Second call, triggers the 1062 handler.

-- 1062 takes precedence
