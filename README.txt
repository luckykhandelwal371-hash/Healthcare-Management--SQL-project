Healthcare Management System — Synthetic SQL Project Dataset

FILES
1. patients.csv          : 50,350 rows
2. doctors.csv           : 1,200 rows
3. appointments.csv      : 120,500 rows
4. medical_records.csv   : 85,000 rows
5. prescriptions.csv     : 110,450 rows

RELATIONSHIPS
patients.patient_id -> appointments.patient_id
doctors.doctor_id -> appointments.doctor_id
patients.patient_id -> medical_records.patient_id
doctors.doctor_id -> medical_records.doctor_id
patients.patient_id -> prescriptions.patient_id
doctors.doctor_id -> prescriptions.doctor_id

INTENTIONAL DATA QUALITY ISSUES
- Missing emails, dates, test names and other NULLs
- Duplicate patient/person and transaction-like records
- Inconsistent capitalization and whitespace
- Inconsistent gender/status/payment/frequency labels
- Invalid negative/zero values
- Malformed dosage formats
- Orphan foreign keys
- Some invalid/placeholder values such as N/A/unknown
- Dates missing in transactional tables

SUGGESTED BUSINESS QUESTIONS
- Which doctors/departments generate the most completed appointments and revenue?
- What is the cancellation and no-show rate by department?
- Which patients have the highest number of visits?
- Which diagnoses are most common?
- Which medicines are prescribed most frequently?
- What is the average consultation amount by department?
- Which doctors have unusually high/low patient loads?
- What are monthly appointment and revenue trends?
- How many patients have multiple prescriptions?
- Can we identify data-quality problems using SQL?

This is synthetic data for learning/project purposes and is not real patient information.
