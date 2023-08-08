#!/bin/bash

jsondir=$1
outfile=$2
outfileext="$outfile".extract

rm -r $outfile
rm -r $outfileext

echo "Filename! QueryId ! QueryText ! queryType ! queryUser ! InputTables ! InputTablesCount ! ExplicitTablesUsed ! ExplicitTablesUsedCount ! NonReplacedTables ! NonReplacedTablesCount ! PeakUserMemory ! PeakTotalMemory ! queryExecTime " >> $outfile

for queryJsonFile in $jsondir/*.json; do
   echo "Query json file : $queryJsonFile"

   queryType=$(cat $queryJsonFile| jq '.queryType')
   queryUser=$(cat $queryJsonFile| jq '.session.user')

   # get executed query text
   queryText=$(cat $queryJsonFile| jq '.query')

   queryid=$(cat $queryJsonFile| jq '.queryId')

   # get input tables
   itables=$(cat $queryJsonFile| jq '.inputs[] | .connectorId + "." + .schema + "." + .table' | sed -e 's/\"//g' | sort -u )
   #echo $itables
   itablesarr=($itables)
   #echo "${#itablesarr[@]}"

   # get cached tables - explicit
   eutables=$(cat $queryJsonFile| jq '.cacheInfo | .cacheTablesUsed[] | select(.cacheType == "USER") | .cachedTable' | sed -e 's/\"//g' | sort -u)
   #echo $eutables
   eutablesarr=($eutables)
   #echo "${#eutablesarr[@]}"

   # get cached tables - explicit
   reutables=$(cat $queryJsonFile| jq '.cacheInfo | .cacheTablesUsed[] | select(.cacheType == "USER") | .remoteTable' | sed -e 's/\"//g' | sort -u)
   #echo $eutables
   reutablesarr=($reutables)
   #echo "${#eutablesarr[@]}"

   # input table will be cached table when replaced so diff between input and eutables should be zero for full replacements
   nonreplacedtablesarr=(`echo ${itablesarr[@]} ${eutablesarr[@]} | tr ' ' '\n' | sort | uniq -u `)

   PeakUserMemory=$(cat $queryJsonFile| jq '.queryStats.peakUserMemoryReservation' | sed -e 's/\"//g')
   PeakTotalMemory=$(cat $queryJsonFile| jq '.queryStats.peakTotalMemoryReservation' | sed -e 's/\"//g')
   queryExecTime=$(cat $queryJsonFile| jq '.queryStats.elapsedTime' | sed -e 's/\"//g')

   echo "$queryJsonFile ! $queryid ! $queryText ! $queryType ! $queryUser ! ${itablesarr[@]} ! ${#itablesarr[@]} ! ${eutablesarr[@]} ! ${#eutablesarr[@]} ! ${nonreplacedtablesarr[@]} ! ${#nonreplacedtablesarr[@]} ! $PeakUserMemory ! $PeakTotalMemory ! $queryExecTime " >> $outfile

   # create extract file to compare across
   echo "$queryType ! $queryid ! ${#itablesarr[@]} ! ${#eutablesarr[@]} ! ${#nonreplacedtablesarr[@]}" >> $outfileext
done
