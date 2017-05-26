#!/usr/bin/env bash

set -e

# usage
if [  $# -lt 5 ]
then
    echo -e "usage: $0 beam_path remote_host remote_docker_name erlang_node_name erlang_cookie"
    exit 1
fi

# args
beam_path=$1
remote_host=$2
remote_docker_name=$3
op_worker_node_name=$4
cookie=$5
beam_file_name=${beam_path##*/}
beam_name=${beam_file_name%.beam}
erl_call_path=/opt/couchbase/lib/erlang/lib/erl_interface-3.7.15/bin/erl_call

# copy beam into the docker
scp $beam_path $remote_host:/tmp/$beam_file_name
ssh $remote_host docker cp /tmp/$beam_file_name $remote_docker_name:/tmp/$beam_file_name

# backup and replace original beam inside the docker
ssh $remote_host docker exec $remote_docker_name find /usr/lib/ -name $beam_file_name -exec cp {} /tmp/$beam_file_name.bak \\\;
ssh $remote_host docker exec $remote_docker_name find /usr/lib/ -name $beam_file_name -exec cp /tmp/$beam_file_name {} \\\;

# hotswap module on running node
ssh $remote_host docker exec $remote_docker_name $erl_call_path -c $cookie -n $op_worker_node_name -a "\"code purge [${beam_name}]\""
ssh $remote_host docker exec $remote_docker_name $erl_call_path -c $cookie -n $op_worker_node_name -a "\"code load_file [${beam_name}]\""
