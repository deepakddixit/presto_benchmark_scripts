-- TPCDS Table: customer 
create table customer $with as select * from $source_catalog.$source_schema.customer;

