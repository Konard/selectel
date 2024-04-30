set -e

# Install tools
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl netcat jq

# Configure kubectl

sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Configure helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# Install kubectl and helm
sudo apt-get update
sudo apt-get install -y kubectl helm

echo ''
echo 'Installed versions:'

kubectl version --client
helm version

# sudo apt update
# sudo apt install snapd -y

# sudo systemctl enable snapd
# sudo systemctl start snapd

# snap install kubectl --classic
# kubectl version --client

# sudo snap install helm --classic
# helm version