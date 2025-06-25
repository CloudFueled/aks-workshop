# 🌌 Lab 1.05 - Adding new Weapons and tools to the Tiefighters - ConfigMaps & Secrets

The tide of battle is shifting.

The rebels are evolving—deploying faster ships, jamming signals, and hiding behind cloaking fields. Your TIE fighters, while agile, need upgraded systems to remain effective in the field.

High Command has authorized an upgrade package: **new weapon calibrations and high-frequency scanning protocols**. These enhancements will allow your fleet to detect threats faster and dispatch them with lethal efficiency.

As the officer in charge of deployment configuration, your task is to integrate these upgrades into the squadron **without rebuilding the ships**. In Kubernetes terms, this means using **ConfigMaps** and **Secrets** to inject critical configuration into your pods dynamically.

> *“Victory is built not just on numbers, but on precision. Configuration is control.”* – Director Orson Krennic

---

### 🎯 Mission objectives

* Create a **ConfigMap** for general system upgrades (e.g., scanner range, engine tuning)
* Create a **Secret** to store sensitive data (e.g., targeting algorithms, encryption keys)
* Mount these into the TIE fighter pods as environment variables or configuration files
* Confirm that the pods are reading and using the upgraded systems

---

## 🧭 Step-by-step: upgrading TIE Fighters via ConfigMaps & Secrets (declarative approach)

The Empire values precision and repeatability. All configuration changes must now be made through formal deployment manifests—ensuring traceability and consistency across fleets.*

The Empire is issuing a battlefield upgrade to your deployed TIE squadron. This operation requires you to fit each ship with:

* Enhanced **scanner calibration settings**
* Aggressive **engine tuning parameters**
* Encrypted **targeting AI protocols**
* Secure **fire control keys**

---

### ⚙️ Phase I: define configuration blueprints

1. **Create a ConfigMap**
   Create a manifest file (`tie-systems-configmap.yaml`) containing these **data fields**:

* `SCANNER_MODE`: `infrared`
* `ENGINE_TUNING`: `aggressive`

2. **Create a Secret**
   Create a manifest file (`tie-weapons-secret.yaml`) containing the following **sensitive data**:

* `targetingAI`: `lockdown-mode`
* `fireControlKey`: `Zzhbwkkjikh123`
  (Hint: these values must be base64 encoded)

---

### ⚙️ Phase II: update the deployment to use the new systems

3. **Modify your TIE Fighter Deployment**
   Update your existing `squadron.yaml` so the pods receive the above values via **environment variables**.

The following variable names should be configured in your container spec:

| Env Var            | Source                             |
| ------------------ | ---------------------------------- |
| `SCANNER_MODE`     | From ConfigMap key `SCANNER_MODE`  |
| `ENGINE_TUNING`    | From ConfigMap key `ENGINE_TUNING` |
| `TARGETING_AI`     | From Secret key `targetingAI`      |
| `FIRE_CONTROL_KEY` | From Secret key `fireControlKey`   |
| `LAUNCHING_MOTD`   | From plain text value in manifest  |

---

### ⚙️ Phase III: deploy and verify

4. **Apply the ConfigMap and Secret to the cluster**

5. **Apply the updated Deployment**

6. **Verify configuration inside the Pods**
   Use `kubectl exec` and `printenv` or `cat` to inspect the injected values:

```bash
kubectl get pods
kubectl exec -it <pod-name> -- printenv | grep SCANNER
kubectl exec -it <pod-name> -- printenv | grep FIRE
```

---

## 📚 Resources
- [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)