#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed on this system. Please install Docker and then run this script again."
    exit 1
fi

# Run the Docker container
docker run -d \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 7878:7878 \
  -v /path/to/radarr/data:/config \
  -v /path/to/movies:/movies `#optional` \
  -v /path/to/download-client-downloads:/downloads `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/radarr:latest
