# 🧰 Lab 3.09.1 - The Vault Whispered Nothing: Secrets Lost in Transit

## 🎯 Scenario

You are deploying an app that uses HTTPS and expects a **TLS certificate** to be mounted from a secret generated by **External Secrets Operator**. The certificate is stored in **Azure Key Vault**. You’ve configured everything, but the secret **isn’t getting created**, and your app fails to start due to missing TLS credentials.
You must **debug the ExternalSecret** setup and identify the problems.

---

## 🧭 Step-by-step

1. Apply the Manifests
```bash
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
```

2. Verify the Service Is Routing Traffic
3. Troubleshoot

---

## 🏁 Completion checklist

* [ ] Identified missing or incorrect `SecretStore` name
* [ ] Discovered invalid secret key names in `remoteRef`
* [ ] Corrected and re-tested the ExternalSecret
* [ ] Verified secret was synced successfully