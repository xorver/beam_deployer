#!/usr/bin/env bash

set -e

# usage
if [  $# -lt 2 ]
then
    echo -e "usage: $0 op_worker_root_dir module_name"
    exit 1
fi

op_worker_root_dir=$1
module_name=$2
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$op_worker_root_dir/make.py -s $op_worker_root_dir compile

beam_path=`find $op_worker_root_dir -name $module_name.beam`
$DIR/deploy_beam.sh $beam_path a-demo-onedata-cyfronet-provider oneprovider-1 op_worker@node1.oneprovider.localhost cluster_node
$DIR/deploy_beam.sh $beam_path a-demo-onedata-infn-provider oneprovider-1 op_worker@node1.oneprovider.localhost cluster_node
$DIR/deploy_beam.sh $beam_path a-demo-onedata-lab-provider oneprovider-1 op_worker@node1.oneprovider.localhost cluster_node