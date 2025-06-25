# 🌌 Lab 1.02 - Launching A Patrol Tiefighter - Pods

**Welcome to Kubernetes, the Galaxy Far Away!**

You are an officer of the Galactic Empire, stationed aboard a Star Destroyer patrolling the Mid Rim. Rebel activity has been detected in the sector, and the Emperor demands swift and decisive action.

Your directive is clear: deploy a TIE fighter to patrol this quadrant and report any signs of insurgence. This isn’t just any starfighter—this is a tightly-contained combat unit, lightweight and fast, designed to launch instantly and operate autonomously in the void.

> _“Peace is a lie. There is only Kubernetes.”_ – Modified Sith Code, DevOps Division

---

## 🎯 Mission objective

Your task as an Imperial deployment officer:

- Connect to your sector’s Kubernetes cluster using `kubectl`
- Define a pod manifest (your official Imperial launch orders)
- Launch a single pod—a TIE fighter unit—into the cluster
- Monitor its operational status and confirm successful patrol readiness

---

## 🧭 Step-by-step: deploying a TIE Fighter

1. **Define the `Pod` manifest**

   Create a YAML file (e.g., `tie-fighter.yaml`) that describes your TIE fighter pod—its metadata, container image (`nginx`), and any configuration needed for launch. This file serves as your flight authorization form.

2. **Apply the Pod manifest to the cluster**

   Use the command console to transmit the launch order to the Kubernetes control center

3. **Verify the Pod is airborne**

   Confirm that the TIE fighter has successfully launched and is patrolling the designated sector

---

## 📚 Resources

- [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
