FROM parzonka/java8

ENV SPARK_VERSION 1.6.1
RUN wget -O - http://apache.openmirror.de/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz  | tar xzf - && mv spark-${SPARK_VERSION}-bin-hadoop2.6 /opt/spark
WORKDIR /opt/spark

ENV SPARK_HOME /opt/spark
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080 7077 6066 8888 8081 4040 7001 7002 7003 7004 7005 7006

CMD ["/bin/bash"]
