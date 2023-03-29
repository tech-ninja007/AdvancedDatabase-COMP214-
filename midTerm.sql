--1
--select avg(count(crime_id)) from crimes group by criminal_id;

select c1.criminal_id, c1.last, c1.first, c2.countcrime, c1.v_status
from criminals c1 join 
(select count(crime_id) countCrime, criminal_id from crimes group by criminal_id)c2
on c1.criminal_id = c2.criminal_id
where countCrime < (select avg(count(crime_id)) from crimes group by criminal_id) and 
v_status = 'N';

--2
select a1.appeal_id, a1.crime_id, c1.criminal_id, c2.last, c2.first, a1.filing_date, a1.hearing_date, (a1.hearing_date-a1.filing_date) no_of_days 
from appeals a1 join crimes c1 on a1.crime_id = c1.crime_id
join criminals c2 on c1.criminal_id = c2.criminal_id
where (a1.hearing_date-a1.filing_date) < (select avg(hearing_date-filing_date) avgDays from appeals);
--select avg(hearing_date-filing_date) avgDays from appeals;

--3

/*select d1.idpay, d1.idpledge, d1.payamt, d2.iddonor, d3.firstname, d3.lastname 
from dd_payment d1 
join dd_pledge d2 on d1.idpledge = d2.idpledge
join dd_donor d3  on d2.iddonor = d3.iddonor
where d3.iddonor = 308 ;*/

--select idpledge, sum(payamt) from dd_payment group by idpledge;
/*
select d1.idpledge, d2.payamt, d1.iddonor, d3.firstname, d3.lastname 
from dd_pledge d1 
join (select idpledge, sum(payamt) payamt from dd_payment 
group by idpledge) d2 on d1.idpledge = d2.idpledge
join dd_donor d3  on d1.iddonor = d3.iddonor
where d3.iddonor = 308;*/

DECLARE 
    cv_pledge SYS_REFCURSOR;
    TYPE type_detail IS RECORD(
        pay_id dd_payment.idpay%TYPE,
        pledge_id dd_pledge.idpledge%TYPE,
        amount dd_payment.payamt%TYPE,
        donor_id dd_donor.iddonor%TYPE,
        firstname dd_donor.firstname%TYPE,
        lastname dd_donor.lastname%TYPE
    );
    TYPE type_summary IS RECORD(
        pledge_id dd_pledge.idpledge%TYPE,
        amount dd_payment.payamt%TYPE,
        donor_id dd_donor.iddonor%TYPE,
        firstname dd_donor.firstname%TYPE,
        lastname dd_donor.lastname%TYPE
    );
    rec_detail type_detail;
    rec_summary type_summary;
    lv_indicator VARCHAR(1) := 'D';
    lv_donor_id dd_donor.iddonor%TYPE := 308;
    lv_cnt_num NUMBER(2) := 0;
BEGIN           
    IF lv_indicator = 'D' THEN
        OPEN cv_pledge FOR select d1.idpay, d1.idpledge, d1.payamt, d2.iddonor, d3.firstname, d3.lastname 
        from dd_payment d1 
        join dd_pledge d2 on d1.idpledge = d2.idpledge
        join dd_donor d3  on d2.iddonor = d3.iddonor
        where d3.iddonor = lv_donor_id ;
        LOOP 
            FETCH cv_pledge INTO rec_detail;
            EXIT WHEN cv_pledge%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('PAY_ID:'||rec_detail.pay_id||' '||'PLEDGE_ID:'||rec_detail.pledge_id||' '||'AMOUNT:'||'$'||rec_detail.amount||' '||'DONOR_ID:'||rec_detail.donor_id||' '||'DONOR_NAME:'||rec_detail.firstname||' '|| rec_detail.lastname);
        END LOOP;    
    ELSIF lv_indicator = 'S' THEN
        OPEN cv_pledge FOR select d1.idpledge, d2.payamt, d1.iddonor, d3.firstname, d3.lastname 
            from dd_pledge d1 
            join (select idpledge, sum(payamt) payamt from dd_payment 
            group by idpledge) d2 on d1.idpledge = d2.idpledge
            join dd_donor d3  on d1.iddonor = d3.iddonor
            where d3.iddonor = lv_donor_id;
        LOOP 
            FETCH cv_pledge INTO rec_summary;
            EXIT WHEN cv_pledge%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('PLEDGE_ID:'||rec_summary.pledge_id||' '||'AMOUNT:'||'$'||rec_summary.amount||' '||'DONOR_ID:'||rec_summary.donor_id||' '||'DONOR_NAME:'||rec_summary.firstname||' '|| rec_summary.lastname);
        END LOOP; 
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('wrong input');
    END IF;
    
END;
