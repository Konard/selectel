const fetch = require('node-fetch');

const accountId = process.env.SELECTEL_ACCOUNT_ID || '';
const serviceUserName = process.env.SELECTEL_USER_NAME || '';
const serviceUserPassword = process.env.SELECTEL_USER_PASSWORD || '';
const projectName = process.env.SELECTEL_PROJECT_NAME || '';

const createProjectToken = async (accountId, serviceUserName, serviceUserPassword, projectName) => {
  const apiUrl = 'https://cloud.api.selcloud.ru/identity/v3/auth/tokens';
  const response = await fetch(`${apiUrl}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ 
      "auth": {
        "identity": {
          "methods": ["password"],
          "password": {
            "user": {
              "name": serviceUserName,
              "domain": {
                "name": accountId
              },
              "password": serviceUserPassword
            }
          }
        },
        "scope": {
          "project": {
            "name": projectName,
            "domain": {
              "name": accountId
            }
          }
        }
      }
    }),
  });
  if (!response.ok) {
    throw new Error(`HTTP Error (status: ${response.status}): ${JSON.stringify(await response.json(), null, 2)}`);
  }
  return response.headers.get("x-subject-token");
};

createProjectToken(accountId, serviceUserName, serviceUserPassword, projectName)
  .then(console.log);
