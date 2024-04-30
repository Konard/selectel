const fetch = require('node-fetch');

const projectToken = process.env.SELECTEL_PROJECT_TOKEN || '';

const createCluster = async (projectToken) => {
  const apiUrl = 'https://ru-2.mks.selcloud.ru/v1/clusters';
  const response = await fetch(`${apiUrl}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Auth-Token': projectToken,
    },
    body: JSON.stringify({
      "cluster": {
        // "additional_software": {
        //   "additionalProp1": "string",
        //   "additionalProp2": "string",
        //   "additionalProp3": "string"
        // },
        "enable_autorepair": true,
        "enable_patch_version_auto_upgrade": true,
        "kube_version": "1.29.1",
        "kubernetes_options": {
          // "admission_controllers": [
          //   "string"
          // ],
          // "enable_pod_security_policy": true,
          // "feature_gates": [
          //   "string"
          // ],
          // "x509_ca_certificates": "string"
        },
        // "maintenance_window_start": "string",
        "name": "example-cluster",
        // "network_id": "string",
        "nodegroups": [
          {
            // "affinity_policy": "soft-anti-affinity",
            "autoscale_min_nodes": 1,
            "autoscale_max_nodes": 3,
            "availability_zone": "ru-2c",
            "count": 1,
            "cpus": 4,
            "enable_autoscale": true,
            // "flavor_id": "string",
            // "keypair_name": "string",
            // "labels": {
            //   "additionalProp1": "string",
            //   "additionalProp2": "string",
            //   "additionalProp3": "string"
            // },
            "local_volume": false,
            "ram_mb": 8192,
            // "taints": [
            //   {
            //     "effect": "string",
            //     "key": "string",
            //     "value": "string"
            //   }
            // ],
            // "user_data": "string",
            "volume_gb": 30,
            "volume_type": "fast.ru-2c"
          }
        ],
        "private_kube_api": false,
        "region": "ru-2",
        // "subnet_id": "",
        "zonal": false
      }
    }),
  });
  if (!response.ok) {
    throw new Error(`HTTP Error (status: ${response.status}): ${JSON.stringify(await response.json(), null, 2)}`);
  }
  return response.json();
};

createCluster(projectToken)
  .then((response) => console.log(JSON.stringify(response, null, 2)));
