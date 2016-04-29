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
spark.worker.cleanup.enabled	true
spark.worker.cleanup.interval	600
spark.worker.cleanup.appDataTtl	12000
EOT

if [ ! -z $LOCAL_IP ]; then
	export SPARK_LOCAL_IP=$LOCAL_IP
fi

if [ ! -z $PUBLIC_DNS ]; then
	export SPARK_PUBLIC_DNS=$PUBLIC_DNS
fi

if [ ! -z $MASTER_IP ]; then
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
