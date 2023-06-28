-- TPCDS Table: web_returns     
create table web_returns $with as select * from $source_catalog.$source_schema.web_returns;

