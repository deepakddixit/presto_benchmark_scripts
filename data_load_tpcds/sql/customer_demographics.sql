-- TPCDS Table: customer_demographics    
create table customer_demographics $with as select * from $source_catalog.$source_schema.customer_demographics;

