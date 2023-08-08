#!/bin/bash

# validates if either transparent cache is created or not

presto=$1
first_query_id=$2
filename='urls.txt'
jsondir='jsons'

user=$PRESTO_USER
password=$PRESTO_PASSWORD

mkdir -p $jsondir
rm -rf $jsondir/*

echo "Downloading query ids"
wget --no-check-certificate --http-user="$user" --http-password="$password" -O - "$presto/v1/query?pretty" | jq '.[] .queryId' | sort | grep -A1000 "$first_query_id" > urls.txt

while read p; do
    queryid=`echo $p | sed 's/\"//g'`
    echo "Query id : $queryid"
    queryJsonFile="$jsondir/$queryid.json"
    wget --no-check-certificate --http-user="$user" --http-password="$password" -q -O "$queryJsonFile" "$presto/v1/query/$queryid?pretty"
    echo "-----------------"
done < "$filename"


