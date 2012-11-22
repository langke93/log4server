@setlocal enabledelayedexpansion
@set classpath=.
@for %%c in (..\lib\*.jar) do @set classpath=!classpath!;%%c
@for %%c in (..\bin\*.jar) do @set classpath=!classpath!;%%c
@set DEFAULT_OPTS=-server -Xms3M -Xmx10M 

# process
@set PNAME=org.apache.log4j.net.SocketServer
@set PORT=5001
@set configFile=../conf/log4jserver.properties
@set configDir=../conf/

java -cp "%classpath%" %DEFAULT_OPTS% %PNAME% %PORT% %configFile% %configDir% %*
