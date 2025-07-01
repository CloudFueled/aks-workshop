# 🌌 Lab 3.02 – Modularizing the Fleet with Kustomize

### **The Kuat Drive Yards initiative – configuration domination**

The Empire is expanding its fleet production and deployment facilities. Kuat Drive Yards, the core shipbuilding world, has begun using **declarative configuration overlays** to optimize deployments across varying planetary environments — from lava worlds like Mustafar to icy moons like Hoth.

To maintain uniform control and reduce manual misconfiguration by rebel infiltrators, Imperial engineers are now required to **standardize deployments using Kustomize** — a tool that enables **base/overlay configuration management** across different sectors.

> _“You don’t deploy the fleet you want. You deploy the fleet your environment demands.”_ – Admiral Thrawn

---

## 🎯 Mission objectives

As a systems officer in DevOps Command, your mission is to:

1. Create a **Kustomization base** for the `squadron` deployment and service.
2. Create **overlays** for:

   - A **development** environment with 1 replica.
   - An **acceptance** environment with 5 replicas and higher resource limits.

3. Use **Kustomize** to build and apply each overlay independently.
4. Validate that the applied configurations match the environment specs.

---

## 🧭 Step-by-step: building the fleet configs

### 1. 🔧 Establish the Base

Inside `tie-squadron/base/`, define the **Deployment** and **Service** manifests. Then create a `kustomization.yaml` to include them both.

```yaml
# tie-squadron/base/kustomization.yaml
resources:
  - squadron.yaml
  - service.yaml
```

---

### 2. 🧪 Create the Development Overlay

Inside `overlays/dev/`, create:

- A `kustomization.yaml` that points to the base
- A `patch.yaml` that sets `replicas: 1` and adjusts resource limits

```yaml
# overlays/dev/kustomization.yaml
bases:
  - ../../base
patches:
  - patch.yaml
```

```yaml
# overlays/dev/patch.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tie-squadron
spec:
  replicas: 1
  template:
    spec:
      containers:
        - name: tie-fighter
          resources:
            requests:
              cpu: "200m"
              memory: "128Mi"
```

---

### 3. 🛰️ Create the Acceptance Overlay

Do the same under `overlays/acc/` but bump `replicas` to 5 and increase requests.

---

### 4. 🛠️ Apply with Kustomize

From the root directory, deploy each overlay using:

```bash
kubectl apply -k overlays/dev/
kubectl apply -k overlays/acc/
```

Use `kubectl get deployment tie-squadron` to confirm the correct `replicas` and configuration.

---

## 📚 Imperial Reference Files

```text
.
├── tie-squadron/
│   └── base/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── kustomization.yaml
|   └── overlays/
│       └── dev/
│           ├── patch.yaml
│           └── kustomization.yaml
│       └── acc/
│           ├── patch.yaml
│           └── kustomization.yaml
```

---

## 💡 Learn More

- [Declarative Management of Kubernetes Objects Using Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
- [Docs](https://kubectl.docs.kubernetes.io/)
