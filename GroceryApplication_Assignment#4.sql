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
    payment_status varchar(50),
    payment_mode varchar(50),
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
ON INVENTORY (product_name );

CREATE INDEX order_product_idx
ON ORDER_ITEMS (order_id, product_id);

--Date format
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--Customers
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20231,'Mack Hensley','mackhensley08@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20232, 'Petra Wilkerson', 'petrawilkerson@yahoo.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20233, 'Marcos Flores', 'marcosflores@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20234, 'Rachel Zimmerman', 'rachelzimmerman01@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20235, 'Jonathon Mckenzie', 'jonathonmckenzie@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20236, 'Frederic Oconnor', 'fredericoconnor571@yahoo.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20237, 'Norris Kaiser', 'norriskaiser@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20238, 'Rod Buchanan', 'rodbuchanan13@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20239, 'Lonnie Kennedy', 'lonniekennedy01@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20240, 'Catalina Dean', 'catalinadean11@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20241, 'Nellie Burnett', 'nellieburnett@outlook.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20242, 'Burl Knight', 'burlknight319@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20243, 'Hester Ayers', 'hesterayers205@outlook.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20244, 'Kory Burton', 'koryburton@gmail.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20245, 'Rosario Russo', 'rosariorusso@gmail.com');


--Addresses
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,'20231','Home','12 Eglinton Avenue','Toronto','ON','MD1 5H6');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20231, 'Office', '451 Lawrence Avenue', 'Toronto', 'ON', 'M4C 6L0');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20232, 'Home', '411 Ellesmere Rd', 'Scarborough', 'ON', 'M1G 5K3');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20232, 'Office', '101 York Mills Rd', 'Toronto', 'ON', 'M6X 1F5');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20233, 'Home', '159 Glenforest Rd', 'Toronto', 'ON', 'M5X 4A7');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20234, 'Home', '201 Markham Rd', 'Scarborough', 'ON', 'M9H 4H7');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20235, 'Home', '61 Pachino Blvd', 'Scarborough', 'ON', 'M1R 4J6');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20236, 'Home', '40 Birchmount Rd', 'Scarborough', 'ON', 'M1T 9M0');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20237, 'Home', '54 Oakville Rd', 'Scarborough', 'ON', 'M6G 8H6');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20238, 'Office', '560 Queen St', 'Toronto', 'ON', 'M3F 5V6');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20239, 'Home', '122 Yonge St', 'Toronto', 'ON', 'M1P 7C0');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20240, 'Home', '12 Victoria Park Ave', 'Toronto', 'ON', 'M1X 4C1');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20241, 'Home', '45 Merton St', 'Toronto', 'ON', 'M3P 1B4');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20242, 'Home', '123 Bay St', 'Toronto', 'ON', 'M3P 1B5');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20243, 'Home', '109 Neilson Avenue', 'Toronto', 'ON', 'M0K 3H5');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20244, 'Home', '298 Sheppard Ave', 'Scarborough', 'ON', 'M8U 2T4');
INSERT INTO Addresses (address_id,customer_id,address_name,street,city,province,postal_code) VALUES (address_id_seq.nextval,20245, 'Office', '131 Markham Rd', 'Scarborough', 'ON ', 'M9B 4A5');

