#!/bin/bash

source .env

az aks get-credentials --subscription $AZURE_SUBSCR --resource-group $AZURE_RG --name $AKS_NAME
