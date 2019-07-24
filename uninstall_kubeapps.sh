#!/bin/bash
helm delete --purge kubeapps
kubectl delete crd apprepositories.kubeapps.com
kubectl delete namespace kubeapps
kubectl delete clusterrolebinding kubeapps-operator
kubectl delete serviceaccount kubeapps-operator
