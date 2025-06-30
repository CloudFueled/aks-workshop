# 🛰️ Lab 1.07 - Configuring workloads – Probes

### **TIE Fighter systems check – health probe protocols**

Before any TIE Fighter is cleared for launch, its onboard systems must pass a series of **diagnostic health checks**. These include startup validations, operational heartbeat signals, and service readiness scans from the hangar bay. If a fighter fails any of these checks, it's either **held back**, **rebooted**, or **reassigned for maintenance**.

You’re assigned to implement **Kubernetes probes** to simulate these checks. The Star Destroyer’s control systems (the cluster) must trust that every deployed TIE Fighter (pod) is fully operational before sending it into combat.

> *“No fighter leaves this bay without passing diagnostics. The Emperor commands operational perfection.”* – Commander Igar

---

## 🎯 Mission objectives

Deploy a **TIE Fighter pod** with:

* A **Startup Probe** to simulate pre-launch system initialization
* A **Liveness Probe** to detect internal system failure
* A **Readiness Probe** to confirm it’s mission-ready and able to receive traffic

---

## 🧭 Step-by-step: probe the Fighters

1. Add a `Startup Probe`, `Liveness Probe` and `Readiness Probe` to the `squadron` deployment

2. Deploy the `squadron` deployment with Probes

3. Inspect Probe Status

4. Delete the deployment

```bash
kubectl delete -f squadron.yaml
```

---

## 📚 Resources
- [Configure Liveness, Readiness and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)