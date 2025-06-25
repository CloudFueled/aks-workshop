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

- Labeling it with Imperial allegiance
- Applying a **taint** to prevent unauthorized access
- Updating the **TIE squadron Deployment** with:

  - Toleration for the node’s taint
  - Node selector for allegiance
  - Pod anti-affinity to prevent TIE Fighters from clustering

- Testing that a **Rebel craft** (e.g., X-wing) is denied access

---

## 🧭 Step-by-step: securing the station

### ⚙️ Phase I: fortify the Star Destroyer Node

1. **Add an extra nodepool**

```bash
az aks nodepool add \
  --resource-group $RESOURCE_GROUP \
  --cluster-name $CLUSTER_NAME \
  --name destroyer \
  --node-count 1 \
  --node-vm-size $NODE_SIZE \
  --node-osdisk-type Ephemeral \
  --node-osdisk-size 64 \
  --mode User
```

2. **Label the node**

Identify a node to represent the Star Destroyer:

```bash
kubectl label node <stardestroyer-node-name> alliance=Empire
```

3. **Taint the node**

Prevent unauthorized pods from being scheduled:

```bash
kubectl taint node <stardestroyer-node-name> access=restricted:NoSchedule
```

---

### ⚙️ Phase II: configure authorized TIE Fighter Deployment

4. **Modify your `squadron.yaml`**

Ensure the Deployment has:

- A **node selector** to land only on Empire-aligned nodes
- A **toleration** for the restricted Star Destroyer access
- A **pod anti-affinity rule** to spread fighters across nodes

---

### ⚙️ Phase III: launch the Squadron

5. **Apply your deployment**

```bash
kubectl apply -f squadron.yaml
```

6. **Verify pod placement**

```bash
kubectl get pods -o wide
```

✅ Ensure that pods:

- Run **only on the Star Destroyer node**
- Are distributed across nodes (if multiple Star Destroyer nodes exist)
- Respect the anti-affinity rule

---

### ⚙️ Phase IV: test Rebel infiltration

7. **Attempt to deploy a Rebel craft**

Create a pod with no toleration or node selector.

⛔ This pod should remain **unscheduled** due to the taint on the Star Destroyer.

---

### ⚙️ Phase V: Optional – Remove the Taint

```bash
kubectl taint node <stardestroyer-node-name> access=restricted:NoSchedule-
```

Use this to allow general scheduling again (e.g., for rollback or cluster load balancing).

---

## 📚 Resources

- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
- [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Pod Affinity and Anti-Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity)
