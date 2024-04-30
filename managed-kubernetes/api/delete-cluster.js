const fetch = require('node-fetch');

const projectToken = process.env.SELECTEL_PROJECT_TOKEN || '';
const clusterId = process.env.SELECTEL_CLUSTER_ID || '';

const deleteCluster = async (projectToken) => {
  const apiUrl = 'https://ru-2.mks.selcloud.ru/v1/clusters';
  const response = await fetch(`${apiUrl}/${clusterId}`, {
    method: 'DELETE',
    headers: {
      'X-Auth-Token': projectToken,
    },
  });
  if (!response.ok) {
    throw new Error(`HTTP Error (status: ${response.status}): ${JSON.stringify(await response.json(), null, 2)}`);
  }
  return response.text();
};

deleteCluster(projectToken);
