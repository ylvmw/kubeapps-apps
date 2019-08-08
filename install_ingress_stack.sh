#!/bin/bash
#kubectl create -f logging_pv.yaml
helm install --name nginx-ingress --namespace ingress -f nginx-ingress.yaml stable/nginx-ingress