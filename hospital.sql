-- Create DataBase --
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;

USE hospital;

-- Doctor Table --
CREATE TABLE Doctor(
  doctor_id SMALLINT UNSIGNED NOT NULL UNIQUE,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  extension_number SMALLINT UNSIGNED UNIQUE, 
  specialization VARCHAR(30),

  PRIMARY KEY(doctor_id)
); 

-- Nurse Table --
CREATE TABLE Nurse(
  nurse_id SMALLINT UNSIGNED NOT NULL UNIQUE,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  patient_section SMALLINT UNSIGNED NOT NULL,
  nurse_type VARCHAR(30),
  
  PRIMARY KEY(nurse_id)
); 

-- Patient Table --
CREATE TABLE Patient(
  patient_id SMALLINT UNSIGNED NOT NULL, 
  doctor_id SMALLINT UNSIGNED NOT NULL, 
  nurse_id SMALLINT UNSIGNED NOT NULL,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  insurance_id SMALLINT UNSIGNED,
  room_number SMALLINT UNSIGNED,
  date_admitted DATE, -- Format: YYYY-MM-DD --

  PRIMARY KEY(patient_id),
  CONSTRAINT fk_doctor_id FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id),
  CONSTRAINT fk_nurse_id FOREIGN KEY(nurse_id) REFERENCES Nurse(nurse_id)
); 

-- PatientHealth Table --
  CREATE TABLE PatientHealth(
  patient_health_id SMALLINT UNSIGNED NOT NULL UNIQUE,
  body_temp_in_f DECIMAL(5,2), -- 5 total max digits, with max two decimal points (inclusive) --
  blood_pressure VARCHAR(10),
  respiration_rate_per_min TINYINT UNSIGNED,
  pulse_rate_per_min SMALLINT UNSIGNED,
  vitals_time_taken DATETIME, -- Format: YYYY-MM-DD hh:mm:ss --
 
  PRIMARY KEY(patient_health_id),
  CONSTRAINT fk_patient_id FOREIGN KEY(patient_health_id) REFERENCES Patient(patient_id)
); 

-- Nurse Insert --
-- nurse_id, first_name, last_name, patient_section, nurse_type --
INSERT INTO Nurse VALUES(1301, 'Tania', 'Grace', 001, 'Cardiac');
INSERT INTO Nurse VALUES(1302, 'Peter', 'Kyle', 001, 'Cardiac');
INSERT INTO Nurse VALUES(1303, 'Theo', 'Walsh', 001,'Cardiac');
INSERT INTO Nurse VALUES(1404, 'Roxanne', 'Smith', 002, 'ICU');
INSERT INTO Nurse VALUES(1405, 'Deborah', 'Miles', 002, 'ICU');
INSERT INTO Nurse VALUES(1406, 'Dylan', 'Case', 002, 'ICU');
INSERT INTO Nurse VALUES(1507, 'Sylvia', 'Mathers', 003, 'Medical-Surgical');
INSERT INTO Nurse VALUES(1508, 'Greg', 'Bowers', 003, 'Medical-Surgical');
INSERT INTO Nurse VALUES(1509, 'Jesse', 'James', 003, 'Medical-Surgical');
INSERT INTO Nurse VALUES(1610, 'Maya', 'Baldwin', 004, 'Anesthetist');
INSERT INTO Nurse VALUES(1611, 'Amy', 'Robinson', 004, 'Anesthetist');
INSERT INTO Nurse VALUES(1612, 'Alina', 'White', 004, 'Anesthetist');
INSERT INTO Nurse VALUES(1713, 'Tori', 'Ho', 005, 'ER');
INSERT INTO Nurse VALUES(1714, 'Darwin', 'Kim', 005, 'ER');
INSERT INTO Nurse VALUES(1715, 'Abigail', 'George', 005, 'ER');

-- Doctor Insert --
-- doctor_id, first_name, last_name, extension_number, specialization --
INSERT INTO Doctor VALUES(2201, 'Adam', 'Smith', 8120, 'Cardiologist'); 
INSERT INTO Doctor VALUES(2202, 'Jessica', 'Parker', 8220, 'ICU'); 
INSERT INTO Doctor VALUES(2203, 'Karyn', 'Foster', 8320, 'Surgeon'); 
INSERT INTO Doctor VALUES(2204, 'Desmond', 'Bonilla', 8420, 'Anesthesiologist'); 
INSERT INTO Doctor VALUES(2205, 'Clara', 'Chase', 8520, 'Emergency'); 


