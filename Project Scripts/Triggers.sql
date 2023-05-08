--ORDER CANCEL TRIGGER
CREATE OR REPLACE TRIGGER ORD_CANCEL_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE
    CURSOR cv_orderitem IS
    SELECT * from order_item
    where order_id = :NEW.order_id;    
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_CANCEL_TRG Fired');
    IF :NEW.status_id = 3  THEN
        DBMS_OUTPUT.PUT_LINE('');
        FOR rec_orderitem in cv_orderitem LOOP
            DBMS_OUTPUT.PUT_LINE('');
            UPDATE INVENTORY
            SET stock_qty = stock_qty + orderitem.quantity
            where product_id = rec_orderitem.product;           
        END LOOP;
    END IF;
END;

----ORDER CONFIRMED TRIGGER
CREATE OR REPLACE TRIGGER ORD_CONFIRMED_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE
    CURSOR cv_orderitem IS
    SELECT * from order_item
    where order_id = :NEW.order_id;    
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_Confirmed_TRG Fired');
    IF :NEW.status_id = 2  THEN
        DBMS_OUTPUT.PUT_LINE('');
        FOR rec_orderitem in cv_orderitem LOOP
            DBMS_OUTPUT.PUT_LINE('');
            UPDATE INVENTORY
            SET stock_qty = stock_qty - orderitem.quantity
            where product_id = rec_orderitem.product;           
        END LOOP;
    END IF;
END;

--ORDER DELIVERED
CREATE OR REPLACE TRIGGER ORD_DELIVERED_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE 
    lv_payment_id orders.payment_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_Delivered_TRG Fired');
    IF :NEW.status_id = 4  THEN
        DBMS_OUTPUT.PUT_LINE('');
        SELECT payment_id 
        INTO lv_payment_id
        FROM ORDERS
        WHERE order_id = :NEW.order_id;
        --update
        UPDATE PAYMENTS
        SET payment_status = 'PAID'
        where payment_id = lv_payment_id;        
    END IF;
END;

--Order Date 
CREATE OR REPLACE TRIGGER ORD_DATE_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE 
    lv_current_date orders.order_date%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_Date_TRG Fired');
    SELECT SYSDATE
    INTO lv_current_date
    FROM dual;
    IF :NEW.status_id = 2  THEN
        DBMS_OUTPUT.PUT_LINE('');
        --update
        UPDATE ORDERS
        SET order_date = lv_current_date
        where order_id = :NEW.order_id;        
    END IF;
END;

