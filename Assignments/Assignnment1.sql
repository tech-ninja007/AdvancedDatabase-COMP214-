--1
--select max(sum(court_fee)) from crime_charges  group by crime_id;

select  c1.criminal_id,c1.last,c1.first, c2.crime_id, c3.total_courtfee
from criminals c1 join crimes c2 on c1.criminal_id = c2.criminal_id
join (select sum(court_fee) total_courtfee, crime_id from crime_charges group by crime_id) c3 on c3.crime_id= c2.crime_id
where total_courtfee = (select max(sum(court_fee)) from crime_charges  group by crime_id);

--2
--select MIN(amount_paid), crime_id from crime_charges group by crime_id;
select  c1.criminal_id, c1.last, c1.first, c2.crime_id, c3.total_amountpaid
from criminals c1 join crimes c2 on c1.criminal_id = c2.criminal_id
join (select sum(amount_paid) total_amountpaid, crime_id from crime_charges group by crime_id) c3 on c3.crime_id= c2.crime_id
where total_amountpaid = (select min(sum(amount_paid)) from crime_charges  group by crime_id);

--3
--select MAX(count(officer_id)) from crime_officers group by officer_id;

--select MAX(officer_count) from (select count(officer_id) officer_count, officer_id 
--from crime_officers group by officer_id) o2 join officers o1 on o2.officer_id = o1.officer_id;

select o1.officer_id, o1.last, o1.first, o2.officer_cases 
from officers o1 join (select count(officer_id) officer_cases, officer_id 
from crime_officers group by officer_id) o2 on o2.officer_id = o1.officer_id
where officer_cases = (select MAX(count(officer_id)) from crime_officers group by officer_id);


--4
--select AVG(count(sentence_id)) from sentences group by criminal_id;

select c1.criminal_id, c1.last, c1.first , s1.sentencesofcriminal 
from criminals c1 join (select count(sentence_id) sentencesOfCriminal, criminal_id 
from sentences group by criminal_id ) s1 on c1.criminal_id = s1.criminal_id
where s1.sentencesOfCriminal > (select AVG(count(sentence_id)) from sentences group by criminal_id);

--5
--select avg(count(criminal_id)) from sentences group by criminal_id; 

--select count(prob_id) probCount, prob_id from sentences group by prob_id;

select  p1.prob_id, p1.last, p1.first, s1.criminalCount 
from prob_officers p1 join (select count(prob_id) criminalCount, prob_id from sentences group by prob_id) s1
on p1.prob_id = s1.prob_id 
where s1.criminalCount > (select avg(count(criminal_id)) from sentences group by criminal_id);

--6
--select violations, criminal_id from sentences;
--select avg(sum(violations)) from sentences group by criminal_id;

select c1.criminal_id, c1.last, c1.first, a1.alias, s1.violations 
from criminals c1 join (select sum(violations) violations, criminal_id from sentences group by criminal_id) s1
on c1.criminal_id = s1.criminal_id join
aliases a1 on c1.criminal_id = a1.criminal_id
where violations < (select avg(sum(violations)) from sentences group by criminal_id);
