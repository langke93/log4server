#!/bin/sh
#if [ "`whoami`" != "root" ] ; then
#        echo
#        echo Must start use root
#        echo
#        exit 1
#fi

DIRNAME=/usr/bin/dirname
BASE_PATH=`$DIRNAME $0`
cd $BASE_PATH
echo `pwd`

#export PATH=/usr/local/jdk1.6.0_26/bin:$PATH

for i in ./*.jar; do
 CLASSPATH=$i:$CLASSPATH;
done

for j in ../lib/*.jar; do
 CLASSPATH=$j:$CLASSPATH;
done

SEARCH_VER=9
DEFAULT_OPTS="-server -Xms3M -Xmx10M -Xss128k"
DEFAULT_OPTS="$DEFAULT_OPTS -Dcom.sun.management.jmxremote.port=89${SEARCH_VER}6" 
DEFAULT_OPTS="$DEFAULT_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
DEFAULT_OPTS="$DEFAULT_OPTS -Dcom.sun.management.jmxremote.ssl=false"
DEBUG_INFO=" -Xdebug -Xrunjdwp:transport=dt_socket,address=1527${SEARCH_VER},server=y,suspend=n "
DEBUG=""
case $1 in
        "debug") DEBUG=${DEBUG_INFO};;
        esac;
shift;
PNAME=org.apache.log4j.net.SocketServer
if test $(pgrep -f ${PNAME}|wc -l) -ne 0;then
  echo "closing...... $PNAME"
  pkill -f $PNAME
  sleep 2
fi


# process
PORT=5001
configFile=../conf/log4jserver.properties
configDir=../conf/
CMD="java -cp $CLASSPATH ${DEBUG} $DEFAULT_OPTS ${PNAME} ${PORT} ${configFile} ${configDir} > /dev/null 2>&1 &"

eval $CMD
echo "start ~~ $CMD"
echo "as pid:`pgrep -f ${PNAME}`"

