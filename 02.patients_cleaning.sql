-- Data cleaning of table patients
select * from patients
limit 20;
---------------------------------------------------------------------------------------------------------------------------------------
-- find duplicate value and handle if exist 
with cte as(
 select *, row_number() over (partition by patient_id order by patient_id) as rownumber
from patients
)
select * from cte
where rownumber>1;
---------------------------------------------------------------------------------------------------------------------------------------
-- check and treat Null values in each columns if exist.
---------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK ->
select count(*),
sum(patient_id is null),
sum(patient_name is null),
sum(gender is null),
sum(date_of_birth is null),
sum(blood_group is null),
sum(city is null),
sum(phone is null),
sum(email is null),
sum(registration_date is null)
from patients;
-- No null value is found 
-----------------------------------------------------------------------------------------------------------------------------------
-- Now  check for missing value and  handle them along with ensuring the right formate ,if they exist.
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (patient_name) ->
select distinct(patient_name)
from patients
order by patient_name;
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (patient_name) ->
select distinct(gender)
from patients;
update patients
set gender = "Male"
where gender in ("M");
update patients
set gender = "Female"
where gender in ("F");
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (patient_name) ->
select distinct(date_of_birth)
from patients;
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (blood_group) ->
select distinct(blood_group)
from patients;
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (city) ->
select distinct(city), length(city)  
from patients
order by city;
update patients
set city=trim(city);
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (patient_name) ->
with cte as(
select distinct(phone),length(phone)as L
from patients
)
select * from cte
where L<14;
-- -- CLEANING (?make phone in standarised formate (+91))
update patients
set phone=concat("+91-",phone)
where length(phone)=10;
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (email) ->
select distinct(email)
from patients;
-- -- CLEANING (?correct missing value in email)
update patients
set email="unknown"
where email ='';
---------------------------------------------------------------------------------------------------------------------------------------
-- -- Check (registration_date) ->
select distinct(registration_date)
from patients;

