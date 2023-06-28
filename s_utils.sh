#!/bin/bash

function jsonDirName {
        return "$1""/""$jsonsDir"    
}

function resultDirName {
        return "$1"/"$resultsDir"    
}

function artifactDirName {
    return "$artifact_outdir""itr_"$1
}