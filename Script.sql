CREATE TABLE USERS 
(
  USERID NUMBER NOT NULL 
, EMAIL VARCHAR2(100) NOT NULL 
, FIRSTNAME VARCHAR2(50) NOT NULL 
, LASTNAME VARCHAR2(50) NOT NULL 
, DATEOFBIRTH DATE NOT NULL 
, Gender VARCHAR2(20) NOT NULL 
, CONSTRAINT USERS_PK PRIMARY KEY 
  (
    USERID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX USERS_PK ON USERS (USERID ASC) 
  )
  ENABLE 
);

CREATE TABLE ADDRESS 
(
  ADDRESSID NUMBER NOT NULL 
, USER_ID NUMBER NOT NULL 
, NO NUMBER
, STREET VARCHAR2(50) NOT NULL 
, CITY VARCHAR2(20) NOT NULL 
, PROVINCE VARCHAR2(20) NOT NULL 
, POSTALCODE VARCHAR2(20) NOT NULL 
, PHONE VARCHAR2(20) NOT NULL 
, CONSTRAINT ADDRESS_PK PRIMARY KEY 
  (
    ADDRESSID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ADDRESS_PK ON ADDRESS (ADDRESSID ASC) 
  )
  ENABLE 
);

ALTER TABLE ADDRESS
ADD CONSTRAINT FK_USER_ADDRESS FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERS
(
  USERID 
)
ENABLE;


CREATE TABLE CATEGORIES 
(
  CATEGORYID NUMBER NOT NULL 
, CATNAME VARCHAR2(20) NOT NULL 
, CONSTRAINT CATEGORIES_PK PRIMARY KEY 
  (
    CATEGORYID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX CATEGORIES_PK ON CATEGORIES (CATEGORYID ASC) 
  )
  ENABLE 
);

CREATE TABLE PRODUCTS 
(
  PRODUCTID NUMBER NOT NULL 
, CATEGORY_ID NUMBER NOT NULL 
, NAME VARCHAR2(50) NOT NULL 
, DESCRIPTION VARCHAR2(100) 
, PRICE NUMBER NOT NULL 
, STATUS NUMBER NOT NULL 
, CONSTRAINT PRODUCTS_PK PRIMARY KEY 
  (
    PRODUCTID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PRODUCTS_PK ON PRODUCTS (PRODUCTID ASC) 
  )
  ENABLE 
);

ALTER TABLE PRODUCTS
ADD CONSTRAINT PRODUCTS_FK FOREIGN KEY
(
  CATEGORY_ID 
)
REFERENCES CATEGORIES
(
  CATEGORYID 
)
ENABLE;

CREATE TABLE DISCOUNTS 
(
  DISCOUNTID NUMBER NOT NULL 
, NAME VARCHAR2(20) NOT NULL 
, DISCOUNT NUMBER NOT NULL 
, STARTDATE DATE NOT NULL 
, ENDDATE DATE NOT NULL 
, QTY NUMBER NOT NULL 
, CONSTRAINT DISCOUNTS_PK PRIMARY KEY 
  (
    DISCOUNTID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX DISCOUNTS_PK ON DISCOUNTS (DISCOUNTID ASC) 
  )
  ENABLE 
);


CREATE TABLE CARDITEMS 
(
  CARDITEMS NUMBER NOT NULL 
, USER_ID NUMBER NOT NULL 
, PRODUCT_ID NUMBER NOT NULL 
, QTY NUMBER NOT NULL 
, DATEADD DATE NOT NULL 
, CONSTRAINT CARDITEMS_PK PRIMARY KEY 
  (
    CARDITEMS 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX CARDITEMS_PK ON CARDITEMS (CARDITEMS ASC) 
  )
  ENABLE 
);

ALTER TABLE CARDITEMS
ADD CONSTRAINT CARDITEMS_FK_PRODUCT FOREIGN KEY
(
  PRODUCT_ID 
)
REFERENCES PRODUCTS
(
  PRODUCTID 
)
ENABLE;

ALTER TABLE CARDITEMS
ADD CONSTRAINT CARDITEMS_FK_USER FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERS
(
  USERID 
)
ENABLE;


CREATE TABLE ORDERS 
(
  ORDERID NUMBER NOT NULL 
, USER_ID NUMBER NOT NULL 
, DISCOUNT_ID NUMBER NOT NULL 
, CREATEDATE DATE NOT NULL 
, AMOUNT NUMBER NOT NULL 
, CONSTRAINT ORDERS_PK PRIMARY KEY 
  (
    ORDERID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ORDERS_PK ON ORDERS (ORDERID ASC)
  )
  ENABLE 
);

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_FK_DISCOUNT FOREIGN KEY
(
  DISCOUNT_ID 
)
REFERENCES DISCOUNTS
(
  DISCOUNTID 
)
ENABLE;

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_FK_USER FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERS
(
  USERID 
)
ENABLE;

