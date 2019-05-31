README
一、前提：
1、安装并运行mysql。
2、创建一个数据库，如create database test。

二、操作步骤：
1、给shell脚本赋予执行权限
--进入bin目录：cd bin
--赋予执行权限：chmod + x check.sh

2、使用check.sh建表
--./check.sh MySQL用户 MySQL密码 MySQL数据库 CreateTables.sql 平台编号
--例：./check.sh root 111111 test CreateTables.sql CERT20180101001

3、往数据库导入数据

4、使用check.sh执行check.sql
--./check.sh MySQL用户 MySQL密码 MySQL数据库 check.sql 平台编号
--例：./check.sh root 111111 test check.sql CERT20180101001

5、使用check.sh执行KPIs.sql
--./check.sh MySQL用户 MySQL密码 MySQL数据库 KPIs.sql 平台编号
--例：./check.sh root 111111 test KPIs.sql CERT20180101001

三、压缩包目录说明
bin--check.sh所在目录
lib--sql文件所在目录
log--输出日志所在目录，按执行时间生成。

附1、sql文件说明
--createTables.sql为建表sql.需要先执行，然后再导入数据。
--check.sql为检查sql.需要导入数据后才能执行。
--KPIs.sql为关键指标sql.需要导入数据后才能执行。

附2、test.sh脚本参数说明
1、test.sh 可接4/5个参数，区别为是否需要MySQL密码。
--即：./check.sh MySQL用户 MySQL密码 MySQL数据库 sql文件名 平台编号
--或：./check.sh MySQL用户 MySQL数据库 sql文件名 平台编号