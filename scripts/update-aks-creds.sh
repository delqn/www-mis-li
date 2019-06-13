#!/bin/bash

set -auexo pipefail

source .env

# Source: https://docs.microsoft.com/en-us/azure/aks/update-credentials

SP_ID=$(az aks show --subscription $AZURE_SUBSCR --resource-group $AZURE_RG --name $AKS_NAME --query servicePrincipalProfile.clientId -o tsv)

SP_SECRET=$(az ad sp credential reset --name $SP_ID --query password -o tsv)

az aks update-credentials \
    --resource-group $AZURE_RG \
    --name $AKS_NAME \
    --reset-service-principal \
    --service-principal $SP_ID \
    --client-secret $SP_SECRET \
    --subscription $AZURE_SUBSCR
