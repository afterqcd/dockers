#! /bin/bash
if [ -f .n ]; then
  n=$(cat .n)
else
  echo "No custer exists"
  exit 0
fi

echo "Destoring elastic search cluster ... "
for ((i=1; i<=$n; i++)); do 
  docker rm -f node$i
done
rm -f .n

echo ""
echo "Destoring kibana ... "
docker rm -f kibana

echo ""
echo "Destoring es-bridge ... "
if $(docker network ls | grep es-bridge >/dev/null 2>&1); then
  docker network rm es-bridge
fi
echo "Done"
