-- TPCDS Table: warehouse       
create table warehouse $with as select * from $source_catalog.$source_schema.warehouse;

