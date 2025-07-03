# 🛰️ Lab 3.06 - Automating Imperial Fleet logistics – GitOps with ArgoCD

### **Imperial Fleet command – GitOps deployment initiative**

Following recent mission-critical oversights—unsynchronized configs, untracked TIE fighter upgrades, and rogue scanner cronjobs—Imperial High Command has enforced full GitOps compliance across all clusters.

From now on, every deployment—from tie-squadrons to surveillance systems—must be **declarative, version-controlled**, and **auto-synced via ArgoCD**.

> _“Victory is achieved not through chaos, but through precision and automation.”_ – Grand Admiral Thrawn

---

## 🎯 Mission objectives

You will:

- Create an **ArgoCD Application** declaratively to track Git-based manifests
- Deploy critical components:

  - `tie-squadron.yaml`
  - `service.yaml`
  - `tie-systems-configmap.yaml`
  - `tie-weapons-secret.yaml`
  - `job.yaml`
  - `cronJob.yaml`

- Ensure changes pushed to Git are automatically synced into the cluster

---

## 🛠️ Step-by-step: enabling GitOps for the Empire

1.  Prepare Your GitOps repository structure

```
clusters/
└── dta/
    └── apps/
        └── imperial-fleet/
            ├── applications/
            │   └── dev-application.yaml                # ArgoCD Application manifest
            └── tie-squadron/
                ├── base/
                │   ├── kustomization.yaml
                │   ├── tie-squadron.yaml
                │   ├── service.yaml
                │   ├── tie-systems-configmap.yaml
                │   ├── tie-weapons-secret.yaml
                │   ├── job.yaml
                │   └── cronjob.yaml
                └── overlays/
                    ├── dev/
                    │   ├── patch.yaml
                    │   └── kustomization.yaml
                    └── acc/
                        ├── patch.yaml
                        └── kustomization.yaml
```

---

2.  Create the ArgoCD Application manifest

```yaml
# clusters/dta/apps/imperial-fleet/applications/dev-application.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: tie-squadron
  namespace: argocd
spec:
  project: default
  destination:
    namespace: dev-imperial-fleet
    server: https://kubernetes.default.svc
  source:
    repoURL: <repo-url>
    path: clusters/dta/apps/imperial-fleet/tie-squadron/overlays/dev
    targetRevision: HEAD
```

3.  Apply the Application to ArgoCD

4.  Monitor deployment in the ArgoCD UI
