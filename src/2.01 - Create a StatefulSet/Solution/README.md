# 🛰️ Lab 2.01 – Imperial Relays: deploying with StatefulSets

The Galactic Empire’s communication network spans entire star systems. To maintain hyperspace comms between fleets and command, a series of **relay beacons** must be deployed. These must be **uniquely addressable**, maintain **stable storage**, and **preserve identity across reboots and failures**.

Kubernetes **StatefulSets** are now the Empire’s preferred mechanism for such mission-critical systems.

> _“A disrupted beacon can cost us a sector. That’s unacceptable.”_ – Admiral Rae Sloane

---

## 🎯 Mission objectives

You will:

1. Deploy a **StatefulSet** of signal relays that:

   - Use **Nginx** to simulate a beacon process
   - Maintain stable network identities
   - Write access logs to persistent volume
   - Start **in order**, shut down in **reverse order**

2. Expose the StatefulSet via a **Headless Service**

---

## 🧭 Step-by-step: deploy the Beacon Network

### ⚙️ Phase I: create the Headless Service

Create a **headless Service** in the `imperial-net` namespace.

> 📡 This will give each pod a **DNS entry** like:
> `relay-0.relay.imperial-net.svc.cluster.local`

---

### ⚙️ Phase II: define the StatefulSet

> 📁 Each pod writes Nginx logs to `/var/log/nginx`, backed by a unique **PersistentVolumeClaim**.

---

### ⚙️ Phase III: apply and observe

Apply everything:

```bash
kubectl apply -f headless-service.yaml
kubectl apply -f statefulset.yaml
```

Then inspect the pods and logs:

```bash
kubectl get pods -n imperial-net -o wide

kubectl exec -n imperial-net relay-0 -- tail /var/log/nginx/access.log
```

### ✅ Expected Outcomes

- Each pod has a predictable name (`relay-0`, `relay-1`, etc.)
- Each pod has a dedicated PVC
- Logs persist across pod restarts
- Pods **start in order** and **terminate in reverse**

---

## 🧪 Bonus Challenge

1. Scale the StatefulSet to 5 replicas:

   ```bash
   kubectl scale statefulset relay --replicas=5 -n imperial-net
   ```

2. Validate:

   - New pods continue the naming sequence
   - PVCs are automatically created and bound
   - Log files remain intact after pod restarts

---

## ❓ Empire Debrief – Storage Strategy

> **Where is this data stored in Azure? What resource is used for persistent storage?**

**Answer:**

- In Azure Kubernetes Service (AKS), when no `storageClassName` is explicitly defined, the **default StorageClass** is used.
- For most AKS clusters, this StorageClass provisions storage through **Azure Disks**.
- Each `PersistentVolumeClaim` results in a **separate managed disk** (Azure resource type: `Microsoft.Compute/disks`) being created.
- You can find these disks in the same resource group as your node pool or AKS cluster, often named like `kubernetes-dynamic-pvc-xxxxx`.!

## 📚 Resources

- [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
