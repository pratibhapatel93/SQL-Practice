CREATE DATABASE Company;

-- Create Emp table
CREATE TABLE Emp (
    eid INTEGER PRIMARY KEY,
    ename VARCHAR(200),
    age INTEGER,
    salary REAL
);


-- Create Dept table
CREATE TABLE Dept (
    did INTEGER PRIMARY KEY,
    dname VARCHAR(200),
    budget INT,
    managerid INTEGER,
    FOREIGN KEY (managerid) REFERENCES Emp(eid)
);

-- Create Works table
CREATE TABLE Works (
    eid INTEGER,
    did INTEGER,
    pct_time INTEGER,
    PRIMARY KEY (eid, did),
    FOREIGN KEY (eid) REFERENCES Emp(eid),
    FOREIGN KEY (did) REFERENCES Dept(did)
);


-- Insert values into Emp table
INSERT INTO Emp (eid, ename, age, salary)
VALUES (1, 'John Doe', 30, 50000),
       (2, 'Jane Smith', 28, 45000),
       (3, 'Michael Johnson', 35, 60000),
       (4, 'Emily Davis', 32, 55000);

-- Insert values into Dept table
INSERT INTO Dept (did, dname, budget, managerid)
VALUES (1, 'Sales', 1, 1),
       (2, 'Marketing', 8, 2),
       (3, 'Finance', 12, 3),
       (4, 'HR', 9, 4),
	   (5, 'Software', 9, 4),
	   (6, 'Hardware', 9, 4);

-- Insert values into Works table
INSERT INTO Works (eid, did, pct_time)
VALUES (1, 1, 100),
       (1, 2, 50),
       (2, 2, 100),
       (3, 3, 80),
       (4, 4, 100),
       (4, 1, 75),
       (4, 3, 50),
	   (4, 5, 50),
	   (3, 6, 50),
	   (2, 5, 50),
	   (2, 6, 50),
	   (3, 5, 50);


-------------------------------A---------------------------------------------------
SELECT e.ename, e.age
FROM Emp e
INNER JOIN Works w ON e.eid = w.eid
INNER JOIN Dept d ON w.did = d.did
WHERE d.dname = 'Hardware' OR d.dname = 'Software'
GROUP BY e.ename, e.age
HAVING COUNT(DISTINCT d.dname) = 2;



-------------------------------C---------------------------------------------------

SELECT e.ename
FROM Emp e
WHERE e.salary > ALL (
  SELECT d.budget
  FROM Dept d
  INNER JOIN Works w ON d.did = w.did
  WHERE w.eid = e.eid
);

-------------------------------D---------------------------------------------------

SELECT d.managerid
FROM Dept d
GROUP BY d.managerid
HAVING MAX(d.budget) > 1 AND MIN(d.budget) > 1;


-------------------------------E---------------------------------------------------
SELECT e.ename
FROM Emp e
JOIN Dept d ON e.eid = d.managerid
WHERE d.budget = (
    SELECT MAX(budget)
    FROM Dept
);



-------------------------------F---------------------------------------------------




SELECT d.managerid ,  SUM(d.budget) AS budget
FROM Dept d
INNER JOIN Works w ON d.managerid = w.eid
GROUP BY  d.managerid
HAVING COUNT(w.eid) > 1 AND SUM(d.budget)>5;




-------------------------------G---------------------------------------------------



SELECT d.managerid
FROM Dept d
GROUP BY d.managerid
HAVING SUM(d.budget) = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(budget) AS total
        FROM Dept
        GROUP BY managerid
    ) AS subquery
);

-------------------------------H---------------------------------------------------

SELECT e.ename
FROM Emp e
INNER JOIN Dept d ON e.eid = d.managerid
GROUP BY e.ename
HAVING
    MAX(d.budget) > 1
    AND MIN(d.budget) < 12;


