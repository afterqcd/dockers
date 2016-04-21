#! /bin/bash
echo "Building elasticsearch image"
cd image/es && ./build.sh && cd -
echo "Done"

echo "Building kibana image"
cd image/kibana && ./build.sh && cd -
echo "Done"
