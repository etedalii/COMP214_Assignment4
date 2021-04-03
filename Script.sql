DROP table carditems;
DROP table orderdetails;
DROP TABLE ORDERS;
DROP TABLE PRODUCTS;
DROP TABLE CATEGORIES;
DROP TABLE DISCOUNTS;
DROP TABLE ADDRESS;
DROP TABLE USERS;
DROP table tblCardItems_trg;
DROP table audit_tbl_order;

DROP SEQUENCE SEQ_USER;
DROP SEQUENCE SEQ_ADDRESS;
DROP SEQUENCE SEQ_CARDITEM;
DROP SEQUENCE SEQ_GENERAL;
DROP SEQUENCE SEQ_ORDER;
DROP SEQUENCE SEQ_ORDERDETAIL;
DROP SEQUENCE SEQ_PRODUCT;

drop INDEX usr_lstn_idx;
drop INDEX prd_nm_idx;
drop INDEX prd_sts_idx;
drop index dsc_date_idx;
drop index order_date_idx;

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
, HSTREQUIRE NUMBER NOT NULL
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
, STARTDATE DATE 
, ENDDATE DATE 
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
  CARDITEMSID NUMBER NOT NULL 
, USER_ID NUMBER NOT NULL 
, PRODUCT_ID NUMBER NOT NULL 
, QTY NUMBER NOT NULL 
, DATEADD DATE NOT NULL 
, CONSTRAINT CARDITEMS_PK PRIMARY KEY 
  (
    CARDITEMSID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX CARDITEMSID_PK ON CARDITEMS (CARDITEMSID ASC) 
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
, DISCOUNT_ID NUMBER 
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
, PRODUCT_ID NUMBER 
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
ADD CONSTRAINT ORDERDETAILS_FK_Order FOREIGN KEY
(
  ORDER_ID 
)
REFERENCES ORDERS
(
  ORDERID 
)
ENABLE;

ALTER TABLE ORDERDETAILS
ADD CONSTRAINT ORDERDETAILS_FK_PRODUCT FOREIGN KEY
(
  PRODUCT_ID 
)
REFERENCES PRODUCTS
(
  PRODUCTID 
)
ENABLE;


CREATE SEQUENCE  SEQ_ADDRESS 
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
 MINVALUE 1
 CYCLE 
 CACHE 20;

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
 
CREATE SEQUENCE SEQ_USER
 INCREMENT BY 1
 START WITH 8000
 MAXVALUE 8888888888888
 MINVALUE 1 
 CYCLE;


--********************************************************************************************************
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Art');
insert into products (productid,category_id,name,description,price,STATUS, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Old Country Roses','Featuring sprays of red',75,1,1);
	
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_USER.nextval,'mohammad','etedali','etedali@gmail.com','12-July-85','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Scarborough','63','Darlingside Dr','ON','M1E3P2','4167221611');
insert into carditems (carditemsid,user_id,product_id,qty,dateadd) values(SEQ_CARDITEM.nextval,SEQ_USER.currval,SEQ_PRODUCT.currval, 2,'18-Jan-21');	
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Audio');
insert into products (productid,category_id,name,description,price,STATUS, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Sennheiser Momentum Headphone','Brand new condition.',419,1,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Baby Item');
insert into products (productid,category_id,name,description,price,STATUS, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Carters size 6 months zip up','3 sleepers used by one baby girl excellent',18,1,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Bike');
insert into products (productid,category_id,name,description,price,STATUS, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'2 BMX Style Bikes','Been sitting in the shed for 12 months',100,0,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Books');
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Guide for Canadian','Ensure you’re getting the most out of your textbook',32,1,1);

		insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
			values(SEQ_USER.nextval,'Ann','Elerk','Ann@gmail.com','12-Oct-95','Female');
		insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
			values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Toronto','235','Young','ON','M1G222','4156587845');
			
			insert into carditems (carditemsid,user_id,product_id,qty,dateadd) values(SEQ_CARDITEM.nextval,SEQ_USER.currval,SEQ_PRODUCT.currval, 1,'12-Feb-21');	
			
		insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
			values(SEQ_USER.nextval,'Atieh','Hosseini','Atieh@gmail.com','14-June-88','Female');
		insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
			values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Victoria','41','St George','BC','KLM232','684752145');
	insert into carditems (carditemsid,user_id,product_id,qty,dateadd) values(SEQ_CARDITEM.nextval,SEQ_USER.currval,SEQ_PRODUCT.currval, 1,'19-March-21');	
    
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Fluent in 3 Months','Fluent in 3 Months',15,1,1);
    
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Bob','Easter','Bob@yahoo.com','18-Dec-65','Male');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Alabama','12','MCCowen','AL','GKRE43','1254698754');
            
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'28-Feb-21',15);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,1,15,seq_product.currval);
    
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'2021 CFA Level 3','The complete set includes all ',199,1,1);
    
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Kathy','Hoss','hoss@msn.com','09-Nov-04','Female');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'NUVANUT','127','St Philip','NT','NERE33','6472779832');
    
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'12-Dec-20',199);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,1,199,seq_product.currval);
    
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Animal Farm','Complete version',62,1,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Business');
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Camera');
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'CD and DVD');

insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Computer');
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'HP pavilion 17z laptop','Refurbished HP Nb 17z laptop',500,1,1);
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'High-end ThinkPad i7','corporate grade, business ultrabook in prestine physical',489,1,1);

        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Soren','serjoei','sorejo@gmail.com','06-June-91','Male');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Montrear','418','Green Dr','QC','QCE516','124587254'); 
            
     insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,TO_DATE(SYSDATE),978);
     insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,2,489,seq_product.currval);

insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Electronics');
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Ooma HD3 cordless','cordless handset - Bluetooth',65,0,1);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Furniture');
insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
    values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Desk 48x24','Desk – 48x24 with drawers – New',275,1,1);
    
    insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
        values(SEQ_USER.nextval,'John','Kale','Kale@msn.com','16-Jan-62','Male');
    insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
        values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Alabama','12','MCCowen','AB','GKRE43','1254698754');
        
        insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
            values(SEQ_GENERAL.nextval,'New Year',35,'15-Dec-21','05-Jan-22',6);
        
         insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,SEQ_GENERAL.currval,'18-Jan-21',275);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,1,275,seq_product.currval);
	
insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Health');

insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'SANITIZER/SOAP DISPENSER','STERYLL SANITIZERS are Licensed and Authorized by HEALTH CANADA',49.99,1,1);
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Nazy','Tabaei','Nazy@gmail.com','12-Sep-01','Female');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Montreal','56','Quebec Dr','QC','QCRD13','610779832');  
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'18-Jan-21',49.99);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,1,49.99,seq_product.currval);
     
     insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'3M Reusable P95 Safety Mask','3M Reusable P95 Valved Safety Mask',100,0,1);   
     insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'perfume Armaf','106 ml sealed box',35,0,1);   
     insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'perfume Dark chocolate','4 oz, 120ml',30,0,1);
     insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Oxygen Cylinder','Medline HCS53006',80,0,1);
     
     
     insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Mask (Adult/Children)Gloves','medical class 2',19,1,1);
        
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Sara','Sirvan','ssvan@yahoo.com','19-Nov-89','Female');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Quebec City','8','Dundas Dr','QC','QCRD13','610779832');  
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'2-April-21',95);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,5,19,seq_product.currval);
        
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'maral','mir','maralmir@gmail.com','10-Nov-95','Female');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Skyline','438','New Brun','NB','N2BG53','8254619857'); 
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'28-March-21',38);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,2,19,seq_product.currval);
        
   insert into categories (categoryid,catname) VALUES (SEQ_GENERAL.nextval,'Groceries');   
    insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
        values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Meat','Pork',7,1,0); 
        
    insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
        values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Eggs','Medline Size',6,1,0);
        
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Pheobie','Phibs','phibs@hotmail.com','16-Aug-84','Female');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Dartmouth','15','Richards Dr','NS','B3A2P1','9024632820'); 
        insert into carditems (carditemsid,user_id,product_id,qty,dateadd) values(SEQ_CARDITEM.nextval,SEQ_USER.currval,SEQ_PRODUCT.currval, 1, To_date(sysdate));
        
    insert into products (productid,category_id,name,description,price,status, HSTREQUIRE)
        values (SEQ_PRODUCT.nextval,SEQ_GENERAL.currval,'Bread','Slice',3,1,0);  
        
        insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
            values(SEQ_USER.nextval,'Ahmad','etedali','ahmade@gmail.com','03-March-60','Male');
        insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
            values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Toronto','64','Hulthman Dr','ON','m61G48','4154619007');  
        
        insert into orders(orderid,user_id,discount_id,createdate,amount) values(seq_order.nextval,seq_user.currval,null,'3-April-21',6);
        insert into orderdetails(orderdetailid,order_Id,qty,price,product_id) values(seq_orderdetail.nextval,seq_order.currval,2,3,seq_product.currval);
        
