#!/bin/bash
#kubectl create -f logging_pv.yaml
helm install --name elasticsearch --namespace logging -f elasticsearch.yaml bitnami/elasticsearch
helm install --name kibana --namespace logging -f kibana.yaml stable/kibana
helm install --name fluent-bit --namespace logging -f fluent-bit.yaml stable/fluent-bit
#helm install --name fluentd --namespace logging -f fluentd.yaml stable/fluentd