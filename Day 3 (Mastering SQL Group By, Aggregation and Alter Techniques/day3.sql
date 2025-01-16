SHOW DATABASES
USE techforallwithpriya
SHOW TABLES

SELECT * from learners

ALTER TABLE learners RENAME COLUMN LearnerSOJ TO SourceOFJoining;

-- Count of the number of students who joined the course via LinkedIn, YouTube, Community
SELECT SourceOfJoining, COUNT(*) as num_of_students
FROM learners
GROUP BY SourceOfJoining
-- group by checks unique value
-- order of execution is from, select, group by, count

-- Grouping via sourceofjoining and the location
SELECT SourceOfJoining, Location, Count(*) as num_of_students
FROM learners
GROUP BY SourceOfJoining, Location

-- Corresponding to each course, how many students have enrolled
SELECT SelectedCourse, COUNT(*) AS num_of_students
FROM learners
GROUP BY SelectedCourse

-- Corresponding to individual source of joining, give the maximum years of experience any person holds 
SELECT sourceofjoining, max(yearsofexperience) as max_exp_years
from learners
group by sourceofjoining
-- similarly, can do min, avg, sum too

-- this is not my problem statement
-- SELECT sourceofjoining, yearsofexperience, count(*) as max_exp_years
-- from learners
-- group by sourceofjoining, yearsofexperience order by max(yearsofexperience) desc;

-- SELECT sourceofjoining FROM learners ORDER BY yearsofexperience DESC; this is wrong too

-- Display the records of those learners who have joined the course via more than one source of joining

-- filteration is required on aggregation
-- after group by, apply having clause
SELECT SourceOfJoining, COUNT(*) as num_of_students
FROM learners
GROUP BY SourceOfJoining
HAVING num_of_students >1;
-- here, i wanna apply filter on num_of_students which is an aggregation of the count(*), can't apply where clause

-- display the count of students who joined via linkedin
SELECT SourceOfJoining, COUNT(*) as num_of_students
FROM learners
GROUP BY SourceOfJoining
HAVING SOurceofjoining='LiNkedIn' 
-- never apply where clause after group by for filteration, before you can use

-- logical operators : and, or, not, ( between is a comparison operator )
-- Display the course which does not include "Excel"

SELECT * from courses
-- select * from courses where coursename != "excel"; this does not give what i want
select * from courses where coursename not like "%Excel%"

-- Display the records of those students who have less than 4 years of exp and soj is yt and location is chennai
select * from learners where yearsofexperience < 4 and sourceofjoining="youtube" and location="chennai";
-- MULTIPLE constraints and all of em should be satisfied, go for and

-- Display the reports of students having years of exp bw 1 to 3 years

select * from learners where yearsofexperience between 1 and 3; -- 1,3 wont work, 1 and 3 are both inclusive

-- Display the records of those students who have less than 4 years of exp or soj is yt or location is chennai
select * from learners where yearsofexperience < 4 or sourceofjoining="youtube" or location="chennai";

-- ALTER COMMAND (DDL : you change schema)
DESC employee
ALTER TABLE employee ADD column jobPosition varchar(50)
ALTER TABLE employee MODIFY column firstname varchar(40)
-- ALTER TABLE employee DROP PRIMARY KEY;  Error Code: 1075. Incorrect table definition; there can be only one auto column and it must be defined as a key

ALTER TABLE employee MODIFY EID INT; -- removes auto_increment
ALTER TABLE employee DROP PRIMARY KEY;
ALTER TABLE employee ADD PRIMARY KEY (EID);
ALTER TABLE employee DROP column jobPosition

-- TRUNCATE

-- DATATYPE IN SQL -> Decimal
DESC courses
INSERT INTO courses(CourseName,CourseDurationMonths,CourseFee) VALUES
("Foundations of Machine Learning",3.5,1599) -- coursedurationmonths was int, so 3.5 will be accepted but turned to 4 lol. THis was Implicit Typecasting
select * from courses
ALTER TABLE courses MODIFY column CourseDurationMonths Decimal
ALTER TABLE courses MODIFY column CourseDurationMonths Decimal(3,1) -- first is precision, 2nd is scale. 3 is atmost no of digits u can have, scale 1 means you can have 1 digit after decimal, eg. 3.5, 12.4 

CREATE TABLE courses_update (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL UNIQUE,
    CourseDurationMonths DECIMAL(3,1) NOT NULL,
    CourseFee INT NOT NULL,
    Changed_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO courses_update(CourseName,CourseDurationMonths,CourseFee) VALUES
("The Complete Excel Mastery Course",3,1499),
("DSA for Interview Preparation",2,4999),
("Foundations of Machine Learning",3.5,1599),
("SQL Bootcamp",1,2999);


select * from courses_update

INSERT INTO courses_update (CourseName, CourseDurationMonths, CourseFee) 
VALUES ("Statistics for data science", 1.5, 3999);

-- Update the CourseFee of SQL bOotcamp to 3999
UPDATE courses_update
SET CourseFee = 3999
WHERE CourseName = "SQL Bootcamp";

ALTER TABLE courses_update MODIFY column Changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW();
UPDATE courses_update
SET CourseFee = 4999
WHERE CourseName = "SQL Bootcamp";
select * from courses_update
