#!/bin/bash
#helm delete --purge fluentd
helm delete --purge fluent-bit
helm delete --purge kibana
helm delete --purge elasticsearch
kubectl delete namespace logging
#kubectl delete -f logging_pv.yaml