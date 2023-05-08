--1
CREATE OR REPLACE FUNCTION STATUS_DESC_SF
    (stage_id IN bb_basketstatus.idstage%TYPE)
    RETURN VARCHAR2
IS
    lv_result varchar2(20);    
BEGIN
    IF stage_id = 1 THEN
        lv_result := 'ORDER SUBMITTED';
    ELSIF stage_id = 2 THEN
        lv_result := 'ACCPEDTED, sent to shipping';
    ELSIF stage_id = 3 THEN
        lv_result := 'BACK-ORDERED';
    ELSIF stage_id = 4 THEN
        lv_result := 'CANCELLED';
    ELSE
        lv_result := 'SHIPPED';
    END IF;
    RETURN lv_result;
END;

SELECT idstatus, idbasket, idstage, STATUS_DESC_SF(idstage) from bb_basketstatus;

--2
DROP TABLE DD_PAYTRACK;
CREATE TABLE DD_PAYTRACK (
    idpaytrack NUMBER(4,0) PRIMARY KEY,
    username varchar2(30) DEFAULT USER,
    current_date date DEFAULT SYSDATE,
    action_taken varchar2(15),
    idpay NUMBER(6,0)
);

--select USER, sysdate from dual;
DROP SEQUENCE DD_PTRACK_SEQ;
CREATE SEQUENCE DD_PTRACK_SEQ
START WITH 100
INCREMENT BY 10;

CREATE OR REPLACE TRIGGER DD_PAYMENT_TRG
    BEFORE INSERT OR UPDATE OR DELETE
    ON DD_PAYMENT
    FOR EACH ROW
DECLARE
     lv_action varchar2(20);   
BEGIN
    DBMS_OUTPUT.PUT_LINE('DD_PAYMENT_TRG Fired');
    IF INSERTING THEN
        lv_action := 'INSERT';
        INSERT INTO DD_PAYTRACK (idpaytrack, username, current_date,action_taken,idpay) 
        VALUES (DD_PTRACK_SEQ.nextval, USER, SYSDATE, lv_action,:NEW.idpay);
    END IF;
    IF DELETING THEN
        lv_action := 'DELETE';
        INSERT INTO DD_PAYTRACK (idpaytrack, username, current_date,action_taken,idpay) 
        VALUES (DD_PTRACK_SEQ.nextval, USER, SYSDATE, lv_action,:OLD.idpay);
    END IF;
    IF UPDATING THEN
        lv_action := 'UPDATE'; 
        INSERT INTO DD_PAYTRACK (idpaytrack, username, current_date,action_taken,idpay) 
        VALUES (DD_PTRACK_SEQ.nextval, USER, SYSDATE, lv_action,:NEW.idpay);
    END IF;    
END;

--INSERT
INSERT INTO DD_PAYMENT 
VALUES(1465,109,30,SYSDATE,'CC');
--UPDATE
UPDATE DD_PAYMENT
SET payamt = 40
WHERE idpay = 1465;
--DELETE
DELETE FROM DD_PAYMENT WHERE idpay =1465;

--CHECK DD_PAYTRACK
SELECT * from DD_PAYTRACK;





