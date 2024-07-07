#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed on this system. Please install Docker and then run this script again."
    exit 1
fi

# Run the Docker container
docker run -d \
  --name overseerr \
  -e LOG_LEVEL=debug \
  -e TZ=Asia/Tokyo \
  -e PORT=5055 `#optional` \
  -p 5055:5055 \
  -v /path/to/appdata/config:/app/config \
  --restart unless-stopped \
  sctx/overseerr
