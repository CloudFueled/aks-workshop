# 🛰️ Lab 3.05 – Initiating fleetwide autopilot – installing Argo CD

### **Imperial automation command – Argo deployment for Continuous Fleet Control**

With the Imperial Starfleet growing at an unprecedented pace, managing deployments across thousands of systems has become infeasible using manual coordination alone. To maintain dominance in every sector, a centralized **autopilot system** must be installed.

This mission introduces the **Argo CD control relay**, which will serve as the Empire’s **GitOps Command Center**, enabling automated fleet rollouts, version tracking, and mission synchronization across clusters in the Outer Rim and beyond.

> _"Let the fleet deploy itself. Your job is to command, not babysit pods."_ – Director Orson Krennic

---

## 🎯 Mission objectives

Your objective is to **establish the Argo CD control system** within the cluster. This will give the Empire the power to declaratively manage deployments via Git repositories—ensuring strategic consistency and zero drift.

You must:

1. Install **Argo CD** into a dedicated `argocd` namespace.
2. Use the **Helm package manager** to install the latest compatible release (v7.x).
3. Apply **critical tolerations** and node selectors to run Argo CD on **system-reserved nodes**.
4. Set **server.insecure=true** to allow unauthenticated access to the Argo CD UI (for lab purposes only).

---

## 🧭 Step-by-step: bringing Argo CD online

### ⚙️ Phase I: install the Argo CD controller

Run the following Helm command to deploy Argo CD:

```bash
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo-cd/argo-cd \
  --version ^7.0.0 \
  --namespace argocd \
  --create-namespace \
  --set configs.params."server\.insecure"=true
```

This command does the following:

- Deploys Argo CD under the namespace `argocd`
- Ensures it can schedule on **system-reserved** nodes
- Applies a toleration for critical workloads
- Enables the **insecure server mode** for simplified access in this lab environment

---

### ⚙️ Phase II: verify the deployment

1. Wait for all Argo CD components to become ready:

```bash
kubectl get pods -n argocd
```

2. Port-forward the Argo CD API server:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

3. Fetch the admin password

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

4. Open your browser and visit: [http://localhost:8080](http://localhost:8080)

> You should see the Argo CD dashboard.

---

## 📚 Resources

- [Argo CD Installation (Helm)](https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/)

- [GitOps with Argo CD](https://argo-cd.readthedocs.io/en/stable/)
