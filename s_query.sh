#!/bin/bash

source $1
runNo=$2

artifact_outdir="$artifact_output""_itr_"$runNo
jsonsDir="$artifact_outdir"/"$jsonsDirC"
resultsDir="$artifact_outdir"/"$resultsDirC"

optionalParams=""

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

if [ -n "${refResultsDir}" ]; then
   echo "Reference results dir $refResultsDir"
   optionalParams="$optionalParams --compare-results-with-ref $refResultsDir"
fi

if [ -n "${username}" ]; then
   echo "Reference results dir $refResultsDir"
   optionalParams="$optionalParams --user "$username""$runNo""
fi

runPrefix="itr""$runNo""_"
echo "Creating query specific params"
specificParams="--sort-results-before-comparing --run-prefix $runPrefix --catalog $query_remote_catalog --schema $query_remote_schema --sql $query_dir"

echo "-------------START: $(date)------------------------"
./presto-benchmark-driver-0.269-executable.jar $optionalParams --server $presto_host:$presto_port --suite-config suite.json --suite $suite --warm $query_warm --runs $query_runs --decimal-comparison 1 $specificParams
echo "-------------END: $(date)------------------------"
