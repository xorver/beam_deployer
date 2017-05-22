#!/usr/bin/env bash

set -e

# usage
if [  $# -lt 2 ]
then
    echo -e "usage: $0 oneclient_root_dir token"
    exit 1
fi

oneclient=$1
token=$2
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$oneclient/make.py -s $oneclient debug

$DIR/deploy_oneclient.sh $oneclient/debug/oneclient a-demo-onedata-cyfronet-provider oneclient-1 $token p-cyfronet.onedata.indigo-datacloud.eu
$DIR/deploy_oneclient.sh $oneclient/debug/oneclient a-demo-onedata-infn-client infnoneclient_oneclient_1 $token p-infn.onedata.indigo-datacloud.eu
