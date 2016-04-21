#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
if [ "$1" = 'elasticsearch' ]; then
	# Change the ownership of data to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/elasticsearch/data
	exec gosu elasticsearch "$@" -Des.network.host=$(hostname -i)
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
