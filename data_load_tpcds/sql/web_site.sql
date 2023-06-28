-- TPCDS Table: web_site        
create table web_site $with as select * from $source_catalog.$source_schema.web_site;
