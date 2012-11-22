#!/bin/sh

DIRNAME=/usr/bin/dirname
BASE_PATH=`$DIRNAME $0`
cd $BASE_PATH
echo `pwd`

#export PATH=/usr/local/jdk1.6.0_26/bin:$PATH

PNAME=org.apache.log4j.net.SocketServer
if test $(pgrep -f ${PNAME}|wc -l) -ne 0;then
  echo "closing...... $PNAME"
  pkill -f $PNAME
  sleep 2
fi


# process
PORT=5001
echo `ps aux|grep  ${PNAME}`

