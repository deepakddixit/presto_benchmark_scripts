-- Load table orders
create table orders $with as select * from $source_catalog.$source_schema.orders;
