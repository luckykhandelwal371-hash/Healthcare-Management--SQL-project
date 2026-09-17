CREATE DATABASE healthcare_management;

USE healthcare_management;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(150),
    gender VARCHAR(20),
    date_of_birth DATE,
    blood_group VARCHAR(30),
    city VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(150),
    registration_date DATE
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(150),
    specialization VARCHAR(100),
    department VARCHAR(100),
    experience_years INT,
    consultation_fee DECIMAL(10,2),
    hospital_branch VARCHAR(50)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_datetime DATETIME,
    appointment_type VARCHAR(50),
    status VARCHAR(50),
    payment_method VARCHAR(50),
    amount DECIMAL(10,2)
);

CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    record_date DATE,
    diagnosis VARCHAR(150),
    symptoms VARCHAR(255),
    test_name VARCHAR(100),
    test_result VARCHAR(100),
    notes VARCHAR(255)
);

CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    prescription_date DATE,
    medicine_name VARCHAR(100),
    dosage VARCHAR(50),
    frequency VARCHAR(100),
    duration_days INT,
    refill_count INT
);
/* =========================================================
   8. LOAD PATIENTS CSV
   ========================================================= */

LOAD DATA LOCAL INFILE
"C:\Users\Lucky Khandelwal\Downloads\Healthcare_Management_SQL_Project_Dataset\patients.csv"
INTO TABLE patients

FIELDS TERMINATED BY ','
ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
    patient_id,
    patient_name,
    gender,
    date_of_birth,
    blood_group,
    city,
    phone,
    email,
    registration_date
);
/* =========================================================
   9. LOAD DOCTORS CSV
   ========================================================= */

LOAD DATA LOCAL INFILE
"C:\Users\Lucky Khandelwal\Downloads\Healthcare_Management_SQL_Project_Dataset\doctors.csv"
INTO TABLE doctors

FIELDS TERMINATED BY ','
ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
    doctor_id,
    doctor_name,
    specialization,
    department,
    experience_years,
    consultation_fee,
    hospital_branch
);
/* =========================================================
   10. LOAD APPOINTMENTS CSV
   ========================================================= */

LOAD DATA LOCAL INFILE
"C:\Users\Lucky Khandelwal\Downloads\Healthcare_Management_SQL_Project_Dataset\appointments.csv"
INTO TABLE appointments

FIELDS TERMINATED BY ','
ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
    appointment_id,
    patient_id,
    doctor_id,
    appointment_datetime,
    appointment_type,
    status,
    payment_method,
    amount
);

/* =========================================================
   11. LOAD MEDICAL RECORDS CSV
   ========================================================= */

LOAD DATA LOCAL INFILE
"C:\Users\Lucky Khandelwal\Downloads\Healthcare_Management_SQL_Project_Dataset\medical_records.csv"
INTO TABLE medical_records

FIELDS TERMINATED BY ','
ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
    record_id,
    patient_id,
    doctor_id,
    record_date,
    diagnosis,
    symptoms,
    test_name,
    test_result,
    notes
);

/* =========================================================
   12. LOAD PRESCRIPTIONS CSV
   ========================================================= */

LOAD DATA LOCAL INFILE
"C:\Users\Lucky Khandelwal\Downloads\Healthcare_Management_SQL_Project_Dataset\prescriptions.csv"
INTO TABLE prescriptions

FIELDS TERMINATED BY ','
ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
    prescription_id,
    patient_id,
    doctor_id,
    prescription_date,
    medicine_name,
    dosage,
    frequency,
    duration_days,
    refill_count
);



