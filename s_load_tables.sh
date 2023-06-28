#!/bin/bash

set -e
source $1
runNo=$2

optionalParams=""

artifact_outdir="$artifact_output""_itr_"$runNo
jsonsDir="$artifact_outdir"/"$jsonsDirC"
resultsDir="$artifact_outdir"/"$resultsDirC"

#for macbook
ir=" ''"

#for linux
#ir=""

if $run_randomly ; then
    optionalParams="$optionalParams --run-randomly"
fi

if $multipleQueriesInSingleFile ; then
    optionalParams="$optionalParams --multi-query-in-single-file"
fi

if $debug ; then
    optionalParams="$optionalParams --debug"
fi

if [ -n "${jsonsDir}" ]; then
   optionalParams="$optionalParams --download-query-jsons $jsonsDir"
fi

if [ -n "${resultsDir}" ]; then
   optionalParams="$optionalParams --save-results $resultsDir"
fi

if [ -n "${username}" ]; then
   echo "Reference results dir $refResultsDir"
   optionalParams="$optionalParams --user "$username""$runNo""
fi

userSchema="$dest_schema""$runNo"

if $replace_values ; then
        echo "Replacing values"
	tmp_dir=$(mktemp -d -t load-"$prefix"-XXX)	

	echo "Copying queries from "load_query_dir" to "$tmp_dir""
	cp -r "$load_query_dir"/* "$tmp_dir"/
	
	for fileName in "$tmp_dir"/*
	do
		#echo "Replacing source_catalog in file $fileName"
    		sed -i$ir "s/\$source_catalog/$source_catalog/g" $fileName 
		
		#echo "Replacing source_schema in file $fileName"
     		sed -i$ir "s/\$source_schema/$source_schema/g" $fileName 

		bfname=$(basename "$fileName")
		fname=${bfname%.*}
		#echo "Simple file name $fname"
		withClause=""
		
		echo "Default value: $with_default"
		echo "File specific: $(eval echo "\$with_$fname")"
		default_val=$with_default
		specific_val=$(eval echo "\$with_$fname")

		if !  [ -z "$specific_val" ] 
		#&& ! [ -n "$specific_val" ] 
                then
			varname="with_$fname"
                        withClause=$specific_val
			echo "Using query overrides"
		elif ! [ -z "$default_val" ] 
		#&& ! [ -n "$(eval echo "\$with_default")" ]
		then
			varname="with_default"
                        withClause=$(eval echo "\$$varname")
			echo "Using default"
                fi


		#echo "Replacing with clause in file $fileName"
		sed -i$ir "s/\$with/$withClause/g" $fileName
		
	done	

fi

load_query_dir=$tmp_dir	

echo "Starting loading of data from dir $load_query_dir"

runPrefix="itr""$runNo""_"
echo "Creating query specific params"
specificParams="--query "$query_regex" --catalog $dest_catalog --schema $userSchema --sql $load_query_dir"

if $create_schema ; then
	echo "Dropping tables when exists from schema $userSchema"
    ./presto-benchmark-driver-0.269-executable.jar $optionalParams --server $presto_host:$presto_port --suite-config suite.json --suite $suite --warm $query_warm --runs $query_runs --decimal-comparison 1 --catalog $dest_catalog --schema $userSchema --sql $drop_query_dir --query "$query_regex"	

	echo "Creating schema "$dest_catalog"."$userSchema""
	./presto-cli-executable.jar --server $presto_host:$presto_port --execute "create schema if not exists "$dest_catalog"."$userSchema""
fi

echo "-------------START: $(date)------------------------"
./presto-benchmark-driver-0.269-executable.jar $optionalParams --server $presto_host:$presto_port --suite-config suite.json --suite $suite --warm $query_warm --runs $query_runs --decimal-comparison 1 --catalog $dest_catalog --schema $userSchema --sql $load_query_dir --query "$query_regex"
echo "-------------END: $(date)------------------------"
