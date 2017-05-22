#!/usr/bin/env bash

set -e

# usage
if [  $# -lt 5 ]
then
    echo -e "usage: $0 oneclient_path remote_host remote_docker_name token provider_hostname"
    exit 1
fi

#args
oneclient_path=$1
remote_host=$2
remote_docker_name=$3
token=$4
provider_hostname=$5

#copy oneclient into the docker
scp $oneclient_path $remote_host:/tmp/oneclient_new
ssh $remote_host docker cp /tmp/oneclient_new $remote_docker_name:/tmp/oneclient_new

# backup and replace original beam inside the docker
ssh $remote_host docker exec $remote_docker_name chmod u+x /tmp/oneclient_new
ssh $remote_host docker exec $remote_docker_name mkdir -p /mnt/oneclient_new
ssh $remote_host docker exec $remote_docker_name /tmp/oneclient_new -u /mnt/oneclient_new
ssh $remote_host docker exec $remote_docker_name /tmp/oneclient_new /mnt/oneclient_new -t $token -H $provider_hostname