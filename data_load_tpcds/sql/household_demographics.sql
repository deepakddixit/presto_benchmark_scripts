-- TPCDS Table: household_demographics   
create table household_demographics $with as select * from $source_catalog.$source_schema.household_demographics;

