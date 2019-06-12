#!/bin/bash

set -auexo pipefail

source .env

AKS_NAME=$(az aks list --subscription $AZURE_SUBSCR --query "[0].name" --output tsv)

az aks update-credentials \
    --resource-group $AZURE_RG \
    --name $AKS_NAME \
    --reset-service-principal \
    --service-principal $AZURE_SPAPPID \
    --client-secret $AZURE_SPPASSWORD \
    --subscription $AZURE_SUBSCR
