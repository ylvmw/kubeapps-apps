#!/bin/bash
kubectl create -f logging_pv.yaml
helm install --name elasticsearch --namespace logging -f elasticsearch.yaml stable/elasticsearch
#helm install --name fluentd --namespace logging stable/fluentd