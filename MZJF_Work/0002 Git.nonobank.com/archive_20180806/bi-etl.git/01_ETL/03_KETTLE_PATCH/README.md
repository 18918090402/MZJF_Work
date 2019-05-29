# kettle 补丁包说明：

* 1、pentaho-big-data-legacy-6.1.0.1-196.jar
  * 修改内容：修改Table exists控件判断表是否存在的检查SQL，默认的SQL是SELECT 1 FROM tablename，更改为 SELECT 1 FROM tablename LIMIT 0；当判断视图且视图里的逻辑比较复杂、查询的表比较多，会导致返回结果时间比较长，可能会达到30分钟作用；
  * 补丁包路径：$KETTLE_HOME/plugins/pentaho-big-data-plugin


