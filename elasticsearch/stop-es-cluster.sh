#! /bin/bash
if [ -f .n ]; then
  n=$(cat .n)
else
  echo "No custer exists"
  exit 0
fi

echo "Stopping elastic search cluster ... "
for ((i=1; i<=$n; i++)); do 
  docker stop node$i
done

echo ""
echo "Stopping kibana ... "
docker stop kibana
echo "Done"
