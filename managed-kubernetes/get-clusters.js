const fetch = require('node-fetch'); 

const projectToken = process.env.SELECTEL_PROJECT_TOKEN || '';

const getClusters = async (projectToken) => {
  const apiUrl = 'https://ru-2.mks.selcloud.ru/v1/clusters';
  const response = await fetch(`${apiUrl}`, {
    method: 'GET',
    headers: {
      'X-Auth-Token': projectToken,
    },
  });
  if (!response.ok) {
    throw new Error(`HTTP error! Status: ${response.status}`);
  }
  return response.json();
};

getClusters(projectToken)
  .then((response) => console.log(JSON.stringify(response, null, 2)))
  .catch((error) => console.error('Error creating cluster:', error));
