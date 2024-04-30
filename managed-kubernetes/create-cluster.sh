set -e

# export SELECTEL_ACCOUNT_ID="111111"
# export SELECTEL_USER_NAME="ExampleUser"
# export SELECTEL_USER_PASSWORD="123examplePassword=-"
# export SELECTEL_PROJECT_NAME="example-project-name"

if [ ! -f ./current/project-token ]; then
    node ./api/create-project-token.js > ./current/project-token
fi

export SELECTEL_PROJECT_TOKEN="$(cat ./current/project-token)"

node ./api/create-cluster.js > ./current/cluster.json

export SELECTEL_CLUSTER_ID="$(jq '.cluster.id' ./current/cluster.json --raw-output)"

echo 'Waiting for kubeconfig to be available...'

set +e
while : ; do
    node ./api/get-cluster-kubeconfig.js 1> ./current/kubeconfig.yaml 2> /dev/null
    [[ $? -ne 0 ]] || break
    sleep 2
done
set -e

chmod go-r ./current/kubeconfig.yaml

echo 'kubeconfig is ready'