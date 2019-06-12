#!/bin/bash

set -auexo pipefail

source .env

SPNAME="az-sp-$(whoami)"

az ad sp create-for-rbac --subscription $AZURE_SUBSCR -n $SPNAME --skip-assign
# APPID=$(az identity show --subscription $AZURE_SUBSCR --name $AZURE_SPAPPID --resource-group $AZURE_RG -o json --query "appId" $SPNAME)
