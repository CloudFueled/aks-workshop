# 🛰️ Lab 3.06 - Automating Imperial Fleet logistics – GitOps with ArgoCD

### **Imperial Fleet command – GitOps deployment initiative**

Following recent mission-critical oversights—unsynchronized configs, untracked TIE fighter upgrades, and rogue scanner cronjobs—Imperial High Command has enforced full GitOps compliance across all clusters.

From now on, every deployment—from squadrons to surveillance systems—must be **declarative, version-controlled**, and **auto-synced via ArgoCD**.

> _“Victory is achieved not through chaos, but through precision and automation.”_ – Grand Admiral Thrawn

---

## 🎯 Mission objectives

You will:

- Create an **ArgoCD Application** declaratively to track Git-based manifests
- Deploy critical components:

  - `squadron.yaml`
  - `service.yaml`
  - `tie-systems-configmap.yaml`
  - `tie-weapons-secret.yaml`
  - `job.yaml`
  - `cronJob.yaml`

- Ensure changes pushed to Git are automatically synced into the cluster

---

## 🛠️ Step-by-step: enabling GitOps for the Empire

1. Prepare Your Git repository structure

```
clusters/
└── dta/
    └── imperial-fleet/
        └── manifests/
            ├── squadron.yaml
            ├── service.yaml
            ├── tie-systems-configmap.yaml
            ├── tie-weapons-secret.yaml
            ├── job.yaml
            └── cronJob.yaml
        └── application.yaml   # ← ArgoCD Application manifest
```

---

2. Create the ArgoCD Application manifest:

- Make sure the manifests are being deployed in the `empire-outpost-1` **namespace**
- Make sure the server is set to `https://kubernetes.default.svc`
- Set the syncPolicy options to ApplyOutOfSyncOnly=true, ServerSideApply=true and CreateNamespace=true
- Set allowEmpty, prune and selfHeal to true

```yaml
# clusters/dta/imperial-fleet/application.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: squadron
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "https://dev.azure.com/<org-name>/aks-workshop"
    path: clusters/dta/imperial-fleet/manifests
    targetRevision: HEAD
```

3. Apply the Application to ArgoCD

4. Monitor deployment in the ArgoCD UI

## 📚 Resources

- [Argo CD Application](https://argo-cd.readthedocs.io/en/latest/user-guide/application-specification/)