--Product Category
INSERT INTO Product_Categories (category_id,category_type) VALUES (1,'Beverages');
INSERT INTO Product_Categories (category_id,category_type) VALUES (2,'Bread');
INSERT INTO Product_Categories (category_id,category_type) VALUES (3,'Canned/Jarred Goods');
INSERT INTO Product_Categories (category_id,category_type) VALUES (4,'Dairy');
INSERT INTO Product_Categories (category_id,category_type) VALUES (5,'Frozen Foods');
INSERT INTO Product_Categories (category_id,category_type) VALUES (6,'Meat');
INSERT INTO Product_Categories (category_id,category_type) VALUES (7,'Fruits');
INSERT INTO Product_Categories (category_id,category_type) VALUES (8,'Sweets');
INSERT INTO Product_Categories (category_id,category_type) VALUES (9,'Vegetables');
INSERT INTO Product_Categories (category_id,category_type) VALUES (10,'Personal Care');
INSERT INTO Product_Categories (category_id,category_type) VALUES (11,'Seafood');
INSERT INTO Product_Categories (category_id,category_type) VALUES (12,'Condiments and Spices');
INSERT INTO Product_Categories (category_id,category_type) VALUES (13,'Pasta, Rice and Cereal');
INSERT INTO Product_Categories (category_id,category_type) VALUES (14,'Snacks');
INSERT INTO Product_Categories (category_id,category_type) VALUES (15,'Others');

