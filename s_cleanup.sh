#!/bin/bash

echo "Cleaning report files"
rm -rf *.report
rm -rf *.extract
rm -rf *.err
rm -rf *.out

echo "QueryJsons"
rm -rf qjsons/*

echo "Query results"
rm -rf qresults/*
