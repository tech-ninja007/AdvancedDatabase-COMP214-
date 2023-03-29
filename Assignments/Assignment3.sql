--1
--Function
CREATE OR REPLACE FUNCTION  NUM_PURCH_SF
    ( shopper_id IN bb_shopper.idshopper%TYPE)
    RETURN NUMBER
IS
    lv_count_order NUMBER;
BEGIN
    select count(idbasket) 
    into lv_count_order
    from bb_basket 
    where idshopper = shopper_id AND orderplaced = 1 
    group by idshopper;
    return lv_count_order;
END;

--Invoking Function
--query
SELECT idshopper ,NUM_PURCH_SF(idshopper) number_of_orders FROM bb_shopper 
WHERE idshopper = 23;
--anonymus block
/*
DECLARE 
    lv_count NUMBER;
    lv_shopper_id bb_basket.idshopper%TYPE := 23;
BEGIN
    SELECT NUM_PURCH_SF(idshopper)
    INTO  lv_count
    FROM bb_shopper
    WHERE idshopper = lv_shopper_id;
    DBMS_OUTPUT.PUT_LINE('Shopper Id:'||lv_shopper_id||' Number of Orders:'||lv_count);
END;
*/


--2
--Function
CREATE OR REPLACE FUNCTION DAY_ORD_SF
    (order_date IN bb_basket.dtcreated%TYPE)
    RETURN VARCHAR2
IS
    lv_day varchar2(10);
BEGIN 
    lv_day := TO_CHAR(order_date,'DAY');
    RETURN lv_day;
END;

--Invoking Function
--SQL queries
SELECT idbasket , DAY_ORD_SF(dtcreated) order_day from bb_basket;

SELECT count(idbasket) Orders_COUNT, DAY_ORD_SF(dtcreated) order_day 
from bb_basket group by DAY_ORD_SF(dtcreated);

SELECT count(idbasket) Orders_COUNT, DAY_ORD_SF(dtcreated) order_day 
from bb_basket group by DAY_ORD_SF(dtcreated)
order by orders_count DESC;
--anonymous block
/*
DECLARE 
    lv_basket_id bb_basket.idbasket%TYPE;
    lv_day varchar2(10);
    CURSOR cv_order IS 
    SELECT idbasket , DAY_ORD_SF(dtcreated) order_day
    from bb_basket;
    CURSOR cv_order_day IS 
    SELECT count(idbasket) orders_count, DAY_ORD_SF(dtcreated) order_day 
    from bb_basket 
    group by DAY_ORD_SF(dtcreated);
BEGIN
    FOR rec_order IN cv_order LOOP
        DBMS_OUTPUT.PUT_LINE('Id Basket:'|| rec_order.idbasket ||' Day of Order:'||rec_order.order_day);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    FOR rec_order IN cv_order_day LOOP
        DBMS_OUTPUT.PUT_LINE('NUMBER OF ORDERS:'|| rec_order.orders_count ||' Day of Order:'||rec_order.order_day);
    END LOOP;
END;
*/

--3
SELECT b1.idbasket, b2.idstatus,b2.idstage, b1.dtordered, b2.dtstage
from bb_basket b1 join bb_basketstatus b2
on b1.idbasket = b2.idbasket
where idstatus = 1;
--Function
CREATE OR REPLACE FUNCTION ORD_SHIP_SF
    (status_id IN bb_basketstatus.idstatus%TYPE)
    RETURN VARCHAR2
IS
    lv_result varchar2(20);
    TYPE type_ship IS RECORD(
        basket_id bb_basket.idbasket%TYPE,
        status_id bb_basketstatus.idstatus%TYPE,
        stage_id bb_basketstatus.idstage%TYPE,
        order_date bb_basket.dtordered%TYPE,
        stage_date bb_basketstatus.dtstage%TYPE
    );
    rec_ship type_ship;
BEGIN
    SELECT b1.idbasket, b2.idstatus,b2.idstage, b1.dtordered, b2.dtstage
    INTO rec_ship
    from bb_basket b1 join bb_basketstatus b2
    on b1.idbasket = b2.idbasket
    where idstatus = status_id;
    IF rec_ship.stage_id = 5 THEN
        IF rec_ship.stage_date - rec_ship.order_date <= 1 THEN
            lv_result := 'OK';            
        ELSE
            lv_result := 'CHECK';
        END IF;
    ELSE
        lv_result := 'NOT SHIPPED';
    END IF;
    RETURN lv_result;
END;
--query
SELECT b1.idbasket, b2.idstatus,b2.idstage, b1.dtordered, b2.dtstage, b2.dtstage-b1.dtordered,ORD_SHIP_SF(idstatus)
from bb_basket b1 join bb_basketstatus b2
on b1.idbasket = b2.idbasket; 
INSERT INTO BB_BASKETSTATUS (idstatus, idbasket, idstage,dtstage )VALUES (16,8,5,'17-02-12');

--anonymous block
DECLARE
    lv_result varchar2(20);
    lv_status_id bb_basketstatus.idstatus%TYPE;
BEGIN
    lv_status_id := 16;
    lv_result:= ORD_SHIP_SF(lv_status_id);
    DBMS_OUTPUT.PUT_LINE('STATUS ID:'||lv_status_id||' ORDER STATUS:'||lv_result);
    
    lv_status_id := 2;
    lv_result:= ORD_SHIP_SF(lv_status_id);
    DBMS_OUTPUT.PUT_LINE('STATUS ID:'||lv_status_id||' ORDER STATUS:'||lv_result);
    
    lv_status_id := 15;
    lv_result:= ORD_SHIP_SF(lv_status_id);
    DBMS_OUTPUT.PUT_LINE('STATUS ID:'||lv_status_id||' ORDER STATUS:'||lv_result);
    
END;

rollback;

--4 
--TRIGGER
CREATE OR REPLACE TRIGGER BB_ORD_CANCEL_TRG
    AFTER INSERT
    ON BB_BASKETSTATUS
    FOR EACH ROW
DECLARE
    CURSOR cv_basketitem IS
    SELECT * from bb_basketitem
    where idbasket = :NEW.idbasket;    
BEGIN
    DBMS_OUTPUT.PUT_LINE('BB_ORD_CANCEL_TRG Fired');
    IF :NEW.idstage = 4  THEN
        DBMS_OUTPUT.PUT_LINE('');
        FOR rec_basketitem in cv_basketitem LOOP
            DBMS_OUTPUT.PUT_LINE('');
            IF rec_basketitem.option1 = 1 THEN
                UPDATE bb_product
                SET stock = stock + 0.5*rec_basketitem.quantity
                where idproduct = rec_basketitem.idproduct;
            ELSE
                UPDATE bb_product
                SET stock = stock + 1*rec_basketitem.quantity
                where idproduct = rec_basketitem.idproduct;
            END IF;
        END LOOP;
    END IF;
END;

INSERT INTO bb_basketstatus 
(idStatus, idBasket, idStage, dtStage) 
VALUES (bb_status_seq.NEXTVAL, 6, 4, SYSDATE);

ROLLBACK;

ALTER TRIGGER bb_ord_cancel_trg DISABLE;

--5
--package
CREATE OR REPLACE PACKAGE DISC_PKG IS
    pv_disc_num NUMBER(3);
    pv_disc_text VARCHAR2(1);
    TRIGGER BB_DISCOUNT_TRG
    AFTER INSERT OR UPDATE
    ON BB_BASKET
    FOR EACH ROW
END;

    