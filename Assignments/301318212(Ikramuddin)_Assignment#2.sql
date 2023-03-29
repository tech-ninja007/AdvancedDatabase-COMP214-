--1
/*select idproj, count(idpledge), SUM(pledgeamt), avg(pledgeamt) 
from dd_pledge group by idproj;
select d1.idproj, d1.projname, d2.pledges, d2.total, d2.average
from dd_project d1 inner join (
    select idproj, count(idpledge) pledges, SUM(pledgeamt) total, avg(pledgeamt) average
    from dd_pledge
    group by idproj) d2 
on d1.idproj = d2.idproj where d1.idproj = 503;*/

DECLARE
    TYPE pledge_totals_type IS RECORD(
        project_id dd_project.idproj%TYPE,
        project_name dd_project.projname%TYPE,
        no_of_pledges NUMBER(3),
        total_amount NUMBER(5),
        average_amount NUMBER(5));
    rec_pledges pledge_totals_type;
    lv_project_id NUMBER(3):= 503;
BEGIN
    SELECT d1.idproj, d1.projname, d2.pledges, d2.total, d2.average
    INTO rec_pledges
    FROM dd_project d1 INNER JOIN (
        SELECT idproj, COUNT(idpledge) pledges, SUM(pledgeamt) total, AVG(pledgeamt) average
        FROM dd_pledge
        GROUP BY idproj) d2 
    ON d1.idproj = d2.idproj
    WHERE d1.idproj = lv_project_id;
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    END IF;
    DBMS_OUTPUT.PUT_LINE('ID:'|| rec_pledges.project_id ||' NAME:'|| rec_pledges.project_name 
        ||' COUNT:'|| rec_pledges.no_of_pledges ||' Total Amount:'|| rec_pledges.total_amount 
        ||' AVERAGE AMOUNT:'|| rec_pledges.average_amount);    
END;

--2
CREATE SEQUENCE DD_PROJID_SEQ
INCREMENT BY 1
START WITH 530;


DECLARE
    lv_project_name VARCHAR(40);
    lv_start DATE;
    lv_end DATE;
    lv_fund_goal NUMBER(6);
BEGIN
    lv_project_name := 'HK Animal Shelter Extension';
    lv_start := '01-01-13';
    lv_end :='31-05-13';
    lv_fund_goal := 68000;
   INSERT INTO dd_project (idproj, projname, projstartdate, projenddate, projfundgoal)
   VALUES (dd_projid_seq.nextval, lv_project_name, lv_start, lv_end, lv_fund_goal);
END;

--3
/*
SELECT idpledge, iddonor, pledgeamt, paymonths 
FROM dd_pledge 
WHERE Extract(Month from pledgedate) = '10'
ORDER BY paymonths;*/
DECLARE
    CURSOR cur_pledge(p_month NUMBER) IS
        SELECT idpledge, iddonor, pledgeamt, paymonths 
        FROM dd_pledge 
        WHERE Extract(Month from pledgedate) = p_month
        ORDER BY paymonths;
    TYPE type_pledge IS RECORD(
    pledge_id dd_pledge.idpledge%TYPE,
    donor_id dd_pledge.iddonor%TYPE,
    pledge_amount dd_pledge.pledgeamt%TYPE,
    pay_months dd_pledge.paymonths%TYPE);
    rec_pledges type_pledge;
    lv_month VARCHAR(2);
BEGIN
    lv_month:= '10';
    OPEN cur_pledge(lv_month);
    LOOP
        FETCH cur_pledge INTO rec_pledges;
        EXIT WHEN cur_pledge%NOTFOUND;
        IF rec_pledges.pay_months = 0 THEN
            DBMS_OUTPUT.PUT_LINE('PLEDGE ID:'|| rec_pledges.pledge_id
            ||' DONOR ID:'||rec_pledges.donor_id||' PLEDGE AMOUNT:'||rec_pledges.pledge_amount||' LUMP SUM');
        ELSE
            DBMS_OUTPUT.PUT_LINE('PLEDGE ID:'|| rec_pledges.pledge_id
            ||' DONOR ID:'||rec_pledges.donor_id||' PLEDGE AMOUNT:'||rec_pledges.pledge_amount
            ||' MONTHLY #'|| rec_pledges.pay_months);
        END IF;
    END LOOP;
    CLOSE cur_pledge;
END;

--4
/*select sum(payamt) total_paid, idpledge from dd_payment group by idpledge order by idpledge;
select d1.idpledge, d1.iddonor, d1.pledgeamt, total_paid, (pledgeamt-total_paid) need_to_pay
from dd_pledge d1 
inner join (select sum(payamt) total_paid, idpledge 
    from dd_payment group by idpledge) d2
on d1.idpledge = d2.idpledge;*/

DECLARE      
    TYPE type_pledge IS RECORD(
    pledge_id dd_pledge.idpledge%TYPE,
    donor_id dd_pledge.iddonor%TYPE,
    pledge_amount dd_pledge.pledgeamt%TYPE,
    total_paid NUMBER(5),
    need_to_pay NUMBER(5));
    rec_pledges type_pledge;
    lv_pledge_id dd_pledge.idpledge%TYPE;
BEGIN
    lv_pledge_id:=107;
    SELECT d1.idpledge, d1.iddonor, d1.pledgeamt, total_paid, (pledgeamt-total_paid) need_pay
    INTO rec_pledges
    FROM dd_pledge d1 INNER JOIN (SELECT SUM(payamt) total_paid, idpledge 
        FROM dd_payment 
        GROUP BY idpledge) d2
    ON d1.idpledge = d2.idpledge
    WHERE d1.idpledge = lv_pledge_id;
    
    DBMS_OUTPUT.PUT_LINE('PLEDGE ID:'|| rec_pledges.pledge_id
            ||' DONOR ID:'||rec_pledges.donor_id||' PLEDGE AMOUNT:'||rec_pledges.pledge_amount
            ||' Total paid:'||rec_pledges.total_paid||' NEED TO PAY:'|| rec_pledges.need_to_pay );   
END;

--5 
DECLARE
    lv_project_id NUMBER(3);
    lv_project_name VARCHAR(70);
    lv_start DATE;
    lv_end DATE;
    lv_prev_fund_goal NUMBER(6);
    lv_updated_fund_goal NUMBER(6);
BEGIN
    lv_project_id:= 501;
    lv_updated_fund_goal :=78000;
    SELECT projname, projstartdate, projenddate, projfundgoal 
    INTO lv_project_name, lv_start, lv_end, lv_prev_fund_goal
    FROM dd_project
    WHERE idproj = lv_project_id;
    
    UPDATE dd_project
    SET projfundgoal = lv_updated_fund_goal
    WHERE idproj = lv_project_id;

    DBMS_OUTPUT.PUT_LINE('ID:'|| lv_project_id ||' NAME:'|| lv_project_name 
    ||' START DATE:'|| lv_start ||' END DATE:'|| lv_end
    ||' PREV FUND:'|| lv_prev_fund_goal ||' UPDATED FUND:'||lv_updated_fund_goal);
END;

