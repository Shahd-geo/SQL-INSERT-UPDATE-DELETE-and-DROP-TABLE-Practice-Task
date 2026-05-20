CREATE DATABASE Company; 
use Company
CREATE TABLE Employees ( 
    Ssn int PRIMARY KEY identity (1,1),
    FirstName VARCHAR(20) NOT NULL, 
    LastName VARCHAR(20) NOT NULL, 
    Gender VARCHAR(10), 
    Bdate Date ,
    Super_id INT,
    FOREIGN KEY (Super_id) REFERENCES Employees(Ssn)
);

CREATE TABLE Department (
    Dnum INT PRIMARY KEY IDENTITY(1,1),
    Dname VARCHAR(30) NOT NULL,
    Manger_id INT,
    Hiredate DATE
    FOREIGN KEY (Manger_id)
    REFERENCES Employees(Ssn)

);
ALTER TABLE Employees

ADD Dnum INT;

ALTER TABLE Employees

ADD FOREIGN KEY (Dnum)

REFERENCES Department(Dnum);

CREATE TABLE Location(
Dnum INT,
Location VARCHAR (30) NOT NULL,
PRIMARY KEY(Dnum,Location),
FOREIGN KEY (Dnum)
REFERENCES  Department(Dnum)
);
CREATE TABLE Project(
P_Num INT PRIMARY KEY IDENTITY(1,1),
P_Name VARCHAR(30) NOT NULL,
City VARCHAR (30) NOT NULL,
Locat VARCHAR(50)NOT NULL,
Dnum INT,
FOREIGN KEY (Dnum)
REFERENCES Department(Dnum)

);
CREATE TABLE Workon(
Ssn int,
P_Num int,
Work_hours int  CHECK (Work_hours > 0),
PRIMARY KEY (Ssn, P_Num),

  FOREIGN KEY (Ssn)
  REFERENCES Employees(Ssn),

  FOREIGN KEY (P_Num)
  REFERENCES Project(P_Num)
  );

  CREATE TABLE Dependent(
    Dname VARCHAR(30),
    Gender VARCHAR(10),
    BD DATE,
    SSN INT,
    PRIMARY KEY (Dname, SSN),
    FOREIGN KEY (SSN)
    REFERENCES Employees(Ssn)

);
INSERT INTO Department (Dname, Manger_id, Hiredate)
VALUES
('Human Resources', NULL, '2020-01-15'),
('IT', NULL, '2021-03-10'),
('Finance', NULL, '2019-06-01'),
('Marketing', NULL, '2022-09-20'),
('Operations', NULL, '2018-11-05');


SELECT * FROM Department; 
INSERT INTO Employees
(FirstName, LastName, Gender, Bdate, Super_id, Dnum)

VALUES
('Ali', 'Ahmed', 'Male', '2000-05-10', NULL, 1),

('Sara', 'Mohammed', 'Female', '1999-02-15', 1, 1),

('Shahd', 'Ali', 'Female', '2002-08-22', NULL, 2),

('Mona', 'Khalid', 'Female', '1998-12-01', 3, 2),

('Ahmed', 'Omar', 'Male', '1993-04-18', NULL, 3),

('Fatma', 'Salim', 'Female', '1996-07-11', 5, 3),

('Omar', 'Hassan', 'Male', '1995-03-09', NULL, 4),

('Lian', 'Ali', 'Female', '1993-09-30', 7, 4),

('Ahmed', 'Ali', 'Male', '1991-11-25', NULL, 5),

('Nora', 'Said', 'Female', '1999-06-17', 9, 5);

SELECT * FROM Employees ;

UPDATE Department
SET Manger_id = 1
WHERE Dnum = 1;

UPDATE Department
SET Manger_id = 3
WHERE Dnum = 2;

UPDATE Department
SET Manger_id = 5
WHERE Dnum = 3;

UPDATE Department
SET Manger_id = 7
WHERE Dnum = 4;

UPDATE Department
SET Manger_id = 9
WHERE Dnum = 5;


SELECT * FROM Department; 

INSERT INTO Location (Dnum, Location)
VALUES
(1, 'Muscat'),
(2, 'Sohar'),
(3, 'Salalah'),
(4, 'Nizwa'),
(5, 'Sur');

INSERT INTO Project
(P_Name, City, Locat, Dnum)

VALUES
('HR Specialiset', 'Muscat', 'Head Office', 1),

('Network Upgrade', 'Sohar', 'IT Center', 2),

('Budget Analysis', 'Salalah', 'Finance Office', 3),

('Marketing Campaign', 'Nizwa', 'Marketing Branch', 4),

