-- TPCDS Table: customer_address 
create table customer_address $with as select * from $source_catalog.$source_schema.customer_address;

