-- Load table region
create table region $with as select * from $source_catalog.$source_schema.region;
