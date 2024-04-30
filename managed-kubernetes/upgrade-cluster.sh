set -e

export KUBECONFIG=./current/kubeconfig.yaml

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo add twuni https://helm.twun.io
helm repo update

helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v3.5.0/deploy/crds.yaml

helm upgrade \
    --install cert-manager jetstack/cert-manager \
    --create-namespace --namespace cert-manager \
    --version v1.14.4 \
    --set installCRDs=true
kubectl apply -f ./configuration/letscrypt.yaml

# helm upgrade \
#     --install docker-registry twuni/docker-registry \
#     --create-namespace --namespace docker-registry \
#     -f ./configuration/docker-registry.yaml

if [ ! nc -vz localhost 8443 > /dev/null 2>&1 ]; then
    echo 'Waiting for kubernetes-dashboard to be available...'

    set +e
    while : ; do
        # node ./api/get-cluster-kubeconfig.js 1> ./current/kubeconfig.yaml 2> /dev/null
        kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443 > /dev/null 2>&1 &
        [[ $? -ne 0 ]] || break
        sleep 2
    done
    set -e
fi

echo 'kubernetes-dashboard is ready. Proxy is up.'

./create-service-token.sh

kubectl get nodes
kubectl get pods --all-namespaces