-- Patient Insert -- 
-- patient_id, doctor_id, nurse_id, first_name, last_name, insurance_id, room_number, date_admitted --
INSERT INTO Patient VALUES (4502, 2201, 1301, 'Asher', 'Williams', 13045, 1001, '2023-12-06');
INSERT INTO Patient VALUES (4040, 2201, 1302, 'Carol', 'Ferguson', 14020, 1002, '2023-12-04');
INSERT INTO Patient VALUES (4021, 2201, 1303, 'Tom', 'Flowers', 31840, 1003, '2023-11-29');
INSERT INTO Patient VALUES (4014, 2202, 1404, 'Ali', 'Patel', 31010, 2001, '2023-12-09');
INSERT INTO Patient VALUES (4102, 2202, 1405, 'Ezra', 'Howe', 41090, 2002, '2023-12-07');
INSERT INTO Patient VALUES (4500, 2202, 1406, 'Alvin', 'Sweets', 30031, 2003, '2023-12-06');
INSERT INTO Patient VALUES (4311, 2203, 1507, 'Gabi', 'Jaeger', 00321, 3001, '2023-12-05');
INSERT INTO Patient VALUES (4600, 2203, 1508, 'Eren', 'Arlent', 02021, 3002, '2023-12-03');
INSERT INTO Patient VALUES (4718, 2203, 1509, 'Mikasa', 'Ackerman', 29932, 3003, '2023-12-02');
INSERT INTO Patient VALUES (4921, 2204, 1610, 'Annie', 'Leonhart', 20431, 4001, '2023-12-01');
INSERT INTO Patient VALUES (4493, 2204, 1611, 'Bruce', 'Wayne', 12901, 4002, '2023-12-07');
INSERT INTO Patient VALUES (4410, 2204, 1612, 'Peter', 'Parker', 12292, 4003, '2023-12-06');
INSERT INTO Patient VALUES (4412, 2205, 1713, 'Aubrey', 'Plaza', 12391, 5001, '2023-12-08');
INSERT INTO Patient VALUES (4415, 2205, 1714, 'Eunice', 'Shoes', 04041, 5002, '2023-12-10');
INSERT INTO Patient VALUES (4498, 2205, 1715, 'Abigail', 'Dawson', 35922, 5003, '2023-12-09');

-- PatientHealth Insert --
-- patient_health_id, body_temp_in_f, blood_pressure, respiration_rate_per_min, pulse_rate_per_min, vitals_time_taken-- 
INSERT INTO PatientHealth VALUES(4502, 97.5, '120/80', 15, 80, '2023-12-10 06:10:00');
INSERT INTO PatientHealth VALUES(4040, 99.5, '140/90', 16, 99, '2023-12-10 06:39:00');
INSERT INTO PatientHealth VALUES(4021, 99.9, '140/90', 18, 100, '2023-12-10 06:17:00');
INSERT INTO PatientHealth VALUES(4014, 100.5, '120/80', 20, 88, '2023-12-10 06:13:00');
INSERT INTO PatientHealth VALUES(4102, 98.6, '130/80', 21, 99, '2023-12-10 06:12:00');
INSERT INTO PatientHealth VALUES(4500, 98.9, '130/90', 17, 90, '2023-12-10 06:14:00');
INSERT INTO PatientHealth VALUES(4311, 98.4, '120/80', 18, 105, '2023-12-10 06:30:00');
INSERT INTO PatientHealth VALUES(4600, 99.2, '120/80', 19, 80, '2023-12-10 06:10:00');
INSERT INTO PatientHealth VALUES(4718, 97.2, '120/80', 14, 85, '2023-12-10 06:20:00');
INSERT INTO PatientHealth VALUES(4921, 99.1, '120/80', 16, 70, '2023-12-10 06:15:00');
INSERT INTO PatientHealth VALUES(4493, 99.1, '120/80', 17, 75, '2023-12-10 06:30:00');
INSERT INTO PatientHealth VALUES(4410, 99.3, '130/80', 15, 77, '2023-12-10 06:37:00');
INSERT INTO PatientHealth VALUES(4412, 98.1, '130/90', 20, 90, '2023-12-10 06:43:00');
INSERT INTO PatientHealth VALUES(4415, 97.1, '120/90', 19, 89, '2023-12-10 06:55:00');
INSERT INTO PatientHealth VALUES(4498, 97.9, '130/90', 14, 75, '2023-12-10 06:51:00');

-- Indexes --
CREATE INDEX PatientInfo
ON patient (first_name, last_name, insurance_id, room_number);

CREATE INDEX PatientVitals
ON patienthealth (body_temp_in_f, blood_pressure, respiration_rate_per_min, pulse_rate_per_min, vitals_time_taken);

CREATE INDEX NurseInfo
ON nurse (first_name, last_name, nurse_type);

CREATE INDEX DoctorInfo
ON doctor (first_name, last_name, specialization, extension_number);

CREATE USER 'hospital_flask_user'@'localhost' IDENTIFIED BY 'not_secure_pw_987';
GRANT SELECT, INSERT,UPDATE, DELETE ON hospital.* TO hospital_flask_user@localhost;