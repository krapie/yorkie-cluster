# yorkie-cluster

Yorkie cluster design & Docker/Kubernetes implementation

## Table of Contents

- [yorkie-cluster](#yorkie-cluster)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Instructions](#instructions)
  - [Development](#development)
    - [Cluster Modes](#cluster-modes)
    - [Project Structure](#project-structure)
    - [About Yorkie](#about-yorkie)
  - [Roadmap](#roadmap)

## Getting Started

If you want to setup and test yorkie cluster,
just clone this repository and follow instructions bellow.

### Prerequisites

- `docker` : Docker system for deploying yorkie cluster in local environment
- `minikube` : Local k8s for deploying yorkie cluster in local environment
- `kubectl` : K8s CLI for deploying & testing yorkie cluster
- `istioctl` : Istio CLI for istio installation & service mesh
- `helm` : Helm CLI for deploying yorkie cluster helm chart

### Instructions

This instruction builds K8s & Istio based Yorkie lookup cluster mode.

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

## Development

> LookUp Cluster Mode PoC on K8s & Istio is now availiable. For more information, follow: [Yorkie LookUp Cluster Mode](./minikube/lookup-cluster-mode/README.md)

### Cluster Modes

There are two cluster modes implemented by docker, kompose, and kubernetes:

- **Broadcast Cluster Mode** : Yorkie cluster mode based on broadcasting & pub/sub & distributed lock.
  For more information about the design, follow this page: [Yorkie Broadcast Cluster Mode](design/broadcast-cluster-mode.md)
- **LookUp Cluster Mode** : Yorkie cluster mode based on routing & sharding. This cluster mode is in progress
  For more information about the design, follow this page: [Yorkie Lookup Cluster Mode](https://github.com/yorkie-team/yorkie/issues/472)

### Project Structure

Current project structure look like this:

- `docker` : Docker-compose manifests for simple deployment. This folder contains two cluster modes
  - `broadcast-cluster-mode` : Yorkie broadcast cluster mode using docker-compose
  - `lookup-cluster-mode` : Yorkie lookup cluster mode using docker-compose
- `helm` : Helm chart for Yorkie cluster deployment
  - `yorkie-cluster` : Yorkie cluster helm chart
- `kompose` : K8s manifests converted from yorkie docker-compose files
  - `broadcast-cluster-mode` : Yorkie broadcast cluster mode converted from docker-compose
- `minikube` : K8s manifests for local k8s cluster (minikube)
  - `broadcast-cluster-mode` : Yorkie broadcast cluster mode using K8s
  - `lookup-cluster-mode` : Yorkie lookup cluster mode using K8s & Istio
- `monitoring` : K8s manifest for monitoring tool (prometheus & grafana)

### About Yorkie

Yorkie is an open source document store for building
collaborative editing applications.
Yorkie uses JSON-like documents(CRDT) with optional types.

Yorkie references

- Yorkie Github: [https://github.com/yorkie-team/yorkie](https://github.com/yorkie-team/yorkie)
- Yorkie Docs: [https://yorkie.dev/](https://yorkie.dev/)

## Roadmap

- [x] Yorkie Broadcast Cluster Mode on minikube (local, simple version)
- [x] Yorkie LookUp Cluster Mode on docker (local, PoC)
- [x] Yorkie LookUp Cluster Mode on minikube (istio & envoy sidecar, PoC)
- [ ] Yorkie LookUp Cluster Mode on minikube (istio & envoy sidecar)
- [ ] Yorkie LookUp Cluster Mode on AWS (cloud)
