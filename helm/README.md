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
helm dependency build yorkie-cluster

# 5. Install/Upgrade yorkie cluster helm chart
helm install yorkie-cluster ./yorkie-cluster --namespace istio-system --create-namespace

# 6. Redeploy istio ingress gateway with auto injecton
kubectl rollout restart deployment istio-ingressgateway -n istio-system

# 7. start minikube tunneling for local connection
minikube tunnel

# 8. test yorkie api!
const client = new yorkie.Client('http://localhost');
```

### Install Yorkie Addons in minikube

Follow above steps and install addons helm chart.

```bash
# 1. Fetch helm chart dependencies
helm dependency build yorkie-addons

# 2. Install/Upgrade yorkie cluster helm chart
helm install yorkie-addons ./yorkie-addons -n monitoring --create-namespace

# 3. Port-forward grafana dashboard
kubectl port-forward -n monitoring service/yorkie-addons-grafana 3000:80

# 4. import yorkie grafana dashboard and go process dashboard
curl https://grafana.com/grafana/dashboards/18451
curl https://grafana.com/grafana/dashboards/18452
```

### Unintall helm charts

```bash
# Uninstall yorkie-cluster helm chart
helm uninstall yorkie-cluster -n istio-system

# Uninstall yorkie-addons helm chart
helm uninstall yorkie-addons 
```