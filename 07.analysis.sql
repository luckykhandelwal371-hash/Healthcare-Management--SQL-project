-- patients.patient_id -> appointments.patient_id
-- doctors.doctor_id -> appointments.doctor_id
-- patients.patient_id -> medical_records.patient_id
-- doctors.doctor_id -> medical_records.doctor_id
-- patients.patient_id -> prescriptions.patient_id
-- doctors.doctor_id -> prescriptions.doctor_id

-- BUSINESS Question
-- - 1)Which doctors/departments generate the most completed appointments and revenue?
-- - 2)What is the cancellation and no-show rate by department?
-- - 3)Which patients have the highest number of visits?
-- - 4)Which diagnoses are most common?
-- - 5)Which medicines are prescribed most frequently?
-- - 6)What is the average consultation amount by department?
-- --7)Which doctors handle the highest number of completed appointments?
-- - 8)What are monthly appointment and revenue trends?
-- - 9)How many patients have multiple prescriptions?
-- --10)What is the average number of appointments per doctor, and how does each doctor compare with the average?

---------------------------------------------------------------------------------------------------------------------------------------
-- --1) Top 5 doctor and department who contributes highest revenue -> 
---------------------------------------------------------------------------------------------------------------------------------------
select d.doctor_id, d.doctor_name, d.department, count(a.appointment_id)as completed_appointments, sum(a.amount) as total_revenue 
from appointments as a
join doctors as d
on a.doctor_id=d.doctor_id
where a.status="Completed"
group by d.doctor_id,d.doctor_name,d.department
order by total_revenue desc
limit 5;

---------------------------------------------------------------------------------------------------------------------------------------
-- - 2)Department wise cancellation rate and no show rate (%).
---------------------------------------------------------------------------------------------------------------------------------------
select
    d.department,
    count(a.appointment_id) as total_appointments,

    sum(case
        when a.status = "Cancelled" then 1
        else 0
    end) as cancelled_appointments,

    sum(case
        when a.status = "No Show" then 1
        else 0
    end) as no_show_appointments,

    round(
        sum(case when a.status = "Cancelled" then 1 else 0 end)
        * 100.0 / count(a.appointment_id), 2
    ) as cancellation_rate,

    round(
        sum(case when a.status = "No Show" then 1 else 0 end)
        * 100.0 / count(a.appointment_id), 2
    ) as no_show_rate

from appointments as a
join doctors as d
    on a.doctor_id = d.doctor_id
group by d.department
order by cancellation_rate desc;

---------------------------------------------------------------------------------------------------------------------------------------
-- 3)Show patients info who have highest number of visits in the hospital.
---------------------------------------------------------------------------------------------------------------------------------------
select p.patient_name, p.patient_id , count(a.appointment_id) as total_visit
from patients as p
join appointments as a 
on p.patient_id = a.patient_id
group by p.patient_id, p.patient_name
order by total_visit desc
limit 10;

-- 4)Here are the Dignosis which are most common (top 5)
select diagnosis, count(record_id) as diagnoses_count
from medical_records
group by diagnosis
order by diagnosis desc
limit 5;

---------------------------------------------------------------------------------------------------------------------------------------
-- --5)Here are the top 10 medicine which are used frequently ->
---------------------------------------------------------------------------------------------------------------------------------------
select medicine_name, count(prescription_id) as medicine_used_count
from prescriptions
group by medicine_name 
order by medicine_used_count desc
limit 10;

---------------------------------------------------------------------------------------------------------------------------------------
-- ----6)The average consultation amount by department are ->
---------------------------------------------------------------------------------------------------------------------------------------
select d.department , round(avg(a.amount),1) as average_amt
from doctors as d
join appointments as a 
on d.doctor_id = a.doctor_id
group by d.doctor_id , d.department
order by average_amt desc;

---------------------------------------------------------------------------------------------------------------------------------------
-- - 7) Top 10 doctors handle which has the highest number of completed appointments.
---------------------------------------------------------------------------------------------------------------------------------------
select
    d.doctor_id, d.doctor_name, d.department, count(a.appointment_id) as completed_appointments
from doctors as  d
join appointments as a
on d.doctor_id = a.doctor_id
where a.status = "Completed"
group by d.doctor_id, doctor_name, d.department
order by completed_appointments desc
limit 10;

---------------------------------------------------------------------------------------------------------------------------------------
-- 8)Month_wise appointment and revenue trends ->
---------------------------------------------------------------------------------------------------------------------------------------
with cte as (
select appointment_id, appointment_datetime, monthname(appointment_datetime) as months, amount 
 from appointments
 )
 select months,count(appointment_id) as monthly_appointments,sum(amount) as monthly_revenue
 from cte 
 group by months 
 order by monthly_revenue;
 
 ---------------------------------------------------------------------------------------------------------------------------------------
-- -- 9)Number of patients have multiple prescriptions?
---------------------------------------------------------------------------------------------------------------------------------------
select p.patient_id, p.patient_name , p.phone , count(pr.prescription_id) as count
from patients as p 
join prescriptions as pr
on p.patient_id=pr.patient_id
group by p.patient_id,p.patient_name ,p.phone
having count>1
order by count desc;

---------------------------------------------------------------------------------------------------------------------------------------
-- --10)What is the average number of appointments per doctor, and how does each doctor compare with the average?
---------------------------------------------------------------------------------------------------------------------------------------
select d.doctor_id , 
       d.doctor_name ,
       d.department,
       count(a.appointment_id)as total_appointments,
       round(avg(count(a.appointment_id)) over() , 1) as average_appointments,
       round(count(a.appointment_id) - avg(count(a.appointment_id))over(),1) as difference_from_average
from doctors as d
join appointments as a 
on d.doctor_id = a.doctor_id
where a.status="completed"
group by d.doctor_id,d.doctor_name,d.department;
