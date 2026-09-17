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
select distinct(patient_name)
from patients
order by patient_name;

select distinct(gender)
from patients;
update patients
set gender = "Male"
where gender in ("M");
update patients
set gender = "Female"
where gender in ("F");

select distinct(date_of_birth)
from patients;

select distinct(blood_group)
from patients;

select distinct(city), length(city)  
from patients
order by city;
update patients
set city=trim(city);

select distinct(phone)
from patients;

with cte as(
select distinct(phone),length(phone)as L
from patients
)
select * from cte
where L<14;
-- make phone in standarised formate (+91)
update patients
set phone=concat("+91-",phone)
where length(phone)=10;


select distinct(email)
from patients;
-- correct missing value in email
update patients
set email="unknown"
where email ='';

select distinct(registration_date)
from patients;

