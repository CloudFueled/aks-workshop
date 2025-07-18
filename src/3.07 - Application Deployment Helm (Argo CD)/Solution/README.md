# 🧭 Lab 3.07 – Deploying the X-Wing squadron via Helm

### **Rebel GitOps operations – forward base deployment**

The Rebel Alliance is setting up tactical relay points throughout the Mid Rim to support rapid hyperspace jumps and squadron coordination. You’ve been tasked with deploying a secure, configurable **NGINX relay node** using **Helm**, managed declaratively via **ArgoCD**.

To meet mission requirements, you’ll reference a custom `dev-values.yaml` stored in your GitOps repository — ensuring X-Wing squadrons get the precise configuration needed for agile communication.

> _“Without comms, we’re flying blind. Let’s light up the grid.”_ – Commander Antilles

---

## 🎯 Mission objectives

You will:

- Define an **ArgoCD Application** to deploy the **Bitnami NGINX Helm chart**
- Provide a **custom `dev-values.yaml`** file stored in Git
- Deploy to the **`dev-rebel-fleet` namespace**
- Confirm the X-Wing relay is active with the proper config

---

## 🛠️ Step-by-step Instructions

1.  Prepare Your GitOps repository structure

In your Git repository, organize the following structure:

```
clusters/
└── dta/
    └── apps/
        └── rebel-fleet/
            ├── applications/
            │   └── dev-application.yaml                 # ArgoCD Application manifest
            └── x-wing-squadron/
                └── dev-values.yaml
```

2.  Create the ArgoCD `application.yaml`

- The repository URL should be `https://charts.bitnami.com/bitnami/`
- The chart should be `nginx`
- The target revision should be `18.2.4`

3.  Commit and Deploy

4.  Then in ArgoCD:

- Locate the `x-wing-squadron` application
- Click **Sync**
- Wait for it to go Healthy & Synced

5.  Verify

Check pod status and access the service locally:

```bash
kubectl -n dev-rebel-fleet get pods
kubectl -n dev-rebel-fleet port-forward svc/x-wing-squadron-nginx 8081:8080
curl http://localhost:8081
```

---

## 📚 Resources

- [Bitnami Charts](https://charts.bitnami.com/)
- [ArgoCD Helm Support](https://argo-cd.readthedocs.io/en/stable/user-guide/helm/)
