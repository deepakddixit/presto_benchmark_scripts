-- TPCDS Table: catalog_returns  
create table catalog_returns $with as select * from $source_catalog.$source_schema.catalog_returns;

