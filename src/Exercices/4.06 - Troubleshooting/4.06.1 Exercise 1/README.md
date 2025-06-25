# 🧰 3.07.2. Troubleshooting Drill - Network Policy Issues

## 🎯 Scenario

You are deploying a microservice in a hardened cluster that uses Cilium for network security. You've defined a CiliumNetworkPolicy to allow traffic between your app and its backend, and everything seems correct.
You must debug the Cilium policy and identify what’s missing. The mission depends on successful service discovery.

---

## 🧭 Step-by-step: Deploying Cilium Sector Shields

1. Apply the Manifests
2. Verify It Can Reach External Sites
3. Troubleshoot

---

## 🏁 Completion Checklist

* [ ] Diagnosed CiliumNetworkPolicy blocking DNS
* [ ] Inspected dropped egress traffic
* [ ] Added proper DNS rules to the policy
* [ ] Verified successful resolution and connectivity