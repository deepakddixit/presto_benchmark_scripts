-- TPCDS Table: store   
create table store $with as select * from $source_catalog.$source_schema.store;

