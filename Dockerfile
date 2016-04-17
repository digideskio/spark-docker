FROM parzonka/java8

ENV SPARK_VERSION 1.6.1

RUN wget -O - http://apache.openmirror.de/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz  | tar xzf - && mv spark-${SPARK_VERSION}-bin-hadoop2.6 /opt/spark
WORKDIR /opt/spark

CMD ["/bin/bash"]
