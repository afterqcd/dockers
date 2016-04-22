#! /bin/bash
if [ -f .n ]; then
  n=$(cat .n)
else
  echo "No custer exists"
  exit 0
fi

echo "Starting elastic search cluster ... "
for ((i=1; i<=$n; i++)); do 
  docker start node$i
done
echo "Cluster is running now, url is http://localhost:9200"

echo ""
echo "Starting kibana ... "
docker start kibana
echo "Kibana is running now, url is http://localhost:5601"
