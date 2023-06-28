#!/bin/bash

echo "==Executing for CDP (Non partitioned)=="
./s_loop.sh config_benchmark_tpcds_cdp_np
./s_validate_tc_v2.sh qjsons config_benchmark_tpcds_cdp_np.report

echo "==Executing for MySQL=="
./s_loop.sh config_benchmark_tpcds_mysql
./s_validate_tc_v2.sh qjsons config_benchmark_tpcds_mysql.report

echo "==Executing for MSSQL=="
./s_loop.sh config_benchmark_tpcds_mssql
./s_validate_tc_v2.sh qjsons config_benchmark_tpcds_mssql.report

echo "==Executing for Snowflake=="
./s_loop.sh config_benchmark_tpcds_sf
./s_validate_tc_v2.sh qjsons config_benchmark_tpcds_sf.report
