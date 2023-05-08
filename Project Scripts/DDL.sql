DROP TABLE CUSTOMERS;
DROP TABLE ADDRESSES;
DROP TABLE ORDER_STATUS;
DROP TABLE PAYMENTS;
DROP TABLE ORDERS;
DROP TABLE PRODUCT_CATEGORIES;
DROP TABLE INVENTORY;
DROP TABLE ORDER_ITEMS;

CREATE TABLE CUSTOMERS(
    customer_id NUMBER(5) PRIMARY KEY,
    customer_name varchar(30) NOT NULL,
    email varchar(60) UNIQUE
);

CREATE TABLE ADDRESSES(
    address_id NUMBER(5) PRIMARY KEY,
    customer_id NUMBER,
    address_name varchar(20),
    street varchar(20) NOT NULL,
    city varchar(20) NOT NULL,
    province varchar(10) NOT NULL,
    postal_code varchar(10) NOT NULL,
    CONSTRAINT FK_CustomerAddress FOREIGN KEY (customer_id)
    REFERENCES CUSTOMERS(customer_id)    
);

CREATE TABLE ORDER_STATUS(
    status_id NUMBER(5) PRIMARY KEY,
    status varchar(15)
);


CREATE TABLE ORDERS(
    order_id NUMBER(5) PRIMARY KEY,
    order_date date NULL,
    ship_date  date NULL,
    customer_id NUMBER(5),
    address_id NUMBER(5),
    status_id NUMBER(5),
    CONSTRAINT FK_CustomerOrder FOREIGN KEY (customer_id)
    REFERENCES CUSTOMERS(customer_id),
    CONSTRAINT FK_OrderAddress FOREIGN KEY (address_id)
    REFERENCES ADDRESSES(address_id),  
    CONSTRAINT FK_OrderStatus FOREIGN KEY (status_id)
    REFERENCES ORDER_STATUS(status_id)
);
CREATE TABLE PAYMENTS(
    payment_id NUMBER(5) PRIMARY KEY,
    order_id NUMBER(5),
    payment_status varchar(20),
    payment_mode varchar(10),
    CONSTRAINT FK_OrderPayment FOREIGN KEY (order_id)
    REFERENCES ORDERS(order_id)
); 

CREATE TABLE PRODUCT_CATEGORIES(
    category_id NUMBER(5) PRIMARY KEY,
    category_type varchar(25)
);

CREATE TABLE INVENTORY(
    product_id NUMBER(5) PRIMARY KEY,
    category_id NUMBER(5),
    product_name varchar(30),
    product_desc varchar(500),
    stock_qty NUMBER(4),
    price NUMBER(5,2),
    CONSTRAINT FK_ProductCategory FOREIGN KEY (category_id)
    REFERENCES PRODUCT_CATEGORIES(category_id)
);

CREATE TABLE ORDER_ITEMS(
    product_id NUMBER(5),
    order_id NUMBER(5),
    quantity NUMBER(4),
    CONSTRAINT FK_OrderItemProduct FOREIGN KEY (product_id)
    REFERENCES INVENTORY(product_id),
    CONSTRAINT FK_OrderItemOrder FOREIGN KEY (order_id)
    REFERENCES ORDERS(order_id)
);

CREATE SEQUENCE product_id_seq
    INCREMENT BY 10
    START WITH 100
    MAXVALUE 990;

CREATE SEQUENCE order_id_seq
    INCREMENT BY 10
    START WITH 100;

CREATE SEQUENCE address_id_seq
    INCREMENT BY 1
    START WITH 100;
    
CREATE INDEX product_name_idx
ON INVENTORY(product_name);

CREATE INDEX order_product_idx
ON ORDER_ITEMS(order_id,product_id);

