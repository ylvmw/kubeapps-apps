#!/bin/bash
kubectl create -f monitoring_pv.yaml
helm install --name prometheus --namespace monitoring -f promethus.yaml stable/prometheus
helm install --name grafana --namespace monitoring -f grafana.yaml stable/grafana