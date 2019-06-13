#!make

include .env

SHELL:=bash

.PHONY: backup
backup:
	./scripts/backup.sh

.PHONY: pod-identity
pod-identity: install-helm
	bash ./scripts/install-aad-pod-identity.sh

.PHONY: install-helm
install-helm: get-aks-creds
	./scripts/install-helm.sh

.PHONY: get-aks-creds
get-aks-creds:
	./scripts/get-aks-creds.sh

.PHONY: install-helm-chart
install-helm-chart: install-helm
	./scripts/install-helm-chart.sh

.PHONY: update-aks-creds
update-aks-creds:
	./scripts/update-aks-creds.sh
