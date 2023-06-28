#!/bin/bash

presto=$1
first_query_id=$2

wget -O - "$presto/v1/query?pretty" | jq '.[] .queryId' | sort | grep -A1000 "$first_query_id" > urls.txt
