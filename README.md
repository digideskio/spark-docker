## Example Usage

Start master

	docker run -dit --net=host --name=spark -e MASTER_IP=<some_host> -e ROLE=master parzonka/spark

Start slave

	docker run -dit --net=host --name=spark -e MASTER_IP=<some_host> -e ROLE=slave parzonka/spark
