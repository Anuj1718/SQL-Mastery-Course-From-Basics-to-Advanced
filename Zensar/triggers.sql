create database zensar;
use zensar;

CREATE TABLE regions (
region_id INT (11) UNSIGNED NOT NULL,  
	region_name VARCHAR(25), 
 	PRIMARY KEY (region_id) 
 	); 
 
CREATE TABLE countries (  	
country_id CHAR(2) NOT NULL,  
	country_name VARCHAR(40),  	
    region_id INT (11) UNSIGNED NOT NULL, 
 	PRIMARY KEY (country_id) 
); 
 
 
CREATE TABLE locations (  	
location_id INT (11) UNSIGNED NOT NULL AUTO_INCREMENT,  
	street_address VARCHAR(40),  
	postal_code VARCHAR(12),  	
    city VARCHAR(30) NOT NULL,  
	state_province VARCHAR(25),  
	country_id CHAR(2) NOT NULL, 
 	PRIMARY KEY (location_id) 
 	); 
 
CREATE TABLE departments (  	
department_id INT (11) UNSIGNED NOT NULL,  
	department_name VARCHAR(30) NOT NULL, 
 	manager_id INT (11) UNSIGNED,  
	location_id INT (11) UNSIGNED, 
 	PRIMARY KEY (department_id) 
 	); 
 
CREATE TABLE jobs (  
	job_id VARCHAR(10) NOT NULL,  
	job_title VARCHAR(35) NOT NULL,  
	min_salary DECIMAL(8, 0) UNSIGNED,  
	max_salary DECIMAL(8, 0) UNSIGNED, 
 	PRIMARY KEY (job_id) 
 	); 
 
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
 
CREATE TABLE job_history (  	
employee_id INT (11) UNSIGNED NOT NULL, 
 	start_date DATE NOT NULL,  
	end_date DATE NOT NULL, 
 	job_id VARCHAR(10) NOT NULL,  
	department_id INT (11) UNSIGNED NOT NULL 
 	); 
 
ALTER TABLE job_history ADD UNIQUE INDEX (  	
employee_id,  	
start_date 
 	); 
 
 
 CREATE TABLE emp_data
 
 (eid INT PRIMARY KEY, 
 email1 varchar(50) UNIQUE,
 bdate DATE NOT NULL,
 sal DECIMAL(8,2) CHECK(sal>0),
 did INT,
 FOREIGN KEY(did) REFERENCES departments(department_id)
 ); -- this would not work as did and department_id has different data types (INT and UNSIGNED INT)

CREATE TABLE emp_data (
    eid INT PRIMARY KEY, 
    email1 VARCHAR(50) UNIQUE,
    bdate DATE NOT NULL,
    sal DECIMAL(8,2) CHECK(sal > 0),
    did INT UNSIGNED,  -- Ensure this matches the type of department_id in the departments table
    FOREIGN KEY (did) REFERENCES departments(department_id)
);

-- TRiggers : 6 types in mysql (before/after update/insert/delete)
-- by default, they are row level triggers
-- executes implicitly 

CREATE TABLE temp_sal(
id INT PRIMARY KEY,
salary DECIMAL(8,2)
);

-- Insert sample data into the temp_sal table
INSERT INTO temp_sal (id, salary) VALUES (1, 800);    
INSERT INTO temp_sal (id, salary) VALUES (2, 1500);  
INSERT INTO temp_sal (id, salary) VALUES (3, 1200);   
INSERT INTO temp_sal (id, salary) VALUES (4, 500);    
INSERT INTO temp_sal (id, salary) VALUES (5, 2500);   

select * from temp_sal;

DELIMITER //
create trigger upd_chk BEFORE UPDATE ON temp_sal -- Create the trigger to enforce salary updates before they occur
FOR EACH ROW
BEGIN
 IF NEW.salary <1000 THEN SET NEW.salary = 1000;
 ELSEIF NEW.salary >=1000 THEN SET NEW.salary=2000;
 END IF;
 END //
 
 DELIMITER ;
 
-- Updating records to test the trigger functionality
UPDATE temp_sal SET salary = 800 WHERE id = 1;    -- This should be updated to 1000
UPDATE temp_sal SET salary = 950 WHERE id = 4;    -- This should be updated to 1000
UPDATE temp_sal SET salary = 1800 WHERE id = 5;   -- This should be updated to 2000
UPDATE temp_sal SET salary = 2500 WHERE id = 3;   -- This should be updated to 2000
UPDATE temp_sal SET salary = 200 WHERE id = 2;    -- This should be updated to 1000

🐔@dvllrs788JuneXXXVstarbucksdbfenHgsillyBk🌔croatiaQxf2+🏋️‍♂️🏋️‍♂️🏋️‍♂️i am loved