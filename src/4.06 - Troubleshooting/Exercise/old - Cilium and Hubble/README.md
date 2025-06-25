# 🧬 16. Containment Protocols – Cilium Network Policies

## Enforcing Sector Isolation with Cilium

The Rebel Alliance has grown increasingly bold—sneaking infiltration droids into our outer systems to disrupt communications and sabotage supply lines. To neutralize this threat, **Cilium-based Containment Protocols** have been deployed in the Imperial cluster.

Using **CiliumNetworkPolicies**, you will enforce **fine-grained identity-aware rules** between pods. These policies offer enhanced control over communication flows and use powerful selectors that align with Imperial classification systems.

> *“Seal off the quadrant. No unauthorized comms, no exceptions.”* – Director Krennic

---

## 🎯 Mission Objective

You will:

1. Deploy two Imperial workloads in the `imperial-net` namespace:

   * `command-center`: The fleet’s control and coordination node (nginx)
   * `supply-droid`: A logistics pod reporting to command (busybox)
2. Deploy a third **unauthorized** pod:

   * `rebel-probe`: Simulates a rogue intruder (busybox)
3. Create a **CiliumNetworkPolicy** that:

   * Allows **only** the `supply-droid` to talk to the `command-center`
   * Blocks all other ingress traffic by default

---

## 🧭 Step-by-step: Deploying Cilium Sector Shields

### ⚙️ Phase I: Set Up the Environment

1. **Create the imperial-net namespace namespace for this scenario.**

2. **Deploy the manifests with appropriate labels**:

* command-center.yml
* supply-droid.yml
* rebel-probe.yml

---

### ⚙️ Phase II: Deploy a Cilium Network Policy

---

### ⚙️ Phase III: Test the Policy

1. **Verify access behavior**:

```bash
# Should succeed
kubectl exec -n imperial-net supply-droid -- wget -qO- command-center

# Should fail
kubectl exec -n imperial-net rebel-probe -- wget -qO- command-center
```

---

### 🛰️ Phase IV: Confirm with Hubble (if installed)

Use Hubble to inspect flows:

```bash
hubble observe --namespace imperial-net --follow
```

## Resources

* https://learn.microsoft.com/en-us/azure/aks/azure-cni-powered-by-cilium