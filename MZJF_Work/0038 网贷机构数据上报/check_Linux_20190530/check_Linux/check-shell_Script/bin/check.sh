#!/bin/bash


Mysqlcommand=`which mysql`
Date=`date '+%Y%m%d%H%M%S'`
Basepath=$(cd `dirname $0`; pwd)
lib_dir=${Basepath}/../lib
log_dir=${Basepath}/../log
usage()
        {
                echo "Usage : $0 mysqluser mysqlpassword mysqldatabase sqlfile sourcecode"
                echo "if MySQL user have no password . Use : $0 mysqluser mysqldatabase sqlfile sourcecode"

        }

if [ $# -ne 4 ] && [ $# -ne 5 ];then
        usage
        exit
elif [ $# == 5 ];then
		sed -i "s/CERT20181126001/$5/g" ${lib_dir}/check.sql
        $Mysqlcommand -u$1 -p$2 -D$3 < ${lib_dir}/$4 |tee ${log_dir}/$4.${Date}.log
		sed -i "s/$5/CERT20181126001/g" ${lib_dir}/check.sql
        exit
elif [ $# == 4 ]; then
		sed -i "s/CERT20181126001/$5/g" ${lib_dir}/check.sql
        $Mysqlcommand -u$1 -D$2 < ${lib_dir}/$3 |tee ${log_dir}/$3.${Date}.log
        sed -i "s/$5/CERT20181126001/g" ${lib_dir}/check.sql
		exit
fi