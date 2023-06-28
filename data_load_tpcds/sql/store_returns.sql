-- TPCDS Table: store_returns   
create table store_returns $with as select * from $source_catalog.$source_schema.store_returns;

