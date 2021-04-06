-- Sequences ************************************
-- I use all of the sequence in Query for insert data to the table but I show some of here
    -- all of mu sequence start with SEQ_ so, with below query I show all of them
    SELECT * FROM user_sequences where sequence_name like 'SEQ_%';
    
    select SEQ_PRODUCT.nextval from dual;
    
    select SEQ_PRODUCT.currval from dual;
    
--Indexes  ------------------------------------------------------------------------
-- this query shows all of my indexes (I created five index)
    SELECT index_name, index_type,visibility,status, table_name FROM all_indexes where lower(index_name) like 'indx_%';
-- Test indx_prd_nm_idx for find Product by name
    select * from Products where name = 'Oxygen Cylinder';
-- Test indx_prd_sts_idx for find Product by name
    select * from Products where status = 1 and price > 1;
-- Test indx_order_date_idx 
    select * from orders where createdate > '01-Jan-2019';
    
    
--Triggers  ---------------------------------------------
-- First trigger is "trg_CardItem_ins" this one work after any entry on CardItems table
-- due to I create this trigger after initialize data entry now is empty to show my demonstration.

    select * from tblcarditems_trg;
    select * from carditems;
    insert into carditems (carditemsid,user_id,product_id,qty,dateadd) values(SEQ_CARDITEM.nextval,8001,6,1,sysdate);
    commit;
    -- Now we can see a new record that add to the table
    select * from carditems;
    -- A new record add to our trigger table 
    select * from tblcarditems_trg;

    -- Second trigger is "audit_trg" that work for insert/update/delete on Orders table is Audit one.
    select * from audit_tbl_order;
    select * from Orders;
    -- First check update on Order
    update orders set amount = 16 , discount_id = 18 where orderid = 1;
    select * from audit_tbl_order;-- we can see change on amount and discount id
    
    --create a log for insert
    insert into orders (orderid,user_id,discount_id,createdate,amount) 
                values (seq_order.nextval,8001,null,sysdate,88888);

    select * from Orders;
    select * from audit_tbl_order;-- check insert change
    
    -- create a log for delete 
    delete orders where amount = 88888;
    select * from audit_tbl_order;-- check delete record
    
-- Procedures --------------------------------------------------------------------------------------
    /* This Procedure use for update price of product base on HST percentage, for those product which HST is not required user can pass a manual price for add
       in this procedure I user CURSOR and EXCEPTION handeling
       - if the user put HST zero or less get error message also, some other exception for not found data
       - Response return a message and number of record was affect by this procedure
    */
    declare 
        Response VARCHAR(100);
    begin
        products_updatePrice(1,0, Response);
        DBMS_OUTPUT.PUT_LINE('Result: ' || Response);
    end;
    
    /*
        This procedure sp_cardItemToOrderByUserId this use for send all of the cardItem to order for complete the processing of shopping
        I get a user_id and check if the id is not exist get proper message with using exception
        the response return a proper message for how many items are add to Order and total price of them after TAX
        I use CURSOR for my operation in the procedure
    */
    declare 
        Response VARCHAR(100);
    begin
        sp_cardItemToOrderByUserId(8000, Response);
        DBMS_OUTPUT.PUT_LINE('Result: ' || Response);
    end;

    
    /*
     This Procedure use for Add data in CardItems Table. this has some in parameter product_id, user_id, and QTY and an out parameter cardItems_Result that is carditems row type
     that is new cardItem record.
     I use Exception handeling also, I call a Function in this procedure that function name is fc_CardItem_add
     If the user enter wrong user_id or product_id get proper message
     this procedure get proper message if the client enter wrong QTY for example enter zero for qty 
    */
    declare 
     TYPE PROREC IS RECORD(
        IDCARD carditems.carditemsid%TYPE,
        UsRID carditems.USER_ID%TYPE,
        ProductId carditems.PRODUCT_ID%TYPE,
        CardQty carditems.QTY%TYPE,
        CardDATE carditems.DATEADD%TYPE);
        C_CARDRCD PROREC;
    begin
        sp_CardItemAdd(17 ,8000,11,  C_CARDRCD);
        DBMS_OUTPUT.put_line('CardItem Id: ' || C_CARDRCD.IDCARD || chr(13) ||
        'CardItem User ID: ' || C_CARDRCD.UsRID || chr(13) ||
        'CardItem  Product ID: ' || C_CARDRCD.ProductId || chr(13) ||
        'CardItem Date: ' || C_CARDRCD.CardDATE || chr(13) ||
        'Project Qty: ' || C_CARDRCD.CardQty);
    end;
    
 --Functions -------------------------------------------------------------------------------------------------
    -- Function fc_CardItem_add, I use this one in procedure for add data in CardItem and return Id of CardItem
    declare
        newId number;
    begin
        newId := fc_CardItem_add(8000,7,1);
        DBMS_OUTPUT.PUT_LINE('CardItem Id: ' || newId);
    end;    
    
    -- Function fc_mostPopularProduct return Item Id that is most popular between people
    declare
        PrdId number;
    begin
        PrdId := fc_mostPopularProduct();
        DBMS_OUTPUT.PUT_LINE('Most Popular Product Id: ' || PrdId);
    end; 
    
    -- this function return all users without any buying
    select fc_get_userswithoutbuy from dual;
    
-- Call Views **************************************
-- This view return all products that are enable  
    select * from prduct_enbl;
-- This view return all disable product
    select * from prduct_dsbl;
-- This view return all users who have someting in the card
    select * from usr_withCard;