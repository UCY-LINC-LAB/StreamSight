
# Check if in swarm mode
docker node ls 2>/dev/null
if [[ $? == '1' ]]; then
    docker swarm init
fi

mkdir /tmp/spark/ 2> /dev/null
docker stack rm spark && echo "Waiting for 5 seconds..." && sleep 5



docker network inspect spark_insights-net > /dev/null
while [[ $? == '0' ]]; do
    echo "Waiting for network to be removed..."
    docker rm spark_insights-net
    docker network inspect spark_insights-net > /dev/null
    sleep 5
done

docker stack deploy --compose-file docker-compose.yaml spark

