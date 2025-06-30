# 🌌 Lab 3.02 – Modularizing the Fleet with Kustomize

### **The Kuat Drive Yards initiative – configuration domination**

The Empire is expanding its fleet production and deployment facilities. Kuat Drive Yards, the core shipbuilding world, has begun using **declarative configuration overlays** to optimize deployments across varying planetary environments — from lava worlds like Mustafar to icy moons like Hoth.

To maintain uniform control and reduce manual misconfiguration by rebel infiltrators, Imperial engineers are now required to **standardize deployments using Kustomize** — a tool that enables **base/overlay configuration management** across different sectors.

> *“You don’t deploy the fleet you want. You deploy the fleet your environment demands.”* – Admiral Thrawn

---

## 🎯 Mission objectives

As a systems officer in DevOps Command, your mission is to:

1. Create a **Kustomization base** for the `squadron` deployment and service.
2. Create **overlays** for:

   * A **staging** environment with 1 replica.
   * A **production** environment with 5 replicas and higher resource limits.
3. Use **Kustomize** to build and apply each overlay independently.
4. Validate that the applied configurations match the environment specs.

---

## 🧭 Step-by-step: building the fleet configs

### 1. 🔧 Establish the Base

Inside `base/squadron/`, define the **deployment** and **service** manifests. Then create a `kustomization.yaml` to include them both.

```yaml
# bases/tie-squadron/kustomization.yaml
resources:
  - squadron.yaml
  - service.yaml
```

---

### 2. 🧪 Create the Staging Overlay

Inside `overlays/staging/`, create:

* A `kustomization.yaml` that points to the base
* A `patch.yaml` that sets `replicas: 1` and adjusts resource limits

```yaml
# overlays/staging/kustomization.yaml
bases:
- ../../bases/tie-squadron
patches:
- patch.yaml
```

```yaml
# overlays/staging/patch.yaml
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
          limits:
            cpu: "200m"
            memory: "128Mi"
```

---

### 3. 🛰️ Create the Production Overlay

Do the same under `overlays/production/` but bump `replicas` to 5 and increase limits.

---

### 4. 🛠️ Apply with Kustomize

From the root directory, deploy each overlay using:

```bash
kubectl apply -k overlays/staging/
kubectl apply -k overlays/production/
```

Use `kubectl get deployment squadron` to confirm the correct `replicas` and configuration.

---

## 📚 Imperial Reference Files

```text
.
├── base/
│   └── squadron/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── kustomization.yaml
├── overlays/
│   ├── staging/
│   │   ├── patch.yaml
│   │   └── kustomization.yaml
│   ├── production/
│   │   ├── patch.yaml
│   │   └── kustomization.yaml
```

---

## 💡 Learn More

* [Declarative Management of Kubernetes Objects Using Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
* [Docs](https://kubectl.docs.kubernetes.io/)