--1
DECLARE 
lv_cardtype bb_basket.cardtype%TYPE;
lv_bask_num NUMBER(3) := 8;
BEGIN
SELECT cardtype 
INTO lv_cardtype FROM bb_basket
WHERE idbasket = lv_bask_num;
IF lv_cardtype = 'V' THEN
    DBMS_OUTPUT.PUT_LINE('VISA CARD');
ELSIF lv_cardtype = 'X' THEN
    DBMS_OUTPUT.PUT_LINE('AMERICAN EXPRESS CARD');
ELSIF lv_cardtype ='M' THEN
    DBMS_OUTPUT.PUT_LINE('MASTER CARD');
ELSE
    DBMS_OUTPUT.PUT_LINE('NO CARD');
END IF;
END;

--2
DECLARE
TYPE type_card IS RECORD(
    card# bb_basket.cardnumber%TYPE, 
    cardtype bb_basket.cardtype%TYPE
);
rec_card type_card;
lv_bask_num NUMBER(3) := 7;
BEGIN
SELECT cardnumber, cardtype 
INTO rec_card FROM bb_basket
WHERE idbasket = 8;
DBMS_OUTPUT.PUT_LINE('CARD#:'||rec_card.card#);
DBMS_OUTPUT.PUT_LINE('CARDTYPE:'||rec_card.cardtype);
END;

--3


