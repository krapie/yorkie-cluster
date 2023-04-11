# Yorkie Cluster Helm Chart

## Getting Started

### Install Yorkie Cluster in minikube

Follow above steps and install yorkie cluster helm chart.

```bash
# 1. clone repository
git clone https://github.com/krapie/yorkie-cluster.git

# 2. change to project directory
cd yorkie-cluster/helm

# 3. start minikube cluster
minikube start

# 4. install ingress addons in minikube
minikube addons enable ingress

# 4. Fetch helm chart dependencies
helm dependency build yorkie-cluster

# 5. Install/Upgrade yorkie cluster helm chart
helm install yorkie-cluster ./yorkie-cluster -n istio-system --create-namespace

# 6. Redeploy istio ingress gateway with auto injecton
kubectl rollout restart deployment istio-ingressgateway -n istio-system

# 7. Append api.yorkie.local to /etc/hosts, if you are using macos, use 127.0.0.1 instead of $(minikube ip)
vi /etc/hosts
$(minikube ip) api.yorkie.local
$(minikube ip) admin.yorkie.local

# 8. Open minikube tunnel
minikube tunnel

# 9. test yorkie api!
const client = new yorkie.Client('http://api.yorkie.local');
```

### Install Yorkie Monitoring in minikube

Follow above steps and install yorkie monitoring helm chart.

```bash
# 1. Fetch helm chart dependencies
helm dependency build yorkie-monitoring

# 2. Install/Upgrade yorkie monitoring helm chart
helm install yorkie-monitoring ./yorkie-monitoring -n monitoring --create-namespace

# 3. Open grafana dashboard
curl http://api.yorkie.local/grafana

# 4. import yorkie grafana dashboard and go process dashboard
curl https://grafana.com/grafana/dashboards/18451
curl https://grafana.com/grafana/dashboards/18452
```

### Install Yorkie ArgoCD in minikube

Follow above steps and install yorkie argocd helm chart.

```bash
# 1. Install/Upgrade yorkie argocd helm chart
helm install yorkie-argocd ./yorkie-argocd -n argocd --create-namespace

# 2. Update admin password
## bcrypt(krapie)=$2a$12$hA1WjWVXcTp8ECYnMzKthuomm0HXvbh8r7FWWtKN8w4ye9CK9Mes6
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$hA1WjWVXcTp8ECYnMzKthuomm0HXvbh8r7FWWtKN8w4ye9CK9Mes6",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
}}'

# 3. Restart argocd-server
kubectl -n argocd get pod --no-headers=true | awk '/argocd-server/{print $1}'| xargs kubectl delete -n argocd pod

# # 3. Open ArgoCD dashboard
curl http://api.yorkie.local/argocd
```

### Unintall helm charts

```bash
# Uninstall yorkie-cluster helm chart
helm uninstall yorkie-cluster -n istio-system

# Uninstall yorkie-monitoring helm chart
helm uninstall yorkie-monitoring -n monitoring

# Uninstall yorkie-argocd helm chart
helm uninstall yorkie-argocd -n argocd
```
