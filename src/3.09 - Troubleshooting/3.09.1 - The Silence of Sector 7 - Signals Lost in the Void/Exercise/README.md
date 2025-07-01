# 🧰 Lab 3.09.1 - The Silence of Sector 7: Signals Lost in the Void

## 🎯 Scenario

You’re deploying a backend service along with a Deployment of pods that handle key functionality. You've written both manifests, applied them, and waited for everything to settle.
But something’s wrong—your service isn't responding, and no traffic seems to reach the pods. You check the pods—they’re running. The service exists. Still, no connections get through.

---

## 🧭 Step-by-step

1. Apply the Manifests
2. Verify the Service is routing traffic
3. Troubleshoot

---

## 🏁 Completion checklist

- [ ] Identified that the service had no endpoints
- [ ] Verified pod labels
- [ ] Corrected the service selector
- [ ] Confirmed traffic routing success via `curl`
