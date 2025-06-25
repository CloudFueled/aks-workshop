# 🚀 Lab 1.00 - Imperial Outpost – Provisioning AKS with Azure CLI

### **Imperial Expansion Order – Outer Rim deployment initiative**

The Emperor has issued a directive: establish a fortified digital outpost in the **Outer Rim** to host the Empire’s next-generation tactical systems. This requires standing up a robust **Kubernetes base** using **Azure Kubernetes Service (AKS)**.

You are assigned as the lead engineer responsible for provisioning the infrastructure—this includes configuring identity, selecting a suitable node profile, and ensuring the cluster is secure and production-ready.

> _“Begin construction immediately. This outpost must be operational before the Rebels regroup.”_ – Darth Vader

---

## 🎯 Mission objective

You will:

1. Use the **Azure CLI** to create a new **AKS cluster**.
2. Configure it with **Workload Identity** for secure identity delegation.
3. Enable **OIDC issuer** and **managed identity**.
4. Deploy into a designated **resource group** and region.

---

## 🧭 Step-by-step: constructing the Imperial AKS Outpost

### 🛠️ Step 01: define the base parameters

Choose and declare:

- Resource Group: `rg-imperial-outpost`
- AKS Cluster Name: `aks-imperial-core`
- Location: `francecentral`
- Node Size: `Standard_D4ads_v6`
- Node Count: `2`
- Enable OIDC issuer and workload identity

```bash
export RESOURCE_GROUP="rg-imperial-outpost"
export CLUSTER_NAME="aks-imperial-core"
export LOCATION="francecentral"
export NODE_SIZE="Standard_D4ads_v6"
```

```bash
# Create the resource group
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION
```

---

### 🛠️ Step 02: deploy the AKS cluster

```bash
az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $CLUSTER_NAME \
  --location $LOCATION \
  --enable-managed-identity \
  --enable-oidc-issuer \
  --node-vm-size $NODE_SIZE \
  --node-count 2 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5 \
  --node-osdisk-size 64 \
  --generate-ssh-keys
```

---

### 🛠️ Step 03: add a high-performance node pool with ephemeral OS disks

Add an extra node pool for workloads needing fast local storage (e.g., CI runners, caching layers):

```bash
az aks nodepool add \
  --resource-group $RESOURCE_GROUP \
  --cluster-name $CLUSTER_NAME \
  --name userpool \
  --node-count 1 \
  --node-vm-size $NODE_SIZE \
  --node-osdisk-type Ephemeral \
  --node-osdisk-size 64 \
  --mode User
```

---

### 🛠️ Step 04: connect to the cluster

```bash
az aks get-credentials \
  --resource-group $RESOURCE_GROUP \
  --name $CLUSTER_NAME
```

Check the cluster status:

```bash
kubectl cluster-info
```

Verify the nodes:

```bash
kubectl get nodes -o wide
```

Check the running pods:

```bash
kubectl get pods -A
```

Check services:

```bash
kubectl get svc -A
```
