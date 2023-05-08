-- Testing the functions and procedures assosciated with calculating the subtotal, shipping cost, and totalcost
-- Procedures: CALCULATE_SUBTOTAL, CALCULATE_SHIP_COST
-- Functions: CALCULATE_TOTAL_COST
-- The procedure CALCULATE_SUBTOTAL in turn uses the function PRODUCT_PRICE.
DECLARE
    lv_ship_cost NUMBER;
    lv_subtotal INVENTORY.PRICE%TYPE;
    lv_total_cost NUMBER;
BEGIN
    CALCULATE_SUBTOTAL(10002,lv_subtotal);
    CALCULATE_SHIP_COST('scarborough',lv_ship_cost);
    DBMS_OUTPUT.PUT_LINE('SubTotal for the order 10002: ' ||lv_subtotal);
    DBMS_OUTPUT.PUT_LINE('Shipping cost for the location: $' ||lv_ship_cost);
    
    lv_total_cost:= CALCULATE_TOTAL_COST(10002,'scarborough');
    DBMS_OUTPUT.PUT_LINE('Total cost for the order 10002: $' ||lv_total_cost);
END;


-- Testing code for the Procedure UPDATE_CUSTOMER_INFO
DECLARE
    lv_customer_id CUSTOMERS.CUSTOMER_ID%TYPE:=20231;
    
    lv_out_customer_id CUSTOMERS.CUSTOMER_ID%TYPE;
    lv_out_customer_email CUSTOMERS.EMAIL%TYPE;
BEGIN

    SELECT customer_id, email 
    INTO lv_out_customer_id,lv_out_customer_email
    FROM customers
    WHERE customer_id = lv_customer_id;

    DBMS_OUTPUT.PUT_LINE('Customer Email before updation');
    DBMS_OUTPUT.PUT_LINE('Customer Id: ' ||lv_out_customer_id);
    DBMS_OUTPUT.PUT_LINE('Customer Email: ' ||lv_out_customer_email);

    UPDATE_CUSTOMER_INFO(
        p_customer_id => lv_customer_id,
        new_email => 'mackhenry@gmail.com'
    );
    
    SELECT customer_id, email 
    INTO lv_out_customer_id,lv_out_customer_email
    FROM customers
    WHERE customer_id = lv_customer_id;

    DBMS_OUTPUT.PUT_LINE('');    
    DBMS_OUTPUT.PUT_LINE('Customer Name after updating email');
    DBMS_OUTPUT.PUT_LINE('Customer Id: ' ||lv_out_customer_id);
    DBMS_OUTPUT.PUT_LINE('Updated Customer Email: ' ||lv_out_customer_email);
    
END;

-- Testing code for the Procedure update_order_status
DECLARE
    lv_order_id ORDERS.ORDER_ID%TYPE:=10001;
    lv_status_id ORDER_STATUS.STATUS_ID%TYPE:=504;
    lv_out_order_id ORDERS.ORDER_ID%TYPE;
    lv_out_order_status ORDER_STATUS.STATUS%TYPE;
BEGIN

    SELECT order_id, status 
    INTO lv_out_order_id,lv_out_order_status
    FROM orders JOIN order_status USING(status_id)
    WHERE order_id = lv_order_id;

    DBMS_OUTPUT.PUT_LINE('Order Status before update');
    DBMS_OUTPUT.PUT_LINE('Order Id: ' ||lv_out_order_id);
    DBMS_OUTPUT.PUT_LINE('Order Status: ' ||lv_out_order_status);

    update_order_status(lv_order_id, lv_status_id);
    
    SELECT order_id, status 
    INTO lv_out_order_id,lv_out_order_status
    FROM orders JOIN order_status USING(status_id)
    WHERE order_id = lv_order_id;

    DBMS_OUTPUT.PUT_LINE('');    
    DBMS_OUTPUT.PUT_LINE('Order Status after update');
    DBMS_OUTPUT.PUT_LINE('Order Id: ' ||lv_out_order_id);
    DBMS_OUTPUT.PUT_LINE('Order Status: ' ||lv_out_order_status);
    
END;

-- Testing code for the package OrderManagement_PP
DROP PROCEDURE CALCULATE_SUBTOTAL;
DROP PROCEDURE CALCULATE_SHIP_COST;
DROP FUNCTION CALCULATE_TOTAL_COST;
DECLARE
    lv_ship_cost NUMBER;
    lv_subtotal INVENTORY.PRICE%TYPE;
    lv_total_cost NUMBER;
BEGIN
      OrderManagement_PP.CALCULATE_SUBTOTAL(10002,lv_subtotal);
      OrderManagement_PP.CALCULATE_SHIP_COST('scarborough',lv_ship_cost);
      DBMS_OUTPUT.PUT_LINE('SubTotal for the order 10002: ' ||lv_subtotal);
      DBMS_OUTPUT.PUT_LINE('Shipping cost for the location: $' ||lv_ship_cost);
    
      lv_total_cost:= OrderManagement_PP.CALCULATE_TOTAL_COST(10002,'scarborough');
      DBMS_OUTPUT.PUT_LINE('Total cost for the order 10002: $' ||lv_total_cost);
END;

--- TRIGGERS EXECUTION SYNTAX

BEGIN
    UPDATE ORDERS
    SET STATUS_ID = 503
    WHERE ORDER_ID = 10003;
END;


BEGIN
    UPDATE ORDERS
    SET STATUS_ID = 502
    WHERE ORDER_ID = 10004;
END;
