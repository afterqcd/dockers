#! /bin/bash
echo "Destoring elastic search cluster ... "
docker rm -f node1
docker rm -f node2
docker rm -f node3
docker rm -f node4
docker rm -f node5
echo "Done"

echo "Destoring elastic search cluster ... "
docker rm -f kibana
echo "Done"
