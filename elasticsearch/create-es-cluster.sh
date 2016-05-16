#! /bin/bash

# check parameters
cluster=$1
if [ -z $cluster ]; then
  echo "Usage: create-es-cluster.sh cluster nodes-number"
  exit 1
fi

n=$2
if [ -z $n ]; then
  n=3
fi

if [ $n -lt 2 ]; then
  echo "Can not create cluster with less than two nodes"
  exit 1
fi

# create network bridge
bridge=es-bridge
if $(docker network ls | grep $bridge >/dev/null 2>&1); then
  echo "Found $bridge"
else
  echo "Create network bridge for elastic search"
  docker network create --driver=bridge $bridge
fi

# create elastic search nodes
echo $n > .n
echo ""
echo "Creating elastic search cluster with $n nodes ..."
docker run -d -p 9200:9200 -p 9300:9300 --hostname=node1 --name=node1 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node1 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1

for ((i=2; i<=$n; i++)); do
  nodename=node$i
  docker run -d --hostname=$nodename --name=$nodename --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=$nodename -Des.cluster.name=$cluster -Des.discovery.zen.ping.unicast.hosts=node1
done
sleep 3s
echo "Cluster is running now, url is http://localhost:9200"

# create kibana
echo ""
echo "Creating kibana ..."
docker run -d -p 5601:5601 --net=es-bridge --name=kibana afterqcd/kibana:v4.5.0
sleep 1s
echo "Kibana is running now, url is http://localhost:5601"
