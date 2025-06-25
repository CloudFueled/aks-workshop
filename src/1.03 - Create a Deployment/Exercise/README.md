# 🌌 1.03 - Launching A Squadron - Deployments

**The situation in the sector has escalated.**

Rebel incursions have increased. Scattered patrol reports indicate multiple unauthorized jumps through hyperspace lanes and coded transmissions intercepted from nearby moons. One TIE fighter is no longer sufficient to maintain order in the region.

The Imperial High Command has issued a new directive:
Deploy a full squadron of TIE fighters to secure the sector.

This operation will require more than a single pod—it demands a scalable, resilient deployment strategy. You are to utilize the Empire’s Kubernetes Deployment Protocol to coordinate and manage this squadron effectively.

> _“In numbers, there is power. In deployment, there is control.”_ – Grand Moff Tarkin, Kubernetes War Doctrine

---

## 🎯 Mission objective

As an Imperial deployment officer, your orders are to:

- Create a Kubernetes Deployment that launches multiple TIE fighter pods
- Ensure the deployment is declarative, replicable, and self-healing
- Scale the squadron up or down as needed to match the threat level
- Monitor and validate the health and operational readiness of all units

## 🧭 Step-by-step: deploying a TIE Fighter Squadron

1. **Define the `Deployment` manifest**

   Create a YAML file (e.g., `squadron.yaml`) that specifies the desired number of TIE fighter pods, the container image, and basic metadata. This will serve as your Imperial deployment order.

2. **Apply the Deployment to the cluster**

   Use the command console to transmit the launch order to the Kubernetes control center (a.k.a., the Star Destroyer’s command bridge):

3. **Verify the Squadron is airborne**

   Ensure your TIE fighters have launched and are patrolling the sector

4. **Scale the Squadron**

   If Rebel activity intensifies, reinforce your squadron

   ```bash
   kubectl edit deployment webapp
   ```

   This opens the deployment manifest in your default editor (usually `vi` or `nano`).

   🔍 Locate this section:

   ```yaml
   spec:
   replicas: 3
   ```

   ✏️ Change it to:

   ```yaml
   spec:
   replicas: 10
   ```

5. **Observe Pod self-healing in action**

   Terminate a pod manually to simulate battle damage

   ```bash
   kubectl delete po
   ```

---

## 📚 Resources

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
