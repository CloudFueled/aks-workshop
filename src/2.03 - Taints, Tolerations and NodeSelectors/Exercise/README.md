# 🛰️ Lab 2.03 – Reinforced Deployment protocol

## **Taints, Tolerations, Node Selectors & Anti-Affinity**

### 🛡️ _Imperial Defense Grid: Post-Endor Isolation Protocol_

Following the catastrophic oversight on the original Star Destroyer, the Empire is rolling out **enhanced pod scheduling policies** to lock down its most critical nodes.

To defend the newly-commissioned Star Destroyer node from unauthorized access—and prevent TIE Fighters from clustering and risking simultaneous failure—you’ll use:

- 🛑 **Taints** to repel unauthorized pods
- 🎯 **Node selectors** for Imperial allegiance
- 🛡️ **Tolerations** for privileged scheduling
- 🧩 **Anti-affinity rules** to distribute TIE fighters safely across Star Destroyer sectors

> _"We will not suffer another flaw in our station’s design. Isolation and alignment ensure control."_ – Director Krennic

---

## 🎯 Mission objectives

Secure the new **Star Destroyer node** by:

- Labeling it with Imperial allegiance (alliance=Empire)
- Applying a **taint** to prevent unauthorized access (access=restricted:NoSchedule)
- Updating the **TIE squadron Deployment** with:

  - Toleration for the node’s taint
  - Node selector for allegiance
  - Pod anti-affinity to prevent TIE Fighters from clustering

- Testing that a **Rebel craft** (e.g., X-wing) is denied access

---

## 🧭 Step-by-step: securing the station

### ⚙️ Phase I: fortify the Star Destroyer Node

1. **Add an extra nodepool**

Find out how to add labels and taints to the nodepool
Tip: check the resources section below.

```bash
export RESOURCE_GROUP="rg-imperial-outpost"
export CLUSTER_NAME="aks-imperial-core"
export NODE_SIZE="Standard_E4ads_v6"
```

```bash
az aks nodepool add \
  --resource-group $RESOURCE_GROUP \
  --cluster-name $CLUSTER_NAME \
  --name destroyer \
  --node-count 3 \
  --node-vm-size $NODE_SIZE \
  --node-osdisk-type Ephemeral \
  --node-osdisk-size 64 \
  --mode User
```

---

### ⚙️ Phase II: configure authorized TIE Fighter Deployment

2. **Modify your `squadron.yaml`**

Ensure the Deployment has:

- A **node selector** to land only on Empire-aligned nodes
- A **toleration** for the restricted Star Destroyer access
- A **pod anti-affinity rule** to spread fighters across nodes

---

### ⚙️ Phase III: launch the Squadron

3. **Apply your deployment**

```bash
kubectl apply -f squadron.yaml
```

4. **Verify pod placement**

```bash
kubectl get pods -o wide
```

✅ Ensure that pods:

- Run **only on the Star Destroyer node**
- Are distributed across nodes (if multiple Star Destroyer nodes exist)
- Respect the anti-affinity rule

---

### ⚙️ Phase IV: test Rebel infiltration

5. **Attempt to deploy a Rebel craft**

Create a pod with no toleration or node selector.

⛔ This pod should remain **unscheduled** due to the taint on the Star Destroyer.

---

## 📚 Resources

- [Az CLI](https://learn.microsoft.com/en-us/cli/azure/aks/nodepool?view=azure-cli-latest#az-aks-nodepool-add)
- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
- [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Pod Affinity and Anti-Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity)
