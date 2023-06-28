-- TPCDS Table: item    
create table item $with as select * from $source_catalog.$source_schema.item;

