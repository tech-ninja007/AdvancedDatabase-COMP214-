
--ORDER CANCEL TRIGGER

CREATE OR REPLACE TRIGGER ORD_CANCEL_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE
    CURSOR cv_orderitem IS
    SELECT * from order_items
    where order_id = :NEW.order_id;    
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_CANCEL_TRG Fired');
    IF :NEW.status_id = 503  THEN
        DBMS_OUTPUT.PUT_LINE('');
        FOR rec_item in cv_orderitem LOOP
            DBMS_OUTPUT.PUT_LINE('');
            UPDATE INVENTORY
            SET stock_qty = stock_qty + rec_item.quantity
            where product_id = rec_item.product_id;           
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
    SELECT * from order_items
    where order_id = :NEW.order_id;    
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_Confirmed_TRG Fired');
    IF :NEW.status_id = 502  THEN
        DBMS_OUTPUT.PUT_LINE('');
        FOR rec_order in cv_orderitem LOOP
            DBMS_OUTPUT.PUT_LINE('');
            UPDATE INVENTORY
            SET stock_qty = stock_qty - rec_order.quantity
            where product_id = rec_order.product_id;           
        END LOOP;
    END IF;
END;

--ORDER DELIVERED
CREATE OR REPLACE TRIGGER ORD_DELIVERED_TRG
    AFTER UPDATE
    ON ORDERS
    FOR EACH ROW
DECLARE 
    lv_payment_id payments.payment_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ORD_Delivered_TRG Fired');
    IF :NEW.status_id = 504  THEN
        DBMS_OUTPUT.PUT_LINE('');
        --update
        UPDATE PAYMENTS
        SET payment_status = 'PAID'
        where order_id = :NEW.order_id;        
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
    IF :NEW.status_id = 502  THEN
        DBMS_OUTPUT.PUT_LINE('');
        --update
        UPDATE ORDERS
        SET order_date = lv_current_date
        where order_id = :NEW.order_id;        
    END IF;
END;

