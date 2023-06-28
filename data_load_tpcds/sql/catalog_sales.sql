-- TPCDS Table: catalog_sales    
create table catalog_sales $with as select * from $source_catalog.$source_schema.catalog_sales;

