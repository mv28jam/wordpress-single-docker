#!/usr/bin/env bash

cd ..
docker build -f Dockerfile-existing . -t wp-cont
ID=$(docker run -p 80:80 -p 443:443 -d -it wp-cont)
echo "Container ID: $ID";