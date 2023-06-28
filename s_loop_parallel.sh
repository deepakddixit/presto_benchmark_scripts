#!/bin/bash

source $1

mkdir -p $artifact_outdir
echo "Cleaning benchmark output dir $artifact_outdir"
rm -rf "$artifact_outdir"/*

# update json dir and results dir if specified
if [ -n "${jsonsDir}" ]; then
   mkdir -p $jsonsDir
fi

if [ -n "${resultsDir}" ]; then
   mkdir -p $resultsDir
fi

##for i in {1..$query_suite_itr}
for (( i=1; i<=$query_suite_itr; i++ ))
do
	echo "-------------START: $(date)------------------------"
	echo "Iteration $i "
	artifact_outdir="$artifact_outdir"
	fname="itr""$i""_""$prefix"_"$scale"_"$query_remote_catalog"_"$query_remote_schema"
	if [ "$suite" = "query" ]; then
		echo "Query suite"
		time ./s_query.sh $1 "$i" 2> "$artifact_outdir"/"$fname.err" 1>"$artifact_outdir"/"$fname.out" &
	else
		echo "Load Suite"
		time ./s_load_tables.sh $1 "$i" 2> "$artifact_outdir"/"$fname.err" 1>"$artifact_outdir"/"$fname.out" &
	fi
	echo "-------------END: $(date)------------------------"
done

echo "Waiting till all background job finishes"

echo "Creating reports"
./s_validate_tc_v3.sh $jsonsDir "$artifact_outdir"/"$artifact_outdir".report > "$artifact_outdir"/json_report_gen.log 2>&1

echo "Generated benchmark output present in $artifact_outdir"
echo "Downloaded Query JSON present in $jsonsDir"
echo "Downloaded Query Results present in $resultsDir"
