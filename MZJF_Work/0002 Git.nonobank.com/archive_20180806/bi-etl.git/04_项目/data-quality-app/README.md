### 项目介绍
---
　data-quality-app 是一个基于规则的跨数据源的对字段进行数据验证的平台，当前只支持hive、mysql两种数据源。  
　其思想是先计算字段值，对这些值根据一定规则做字段值之间的比较。

#### 解释
* 数据源：定义字段来源，对应到hive、mysql的一张表
* 字段过滤规则：在计算字段值时先过滤掉非法数据
* 字段汇总规则：对过滤后的字段进行count、count distinct、sum等汇总操作
* 字段校验规则：一个字段的值和其他字段值作比较

### Building it
---
```
$ gradle build
```
打包后的JAR包在: ```build/libs```

### Running
---
默认端口号：15001
```
$ nohup java -Dspring.profiles.active=prod -jar build/libs/data-quality-app-1.0.0.jar >> spring-boot-data-quality-app.log 2>&1 &

```

### API访问URL
---
```
http://localhost:15001/data-quality-app/swagger-ui.html      
http://localhost:15001/data-quality-app/api/dq/compare?ids=1,2&depends=1
```


调度起来后会根据设置的时间自动执行:
	1、如果是正在跑出现异常
		
groupName:job分组;
	枚举：dq_calculate、dq_compare
jobName：job名，唯一。

periodTime：单位是秒
curl -l -H "Content-type: application/json" -X POST -d '{"dataId":"2","dataStartTimestamp":"1502962161000","periodTime":"60","jobStartTime":"1502962161000"}' "http://localhost:15001/data-quality-app/api/jobs/add?groupName=dq_calculate&jobName=job3"


curl -l -H "Content-type: application/json" -X POST -d '{"dataId":"1","dataStartTimestamp":"1502962161000","periodTime":"60","jobStartTime":"1502962161000"}' "http://localhost:15001/data-quality-app/api/jobs/add?groupName=dq_compare&jobName=job3"


curl -l -H "Content-type: application/json" -X POST -d '{"dataId":"1","dataStartTimestamp":"1502962161000","periodTime":"60","jobStartTime":"1502962161000"}' "http://localhost:15001/data-quality-app/api/jobs/add?groupName=test2&jobName=job3"

curl -l -H "Content-type: application/json" "http://localhost:15001/data-quality-app/api/jobs/pause?groupName=test2&jobName=job3"

curl -l -H "Content-type: application/json" -X GET "http://localhost:15001/data-quality-app/api/jobs/unschedule?groupName=test2&jobName=job3"

curl -l -H "Content-type: application/json" -X DELETE "http://localhost:15001/data-quality-app/api/jobs/del?groupName=test2&jobName=job3"