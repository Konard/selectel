set -e

export KUBECONFIG=./current/kubeconfig.yaml

kubectl apply -f ./configuration/kubernetes-dashboard/service-account.yaml
kubectl apply -f ./configuration/kubernetes-dashboard/cluster-role.yaml

echo '--------kubernetes-dashboard token---------'

kubectl -n kubernetes-dashboard create token admin-user

echo '-------------------------------------------'