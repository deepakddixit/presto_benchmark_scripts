Readme.md

Contents are like below

|-- benchmark_rks
|   `-- sql
|-- benchmark_tpcds
|   `-- sql
|-- benchmark_tpch
|   `-- sql
|-- config_benchmark_rks
|-- config_benchmark_tpcds
|-- config_benchmark_tpch
|-- config_load_into_cache.template
|-- config_load_into_memory.template
|-- config_load_rks_into_cache
|-- config_load_tpcds_into_cache
|-- config_load_tpch_into_cache
|-- data_load_rks
|   `-- sql
|-- data_load_tpcds
|   `-- sql
|-- data_load_tpch
|   `-- sql
|-- presto-benchmark-driver-0.269-executable.jar
|-- presto-cli-executable.jar
|-- s_create_schema.sh
|-- s_load_tables.sh
|-- s_loop.sh
|-- s_pre_req.sh
|-- s_query.sh
|-- suite.json


Notations:
s_ -> scripts
config_ -> configurations
benchmark_ -> dir containing queries to benchmark
data_load_ -> dir containing queries to populate data


--------------------

How to load TPCH data

- ./s_load_tables.sh config_load_tpcds_into_cache

This will data into cache catalog. Refer `config_load_tpcds_into_cache` file for configurations

- ./s_load_tables.sh config_load_tpch_into_cache

This will data into cache catalog. Refer `config_load_tpch_into_cache` file for configurations

- ./s_load_tables.sh config_load_rks_into_cache

This will data into cache catalog. Refer `config_load_rks_into_cache` file for configurations

--------------------

Loading configurations explained

Check any config file for sample values


prefix=<prefix used to identify suite. tpcds/tpch/rks are currently configured>
scale=<scale for tpch/tpcds>

# Generic props
presto_host=localhost
presto_port=32234

debug=true
run_randomly=<true/false whether to execute queries randonmly or not>

multipleQueriesInSingleFile=false

# query regex filter which will pick matching query files like (nation|region)* will pick nation.sql and region.sql files from dir
query_regex=<valid java regex for file names to pick queries to be executed. Can be used to selectively load tables>

create_schema=true

# should we replace source_catalog and source_schema from load queries
replace_values=true
temp_query_dir=/tmp/

source_catalog=<source catalog to load data>
source_schema=<source schema to load data>

dest_catalog=<destination catalog to write data>
dest_schema=<destination schema to write data>

load_query_dir=data_load_"$prefix"/sql <dir containing ctas queries>

# with clause table properties
# default with clause which will be used for all tables
with_default="with (\"ampool.buckets\"=23, \"ampool.block.size\"=10000, \"ampool.block.format\"='AMP_COLUMNAR_OFF_HEAP', \"ampool.table.type\"='IMMUTABLE', \"ampool.redundancy\"=0)"

# can be overriden with key as filename=<value>
# with_filename or tablename
with_call_center="with (\"ampool.buckets\"=1, \"ampool.block.size\"=1, \"ampool.block.format\"='AMP_COLUMNAR_OFF_HEAP', \"ampool.table.type\"='IMMUTABLE', \"ampool.redundancy\"=0)"
with_warehouse="with (\"ampool.buckets\"=1, \"ampool.block.size\"=1, \"ampool.block.format\"='AMP_COLUMNAR_OFF_HEAP', \"ampool.table.type\"='IMMUTABLE', \"ampool.redundancy\"=0)"


--------------------

How to execute queries for benchmark


-- How to execute RKS benchmark queries

./s_query.sh config_benchmark_rks

-- How to execute TPCDS benchmark queries

./s_query.sh config_benchmark_tpcds

-- How to execute TPCH benchmark queries

./s_query.sh config_benchmark_tpch

--------------------

Loading configurations explained

Check any config file for sample values


prefix=tpch
scale=1

# Generic props
presto_host=localhost
presto_port=8080
query_runs=3
query_warm=1
query_suite_itr=5
debug=true
run_randomly=false
multipleQueriesInSingleFile=false

# Query releated props
query_dir=benchmark_"$prefix"/sql
#query_dir=benchmark_"$prefix"/sql/sf_$scale

#query_remote_catalog=cache
# catalog on which queries to be executed
query_remote_catalog=tpch
# catalog on which queries to be executed
query_remote_schema=tiny
#query_remote_schema="$prefix"_tpch_$scale


