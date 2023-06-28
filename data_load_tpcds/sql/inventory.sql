-- TPCDS Table: inventory       
create table inventory $with as select * from $source_catalog.$source_schema.inventory;

