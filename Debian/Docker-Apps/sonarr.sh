#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed on this system. Please install Docker and then run this script again."
    exit 1
fi

# Run the Docker container
docker run -d \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 8989:8989 \
  -v /path/to/sonarr/data:/config \
  -v /path/to/tvseries:/tv `#optional` \
  -v /path/to/downloadclient-downloads:/downloads `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/sonarr:latest
