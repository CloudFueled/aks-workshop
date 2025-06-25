# 🛰️ Lab 2.06 - Cleanup protocols – working with Finalizers

### **Imperial data lockdown – preventing premature disposal**

The Empire's data archives are not to be erased lightly. When sensitive telemetry from TIE squadrons is stored in mission logs, it must not be accidentally deleted without clearance from command.

For this reason, a special **finalizer** is applied to critical storage volumes—preventing them from being deleted until the cleanup task is complete or manually authorized.

In this exercise, you’ll simulate the secure deletion protocol by attaching a **finalizer** to a `PersistentVolumeClaim`. You will then attempt to delete it, observe the behavior, and execute a forced cleanup sequence.

> _“No data is purged without command authorization.”_ – Moff Jerjerrod

---

## 🎯 Mission objectives

- Add a **finalizer** to an existing `PersistentVolumeClaim` named `azure-datalog-claim`
- Attempt to delete the PVC and observe the block
- Confirm the PVC is stuck in **terminating**
- Remove the finalizer and force the deletion
- Do it all **declaratively** or using minimal imperative intervention

---

## 🧭 Step-by-step: using Finalizers

1. Inspect the `azure-datalog-claim` PVC

2. Edit the PVC to add a finalizer

3. Attempt to delete the PVC

4. Confirm that the PVC is **stuck in `Terminating`**

5. Remove the finalizer manually by editing the resource in a new terminal

```bash
kubectl get pvc azure-datalog-claim -o json | jq '.metadata.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/default/persistentvolumeclaims/azure-datalog-claim/finalize" -f -
```

> If you don't have `jq` installed, you can also patch the resource manually:

```bash
kubectl patch pvc azure-datalog-claim -p '{"metadata":{"finalizers":[]}}' --type=merge
```

6. Confirm deletion

---

## 📚 Resources

- [Finalizers](https://kubernetes.io/docs/concepts/overview/working-with-objects/finalizers/)
