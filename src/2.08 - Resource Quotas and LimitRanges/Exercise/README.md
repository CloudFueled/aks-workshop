# 🛰️ Lab 2.08 - Imperial resource allocation – Quotas and Limits

### **Sector resource management protocol – preventing overconsumption**

With the rapid expansion of the Imperial fleet, resource contention across starbases has become a critical concern. Unchecked deployments have caused CPU spikes, memory thrashing, and even caused downtime in outer rim sectors.

To preserve **galactic efficiency and operational stability**, Moff Jerjerrod has ordered strict **resource quotas and usage limits** across all new mission namespaces. No squadron may consume more than its allocated share of CPU, memory, or pod count—**regardless of rank.**

> _"Every TIE consumes fuel and bandwidth. Discipline begins with limits."_ – Moff Jerjerrod

---

## 🎯 Mission objectives

You will:

1. Create a **new namespace** for the `delta-squadron`.
2. Apply a **ResourceQuota** that:

   - Limits the total number of pods
   - Caps total CPU and memory requests across the namespace

3. Define a **LimitRange** that:

   - Sets **default CPU/memory requests and limits** for any container

4. Deploy a pod and confirm that defaults are applied and limits are enforced.

---

## 🧭 Step-by-step: Enforcing Galactic Resource Discipline

### ⚙️ Phase I: create the Namespace

### ⚙️ Phase II: apply the ResourceQuota

Create a manifest named `resource-quota.yaml`

---

### ⚙️ Phase III: apply the LimitRange

Create a manifest named `limit-range.yaml`

---

### ⚙️ Phase IV: Deploy a Test Pod

Create a pod manifest `test-pod.yaml` **without resource requests or limits**
Name it `delta-tie` and place it in the `delta-squadron` namespace.

Then check the default values applied:

```bash
kubectl get pod delta-tie -n delta-squadron -o jsonpath="{.spec.containers[*].resources}"
```

You should see the default CPU/memory requests and limits from the `LimitRange`.

---

### ⚙️ Phase V: Try to Break the Rules

Attempt to create 6 pods or request more than 1Gi memory—Kubernetes will **deny** the request based on the quota.

---

## 📚 Resources

- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