--******************************************************************************************
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Black Friday',55,'25-Nov-21','27-Nov-21',10);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Spring',20,'01-March-21','15-March-21',3);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'Fall',10,'01-Sep-21','15-Sep-21',1);
insert into Discounts (discountid,name,discount,startdate,enddate,qty) 
	values(SEQ_GENERAL.nextval,'General',3,null,null,6);
	
--********************************************************************************************	    
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_USER.nextval,'James','Junior','James@gmail.com','02-Feb-90','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Yukon','98','Yukon ','YT','YTRE43','5642779832');
    
 
    
insert into USERS (userid,firstname,lastname,email,dateofbirth,Gender) 
    values(SEQ_USER.nextval,'Soren','serjoei','sorejo@gmail.com','06-June-91','Male');
insert into address (addressid,user_id,city,no,street,province,postalcode,phone)
    values(SEQ_ADDRESS.nextval,SEQ_USER.currval,'Montrear','418','Green Dr','QC','QCE516','124587254');   
      
commit;	

CREATE INDEX usr_lstn_idx ON users (lastname);
CREATE INDEX prd_nm_idx ON products (NAME);
CREATE INDEX prd_sts_idx ON products (price,status);
create index dsc_date_idx ON DISCOUNTS(startdate,enddate);
create index order_date_idx ON orders (createdate);

-- Views ************************************************************
CREATE OR REPLACE VIEW 	prduct_enbl
as
    select * from products where status = 1
    with read only;
    
CREATE OR REPLACE VIEW 	prduct_dsbl
as
    select * from products where status = 0
    with read only;
    
    CREATE OR REPLACE VIEW usr_withCard AS
        SELECT u.firstname, u.lastname, c.qty, c.dateadd
        FROM users u, carditems c
        WHERE u.userid = c.user_id
        with read only;
-- Trigers *********************************************************************
CREATE TABLE tblCardItems_trg (carditemid number, usr_id number,prd_id number,qty number, dateadd date);

CREATE OR REPLACE TRIGGER trg_CardItem_ins 
AFTER INSERT ON CardItems 
FOR EACH ROW 
BEGIN 
     insert into tblCardItems_trg values (:new.carditemsid , :new.user_id,:new.product_id,:new.qty,:new.dateadd); 
END;
/

Create table audit_tbl_order(op_time date, ord_id number,dis_id_before number,dis_id_after number, amount_before number,amount_after number);
CREATE OR REPLACE TRIGGER audit_trg
AFTER INSERT OR DELETE OR UPDATE ON orders 
FOR EACH ROW 
BEGIN 
     insert into audit_tbl_order values (sysdate, :new.orderid, :old.discount_id,:new.discount_id ,:old.amount, :new.amount); 
END; 
/

