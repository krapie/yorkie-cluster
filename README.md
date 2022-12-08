# yorkie-kubernetes

Yorkie cluster on kubernetes

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Instructions](#instructions)
- [Development](#development)
  - [Project Structure](#project-structure)
  - [Minikube Structure](#minikube-structure)
  - [About Yorkie](#about-yorkie)
- [Roadmap](#roadmap)

## Getting Started

If you want to setup and test yorkie cluster on k8s,
just clone this repository and follow instructions bellow.

### Prerequisites

- `minikube` : local k8s for deploying yorkie cluster in local environment
- `kubectl` : k8s cli for deploying & testing yorkie cluster

### Instructions

```bash
# 1. clone repository
git clone https://github.com/Krapi0314/yorkie-kubernetes.git

# 2. change to project directory
cd yorkie-kubernetes

# 3. start minikube cluster
minikube start

# 4. enable minikube ingress addon
minikube addons enable ingress

# 5. start minikube tunneling for local connection
minikube tunnel

# 6. deploy all minikube manifests in minikube cluster
kubectl apply -f minikube --recursive

# 7. test yorkie api!
const client = new yorkie.Client('http://localhost');
```

For play with more fun stuff,

```bash
# 8. deploy monitoring tools if you want to see metrics
#    (ignore json error, it's grafana json file, not k8s manifest file)
kubectl apply -f monitoring --recursive

# 9. enter grafana web url in your browser
curl http://localhost

# 10. clone dashboard repository for admin dashboard!
#     (change REACT_APP_ADMIN_ADDR to http://localhost)
git clone https://github.com/yorkie-team/dashboard.git

# 11. clone yorkie-tldraw repository for real-time collaboration whiteboard!
#     (change REACT_APP_YORKIE_RPC_ADDR to http://localhost)
git clone https://github.com/Krapi0314/yorkie-tldraw.git
```

## Development

### Project Structure

- `kompose` : k8s manifests converted from yorkie docker-compose files
- `minikube` : k8s manifests for local k8s cluster (minikube)
  - **istio & envoy sidecar will be implemented in later updates.**
  - **for now, istio is not implemented to simplify**
    **yorkie cluster architecture in local environment, and also instruction guide**
- `monitoring` : k8s manifest for monitoring tool (prometheus & grafana)

### Minikube Structure

![argocd screenshot](./screenshot/argocd.PNG)

In minikube yorie cluster, there are:

- `yorkie-ingress` : ingress (lb, gw) for routing yorkie related services
  - `envoy-service` -> `envoy pod` : envoy proxy for web connection & routing api, 1 replica exists
    - `yorkie-service` -> `yorkie pods` : yorkie api server, 3 replica exists
      - `etcd-service` -> `etcd stateful pod` : etcd for cluster mode, 1 replica exists
      - `mongo-service` -> `mongo stateful pod` : mongodb for nosql db, 1 replica exists

### About Yorkie

Yorkie is an open source document store for building
collaborative editing applications.
Yorkie uses JSON-like documents(CRDT) with optional types.

Yorkie references

- Yorkie Github: [https://github.com/yorkie-team/yorkie](https://github.com/yorkie-team/yorkie)
- Yorkie Docs: [https://yorkie.dev/](https://yorkie.dev/)

## Roadmap

- [x] yorkie broadcasting cluster mode on minikube (local, simple version)
- [ ] yorkie broadcasting cluster mode on minikube (istio & envoy sidecar)
- [ ] yorkie broadcasting cluster mode on GKE (cloud)
- [ ] yorkie cluster mode (other architectural approach) on minikube (local)
- [ ] yorkie cluster mode (other architectural approach) on GKE (cloud)
