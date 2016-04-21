#! /bin/bash
echo "Creating elastic search cluster ..."
docker run -d -p 9200:9200 --hostname=node1 --name=node1 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node1 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1
docker run -d --hostname=node2 --name=node2 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node2 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1
docker run -d --hostname=node3 --name=node3 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node3 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1
docker run -d --hostname=node4 --name=node4 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node4 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1
docker run -d --hostname=node5 --name=node5 --net=es-bridge afterqcd/elasticsearch:v2.3.1 elasticsearch -Des.node.name=node5 -Des.cluster.name=test -Des.discovery.zen.ping.unicast.hosts=node1
sleep 5s
echo "Cluster is running now, url is http://localhost:9200"

echo "Creating kibana ..."
docker run -d -p 5601:5601 --net=es-bridge --name=kibana afterqcd/kibana:v4.5.0
sleep 3s
echo "Kibana is running now, url is http://localhost:5601"
