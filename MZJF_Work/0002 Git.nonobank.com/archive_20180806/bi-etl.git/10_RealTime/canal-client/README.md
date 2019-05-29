### Building it
```
$ gradle build
```
打包后的JAR包在: ```build/libs```

### Running
默认端口号：15001
```
$ nohup java -Dspring.profiles.active=prod -jar build/libs/canal-client-core-1.0.0.jar >> spring-boot-data-quality-app.log 2>&1 &

```

### Kafka相关设置
```
1、需要设置自动创建topic：
	auto.create.topics.enable=true
2、同时设置默认replication，设置为1个分区（多个分区不能保证顺序性）:
	default.replication.factor=1
```

### 多线程从多个instance中消费数据
```
一个线程负责一个instance的读写，每个线程的业务：
	一个instance对应一个canal client，一个canal client的对应一个kafka produce发布数据到kafka
```