--Inventory
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Coca-cola', 'The worlds most popular soft drink, known for its iconic taste and refreshing bubbles.', 574, 4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Sprite','Lemon-lime flavored soft drink that is known for its refreshing taste.',104,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Fanta','Refreshing orange-flavored soft drink.',293,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Pepsi','Classic cola that is known for its bold and refreshing taste.',390,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Minute Maid Orange Juice','Made from 100% real orange juice.',960,3.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,1, 'Lipton Lemon Iced Tea','Made with real tea leaves and no artificial flavors.',405,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,2, 'Dempsters','100% whole grain bread is made from flour that is entirely made from the whole grain kernel.',175,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,2, 'Country Harvest','14-grain bread is a type of bread made from a variety of grains and seeds.',107,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,2, 'Wonder','White Bread  made from refined flour, resulting in a softer and lighter texture.',156,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,2, 'Natural Bakery','Canadian Rye bread is a traditional type of bread made from rye flour.',186,3.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'SPAM','Made with high-quality pork, ham, salt, and a blend of savory spices.',166,3.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'Spicy Chili Con Carne','Made with high-quality ground beef, kidney beans, and a blend of chili spices.',414,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'Maple Baked Beans','Classic Canadian baked beans slow-cooked with real maple syrup for a sweet and savory taste.',32,1.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'Wild Pacific Salmon','Packed with omega-3 fatty acids and protein, its perfect for salads, sandwiches, or eaten straight out of the can.',424,5.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'Pea Soup with Ham','Traditional pea soup made with green peas, carrots, and chunks of smoked ham for a hearty and flavorful soup.',247,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,3, 'Corned Beef','Classic corned beef hash is made with tender chunks of beef, diced potatoes, and a blend of spices.',87,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,4, 'Canadian Cheddar Cheese','Made from the milk of grass-fed cows and aged to perfection for a rich and nutty flavor.',198,6.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,4, 'Maple Syrup Butter','Blended with pure maple syrup for a sweet and delicious spread.',367,3.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,4, 'Yogurt','Smooth and creamy yogurt is made with fresh milk and live cultures.',162,3.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,4, 'Whipped Cream','Made with real cream and a touch of sugar for a light and airy topping.',245,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,4, 'Mango Ice Cream','Premium mango ice cream made with fresh milk and mango cream for a smooth and creamy texture.',29,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,5, 'Dr. Oetker Frozen Pizza',' Dr. Oetker is a popular brand of frozen pizza in Canada, known for its thin crust and gourmet toppings.',385,3.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,5, 'Poutine','Frozen poutine is made with crispy French fries, rich beef gravy, and melty cheese curds for a classic Canadian dish',70,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,5, 'Cavendish Farms French Fries','Frozen French fries are made from 100% real potatoes and are carefully cut and fried to perfection.',258,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,5, 'St. Hubert Chicken Pot Pie','Frozen chicken pot pie is a Canadian favorite, made with tender chicken, potatoes, peas, and carrots in a creamy sauce.',471,5.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Chicken Breasts','Chicken breasts are made from all-natural, grain-fed chickens that are raised without antibiotics.',118,15.9);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Pork Tenderlion',' Pork tenderloin is a lean and versatile cut of meat thats perfect for roasting, grilling, or pan-frying.',387,18.4);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Angus Beef Ribeye Steak','Made from Canadian AAA Angus beef, which is known for its marbling and flavor.',72,15.9);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Halal Chicken Wings','Made from halal-certified chicken and are perfect for game day or any other occasion.',10,17.9);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Canadian Lamb Shoulder','Tender and flavorful lamb shoulder is a Canadian specialty.',219,18.1);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,6, 'Turkey Breasts','Boneless and skinless turkey breast from Maple Leaf Farms is a lean and healthy source of protein.',448,19.1);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,7, 'Gala Apples','Fresh and crisp apples with a sweet flavor.',29,1.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,7, 'Valencia Oranges','Juicy and seedless oranges with a tart flavor.',157,0.79);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,7, 'Sweet Pineapple','Sweet and juicy pineapple with a golden flesh.',338,3.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,7, 'Red Grapes','Sweet and plump grapes with a firm texture.',166,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,7, 'Bananas','Fresh and ripe bananas with a soft texture.',85,0.59);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,8, 'Hersheys Chocolate Bars','Creamy milk chocolate bars with a rich flavor.',143,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,8, 'Skittles Candy','Chewy and fruity candy with a variety of flavors.',326,1.29);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,8, 'Twizzlers Licorice','Chewy and twisted licorice with a strawberry flavor.',305,1.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,8, 'Sour Patch Kids','Sour and sweet gummy candy in a variety of flavors.',486,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,8, 'Reeses Peanut Butter Cups','Creamy peanut butter cups with a milk chocolate coating.',339,0.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,9, 'Broccoli Crowns','Fresh and crisp broccoli crowns with a slightly sweet flavor.',97,1.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,9, 'Carrots','Juicy and sweet carrots with a crunchy texture.',32,0.89);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,9, 'Green Beans','Tender and flavorful green beans with a slight crunch.',132,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,9, 'Red Bell Peppers','Sweet and crunchy red bell peppers with a vibrant color.',135,1.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,9, 'Yellow Onions','Sweet and savory yellow onions with a firm texture.',165,0.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,10, 'Dove Body Wash','Creamy and moisturizing body wash with a soothing scent.',97,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,10, 'Colgate Toothpaste','Fresh and minty toothpaste that fights cavities and whitens teeth.',106,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,10, 'Pantene Shampoo','Nourishing and strengthening shampoo for all hair types.',270,5.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,10, 'Dove Deodorant','Long-lasting deodorant that keeps you feeling fresh all day.',164,3.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,10, 'Q-tips Cotton Swabs','Soft and gentle cotton swabs for a variety of uses.',282,2.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,11, 'Atlantic Salmon Fillets','Fresh and flavorful salmon fillets with a tender texture.',401,12.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,11, 'Raw Shrimp','Sweet and juicy raw shrimp with a mild flavor.',472,9.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,11, 'Ahi Tuna Steaks','Meaty and flavorful tuna steaks with a firm texture.',60,14.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,11, 'Pacific Cod Fillets','Mild and flaky cod fillets with a delicate flavor.',318,8.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,11, 'Wild-caught Scallops','Sweet and tender scallops with a buttery flavor.',259,19.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,12, 'McCormick Garlic Powder','Adds bold, savory flavor to any dish.',213,4.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,12, 'Heinz Ketchup','Classic tomato ketchup for all your favorite foods.',491,3.49);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,13, 'Barilla Spaghetti','Made from high-quality durum wheat semolina for the perfect al dente texture.',339,2.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,13, 'Quaker Oats','Heart-healthy and nutritious oats for a healthy breakfast.',362,4.79);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,14, 'Lays Potato Chips','Crispy and flavorful potato chips in a variety of flavors.',287,3.99);
INSERT INTO Inventory (PRODUCT_ID,CATEGORY_ID,PRODUCT_NAME,PRODUCT_DESC,STOCK_QTY,PRICE) VALUES (product_id_seq.nextval,15, 'Duracell AA Batteries','Reliable and long-lasting power source for your electronics.',303,8.99);

