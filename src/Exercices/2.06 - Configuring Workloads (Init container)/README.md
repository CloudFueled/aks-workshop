# 🛰️ Lab 2.06 - Preflight protocols – Init Containers & Sidecar Systems

### **Imperial launch prep: ensuring systems are go**

Before a squadron of TIE Fighters launches, each ship must pass a rigorous **preflight check**—weapons diagnostics, shield harmonization, and telemetry calibration. These checks are completed by specialized support systems before the fighters are even powered up.

In Kubernetes, this sequence is handled by **Init Containers**, which run before the main workload starts. In parallel, **sidecar containers** assist by monitoring or supporting the running system—just like engineering droids deployed alongside the fleet.

In this mission, you’ll enhance the existing **squadron deployment** with:

* An **init container** that performs a simulated preflight system check
* A **sidecar container** that monitors launch readiness

> *"No fighter lifts off without clearance from the engineering bay."* – Fleet Technician D8-R0

---

## 🎯 Mission objectives

Modify your existing `squadron.yaml` manifest to:

* Add an **init container** that writes a preflight status file
* Add a **sidecar container** that tails and logs the file
* Share a volume between all containers
* Perform all steps **declaratively** using manifest files

---

## 🧭 Step-by-step: adding init-containers

1. Open the existing `squadron.yaml` deployment file.

2. Add a shared volume named `preflight-status`.

3. Define an **init container** named `preflight-check` that writes to `/var/preflight/status.txt`

4. Update the existing `tie-fighter` container to mount the volume and serve the file from `/usr/share/nginx/html`

5. Add a **sidecar container** named `telemetry-logger` that tails the file

6. Apply the updated deployment

7. Watch the pod rollout and confirm it waits for the init container

8. Confirm that the sidecar logs the preflight message

---

## 📚 Resources
- [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
- [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/)