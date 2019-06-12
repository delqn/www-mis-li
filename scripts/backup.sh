#!/bin/bash

set auexo pipefail

source .env

rm -rf /tmp/www-mis-li.tgz*
tar -czf /tmp/www-mis-li.tgz ../www-mis-li
gpg -c /tmp/www-mis-li.tgz

az storage account keys list \
   --account-name $AZURE_STORAGE_ACCOUNT \
   --resource-group $AZURE_RG \
   --subscription $AZURE_SUBSCR

az storage blob upload \
   --subscription $AZURE_SUBSCR \
   -c "pc-backup" \
   -n www-mis-li.tgz.gpg \
   -f /tmp/www-mis-li.tgz.gpg

az storage blob list \
   --subscription $AZURE_SUBSCR \
   -c $AZURE_STORAGE_CONTAINER
