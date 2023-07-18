CREATE DATABASE FlightDb;

CREATE TABLE Flights (
    flno INT PRIMARY KEY,
    [from] VARCHAR(100),
    [to] VARCHAR(100),
    distance INT,
    departs TIME,
    arrives TIME,
    price INT
);

CREATE TABLE Aircraft (
    aid INT PRIMARY KEY,
    aname VARCHAR(100),
    cruisingrange INT
);

INSERT INTO Aircraft (aid, aname, cruisingrange)
VALUES
    (1, 'Boeing 747', 8000),
    (2, 'Airbus A320', 3500),
    (3, 'Cessna 172', 800),
    (4, 'Bombardier Global 6000', 7000),
    (5, 'Embraer E175', 2400);




CREATE TABLE Employees (
    eid INT PRIMARY KEY,
    ename VARCHAR(100),
    salary INT
);

INSERT INTO Employees (eid, ename, salary)
VALUES
    (1, 'John Smith', 90000),
    (2, 'Emily Johnson', 75000),
    (3, 'Michael Brown', 80000),
    (4, 'Sarah Davis', 70000),
    (5, 'Jessica Wilson', 85000),
    (6, 'Matthew Taylor', 95000),
    (7, 'Olivia Martinez', 70000),
    (8, 'David Lee', 80000);


CREATE TABLE Certified (
    eid INT,
    aid INT,
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES Employees(eid),
    FOREIGN KEY (aid) REFERENCES Aircraft(aid)
);

INSERT INTO Certified (eid, aid)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 1),
    (3, 3),
    (4, 4),
    (5, 2),
    (5, 5),
    (6, 1),
    (7, 3),
	(5, 3),
    (6, 2),
    (7, 1),
	(5, 1),
    (6, 5),
    (7, 2);


INSERT INTO Flights (flno, [from], [to], distance, departs, arrives, price)
VALUES 
    (101, 'New York', 'London', 3500, '08:00', '15:00', 1000),
    (102, 'Paris', 'Tokyo', 6000, '10:30', '18:30', 1500),
    (103, 'Los Angeles', 'Sydney', 7000, '14:45', '22:45', 2000),
    (104, 'Dubai', 'Mumbai', 1000, '09:15', '12:30', 800),
    (105, 'London', 'Paris', 200, '11:30', '13:00', 200),
	  (106, 'Tokyo', 'New York', 5500, '16:30', '22:00', 1800),
    (107, 'Sydney', 'Los Angeles', 8000, '19:45', '05:15', 2500),
    (108, 'Mumbai', 'Dubai', 900, '11:00', '13:30', 700),
    (109, 'London', 'Berlin', 400, '09:30', '11:00', 250),
    (100, 'Paris', 'Rome', 700, '14:00', '16:30', 350);

------------------------1-----------------------------

SELECT DISTINCT a.aname
FROM Aircraft a
WHERE NOT EXISTS (
    SELECT *
    FROM Certified c
    JOIN Employees e ON c.eid = e.eid
    WHERE c.aid = a.aid AND e.salary <= 80000
);
------------------------1-----------------------------------------------------1-----------------------------
------------------------2-----------------------------

SELECT c.eid, MAX(a.cruisingrange) AS MAXRANGE
FROM Certified c
INNER JOIN Aircraft a 
ON c.aid = a.aid
GROUP BY c.eid
HAVING COUNT(c.aid) > 3;


NOTE- WHERE CANNOT BE USED WITH AGGREGTE FUNCTIONS

------------------------2-----------------------------------------------------2-----------------------------
-----------------------C-----------------------------
SELECT e.ename
FROM Employees e
INNER JOIN Certified c ON e.eid = c.eid
INNER JOIN Flights f ON c.aid = f.flno
WHERE [from] = 'New York' AND [to] = 'London'
GROUP BY e.eid, e.ename
HAVING e.salary < MIN(f.price);

------------------------C-----------------------------------------------------C-----------------------------
-----------------------D------------------------------

SELECT a.aname AS AircraftName, AVG(e.salary) AS AverageSalary
FROM Aircraft a
INNER JOIN Certified c ON a.aid = c.aid
INNER JOIN Employees e ON c.eid = e.eid
WHERE a.cruisingrange > 1000
GROUP BY a.aname;
------------------------D-----------------------------------------------------D-----------------------------
-----------------------E------------------------------

SELECT e.ename AS PilotName
FROM Employees e
INNER JOIN Certified c ON e.eid = c.eid
INNER JOIN Aircraft a ON c.aid = a.aid
WHERE a.aname LIKE 'Boeing 747%';

------------------------E-----------------------------------------------------E-----------------------------
-----------------------F------------------------------




------------------------f-----------------------------------------------------F-----------------------------
-----------------------G------------------------------



-----------------------G-----------------------------------------------------G------------------------------

-----------------------H-----------------------------------------------------H------------------------------

SELECT e.ename AS pilot_name
FROM Employees e
WHERE e.eid NOT IN (
    SELECT c.eid
    FROM Certified c
    INNER JOIN Aircraft a ON c.aid = a.aid
    WHERE a.aname LIKE 'Boeing%'
)
AND e.eid IN (
    SELECT c.eid
    FROM Certified c
    INNER JOIN Aircraft a ON c.aid = a.aid
    WHERE a.cruisingrange > 3000
)
-----------------------H-----------------------------------------------------H------------------------------
-----------------------I----------------------------------------------------I-----------------------------



----------------------I-----------------------------------------------------I------------------------------
-----------------------J----------------------------------------------------J-----------------------------

SELECT (SELECT AVG(salary) FROM Employees
WHERE eid IN (SELECT eid FROM Certified)) - 
(SELECT AVG(salary) FROM Employees)
AS SalaryDifference;

----------------------J-----------------------------------------------------J------------------------------
-----------------------K----------------------------------------------------K-----------------------------




 SELECT e.ename, e.salary
FROM Employees e
WHERE e.eid NOT IN
(SELECT c.eid FROM Certified c)
    AND e.salary < (SELECT AVG(e2.salary) FROM Employees e2 
	WHERE e2.eid IN 
	(SELECT c2.eid FROM Certified c2));



	----------------------k-----------------------------------------------------k------------------------------
-----------------------L----------------------------------------------------L-----------------------------
SELECT e.ename AS pilot_name
FROM Employees e
WHERE NOT EXISTS (
    SELECT *
    FROM Certified c
    INNER JOIN Aircraft a ON c.aid = a.aid
    WHERE c.eid = e.eid AND a.cruisingrange <= 1000
);

	----------------------L-----------------------------------------------------L------------------------------
-----------------------M----------------------------------------------------M-----------------------------

SELECT e.ename
FROM Employees e
INNER JOIN Certified c ON e.eid = c.eid
INNER JOIN Aircraft a ON c.aid = a.aid
WHERE a.cruisingrange > 1000
GROUP BY e.ename
HAVING COUNT(DISTINCT a.aid) >= 2 ;

-----------------------M----------------------------------------------------M-----------------------------
-----------------------N----------------------------------------------------N-----------------------------

SELECT e.ename
FROM Employees e
INNER JOIN Certified c ON e.eid = c.eid
INNER JOIN Aircraft a ON c.aid = a.aid
WHERE a.cruisingrange > 1000
  AND a.aname LIKE 'Boeing 747%' ;


  -------------------------------------------------n-----------------------------
-----------------------N----------------------------------------------------N-----------------------------








