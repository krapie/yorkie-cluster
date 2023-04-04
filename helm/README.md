# Yorkie Cluster Helm Chart

## Getting Started

### Install Yorkie Cluster in minikube

```bash
# 1. clone repository
git clone https://github.com/krapie/yorkie-cluster.git

# 2. change to project directory
cd yorkie-cluster/helm

# 3. start minikube cluster
minikube start

# 4. Install Istio with default profile
istioctl install --set profile=default -y

# 5. Install/Upgrade yorkie cluster helm chart
helm install yorkie-cluster ./yorkie-cluster

# 6. start minikube tunneling for local connection
minikube tunnel

# 7. test yorkie api!
const client = new yorkie.Client('http://localhost');
```
