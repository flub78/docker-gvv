#!/bin/bash
# look for the IP address of a docker container
# usage: ip.sh container_id

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
