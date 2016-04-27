#!/bin/bash -e

# fix ports
cat <<EOT > /opt/spark/conf/spark-defaults.conf
spark.driver.port			7001
spark.fileserver.port		7002
spark.broadcast.port		7003
spark.replClassServer.port	7004
spark.blockManager.port 	7005
spark.executor.port 		7006
spark.ui.port 				4040
spark.broadcast.factory 	org.apache.spark.broadcast.HttpBroadcastFactory
EOT

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
