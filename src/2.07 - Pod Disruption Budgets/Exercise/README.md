# 🛰️ Lab 2.07 - Maintaining Squadron Formation – Pod Disruption Budgets

### **Imperial flight stability protocol – preventing tactical downtime**

The Emperor has decreed that TIE Fighter squadrons must **never drop below operational minimum** during node upgrades or maintenance. Losing too many fighters to routine disruptions jeopardizes mission readiness and fleet cohesion.

To enforce this, Imperial engineers are instructed to implement a **Pod Disruption Budget (PDB)** that ensures at least a portion of each TIE squadron remains active at all times—even during voluntary disruptions like node drains or maintenance reboots.

> _"Formation integrity is non-negotiable. Maintain operational readiness at all costs."_ – Admiral Piett

---

## 🎯 Mission objectives

Your mission is to create a disruption policy that **preserves minimum combat readiness** for the `squadron` deployment.

You must:

1. Create a **PodDisruptionBudget** named `squadron-pdb` for the `squadron` deployment.
2. Ensure that **at least 2 out of 3 pods** remain available at any given time.
3. Apply the PDB manifest declaratively.
4. Simulate a voluntary disruption using `kubectl drain` and **observe enforcement** of the policy.

---

## 🧭 Step-by-step: maintaining flight readiness

### ⚙️ Phase I: define the PDB

Create a manifest named `squadron-pdb.yaml` with the following content:

- `minAvailable: 2`
- `selector.matchLabels.app: squadron`

> This ensures that **at least 2 pods must remain available**, so Kubernetes will only allow 1 pod to be voluntarily disrupted at any time.

Apply it:

---

### ⚙️ Phase II: simulate a disruption

1. Identify a node running one or more `squadron` pods:

```bash
kubectl get pods -l app=squadron -o wide
```

2. Attempt to drain the node:

```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

> ⚠️ You should see that **only one pod can be evicted**. The remaining pods will be protected by the PDB.

3. You can also try deleting two `squadron` pods manually and observe that **only the first will be deleted**; the second will be blocked:

```bash
kubectl delete pod <pod-1>
kubectl delete pod <pod-2>
```

---

### ⚙️ Phase III: confirm protection

Run:

```bash
kubectl get pdb squadron-pdb
```

Expected output:

```
NAME            MIN AVAILABLE   ALLOWED DISRUPTIONS   CURRENT   DESIRED   AGE
squadron-pdb    2               1                     3         3         5m
```

This confirms that the disruption policy is active and enforced. At most **1 pod may be disrupted** at any given time.

---

4. Delete the deployment

```bash
kubectl delete -f squadron.yaml
```

## 📚 Resources

- [Pod Disruption Budgets](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/)
