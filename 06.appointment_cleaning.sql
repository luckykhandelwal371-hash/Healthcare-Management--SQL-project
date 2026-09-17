-- Data cleaning of doctors.
select * from appointments
limit 20;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find duplicate value and handle if exist 
select appointment_id,count(*) as c
from appointments
group by appointment_id
 having c>1;
 -- -- No duplicate record is the table!
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- check and treat Null values in each columns if exist.
SELECT *
FROM appointments
WHERE appointment_id IS NULL
   OR patient_id IS NULL
   OR doctor_id IS NULL
   OR appointment_datetime IS NULL
   OR appointment_type IS NULL
   OR status IS NULL
   OR payment_method IS NULL
   OR amount IS NULL;
-- NO Null value found !
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Now  check for missing value and  handle them along with ensuring the right formate ,if they exist.
select distinct(patient_id)
from appointments;

select distinct(doctor_id)
from appointments;

select distinct(appointment_datetime)
from appointments;

select distinct(appointment_type)
from appointments;

select distinct(status)
from appointments
order by status;
start transaction;
update appointments
set  status =
    case
        when lower(trim(status)) in ('complete', 'completed', 'done')
            then 'Completed'
        when lower(trim(status)) in ('no show','no-show')
            then 'No show'
        when lower(trim(status)) = 'cancelled'
            then 'Cancelled'
        when lower(trim(status)) = 'rescheduled'
            then 'Rescheduled'
        when lower(trim(status)) = 'scheduled'
            then 'Scheduled'
        when lower(trim(status)) in ('n/a', 'none', '')
            then 'N/A'
        else status
    end;
commit;

select distinct(payment_method),length(payment_method)
from appointments
order by payment_method ;
update appointments
set payment_method = trim(payment_method);

select distinct(amount)
from appointments;
-- --In this amount column ,'-1' represent null value  so ->
start transaction;
update appointments
set amount = null
where amount=-1;
commit;
-- --convert negative value into positive->
start transaction;
update appointments
set amount= abs(amount)
where amount<0;
commit;
 
 