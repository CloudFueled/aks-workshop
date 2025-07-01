# 🛰️ Lab 3.06 - Automating Imperial Fleet logistics – GitOps with ArgoCD

### **Imperial Fleet command – GitOps deployment initiative**

Following recent mission-critical oversights—unsynchronized configs, untracked TIE fighter upgrades, and rogue scanner cronjobs—Imperial High Command has enforced full GitOps compliance across all clusters.

From now on, every deployment—from squadrons to surveillance systems—must be **declarative, version-controlled**, and **auto-synced via ArgoCD**.

> *“Victory is achieved not through chaos, but through precision and automation.”* – Grand Admiral Thrawn

---

## 🎯 Mission objectives

You will:

* Create an **ArgoCD Application** declaratively to track Git-based manifests
* Deploy critical components:

  * `squadron.yaml`
  * `service.yaml`
  * `tie-systems-configmap.yaml`
  * `tie-weapons-secret.yaml`
  * `job.yaml`
  * `cronJob.yaml`
* Ensure changes pushed to Git are automatically synced into the cluster

---

## 🛠️ Step-by-step: enabling GitOps for the Empire

01. Prepare Your GitOps repository structure

```
clusters/
└── dta/
    └── apps/
        └── imperial-fleet/
            ├── applications/
            │   └── application.yaml                # ArgoCD Application manifest
            └── tie-squadron/
                ├── base/
                │   ├── kustomization.yaml
                │   ├── squadron.yaml
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

02. Create the ArgoCD Application manifest
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

03. Apply the Application to ArgoCD

04. Monitor deployment in the ArgoCD UI