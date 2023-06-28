-- Load table part
create table part $with as select * from $source_catalog.$source_schema.part;
