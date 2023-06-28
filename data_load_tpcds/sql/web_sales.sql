-- TPCDS Table: web_sales       
create table web_sales $with as select * from $source_catalog.$source_schema.web_sales;

