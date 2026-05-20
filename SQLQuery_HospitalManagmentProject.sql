CREATE DATABASE HOSPITAL
use HOSPITAL

CREATE TABLE Patient (

    Patient_id INT PRIMARY KEY IDENTITY(1,1),

    F_name VARCHAR(30) NOT NULL,

    L_name VARCHAR(30) NOT NULL,

    Email VARCHAR(50) UNIQUE,

    Address VARCHAR(100),

    DOB DATE,

    Gender VARCHAR(10),

    Blood_group VARCHAR(5)

);
CREATE TABLE Patient_Phone (

    Patient_id INT,

    Phone_num VARCHAR(20) ,

    PRIMARY KEY (Patient_id, Phone_num),

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id)

);
CREATE TABLE Department (

    Dept_id INT PRIMARY KEY IDENTITY(1,1),

    Dept_name VARCHAR(50) NOT NULL ,

    Location VARCHAR(50) NOT NULL,

    No_of_doctor INT CHECK (No_of_doctor >= 0),

    Contact VARCHAR(30),

    Head_doc_id INT

);
CREATE TABLE Doctor (

    Doctor_id INT PRIMARY KEY IDENTITY(1,1),

    Name VARCHAR(50),

    Specialization VARCHAR(50) NOT NULL ,

    Email VARCHAR(50) UNIQUE,

    Lisence_no VARCHAR(30) UNIQUE,

    Qualification VARCHAR(50) NOT NULL ,

    Year_exp INT CHECK (Year_exp >= 0),

    Dept_id INT,

    FOREIGN KEY (Dept_id)
    REFERENCES Department(Dept_id)

);
ALTER TABLE Department

ADD FOREIGN KEY (Head_doc_id)

REFERENCES Doctor(Doctor_id);

CREATE TABLE Doctor_Phone (

    Doctor_id INT,

    Phone_num VARCHAR(20),

    PRIMARY KEY (Doctor_id, Phone_num),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id)

);
CREATE TABLE Appointment (

    App_id INT PRIMARY KEY IDENTITY(1,1),

    Date DATE,

    Time TIME,

    Status VARCHAR(20) NOT NULL,

    App_type VARCHAR(30) NOT NULL,

    Reason VARCHAR(100),

    Patient_id INT,

    Doctor_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id)

);
CREATE TABLE Services (

    Service_id INT PRIMARY KEY IDENTITY(1,1),

    Service_name VARCHAR(50) NOT NULL,

    Service_type VARCHAR(50) NOT NULL ,

    Unit_price DECIMAL(10,2) CHECK (Unit_price >= 0),

    Descrip VARCHAR(100),

    Dept_id INT,

    FOREIGN KEY (Dept_id)
    REFERENCES Department(Dept_id)

);
CREATE TABLE Appointment_Services (

    App_id INT,

    Service_id INT,

    Quantity INT CHECK (Quantity > 0),

    PRIMARY KEY (App_id, Service_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id),

    FOREIGN KEY (Service_id)
    REFERENCES Services(Service_id)

);
CREATE TABLE Medical_Record (

    Record_id INT PRIMARY KEY IDENTITY(1,1),

    Visit_date DATE,

    Diagnosis VARCHAR(100),

    Treatment VARCHAR(100) NOT NULL,

    Prescribed_medication VARCHAR(100) NOT NULL,

    Doctor_note VARCHAR(100),

    Follow_up VARCHAR(50),

    Patient_id INT,

    Doctor_id INT,

    App_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id)

);
CREATE TABLE Billing (

    Bill_id INT PRIMARY KEY IDENTITY(1,1),

    Bill_date DATE,

    Total_amount DECIMAL(10,2) CHECK (Total_amount > 0),

    Payment_status VARCHAR(20) NOT NULL,

    Payment_method VARCHAR(20) NOT NULL,

    Due_date DATE,

    Patient_id INT,

    App_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id)

);

--Insert Departments
INSERT INTO Department
(Dept_name, Location, No_of_doctor, Contact, Head_doc_id)

VALUES
('Cardiology', 'Muscat', 5, '24567890', NULL),

('Surgary', 'Sohar', 4, '26789012', NULL),

('Orthopedics', 'Salalah', 3, '23456789', NULL),

('Pediatrics', 'Nizwa', 6, '27890123', NULL);

SELECT * FROM Department;

--Insert Patients
INSERT INTO Patient
(F_name, L_name, Email, Address, DOB, Gender, Blood_group)

VALUES
('Ali', 'Ahmed', 'ali@gmail.com', 'Muscat', '2000-05-10', 'Male', 'A+'),

('Sara', 'Mohammed', 'sara@gmail.com', 'Sohar', '1999-02-15', 'Female', 'B+'),

('Shahd', 'Ali', 'shahd@gmail.com', 'Muscat', '2002-08-22', 'Female', 'O+'),

('Omar', 'Hassan', 'omar@gmail.com', 'Nizwa', '1995-03-09', 'Male', 'AB+'),

('Fatma', 'Salim', 'fatma@gmail.com', 'Salalah', '1996-07-11', 'Female', 'A-'),

