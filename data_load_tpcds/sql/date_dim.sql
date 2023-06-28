-- TPCDS Table: date_dim 
create table date_dim $with as select * from $source_catalog.$source_schema.date_dim;

