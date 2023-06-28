-- Load table nation
create table nation $with as select * from $source_catalog.$source_schema.nation;
