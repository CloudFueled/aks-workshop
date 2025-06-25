# 🛰️ Lab 2.07 - Maintaining Squadron formation – Pod Disruption Budgets

### **Imperial flight stability protocol – preventing tactical downtime**

The Emperor has decreed that TIE Fighter squadrons must **never drop below operational minimum** during node upgrades or maintenance. Losing too many fighters to routine disruptions jeopardizes mission readiness and fleet cohesion.

To enforce this, Imperial engineers are instructed to implement a **Pod Disruption Budget (PDB)** that ensures at least a portion of each TIE squadron remains active at all times—even during voluntary disruptions like node drains or maintenance reboots.

> _"Formation integrity is non-negotiable. Maintain operational readiness at all costs."_ – Admiral Piett

---

## 🎯 Mission objectives

Your mission is to create a disruption policy that **preserves minimum combat readiness** for the `squadron` deployment.

Specifically, you must:

1. Create a **PodDisruptionBudget** named `squadron-pdb` for the `squadron` deployment.
2. Ensure that **at least 2 out of 3 pods** remain available at any given time.
3. Apply the PDB manifest declaratively.
4. Simulate a voluntary disruption using `kubectl drain` and **observe enforcement** of the policy.

---

## 🧭 Step-by-step: maintaining flight readiness

### ⚙️ Phase I: define the PDB

Create a manifest named `squadron-pdb.yaml`

---

### ⚙️ Phase II: simulate a disruption

1. Identify a node with one or more `squadron` pods

2. Attempt to evict a pod or drain the node:

```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

3. Observe that Kubernetes **respects the PDB**, and **will not remove** more than 1 pod.

---

### ⚙️ Phase III: confirm protection

Run:

```bash
kubectl get pdb squadron-pdb
```

You should see output like:

```
NAME            MIN AVAILABLE   ALLOWED DISRUPTIONS   CURRENT   DESIRED   AGE
squadron-pdb    2               1                     3         3         5m
```

This confirms that at most **1 pod may be disrupted** at a time.

---

## 📚 Resources

- [Pod Disruption Budgets](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/)
