#!/bin/bash

set -auexo pipefail

source .env

az identity create -g $AZURE_RG -n $AZURE_IDENTITY --subscription $AZURE_SUBSCR || true

SP_ID=$(az identity show -g $AZURE_RG -n $AZURE_IDENTITY --subscription $AZURE_SUBSCR --query principalId -o tsv)

APP_GWY=$(az network application-gateway list --subscription $AZURE_SUBSCR --query "[0].id" -o tsv)

az role assignment create --role Reader --assignee $SP_ID  --scope $APP_GWY --subscription $AZURE_SUBSCR
