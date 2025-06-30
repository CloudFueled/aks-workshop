# 🧭 Lab 3.06 - ArgoCD Project – securing the Fleet with boundaries

### **Imperial GitOps Protocol – sector isolation directive**

The Empire’s GitOps deployment pipeline spans countless star systems. However, without proper segmentation, a single misconfigured application could override another fleet's deployment. To prevent this, the **DevOps Command** has mandated that each unit operates within an isolated **ArgoCD Project**.

Your assignment: define a secure, declarative **ArgoCD Project** that enforces **namespace boundaries**, **source restrictions**, and **cluster-scoped controls** for the `tie-squadron`.

> _“The TIE units must remain in their designated airspace. No more friendly fire deployments.”_ – Admiral Piett

---

## 🎯 Mission objectives

You will:

- Create an **ArgoCD Project** declaratively using a YAML manifest
- Restrict allowed **destination clusters** and **namespaces**
- Limit allowed **Git repositories** to the current GitOps-repository
- Limit the **sync windows** from `5PM to 9AM`

---

## 🛠️ Step-by-step: creating an ArgoCD Repository

1.  Define the ArgoCD Project

2.  Apply the Project to ArgoCD

3.  **Edit your Deployment manifest** in your GitOps repository.
    For example, in your app’s `deployment.yaml`, change the Deployment `name`:

```yaml
metadata:
  name: tie-squadron-app
```

to:

```yaml
metadata:
  name: tie-squadron-app-v2
```

4.  **Commit and push** the change to your GitOps repo:

```bash
git add .
git commit -m "Rename deployment to tie-squadron-app-v2"
git push origin main
```

5.  **Open the ArgoCD UI**, locate the corresponding application, and click **"Sync"** manually.

6.  **Observe the results**:

- Confirm ArgoCD detects the new Deployment name
- Watch the app sync and apply the change in-cluster
