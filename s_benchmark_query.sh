#!/bin/bash
source $1
optionalParams=$2
specific_params=$3

./presto-benchmark-driver-0.269-executable.jar $optionalParams --server $presto_host:$presto_port --suite-config suite.json --suite $suite --warm $query_warm --runs $query_runs --decimal-comparison 1 $specific_params