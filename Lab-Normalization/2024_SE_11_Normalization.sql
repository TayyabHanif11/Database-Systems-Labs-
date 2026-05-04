-- Functional Dependencies (X -> Y) and Candidate Keys:



-- 1. VisitID -> VisitDate, PatientID, DoctorID, Diagnosis, Fee (Primary FD)
-- 2. PatientID -> PatientName, PatientPhone
-- 3. DoctorID -> DoctorName, Specialty, DeptName
-- 4. DeptName -> DeptHead (Transitive dependency)
-- Candidate Key: VisitID


-- 1NF version of the table:

CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

CREATE TABLE Hospital_1NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20),
    DoctorID VARCHAR(10),
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    DeptHead VARCHAR(50),
    Diagnosis VARCHAR(100),
    Fee INT
);

INSERT INTO Hospital_1NF VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan', '0300-1112233', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan', '0300-1112233', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid', '0302-7778899', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Arrhythmia', 3000);



-- 2NF Schema
-- Justification: Extracted Patient and Doctor details because they repeat 
-- across multiple visits, causing redundancy.

CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20)
);

CREATE TABLE Doctor_2NF (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    DeptHead VARCHAR(50)
);

CREATE TABLE Visit_2NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    Diagnosis VARCHAR(100),
    Fee INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor_2NF(DoctorID)
);


-- 3NF Schema (Final Normalized Design)

CREATE TABLE Department (
    DeptName VARCHAR(50) PRIMARY KEY,
    DeptHead VARCHAR(50)
);

CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
);

-- Visit table remains largely the same but references the 3NF Doctor table
CREATE TABLE Visit (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    Diagnosis VARCHAR(100),
    Fee INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Populating 3NF Data
INSERT INTO Patient VALUES 
('P-201', 'Hassan', '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid', '0302-7778899');

INSERT INTO Department VALUES 
('Heart Care', 'Dr. Tariq'),
('Skin Clinic', 'Dr. Asma');

INSERT INTO Doctor VALUES 
('D-30', 'Dr. Imran', 'Cardiology', 'Heart Care'),
('D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic');

INSERT INTO Visit VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia', 3000);



-- Verification Query
SELECT v.VisitID, v.VisitDate, p.PatientID, p.PatientName, p.PatientPhone,
       d.DoctorID, d.DoctorName, d.Specialty, dep.DeptName, dep.DeptHead,
       v.Diagnosis, v.Fee
FROM Visit v
JOIN Patient p ON v.PatientID = p.PatientID
JOIN Doctor d ON v.DoctorID = d.DoctorID
JOIN Department dep ON d.DeptName = dep.DeptName;


-- Anomaly reflection
-- 1. Insertion: We can now add a new Department or Doctor without needing a Patient Visit.
-- 2. Update: If a DeptHead changes, we only update one row in the Department table.
-- 3. Deletion: Deleting a Visit record (e.g., V-9002) no longer loses the Doctor's details.