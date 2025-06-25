# 🌌 Lab 1.04 - Establishing Communication - Services

The squadron is in flight and patrolling the sector. But with rebel forces actively engaging across multiple fronts, static deployment is no longer sufficient. High Command needs real-time communication to issue orders, adjust formations, and respond to threats as they evolve.

Your mission: **establish a secure communication channel to the TIE fighter squadron**. This will allow Imperial command centers—or other systems—to interact with the deployed units via a stable network endpoint.

In Kubernetes, this means **exposing your Deployment** using a **Service**.

> _“Without control, there is chaos. With Service, there is command.”_ – Grand Admiral Thrawn

---

## 🎯 Mission objectives

- Create a **Kubernetes Service** to expose your squadron Deployment
- Choose the appropriate service type (`ClusterIP`, `NodePort`, or `LoadBalancer`) based on operational needs
- Test connectivity to the squadron through the new communication channel

## 🧭 Step-by-step: establishing communications with the Squadron

### ⚙️ Phase I: internal comms – ClusterIP + port forwarding

1. **Create a ClusterIP `Service` manifest**
   <br />
   Define a YAML file named `service.yaml` that specifies a `ClusterIP` service to expose your Deployment internally. For example:

2. **Apply the ClusterIP Service**
   <br />
   Transmit the initial comm relay to the cluster

3. **Verify the Service**
   <br />
   Confirm that the internal relay is active

4. **Establish communication via port forwarding**
   Temporarily forward traffic from your machine to the service using:
   ```bash
   kubectl port-forward service/tie-squadron 8080:80
   curl http://localhost:8080
   ```

This simulates direct command relaying from an internal Imperial system.

---

### ⚙️ Phase II: Sector-Wide Comms – Upgrade to LoadBalancer

5. **Update the Service to LoadBalancer**
   Edit your existing service file or use the command line to change its type to `LoadBalancer`, making it accessible from outside the cluster (within your network)

Change:

```yaml
type: ClusterIP
```

to:

```yaml
type: LoadBalancer
```

Save and exit.

7. **Test external access to the LoadBalancer**

---

## 📚 Resources

- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
