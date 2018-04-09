#!/bin/bash

[ -z $(echo $PATH | grep "greenplum-db") ] && source /usr/local/greenplum-db/greenplum_path.sh

WS_DIR='/home/pivpair/AirlineOptimization'

psql -c 'drop schema pricing cascade'
psql -c 'create schema pricing'

for sqlfile in ${WS_DIR}/01_Data_Prep/[0-9]*.sql
do
    echo Create table and load data from file \"$sqlfile\"
    psql -f $sqlfile
done
