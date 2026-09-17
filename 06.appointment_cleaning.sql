-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Data cleaning of Appointments.
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select * from appointments
limit 20;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find duplicate value and handle if exist 
-- -- CHECK ->
select appointment_id,count(*) as c
from appointments
group by appointment_id
 having c>1;
 -- -- No duplicate record is the table!
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- check and treat Null values in each columns if exist.
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK ->
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
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(patient_id)
from appointments;
-- -- NOT exist!
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(doctor_id)
from appointments;
-- -- NOT exist!
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(appointment_datetime)
from appointments;
-- -- NOT exist!
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(appointment_type)
from appointments;
-- -- NOT exist!
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(status)
from appointments
order by status;
-- -- CLEANING (?inconsistent data value)
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
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(payment_method),length(payment_method)
from appointments
order by payment_method ;
-- -- CLEANING [?extra space between words] ->
update appointments
set payment_method = trim(payment_method);
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK (email) ->
select distinct(amount)
from appointments;
-- -- CLEANING [?amount column has negetive value '-1' ,so ->
start transaction;
update appointments
set amount = null
where amount=-1;
commit;
-- -- CLEANING [?columns has  inappropiate negetive value] ->
start transaction;
update appointments
set amount= abs(amount)
where amount<0;
commit;
 
 