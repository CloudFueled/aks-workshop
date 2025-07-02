# 🧭 Lab 3.08 – ArgoCD Projects: Jedi vs. Sith sector isolation

### **Imperial GitOps protocol – dual-faction enforcement**

The Force must remain in balance — even within GitOps.

With star systems aligned to either the Jedi Council or the Sith Order, a new protocol has been enacted to **segregate deployments** using **ArgoCD Projects**. This ensures each faction maintains autonomy, security, and operational integrity within their own galactic domains.

> *“A Jedi does not deploy into Sith territory... unless he's debugging.”* – Master Windu

> *“You control deployments by controlling the Project. That is the way of the Sith.”* – Darth Sidious

---

## 🎯 Mission objectives

You will:

* Create **two ArgoCD Projects**: `jedi-project` and `sith-project`
* Define **source and destination boundaries** per project
* Limit **sync windows** for both
* Update the **ArgoCD Application manifests** from:

  * **Lab 3.07** (e.g. `x-wing-squadron`) to use `jedi-project`
  * **Lab 3.06** (e.g. `tie-squadron`) to use `sith-project`

---

## 🛠️ Step-by-step: Defining the Projects

1. Create `jedi-project`

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: jedi-project
  namespace: argocd
spec:
  description: GitOps project for the Jedi deployments
  sourceRepos:
    - https://github.com/empire/gitops-repo.git
  destinations:
    - namespace: dev-rebel-fleet
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  syncWindows:
    - kind: allow
      schedule: "0 20 * * *" # 8PM
      duration: 12h
      timeZone: UTC
```

---

2. Create `sith-project` using the following specs:

- name: `sith-project`
- destination namespace: `dev-imperial-fleet`
- destination server: `https://kubernetes.default.svc`
- the sync window schedule should start at `8AM`
- the sync window duration should be `12 hours`
- the sync window time zone should be `UTC`

3. Apply Both Projects

4. Update Application from **Lab 3.07** (Jedi) to be part of the jedi-project

5. Update Application from **Lab 3.06** (Sith) to be part of the sith-project

6. Update the image tag from the deployment in the tie-squadron `Deployment` to `1.28.0`

7. Update the targetRevision in the x-wing-squadron application manifest to `18.2.3`

---

7. Push Changes and Validate

Then in the **ArgoCD UI**:

* Confirm each app is assigned to the correct project
* Try syncing during and outside of the allowed window
* Observe access violations if misaligned with namespace/project rules