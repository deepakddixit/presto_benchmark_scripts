-- Load table lineitem
create table lineitem  $with as select * from $source_catalog.$source_schema.lineitem;
