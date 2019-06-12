#!/bin/bash

set -auexo pipefail

source .env

APP_GWY_NAME=$(az network application-gateway list --subscription $AZURE_SUBSCR -o json --query "[0].name")
AKS_ADDR=$(az aks list --resource-group $AZURE_RG --subscription $AZURE_SUBSCR --query "[0].fqdn" --output json)

rm -rf helm-config.yaml*

wget "https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/helm-config.yaml"

## TODO: Use Jinja or sometthing else better than this
sed -i "s/<subscriptionId>/$AZURE_SUBSCR/g" helm-config.yaml
sed -i "s/<resourceGroupName>/$AZURE_RG/g" helm-config.yaml
sed -i "s/<applicationGatewayName>/$APP_GWY_NAME/g" helm-config.yaml

sed -i "s/<identityResourceId>/$APP_GWY_NAME/g" helm-config.yaml
sed -i "s/<identityClientId>/$APP_GWY_NAME/g" helm-config.yaml

sed -i "s/<aks-api-server-address>/$AKS_ADDR/g" helm-config.yaml
sed -i "s/enabled: false/enabled: true/g" helm-config.yaml

cat helm-config.yaml

helm install -f helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure
