# 🌌 Lab 1.06 - Fleet Logistics – resource Requests & Limits

## Imperial Resource Control Directive

Before any Imperial vessel is cleared for deployment, it must submit a logistics requisition: the number of crew, amount of fuel, food rations, weapons, and other essential resources. This ensures optimal allocation across the fleet and prevents smaller craft—like TIE Fighters—from over-consuming limited station reserves.

In this exercise, you’ll configure **resource requests and limits** for various Imperial vessels within a **Deployment**. These limits are enforced by the Empire to ensure no ship starves others of critical resources—or consumes beyond its rank.

> *“The Empire does not tolerate waste. Every resource is accounted for.”* – Grand Admiral Thrawn

---

## 🎯 Mission objectives

* Define **CPU and memory requests and limits** in your squadron's deployment spec.
* Ensure **TIE Fighters** operate with lightweight resource allocations.
* Create a `star-destroyer` deployment with the necessary specs to reflect its capital-class capacity.
* Observe the behavior of the scheduler when a vessel violates provisioning policy.

---

## 🧭 Step-by-step: configuring Imperial Fleet resource policies

### 🛠️ Step 01: update `squadron.yaml` – TIE Fighters

Edit the existing **`squadron.yaml`** file used to deploy the **TIE squadron**. Update the container spec in the Deployment to include the following:

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "64Mi"
  limits:
    cpu: "200m"
    memory: "128Mi"
```

This ensures the TIE Fighters declare minimal resource usage and cannot exceed their assigned budget.

### 🛠️ Step 02: apply and inspect

* Apply the updated Deployment.
* Check the Deployment and Pods.
* Review the `Limits` and `Requests` sections to verify proper settings.

---

### 🛠️ Step 03: add a Star Destroyer Deployment

* Create a new deployment file called `star-destroyer.yaml` and define a heavier vessel.
* Apply the manifest and confirm the pod is scheduled with its enhanced allocation.

---

### 🛠️ Step 04: try overconsumption – violate Fleet Policy

1. Create a test pod (`rogue-cruiser`) without any resource limits and monitor its usage.
2. Try requesting more than the available node capacity (e.g. 10000m CPU), and observe scheduling behavior.

The pod should either be **evicted**, **throttled**, or **remain pending**, depending on the scenario.

---

## 📚 Resources
- [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)