('Lian', 'Khalid', 'lian@gmail.com', 'Sur', '2001-01-19', 'Female', 'B-');

SELECT * FROM Patient;

--Insert Dector
INSERT INTO Doctor
(Name, Specialization, Email, Lisence_no, Qualification, Year_exp, Dept_id)

VALUES
('Dr. Ahmed Ali', 'Cardiology', 'ahmed@hospital.com', 'LIC1001', 'MBBS', 10, 1),

('Dr. Mona Salim', 'Surgary', 'mona@hospital.com', 'LIC1002', 'MD', 8, 2),

('Dr. Khalid Omar', 'Orthopedics', 'khalid@hospital.com', 'LIC1003', 'MBBS', 12, 3),

('Dr. Sara Hassan', 'Pediatrics', 'sara@hospital.com', 'LIC1004', 'MD', 7, 4);

--Update Department Head Doctors
UPDATE Department
SET Head_doc_id = 1
WHERE Dept_id = 1;

UPDATE Department
SET Head_doc_id = 2
WHERE Dept_id = 2;

UPDATE Department
SET Head_doc_id = 3
WHERE Dept_id = 3;

UPDATE Department
SET Head_doc_id = 4
WHERE Dept_id = 4;

--Insert Appointments
INSERT INTO Appointment
(Date, Time, Status, App_type, Reason, Patient_id, Doctor_id)

VALUES
('2026-05-21', '09:00:00', 'Completed', 'Checkup', 'Heart pain', 1, 1),

('2026-05-22', '10:30:00', 'Scheduled', 'Consultation', 'Headache', 2, 2),

('2026-05-23', '11:00:00', 'Completed', 'Follow-up', 'Knee pain', 3, 3),

('2026-05-24', '01:00:00', 'Scheduled', 'Checkup', 'Fever', 4, 4),

('2026-05-25', '09:30:00', 'Completed', 'Consultation', 'Back pain', 5, 3),

('2026-05-26', '02:00:00', 'Scheduled', 'Follow-up', 'Child vaccination', 6, 4),

('2026-05-27', '11:30:00', 'Completed', 'Checkup', 'Chest pain', 1, 1),

('2026-05-28', '12:00:00', 'Scheduled', 'Consultation', 'Migraine', 2, 2);

SELECT * FROM Appointment

--Write SQL UPDATE statements
-- Correct patient date of birth
UPDATE Patient
SET DOB = '2001-05-10'
WHERE Patient_id = 1;

-- Change doctor specialty
UPDATE Doctor
SET Specialization = 'Cardiothoracic Surgery'
WHERE Doctor_id = 1;
UPDATE Doctor
SET Specialization = 'General Surgery'
WHERE Doctor_id = 2;

-- Update appointment date
UPDATE Appointment
SET Date = '2026-06-01'
WHERE App_id = 2;

-- Correct patient name spelling
UPDATE Patient
SET F_name = 'Shahad'
WHERE Patient_id = 3;

-- Reassign appointment to another doctor
UPDATE Appointment
SET Doctor_id = 4
WHERE App_id = 5;

-- – Data Deletion 
-- Delete patient  by id
-- frist we delet all data conected to patient id 
DELETE FROM Patient_Phone
WHERE Patient_id = 2;
DELETE FROM Appointment
WHERE Patient_id = 2;
DELETE FROM Medical_Record
WHERE Patient_id = 2;
DELETE FROM Billing
WHERE Patient_id = 2;
DELETE FROM Patient
WHERE Patient_id = 2;

--Remove doctor no longer working
-- insert new dector that not head of department
INSERT INTO Doctor
(Name, Specialization, Email, Lisence_no, Qualification, Year_exp, Dept_id)

VALUES
('Dr. Samir Ali', 'Dermatology', 'samir@hospital.com',
'LIC2000', 'MBBS', 5, 1);
DELETE FROM Doctor
WHERE Doctor_id = 5;

--Delete completed or canceled appointment
DELETE FROM Appointment
WHERE Status = 'Canceled';
--No have cancelld appointmant
DELETE FROM Appointment
WHERE App_id = 5;

--Remove patients with missing data null
DELETE FROM Patient
WHERE Email IS NULL;

-- Delete all appointments for specific doctor
DELETE FROM Appointment
WHERE Doctor_id = 1;


--SQL DROP TABLE
DROP TABLE Doctor_Phone;

--Remove temporary reporting table
-- I will creat temporary tabel and remove it
CREATE TABLE Temp_Report(
    Report_id INT
);

DROP TABLE Temp_Report;

--Simulate system redesign by dropping one module table 
DROP TABLE Appointment_Services;

--Identify tables that should be dropped last due to dependencies 
-- These tables should be dropped last
-- because many tables depend on them
-- Patient
-- Doctor
-- Department

-- Correct drop order:
-- 1. Appointment_Services
-- 2. Billing
-- 3. Medical_Record
-- 4. Appointment
-- 5. Doctor_Phone
-- 6. Patient_Phone
-- 7. Services
-- 8. Doctor
-- 9. Patient
-- 10. Department