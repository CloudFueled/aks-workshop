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

3. Create a **headless Service** in the `imperial-net` namespace.

> 📡 This will give each pod a **DNS entry** like:
> `relay-0.relay.imperial-net.svc.cluster.local`

---

### ⚙️ Phase II: define the StatefulSet

Mind the following requirements in the specification:
* Set the CPU resource request to 500m

### ⚙️ Phase III: apply and observe

4. Apply everything:

```bash
kubectl apply -f service.yaml
kubectl apply -f statefulset.yaml
```

5. Copy the index.html file into the container

```bash
kubectl cp index.html relay-0:/usr/share/nginx/html/index.html -n imperial-net
```

** It's possible that you need to do this more than one **

6. Then inspect the pods and index.html file:

```bash
kubectl get pods -n imperial-net -o wide

kubectl exec -n imperial-net relay-0 -- cat /usr/share/nginx/html/index.html
```

7. Delete the pod:
```bash
kubectl delete pod relay-0 -n imperial-net
```

8. When it comes back, check again:
```bash
kubectl exec -n imperial-net relay-0 -- cat /usr/share/nginx/html/index.html
```

9. Check the contents of the site:
```bash
kubectl port-forward -n imperial-net pod/relay-0 8080:80
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
   kubectl scale statefulset relay --replicas=30 -n imperial-net
   ```

2. Validate:

   - New pods continue the naming sequence
   - PVCs are automatically created and bound
   - Log files remain intact after pod restarts

---

## ❓ Empire Debrief – Storage Strategy

> **Where is this data stored in Azure? What resource is used for persistent storage?**
