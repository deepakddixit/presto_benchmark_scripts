#!/bin/bash

# validates if either transparent cache is created or not

#presto=$1
outfile=$2
jsondir=$1
#jsondir='jsons'

rm -rf $outfile

echo "Filename| QueryId | QueryText | InputTables | InputTablesCount | ExplicitTablesUsed | ExplicitTablesUsedCount | TransTablesUsed | TransTablesUsedCount | TransTablesCreated | TransTablesCreatedCount " >> $outfile

#while read p; do
for queryJsonFile in $jsondir/*.json; do
    #queryid=`echo $p | sed 's/\"//g'`
    echo "Query json file : $queryJsonFile"
    #queryJsonFile="$jsondir/$queryid.json"
    #wget -q -O "$queryJsonFile" "$presto/v1/query/$queryid?pretty"
   
   # get executed query text
   queryText=$(cat $queryJsonFile| jq '.query')

   queryid=$(cat $queryJsonFile| jq '.queryId')

   # get input tables
   itables=$(cat $queryJsonFile| jq '.inputs[] | .connectorId + "." + .schema + "." + .table' | sed -e 's/\"//g' | sort -u )
   #echo $itables
   itablesarr=($itables)
   #echo "${#itablesarr[@]}"

   # get cached tables
   #utables=$(cat $queryJsonFile| jq '.cacheInfo[] .cachedTable' | sed -e 's/\"//g' | sort )
   #echo $utables
   #utablesarr=($utables)
   #echo "${#utablesarr[@]}"

   # get cached tables - explicit
   eutables=$(cat $queryJsonFile| jq '.cacheInfo[] | select(.isCacheUsed) | select(.cacheType == "EXPLICIT") | .cachedTable' | sed -e 's/\"//g' | sort -u)
   #echo $eutables
   eutablesarr=($eutables)
   #echo "${#eutablesarr[@]}"

   # get cached tables - transparent
   tutables=$(cat $queryJsonFile| jq '.cacheInfo[] | select(.isCacheUsed) | select(.cacheType == "TRANSPARENT") | .cachedTable' | sed -e 's/\"//g' | sort -u)
   #echo $tutables
   tutablesarr=($tutables)
   #echo "${#tutablesarr[@]}"

   # get cached tables new created
   utablesc=$(cat $queryJsonFile| jq '.cacheInfo[] | select(.isCacheCreated) | .cachedTable' | sed -e 's/\"//g' | sort -u)
   #echo $utablesc
   utablescarr=($utablesc)
   #echo "${#utablescarr[@]}"

   diff <(cat $queryJsonFile| jq '.inputs[] | .connectorId + "." + .schema + "." + .table' | sed -e 's/\"//g' | sort -u ) <(cat $queryJsonFile| jq '.cacheInfo[] .cachedTable' | sed -e 's/\"//g' | sort -u)
   #if [ $? -ne 0 ]; then
   # alltablesfromcache="false"
   # echo "Diff exists"
   #else
   # alltablesfromcache="true"
   # echo "Diff not exists"
   #fi
   
   #echo "-----------------"

   echo "$queryJsonFile | $queryid | $queryText | ${itablesarr[@]} | ${#itablesarr[@]} | ${eutablesarr[@]} | ${#eutablesarr[@]} | ${tutablesarr[@]} | ${#tutablesarr[@]} | ${utablescarr[@]} | ${#utablescarr[@]} " >> $outfile
done
#done < "$filename"