CREATE TABLE ORDERDETAILS 
(
  ORDERDETAILID NUMBER NOT NULL 
, ORDER_ID NUMBER NOT NULL 
, QTY NUMBER NOT NULL 
, PRICE NUMBER NOT NULL 
, CONSTRAINT ORDERDETAILS_PK PRIMARY KEY 
  (
    ORDERDETAILID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ORDERDETAILS_PK ON ORDERDETAILS (ORDERDETAILID ASC) 
  )
  ENABLE 
);

ALTER TABLE ORDERDETAILS
ADD CONSTRAINT ORDERDETAILS_FK1 FOREIGN KEY
(
  ORDER_ID 
)
REFERENCES ORDERS
(
  ORDERID 
)
ENABLE;


CREATE SEQUENCE SEQ_ADDRESS 
	INCREMENT BY 1
	MAXVALUE 10000
	MINVALUE 1
	CACHE 20;
	
CREATE SEQUENCE SEQ_CARDITEM 
	INCREMENT BY 1
	MAXVALUE 90000
	MINVALUE 1
	CACHE 20;

CREATE SEQUENCE SEQ_GENERAL
 INCREMENT BY 1
 MAXVALUE 9999999999
 MINVALUE -999999999
 CYCLE CACHE 20;

CREATE SEQUENCE SEQ_ORDER
 INCREMENT BY 1
 MAXVALUE 9999999999999
 MINVALUE 1 
 CACHE 20;

CREATE SEQUENCE SEQ_ORDERDETAIL 
INCREMENT BY 1
 MAXVALUE 999999
 MINVALUE 1 CYCLE 
 CACHE 20;

CREATE SEQUENCE SEQ_PRODUCT
 INCREMENT BY 1
 MAXVALUE 999999999999999 
 MINVALUE 1
 CACHE 20;

--********************************************************************************************************
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Art');
insert into products (productid,category_id,name,description,price,STATUS)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Old Country Roses','Featuring sprays of red',75,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Audio');
insert into products (productid,category_id,name,description,price,STATUS)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Sennheiser Momentum Headphone','Brand new condition.',419,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Baby Item');
insert into products (productid,category_id,name,description,price,STATUS)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Carters size 6 months zip up','3 sleepers used by one baby girl excellent',18,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Bike');
insert into products (productid,category_id,name,description,price,STATUS)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'2 BMX Style Bikes','Been sitting in the shed for 12 months',100,0);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Books');
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Guide for Canadian','Ensure you’re getting the most out of your textbook',32,1);    
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Fluent in 3 Months','Fluent in 3 Months',15,1);
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'2021 CFA Level 3','The complete set includes all ',199,1);
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Animal Farm','Complete version',62,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Business');
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Camera');
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'CD and DVD');
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Computer');
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'HP pavilion 17z laptop','Refurbished HP Nb 17z laptop',500,1);
insert into products (productid,category_id,name,description,price,status)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'High-end ThinkPad i7','corporate grade, business ultrabook in prestine physical',489,1);

insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Electronics');
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Ooma HD3 cordless','cordless handset - Bluetooth',65,0);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Furniture');
insert into products (productid,category_id,name,description,price,status)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Desk 48x24','Desk – 48x24 with drawers – New',275,0);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Health');


--******************************************************************************************
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Black Friday',55,'25-Nov-21','27-Nov-21',10);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Spring',20,'01-March-21','15-March-21',3);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Fall',10,'01-Sep-21','15-Sep-21',1);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'New Year',35,'15-Dec-21','05-Jan-22',6);
	
--********************************************************************************************	
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'mohammad','etedali','etedali@gmail.com','12-July-85','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Scarborough','63','Darlingside Dr','ON','M1E3P2','4167221611');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Ann','Elerk','Ann@gmail.com','12-Oct-95','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Toronto','235','Young','ON','M1G222','4156587845');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Atieh','Hosseini','Atieh@gmail.com','14-June-88','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Victoria','41','St George','BC','KLM232','684752145');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Bob','Easter','Bob@yahoo.com','18-Dec-65','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Alabama','12','MCCowen','AL','GKRE43','1254698754');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'John','Kale','Kale@msn.com','16-Jan-62','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Alabama','12','MCCowen','AB','GKRE43','1254698754');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'James','Junior','James@gmail.com','02-Feb-90','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Yukon','98','Yukon ','YT','YTRE43','5642779832');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Kathy','Hoss','hoss@msn.com','09-Nov-04','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'NUVANUT','127','St Philip','NT','NERE33','6472779832');
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Nazy','Tabaei','Nazy@gmail.com','12-Sep-01','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Montreal','56','Quebec Dr','QC','QCRD13','610779832');    
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Sara','Sirvan','ssvan@yahoo.com','19-Nov-89','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Quebec City','8','Dundas Dr','QC','QCRD13','610779832');     
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Soren','serjoei','sorejo@gmail.com','06-June-91','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Montrear','418','Green Dr','QC','QCE516','124587254');   
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'maral','mir','maralmir@gmail.com','10-Nov-95','Female');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Skyline','438','New Brun','NB','N2BG53','8254619857');     
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_GENERAL.nextval,'Ahmad','etedali','ahmade@gmail.com','03-March-60','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_GENERAL.currval,'Toronto','64','Hulthman Dr','ON','m61G48','4154619007');     
	
	
	