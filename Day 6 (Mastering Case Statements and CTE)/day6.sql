use techforallwithpriya;

-- course id, course name, enrollment count
SELECT * FROM courses_update
SELECT * FROM learners
-- CASE Statements in SQL
-- Create a new column named "CourseFeeStatus" 
/*
	CourseFee > 3999 -> Expensive course
    CourseFee > 1499 -> Moderate Course
    ELSE -> Cheap Course
*/

SELECT CourseID, CourseName, CourseFee,
	CASE
		WHEN CourseFee > 3999 THEN 'Expensive Course'
        WHEN CourseFee > 1499 THEN 'Moderate Course'
        ELSE 'Cheap Course'
	END AS CourseFeeStatus
FROM courses_update

-- CASE Expressions in SQL
-- CourseType: Premium Course, Plus Course, Regular Course
SELECT CourseID, CourseName, CourseFee,
	CASE CourseFee
		WHEN 4999 THEN 'Premium Course'
        WHEN 3999 THEN 'Plus Course' 
        ELSE 'Regular Course'
	END AS CourseType
FROM courses_update

-- Create a new table "orders" in the techforallwithpriya data
-- OrderID -> PRIMARY KEY [Auto_Increment]
-- Order_Date
-- Order_Student_ID
-- ORDER_Status -> Complete, Pending, Closed 

CREATE TABLE Orders(
OrderID INT AUTO_INCREMENT,
Order_Date TIMESTAMP NOT NULL, 
Order_Learner_Id INT NOT NULL, 
OrderStatus VARCHAR(30) NOT NULL,
PRIMARY KEY(OrderID),
FOREIGN KEY(Order_Learner_Id) REFERENCES Learners(LearnerId));

SHOW TABLES
DESC Orders
DROP TABLE Orders

SELECT * FROM Learners
-- Insertion of the records inside the orders table
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-21',1,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',6,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-02-22',3,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-15',4,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-16',7,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-13',8,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-14',9,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-22',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-25',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-11',7,'CLOSED');

SELECT * FROM Orders

-- Total orders per student
-- Order_Learner_Id, Total_Orders
SELECT Order_Learner_Id, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Order_Learner_Id


-- Order_Learner_Id, LearnerFirstName, LearnerLastName, Total_Orders
SELECT temp.Order_Learner_Id,LearnerFirstName, LearnerLastName, temp.Total_Orders
FROM learners
JOIN
(SELECT Order_Learner_Id, COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Learner_Id) as temp
ON
Learners.LearnerId = temp.Order_Learner_Id

-- SELECT Order_Learner_Id,LearnerFirstName, LearnerLastName, Total_Orders
-- FROM learners
-- JOIN
-- (SELECT Order_Learner_Id, COUNT(*) AS Total_Orders
-- FROM orders
-- GROUP BY Order_Learner_Id) as temp
-- ON
-- Learners.LearnerId = temp.Order_Learner_Id

-- SELECT Order_Learner_Id, LearnerFirstName, LearnerLastName, COUNT(*) AS Total_Orders
-- FROM Learners
-- JOIN 
-- orders
-- ON
-- Learners.LearnerId = Orders.Order_Learner_Id
-- GROUP BY Order_Learner_Id, LearnerFirstName, LearnerLastName;
-- this works even if we do GROUP BY Order_Learner_Id;


USE techforallwithpriya
-- Order_Learner_Id, LearnerFirstName, LearnerLastName, Total_Orders, Avg_Orders_Entire_Student -> AVG(SUM(Total_Orders))
-- Complex Queries --> Common Table Expressions
SELECT temp.Order_Learner_Id, LearnerFirstName, LearnerLastName, temp.total_orders,  AVG(SUM(temp.total_orders)) OVER()  as Avg_Orders_Entire_Student
FROM
    (SELECT 
        Order_Learner_Id, 
        COUNT(*) AS total_orders
    FROM 
        Orders
    GROUP BY 
        Order_Learner_Id) as temp
JOIN 
    Learners 
ON 
    temp.Order_Learner_Id = Learners.LearnerId
GROUP BY 
    temp.Order_Learner_Id


-- Do this after learning CTE in day 7
-- Display the premium users of techforallwithpriya
-- use the concept of cte
-- condition -> total_orders > avg_orders
-- akash mishra, akhil george, nagasai sreedhar



WITH anuj as (SELECT temp.Order_Learner_Id, LearnerFirstName, LearnerLastName, temp.total_orders,  AVG(SUM(temp.total_orders)) OVER()  as Avg_Orders_Entire_Student
FROM
    (SELECT 
        Order_Learner_Id, 
        COUNT(*) AS total_orders
    FROM 
        Orders
    GROUP BY 
        Order_Learner_Id) as temp
JOIN 
    Learners 
ON 
    temp.Order_Learner_Id = Learners.LearnerId
GROUP BY 
    temp.Order_Learner_Id
    )SELECT * FROM anuj
    WHERE total_orders > Avg_Orders_Entire_Student;




    
    