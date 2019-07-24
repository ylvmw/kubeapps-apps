#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add harbor http://10.161.172.125/chartrepo/helm-repo
helm install --name kubeapps --namespace kubeapps bitnami/kubeapps --set frontend.service.type=NodePort
kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
export NODE_IP=$(kubectl get nodes --namespace kubeapps -o jsonpath="{.items[0].status.addresses[0].address}")
export NODE_PORT=$(kubectl get --namespace kubeapps -o jsonpath="{.spec.ports[0].nodePort}" services kubeapps)
echo "Kubeapps URL: http://$NODE_IP:$NODE_PORT"
echo "Kubernetes API Token:"
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 --decode && echo
