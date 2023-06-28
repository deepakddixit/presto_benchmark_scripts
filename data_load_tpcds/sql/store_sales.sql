-- TPCDS Table: store_sales     
create table store_sales $with as select * from $source_catalog.$source_schema.store_sales;

