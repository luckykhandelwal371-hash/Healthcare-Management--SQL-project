-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Data cleaning of doctors.
-------------------------------------------------------------------------------------------------------------------------------------------------------
select * from doctors
limit 20;
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find duplicate value and handle if exist 
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK ->
select 
	doctor_id,
    count(*) as c
from doctors
group by doctor_id
having c>2;
-- -- No duplicate record is the table!
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Check and treat Null values in each columns if exist.
-------------------------------------------------------------------------------------------------------------------------------------------------------
select
    SUM(doctor_id IS NULL) AS doctor_id_null,
    SUM(doctor_name IS NULL) AS doctor_name_null,
    SUM(specialization IS NULL) AS specialization_null,
    SUM(department IS NULL) AS department_null,
    SUM(experience_years IS NULL) AS experience_years_null,
    SUM(consultation_fee IS NULL) AS consultation_fee_null,
    SUM(hospital_branch IS NULL) AS hospital_branch_null
from doctors;
-- NO Null value found !
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Now  check for missing value and  handle them along with Correct inconsistent data values ,if they exist.
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (doctor_name) ->
select distinct(doctor_name)
from doctors;
-- -- NOT exist!
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (specialization) ->
select distinct(specialization)
from doctors
order by specialization;
-- -- NOT exist!
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (department) ->
select distinct( department),length(department)
from doctors
order by department;
-- -- CLEANING [?inconsistent data values] ->
start transaction;
update doctors
set department="General medicine"
where department in ("general medicine","General  Medicine");
commit;
start transaction;
update doctors
set department = "Oncology"
where department in ("ONCOLOGY","Oncology");
commit;
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (experience_years) ->
select distinct(experience_years)
from doctors
order by experience_years;
-- -- NOT exist!
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (consultation_fee) ->
select distinct(consultation_fee)
from doctors;
-- -- CLEANING [?correcting negetive fee value] ->
start transaction;
update doctors
set consultation_fee = abs(consultation_fee)
where consultation_fee<0;
commit;
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (hospital_branch) ->
select distinct(hospital_branch)
from doctors;
-- -- NOT exist!
