#!/bin/bash

source $1

if $create_schema ; then
        echo "Creating schema "$dest_catalog"."$dest_schema""
        ./presto-cli-executable.jar --server $presto_host:$presto_port --execute "create schema if not exists "$dest_catalog"."$dest_schema""
fi