--Order_Status
INSERT INTO ORDER_STATUS (STATUS_ID,STATUS) VALUES (501,'In-basket');
INSERT INTO ORDER_STATUS (STATUS_ID,STATUS) VALUES (502,'Ordered');
INSERT INTO ORDER_STATUS (STATUS_ID,STATUS) VALUES (503,'Cancelled');
INSERT INTO ORDER_STATUS (STATUS_ID,STATUS) VALUES (504,'Delivered');

--Orders
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10001,'2023-01-03',null,'20231',100,502);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10002,'2023-01-23','2023-01-25','20231',100,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10003,null,null,'20232',102,501);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10004,null,null,'20232',102,501);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10005,'2023-02-28',null,'20233',104,502);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10006,'2023-03-03',null,'20234',105,503);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10007,'2023-03-04','2023-03-06','20235',106,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10008,'2023-03-13','2023-03-15','20236',107,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10009,'2023-03-23',null,'20237',108,502);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10010,'2023-03-25',null,'20238',109,503);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10011,null,null,'20239',110,501);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10012,'2023-04-03','2023-04-05','20236',107,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10013,'2023-04-09','2023-04-11','20237',108,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10014,'2023-04-09','2023-04-11','20238',109,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10015,'2023-04-11','2023-04-13','20239',110,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10016,'2023-04-11','2023-04-13','20240',111,504);
INSERT INTO Orders (ORDER_ID, ORDER_DATE, SHIP_DATE, CUSTOMER_ID, ADDRESS_ID, STATUS_ID) VALUES (10017,'2023-04-11','2023-04-13','20241',112,504);

INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (200,10001,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (150,10002,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (160,10003,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (110,10004,2);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (180,10004,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (150,10005,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (160,10005,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (200,10006,2);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (200,10007,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (220,10008,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (130,10009,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (170,10009,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (200,10009,2);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (140,10010,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (170,10011,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (160,10012,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (180,10013,3);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (190,10014,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (130,10015,2);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (110,10016,1);
INSERT INTO ORDER_ITEMS (PRODUCT_ID,ORDER_ID,QUANTITY) VALUES (120,10017,5);



--Payment Status
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(1,10001,'Paid','Debit/Credit');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(2,10007,'Not Paid','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(3,10004,'Refund','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(4,10008,'Paid','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(5,10012,'Not Paid','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(6,10013,'Paid','Debit/Credit');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(7,10014,'Paid','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(8,10015,'Not Paid','Cash');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(9,10016,'Paid','Debit/Credit');
INSERT INTO Payments(PAYMENT_ID,order_id,PAYMENT_STATUS,PAYMENT_MODE) VALUES(10,10017,'Paid','Cash');



CREATE OR REPLACE FUNCTION PRODUCT_PRICE 
(
    p_product_id IN INVENTORY.PRODUCT_ID%TYPE
)
RETURN INVENTORY.PRICE%TYPE
AS
    lv_prod_price INVENTORY.PRICE%TYPE;
BEGIN
    SELECT price
    INTO lv_prod_price
    FROM INVENTORY
    WHERE product_id = p_product_id;
    
RETURN lv_prod_price; 
END;




CREATE OR REPLACE PROCEDURE CALCULATE_SUBTOTAL(
    P_ORDER_ID IN ORDERS.ORDER_ID%TYPE,
    P_TOTAL_COST OUT NUMBER)
AS
BEGIN
    SELECT SUM( product_price(product_id) * quantity)
    INTO P_TOTAL_COST
    FROM order_items
    WHERE ORDER_ID = P_ORDER_ID;    
END CALCULATE_SUBTOTAL;




CREATE OR REPLACE PROCEDURE CALCULATE_SHIP_COST(
    p_city IN ADDRESSES.CITY%TYPE,
    p_ship_cost OUT NUMBER)
AS
    lv_default_cost NUMBER:= 2;
BEGIN
    IF p_city = 'scarborough' THEN
        p_ship_cost := lv_default_cost;
    ELSIF p_city= 'markham' THEN
        p_ship_cost := lv_default_cost + 2;
    ELSIF p_city= 'toronto' THEN
        p_ship_cost := lv_default_cost + 4;
    ELSIF p_city= 'vaughan' THEN
        p_ship_cost := lv_default_cost + 6;
    ELSIF p_city= 'etobicoke' THEN
        p_ship_cost := lv_default_cost + 8;
    ELSIF p_city= 'pshawa' THEN
        p_ship_cost := lv_default_cost + 10;
    ELSIF p_city= 'mississauga' THEN
        p_ship_cost := lv_default_cost + 12;        
    ELSIF p_city= 'brampton' THEN
        p_ship_cost := lv_default_cost + 14;        
    ELSIF p_city= 'hamilton' THEN
        p_ship_cost := lv_default_cost + 16; 
    ELSE
        p_ship_cost := lv_default_cost + 18;
    END IF;
END CALCULATE_SHIP_COST;





CREATE OR REPLACE PROCEDURE update_customer_info (
    p_customer_id IN NUMBER,
    new_name IN VARCHAR2 DEFAULT NULL,
    new_email IN VARCHAR2 DEFAULT NULL    
)
AS
BEGIN
    IF new_name IS NOT NULL THEN
        UPDATE customers
        SET customer_name = new_name
        WHERE customer_id = p_customer_id;
    END IF;
    
    IF new_email IS NOT NULL THEN
        UPDATE customers
        SET email = new_email
        WHERE customer_id = p_customer_id;
    END IF;
        
    COMMIT;
END;





CREATE OR REPLACE PROCEDURE update_order_status (
    p_order_id IN ORDERS.ORDER_ID%TYPE,
    updated_status_id IN ORDER_STATUS.STATUS_ID%TYPE
)

AS
    lv_status_id NUMBER;
BEGIN
    UPDATE orders
    SET status_id = updated_status_id
    WHERE order_id = p_order_id;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occured: ' || SQLERRM);

END;




-- SHOULD BE RUN AFTER CREATING THE PROCEDURE CALCULATE_SUB_TOTAL & CALCUATE_SHIP_COST 
CREATE OR REPLACE FUNCTION CALCULATE_TOTAL_COST
(
    order_id IN ORDERS.ORDER_ID%TYPE,
    delivery_city IN ADDRESSES.CITY%TYPE    
)
RETURN NUMBER
AS
    lv_subtotal NUMBER;
    lv_ship_cost NUMBER;
    lv_total_cost NUMBER;
BEGIN
    CALCULATE_SUBTOTAL(order_id,lv_subtotal);
    CALCULATE_SHIP_COST(delivery_city,lv_ship_cost);
    lv_total_cost := lv_subtotal + lv_ship_cost;
    RETURN lv_total_cost;
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;




CREATE OR REPLACE PACKAGE OrderManagement_PP
IS
gv_total_cost NUMBER;

FUNCTION PRODUCT_PRICE (
    p_product_id IN INVENTORY.PRODUCT_ID%TYPE)
    RETURN INVENTORY.PRICE%TYPE;

FUNCTION CALCULATE_TOTAL_COST(
    order_id IN ORDERS.ORDER_ID%TYPE,
    delivery_city IN ADDRESSES.CITY%TYPE)
    RETURN NUMBER;

PROCEDURE CALCULATE_SUBTOTAL(
    P_ORDER_ID IN ORDERS.ORDER_ID%TYPE,
    P_TOTAL_COST OUT NUMBER);

PROCEDURE CALCULATE_SHIP_COST(
    p_city IN ADDRESSES.CITY%TYPE,
    p_ship_cost OUT NUMBER);
END;




CREATE OR REPLACE PACKAGE BODY OrderManagement_PP
IS

FUNCTION PRODUCT_PRICE 
    (
    p_product_id IN INVENTORY.PRODUCT_ID%TYPE
    )
    RETURN INVENTORY.PRICE%TYPE
    AS
        lv_prod_price INVENTORY.PRICE%TYPE;
    BEGIN
        SELECT price
        INTO lv_prod_price
        FROM INVENTORY
        WHERE product_id = p_product_id;
        
    RETURN lv_prod_price; 
END;




FUNCTION CALCULATE_TOTAL_COST
(
    order_id IN ORDERS.ORDER_ID%TYPE,
    delivery_city IN ADDRESSES.CITY%TYPE    
)
RETURN NUMBER
AS
    lv_subtotal NUMBER;
    lv_ship_cost NUMBER;
BEGIN
    CALCULATE_SUBTOTAL(order_id,lv_subtotal);
    CALCULATE_SHIP_COST(delivery_city,lv_ship_cost);
    gv_total_cost := lv_subtotal + lv_ship_cost;
    RETURN gv_total_cost;
END;




PROCEDURE CALCULATE_SUBTOTAL(
    P_ORDER_ID IN ORDERS.ORDER_ID%TYPE,
    P_TOTAL_COST OUT NUMBER)
AS
BEGIN
    SELECT SUM( product_price(product_id) * quantity)
    INTO P_TOTAL_COST
    FROM order_items
    WHERE ORDER_ID = P_ORDER_ID;    
END CALCULATE_SUBTOTAL;





PROCEDURE CALCULATE_SHIP_COST(
    p_city IN ADDRESSES.CITY%TYPE,
    p_ship_cost OUT NUMBER)
AS
    lv_default_cost NUMBER:= 2;
BEGIN
    IF p_city = 'scarborough' THEN
        p_ship_cost := lv_default_cost;
    ELSIF p_city= 'markham' THEN
        p_ship_cost := lv_default_cost + 2;
    ELSIF p_city= 'toronto' THEN
        p_ship_cost := lv_default_cost + 4;
    ELSIF p_city= 'vaughan' THEN
        p_ship_cost := lv_default_cost + 6;
    ELSIF p_city= 'etobicoke' THEN
        p_ship_cost := lv_default_cost + 8;
    ELSIF p_city= 'pshawa' THEN
        p_ship_cost := lv_default_cost + 10;
    ELSIF p_city= 'mississauga' THEN
        p_ship_cost := lv_default_cost + 12;        
    ELSIF p_city= 'brampton' THEN
        p_ship_cost := lv_default_cost + 14;        
    ELSIF p_city= 'hamilton' THEN
        p_ship_cost := lv_default_cost + 16; 
    ELSE
        p_ship_cost := lv_default_cost + 18;
    END IF;
END CALCULATE_SHIP_COST;

END;

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
    DBMS_OUTPUT.PUT_LINE('');
    IF :NEW.status_id = 503  THEN
        DBMS_OUTPUT.PUT_LINE('ORD_CANCEL_TRG Fired');
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
    FOLLOWS ORD_CANCEL_TRG
DECLARE
    CURSOR cv_orderitem IS
    SELECT * from order_items
    where order_id = :NEW.order_id;
    lv_current_date orders.order_date%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    SELECT SYSDATE
    INTO lv_current_date
    FROM dual;
    IF :NEW.status_id = 502  THEN
        DBMS_OUTPUT.PUT_LINE('ORD_Confirmed_TRG Fired');
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
    FOLLOWS ORD_CONFIRMED_TRG
DECLARE 
    lv_payment_id payments.payment_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    IF :NEW.status_id = 504  THEN
        DBMS_OUTPUT.PUT_LINE('ORD_Delivered_TRG Fired');
        --update
        UPDATE PAYMENTS
        SET payment_status = 'PAID'
        where order_id = :NEW.order_id;        
    END IF;
END;

