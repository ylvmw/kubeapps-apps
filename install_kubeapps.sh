#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --name kubeapps --namespace kubeapps bitnami/kubeapps --set frontend.service.type=NodePort
kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
export NODE_IP=$(kubectl get nodes --namespace kubeapps -o jsonpath="{.items[0].status.addresses[0].address}")
export NODE_PORT=$(kubectl get --namespace kubeapps -o jsonpath="{.spec.ports[0].nodePort}" services kubeapps)
echo "Kubeapps URL: http://$NODE_IP:$NODE_PORT"
export token=$(kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 --decode)
echo "Kubernetes API Token:"
echo $token
export app_repo_name='harbor'
export app_repo_url='http://10.161.172.125/chartrepo/helm-repo'
echo "Add app repo: ${app_repo_name} ${app_repo_url}"
sleep 10s
status=$(curl -s -o /dev/null -w '%{http_code}' -k -H "Content-Type: application/json" -H "Accept: application/json" -H "Authorization: Bearer ${token}" -X POST "http://${NODE_IP}:${NODE_PORT}/api/kube/apis/kubeapps.com/v1alpha1/namespaces/kubeapps/apprepositories" -d '{"apiVersion":"kubeapps.com/v1alpha1","kind":"AppRepository","metadata":{"name":"'${app_repo_name}'"},"spec":{"auth":{},"type":"helm","url":"'${app_repo_url}'"}}')
if [ $status -eq 201 ]; then
    echo "Add app repo done!"
else
    echo "Failed to add app repo: status=$status"
fi