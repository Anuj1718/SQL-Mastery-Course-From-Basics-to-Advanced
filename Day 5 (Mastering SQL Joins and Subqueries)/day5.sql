 use techforallwithpriya
 select * from employee;
 SHOW TABLES
 
 DESC Learners;
 select * from learners;
 desc courses_update
select * from courses;
 
 select selectedcourse, count(*) as enrollmentcount
 from learners
 group by selectedcourse
 order by enrollmentcount desc
 limit 1
 
 -- courseid, coursename, enrollment count
 
-- select selectedcourse, coursename, count(*) as enrollmentcount
--  from learners
--  join courses
--  group by selectedcourse, coursename
--  order by enrollmentcount desc
--  limit 1
-- this is wrong
 
 select selectedcourse, coursename, count(*) as enrollmentcount
 from learners
 join courses
 on learners.selectedcourse = courses.courseid
 group by selectedcourse, coursename
 order by enrollmentcount desc
 limit 1
 
 --  select selectedcourse, coursename, count(*) as enrollmentcount
--  from learners
--  join courses
--  on learners.selectedcourse = courses.courseid
--  group by selectedcourse
--  order by enrollmentcount desc
--  limit 1
--  
-- select courseid, coursename, count(*) as enrollmentcount
--  from learners
--  join courses
--  on learners.selectedcourse = courses.courseid
--  group by selectedcourse
--  order by enrollmentcount desc
--  limit 1
--  
 select courseid, coursename, temptable.enrollmentcount
 from courses
 join
 (select selectedcourse, count(*) as enrollmentcount
 from learners
 group by selectedcourse
 order by enrollmentcount desc
 limit 1) as temptable
 on courses.courseId = temptable.selectedcourse;
 -- this is more optimized as it filters the records and then doing a join so less join operations are required.