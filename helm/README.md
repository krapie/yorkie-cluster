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

# 4. Fetch helm chart dependencies
helm dependency build

# 5. Install/Upgrade yorkie cluster helm chart
helm install yorkie-cluster ./yorkie-cluster --namespace istio-system --create-namespace

# 6. Redeploy istio ingress gateway with auto injecton
kubectl rollout restart deployment istio-ingressgateway -n istio-system

# 7. start minikube tunneling for local connection
minikube tunnel

# 8. test yorkie api!
const client = new yorkie.Client('http://localhost');
```
