-- Load table supplier
create table supplier $with as select * from $source_catalog.$source_schema.supplier;
