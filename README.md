# yorkie-cluster

Yorkie cluster design & Docker/Kubernetes implementation

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Instructions](#instructions)
- [Development](#development)
  - [Cluster Modes](#cluster-modes)
  - [Project Structure](#project-structure)
  - [Kubernetes Structure](#kubernetes-structure)
  - [About Yorkie](#about-yorkie)
- [Roadmap](#roadmap)

## Getting Started

If you want to setup and test yorkie cluster,
just clone this repository and follow instructions bellow.

### Prerequisites

- `docker` : Docker system for deploying yorkie cluster in local environment
- `minikube` : Local k8s for deploying yorkie cluster in local environment
- `kubectl` : K8s cli for deploying & testing yorkie cluster

### Instructions

```bash
# 1. clone repository
git clone https://github.com/krapie/yorkie-cluster.git

# 2. change to project directory
cd yorkie-cluster

# 3. start minikube cluster
minikube start

# 4. enable minikube ingress addon
minikube addons enable ingress

# 5. start minikube tunneling for local connection
minikube tunnel

# 6. create yorkie namespace and switch context (optional)
kubectl create namespace yorkie
# kubectl config set-context --current --namespace yorkie

# 7. deploy all minikube manifests in minikube cluster
kubectl apply -f minikube/broadcast-cluster-mode --recursive

# 8. test yorkie api!
const client = new yorkie.Client('http://localhost');
```

For play with more fun stuff,

```bash
# 9. deploy monitoring tools if you want to see metrics
#    (ignore json error, it's grafana json file, not k8s manifest file)
kubectl apply -f monitoring --recursive

# 10. enter grafana web url in your browser
curl http://localhost

# 11. clone dashboard repository for admin dashboard!
#     (change REACT_APP_ADMIN_ADDR to http://localhost)
git clone https://github.com/yorkie-team/dashboard.git

# 12. clone yorkie-tldraw repository for real-time collaboration whiteboard!
#     (change REACT_APP_YORKIE_RPC_ADDR to http://localhost)
git clone https://github.com/krapie/yorkie-tldraw.git
```

## Development

> LookUp Cluster Mode PoC & Prototype implementation is in progress. For more information, follow: [Yorkie LookUp Cluster Mode](./docker/lookup-cluster-mode/yorkie-lookup-cluster-poc-docker/README.md)

### Cluster Modes

There are two cluster modes implemented by docker, kompose, and kubernetes:

- **Broadcast Cluster Mode** : Yorkie cluster mode based on broadcasting & pub/sub & distributed lock. 
For more information about the design, follow this page: [Yorkie Broadcast Cluster Mode](design/broadcast-cluster-mode.md) 
- **LookUp Cluster Mode** : Yorkie cluster mode based on routing & sharding. This cluster mode is in progress
For more information about the design, follow this page: [Yorkie Lookup Cluster Mode](design/lookup-cluster-mode.md)

### Project Structure

Current project structure look like this:

- `docker` : Docker-compose manifests for simple deployment. This folder contains two cluster modes
  - `broadcast-cluster-mode` : Yorkie cluster mode based on broadcasting & pub/sub & distributed lock
  - `lookup-cluster-mode` : Yorkie cluster mode based on routing & sharding
- `kompose` : K8s manifests converted from yorkie docker-compose files
  - `broadcast-cluster-mode` : Yorkie cluster mode based on broadcasting & pub/sub & distributed lock
- `minikube` : K8s manifests for local k8s cluster (minikube)
  - `broadcast-cluster-mode` : Yorkie cluster mode based on broadcasting & pub/sub & distributed lock
    - **_istio & envoy sidecar will be implemented in later updates._**
    - **_for now, istio is not implemented to simplify_**
      **_yorkie cluster architecture in local environment, and also instruction guide_**
- `monitoring` : K8s manifest for monitoring tool (prometheus & grafana)

### Kubernetes Structure

![argocd screenshot](./screenshot/argocd.png)

In current kubernetes(minikube) yorkie cluster, there are:

- `yorkie-ingress` : Ingress (lb, gw) for routing yorkie related services
  - `envoy-service` -> `envoy pod` : Envoy proxy for web connection & routing api, 1 replica exists
    - `yorkie-service` -> `yorkie pods` : Yorkie api server, 3 replica exists
      - `etcd-service` -> `etcd stateful pod` : Etcd for cluster mode, 2 replica exists
      - `mongo-service` -> `mongo stateful pod` : Mongodb for nosql db, 1 replica exists

### About Yorkie

Yorkie is an open source document store for building
collaborative editing applications.
Yorkie uses JSON-like documents(CRDT) with optional types.

Yorkie references

- Yorkie Github: [https://github.com/yorkie-team/yorkie](https://github.com/yorkie-team/yorkie)
- Yorkie Docs: [https://yorkie.dev/](https://yorkie.dev/)

## Roadmap

- [x] Yorkie Broadcast Cluster Mode on minikube (local, simple version)
- [ ] Yorkie Broadcast Cluster Mode on minikube (istio & envoy sidecar)
- [ ] Yorkie Broadcast Cluster Mode on GKE (cloud)
- [ ] Yorkie LookUp Cluster Mode on docker (local)
- [x] Yorkie LookUp Cluster Mode on minikube (local)
- [ ] Yorkie LookUp Cluster Mode on minikube (istio & envoy sidecar)
- [ ] Yorkie LookUp Cluster Mode on AWS (cloud)