('Logistics System', 'Sur', 'Operations Center', 5);
SELECT * FROM Project; 

INSERT INTO Workon
(Ssn, P_Num, Work_hours)

VALUES
(1, 1, 20),

(2, 1, 15),

(3, 2, 30),

(4, 2, 25),

(5, 3, 18),

(6, 3, 22),

(7, 4, 16),

(8, 4, 19),

(9, 5, 28),

(10, 5, 24);

INSERT INTO Dependent
(Dname, Gender, BD, SSN)

VALUES
('Khalid', 'Male', '2015-03-10', 1),

('Mariam', 'Female', '2018-07-22', 2),

('Yousef', 'Male', '2012-01-14', 3),

('Aisha', 'Female', '2016-11-05', 5),

('Salim', 'Male', '2019-09-18', 7);
SELECT * FROM Workon;

SELECT * FROM Dependent;

ALTER TABLE Employees

ADD Salary DECIMAL(10,2);
UPDATE Employees
SET Salary = 1200
WHERE Ssn = 1;

UPDATE Employees
SET Salary = 950
WHERE Ssn = 2;

UPDATE Employees
SET Salary = 1500
WHERE Ssn = 3;

UPDATE Employees
SET Salary = 1100
WHERE Ssn = 4;

UPDATE Employees
SET Salary = 1300
WHERE Ssn = 5;

UPDATE Employees
SET Salary = 1000
WHERE Ssn = 6;

UPDATE Employees
SET Salary = 1400
WHERE Ssn = 7;

UPDATE Employees
SET Salary = 1050
WHERE Ssn = 8;

UPDATE Employees
SET Salary = 1600
WHERE Ssn = 9;

UPDATE Employees
SET Salary = 1150
WHERE Ssn = 10;


UPDATE Employees
SET Salary = Salary * 1.10
WHERE Dnum = 2;

UPDATE Department
SET Dname = 'Information Technology'
WHERE Dnum = 2;
SELECT * FROM Department;
SELECT * FROM Employees;
UPDATE Project
SET P_Name = 'Advanced Network Planing '
WHERE P_Num = 2;

UPDATE Employees
SET Dnum = 3
WHERE Ssn = 4;

UPDATE Employees
SET Salary = 1800
WHERE Ssn = 3;


SELECT * FROM Employees;


-- Delete employee by ID
DELETE FROM Employees
WHERE Ssn = 10;
--We need to delet all data assosite with it 
DELETE FROM Workon
WHERE Ssn = 10;
DELETE FROM Dependent
WHERE SSN = 10;
DELETE FROM Employees
WHERE Ssn = 10;

--Remove employees from specific department
DELETE FROM Workon
WHERE Ssn IN (
    SELECT Ssn
    FROM Employees
    WHERE Dnum = 4
);

DELETE FROM Dependent
WHERE SSN IN (
    SELECT Ssn
    FROM Employees
    WHERE Dnum = 4
);

DELETE FROM Employees
WHERE Dnum = 4;

-- Ensure Remove work correctly 
SELECT * FROM Employees;
SELECT * FROM Department;

--Delete inactive project
DELETE FROM Workon
WHERE P_Num = 5;
DELETE FROM Project
WHERE P_Num = 5;

-- Remove related records first

DELETE FROM Workon
WHERE P_Num IN (
    SELECT P_Num
    FROM Project
    WHERE Dnum = 5
);
DELETE FROM Project
WHERE Dnum = 5;
DELETE FROM Location
WHERE Dnum = 5;
UPDATE Employees
SET Dnum = NULL
WHERE Dnum = 5;

DELETE FROM Department
WHERE Dnum = 5;

SELECT * FROM Department;

--Delete employees with low (1000) salary

DELETE FROM Workon
WHERE Ssn IN (
    SELECT Ssn
    FROM Employees
    WHERE Salary < 1000
);

DELETE FROM Dependent
WHERE SSN IN (
    SELECT Ssn
    FROM Employees
    WHERE Salary < 1000
);

DELETE FROM Employees
WHERE Salary < 1000;

SELECT * FROM Employees;
SELECT * FROM Project;
SELECT * FROM Department;

-- Drop table no longer required
DROP TABLE Workon;
--Ensure drop susscafuly
SELECT * FROM Workon;

-- Remove temporary table but creat it frist
CREATE TABLE Temp_Employees(
    Temp_id INT
);

DROP TABLE Temp_Employees;
;

-- Drop project related table after redesign

DROP TABLE Project;

-- Employees and Department should not be dropped directly
-- because other tables depend on them

--Recognize impact on relationships
-- Correct order:
-- 1. Workon
-- 2. Project
-- 3. Employees
-- 4. Department