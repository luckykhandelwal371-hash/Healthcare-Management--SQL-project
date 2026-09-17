-- Data cleaning of medical record.
select * from medical_records
limit 20;
-- query allow to make change in the dataset/table 's record! 
SET SQL_SAFE_UPDATES = 0;
--------------------------------------------------------------------------------------------------------------------------------------------
-- Find duplicate value and handle if exist 
select 
       record_id, 
       COUNT(*) AS duplicate_count
FROM medical_records
GROUP BY record_id
HAVING COUNT(*) > 1;
-- No duplicate record is the table!
----------------------------------------------------------------------------------------------------------------------------------------------
-- check and treat Null values in each columns if exist.
select 
	sum(record_id is null),
	sum(patient_id is null),
    sum(doctor_id is null),
    sum(record_date is null),
    sum(diagnosis is null),
    sum(symptoms is null),
    sum(test_name is null),
    sum(test_result is null),
    sum(notes is null)
from medical_records;
-- NO Null value found !
------------------------------------------------------------------------------------------------------------------------------------------------
-- Now  check for missing value and  handle them along with ensuring the right formate ,if they exist.
select distinct(record_id)
from medical_records;

select distinct(patient_id)
from medical_records;


select distinct(doctor_id)
from medical_records;

select distinct(record_date)
from medical_records;

select distinct(diagnosis),length(diagnosis) as l
from medical_records
order by diagnosis;

update medical_records
set diagnosis = trim(diagnosis);

select distinct(symtoms)
from medical_records;

select distinct(symptoms)
from medical_records;

select distinct(test_name)
from medical_records
order by test_name;
update medical_records
set test_name = "X-Ray"
where test_name ="x ray";
update medical_records
set test_name = "N/A"
where test_name is null or trim(test_name)= '' or test_name ="None";
update medical_records
set test_name = trim(test_name);

-- **********************************************************************************************************************************
select distinct(test_result)
from medical_records;
update medical_records
set test_result = upper(left(test_result,1));

select distinct(notes)
from medical_records;