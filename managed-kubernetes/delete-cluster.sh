set -e

export SELECTEL_PROJECT_TOKEN="$(cat ./current/project-token)"
export SELECTEL_CLUSTER_ID="$(jq '.cluster.id' ./current/cluster.json --raw-output)"

node ./api/delete-cluster.js

rm -f ./current/cluster.json
rm -f ./current/kubeconfig.yaml
