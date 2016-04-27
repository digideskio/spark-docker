#!/bin/bash -e

if [ -z $MASTER_IP ]; then
	echo "no master ip defined"
else
	if [ "$ROLE" = "master" ]; then
		echo "starting master at $MASTER_IP" 
		/opt/spark/sbin/start-master.sh -h $MASTER_IP
	else
		MASTER_URL="spark://$MASTER_IP:7077"
		echo "starting slave connecting to $MASTER_URL" 
		/opt/spark/sbin/start-slave.sh $MASTER_URL
	fi
fi

exec "$@"
