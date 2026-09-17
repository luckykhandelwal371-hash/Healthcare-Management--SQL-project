--  data cleaning of table prescription
select * from prescriptions
limit 20;
--------------------------------------------------------------------------------------------------------------------------
-- check null values
select 
sum(prescription_id is null) as prescription_id_null,
sum(patient_id is null) as patient_id_null,
sum(doctor_id is null) as doctor_id_null,
sum(prescription_date is  null) as pres_date_null,
sum(medicine_name is null) as medicine_name_null,
sum(dosage is null) as dosage_null,
sum(frequency is null) as frequency_null,
sum(duration_days is null) as duration_days_null,
sum(refill_count is null) as refill_count_null
from prescriptions;

---------------------------------------------------------------------------------------------------------------------------
-- check duplicate value 
with cte as(
select  * , row_number() over (partition by prescription_id order by prescription_id) as rownumber
from  prescriptions
)
select *from cte
where rownumber >1;
-- No duplicate value found.

------------------------------------------------------------------------------------------------------------------------------
-- cleaning values  formate in medicine_name ,dosage ,frequency columns 
select distinct(medicine_name)as m , length(medicine_name)
from prescriptions
order by m;
SET SQL_SAFE_UPDATES = 0;
update prescriptions
set medicine_name = trim(medicine_name);

update prescriptions
set medicine_name = "Metformin"
where medicine_name in ("Metformin");

update prescriptions
set medicine_name = "Metformin"
where medicine_name in ("Metformin");

update prescriptions
set medicine_name = "Metformin"
where medicine_name in ("Metformin");

update prescriptions
set medicine_name = "Paracetamol"
where medicine_name in ("paracetamol","paracetmol");

select distinct(dosage)
from prescriptions;

select distinct(frequency)
from prescriptions;
select frequency,count(*)
from prescriptions
group by frequency;

update prescriptions
set frequency ="unknown"
where frequency is null or trim(frequency)= '';

update prescriptions
set frequency = "Twice daily"
where frequency in ("BD","twice daily","2x daily");

update prescriptions
set frequency = "Three times daily"
where frequency in ("TDS");

update prescriptions
set frequency = "one daily"
where frequency in("Once daily","once a day","OD");
