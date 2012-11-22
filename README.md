log4server
===============

log4server是个简单的日志收集服务，是使用log4j的SocketServer,用来收集分布式系统中的日志，方便集中日志查询、分析

1.日志服务启动脚本bin/restart_server.sh<br>
主要配置是conf/generic.lcf<br>
第一行是指定日志存储路径<br>
第二段是配置全局日志存储，所有接收到的日志都会在这边输出<br>
第三、四段是配置局部日志存储，可以细分指定一个包输出到一个日志文件，用来区分项目挺方便<r>
log4j.logger.org.langke.core=INFO,rest-nettyserver<br>
这里的包名跟项目包名对上就可以了<br>

2.客户端配置参考：doc/log4j.properties<br> 
主要就是把下列配置加到各个服务器的log4j.properties<br>
rootLogger加下SOCKET_CLIENT
<pre>
log4j.rootLogger=INFO,SOCKET_CLIENT

#remote logging
log4j.appender.SOCKET_CLIENT = org.apache.log4j.net.SocketAppender
log4j.appender.SOCKET_CLIENT.RemoteHost = log4server
log4j.appender.SOCKET_CLIENT.Port = 5001
log4j.appender.SOCKET_CLIENT.LocationInfo = true
</pre>
这里log4server是指向log4server服务器host,需要配置hosts文件，或者直接用ip