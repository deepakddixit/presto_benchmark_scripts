-- TPCDS Table: time_dim        
create table time_dim $with as select * from $source_catalog.$source_schema.time_dim;

