#!/bin/bash
helm delete --purge grafana
helm delete --purge prometheus
kubectl delete namespace monitoring
kubectl delete -f monitoring_pv.yaml