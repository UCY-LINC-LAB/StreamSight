docker build -t streamsight -f ../Dockerfile ../ && \
docker service remove streamsight
docker service create --network=spark_insights-net --name streamsight \
	--env MASTER_NODE="spark://master:7077" \
	--publish published=4040,target=4040 \
	-d streamsight
docker service logs streamsight -f
