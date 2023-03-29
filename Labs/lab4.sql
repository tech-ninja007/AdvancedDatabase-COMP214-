--1
DECLARE
 lv_test_date DATE := '10-DEC-12';
 lv_test_num constant NUMBER(3) := 10;
 lv_test_txt VARCHAR2(20);
BEGIN
 lv_test_txt := 'Brown';
 DBMS_OUTPUT.PUT_LINE(lv_test_date);
 DBMS_OUTPUT.PUT_LINE(lv_test_txt);
 DBMS_OUTPUT.PUT_LINE(lv_test_num);
END;

--2
