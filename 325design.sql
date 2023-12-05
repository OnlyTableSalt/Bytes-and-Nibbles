-- Names: Natalie Oulman, Simon Saltikov, Shawn Zereh, Aidan Sevillia, Brian Pinkernell, Griffin Jarrell-Desch
-- CS 325 - Fall 2023
-- 12/04/2023


drop table vendor_account cascade constraints;
drop table user_account cascade constraints;
drop table customer_account cascade constraints;
drop table subscription cascade constraints;
drop table customer_order cascade constraints;
drop table treat_catalog cascade constraints;
drop table treat_type cascade constraints;
drop table treat_ingredients cascade constraints;

create table user_account
(user_id         varchar2(10),
 is_customer     char(1),
 is_admin        char(1),
 is_vendor       char(1),
 email           varchar2(30),
 password        varchar2(25),
 fname           varchar2(15),
 lname           varchar2(15),
 primary key     (user_id)
);

--*********
-- Table user describes keeps track of all users.
--     Users can be either customers, admins, or a vendor.
--     the table keeps track of the user's email, password, first and last name.




create table customer_account
(user_id         varchar2(10),
 phone_number    varchar2(15),
 address         varchar2(30),
 city            varchar2(20),
 state           varchar2(20),
 zip_code        varchar2(10),
 country         varchar2(15),
 credit_card     varchar2(20),
 primary key     (user_id),
 foreign key     (user_id) references user_account (user_id)
);

--********
-- Table customer holds information for all the customers.
--       The table holds credit card information and the address for each customer.


drop table admin_account cascade constraints;

create table admin_account
(user_id         varchar2(10),
 is_admin        char(1),
 primary key     (user_id),
 foreign key     (user_id) references user_account (user_id)
);


--********
-- Table admin allows us to see if the user is an admin or not



create table vendor_account
(user_id         varchar2(10),
 location        varchar2(100),
 billing_info    varchar2(100),
 primary key     (user_id),
 foreign key     (user_id) references user_account (user_id)
);

--*******
-- Table vendor holds information about the vendor of the treats.
--       table vendor holds the billing info and location for the vendor.
--       the vendor sends the customer their treats and charges us for the treats.




create table subscription
(subscription_id   varchar2(10),
 user_id           varchar2(10),
 start_time        varchar2(40),
 billing_info      varchar2(40),
 primary key       (subscription_id),
 foreign key       (user_id) references user_account (user_id)
);

--*******
-- Table subscription has the subscription ID which tells if the customer
--         is currently subscribed to Bytes-N-Nibbles, when they subscribed, 
--         and current billing info 





create table customer_order
(order_id_num       varchar2(10),
 user_id            varchar2(10),
 date_received      date,
 primary key        (order_id_num),
 foreign key        (user_id) references user_account (user_id)
);

--*******
-- Gets around the 1NF constraint by removing the
-- multivalued attributes in the order (items in order).
--
create table items_in_order
(
    order_id_num varchar2(10),
    user_id      varchar2(10),
    item_id_num  varchar2(10),
    item_quantity      integer,
    primary key(order_id_num,user_id,item_id_num),

    foreign key (order_id_num) REFERENCES customer_order(order_id_num),
    foreign key (user_id) REFERENCES user_account(user_id),
    foreign key (item_id_num) REFERENCES treat_catalog(item_id_num)
);


--*******
-- Tables order tracks orders placed by customers by keeping record of order placed,
--             order total, and if there are any discounts for the customer


create table treat_catalog
(item_id_num        varchar2(10),
 item_name          varchar2(30),
 item_description   varchar2(300),
 quantity_on_hand   integer,
 price              decimal(8,2),
 quantity_sold      integer,
 primary key        (item_id_num)
);

--*******
-- Table treat_catalog tracks the items currently being sold by Bytes-N-Nibbles,
--             their unique description, price, and quantity currently available



create table treat_type
(item_id_num        varchar2(10),
 treat_type         varchar2(30),
 primary key        (item_id_num),
 foreign key        (item_id_num) references treat_catalog
);

--*******
--Tables treat_type holds the treat type and item ID number of all treats currently being sold by Bytes-N-Nibbles




create table treat_ingredients
(item_id_num        varchar2(10),
 treat_ingredients  varchar2(1000),
 primary key        (item_id_num),
 foreign key        (item_id_num) references treat_catalog
);

--*******
-- Table treat_ingredients holds the description and item ID number
--            of all treats currently being sold by Bytes-N-Nibbles



