-- Load table partsupp
create table partsupp $with as select * from $source_catalog.$source_schema.partsupp;
