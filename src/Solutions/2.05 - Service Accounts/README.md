# 🛰️ Lab 2.05 - Squadron clearance – Service Accounts in action

### **Imperial clearance protocol: Squadron identity enforcement**

Every deployed TIE Squadron must carry a valid **Imperial clearance code**—without it, they are considered rogue and risk being shot down by friendly fire. These clearance codes are represented in Kubernetes as **Service Accounts**, granting pods their unique identity when interacting with the cluster.

In this operation, you will issue a **custom service account** to the `squadron` deployment to ensure it flies under authorized credentials and can later access secured APIs or mount specific permissions.

> *“A TIE without clearance is a liability. No exceptions.”* – Moff Jerjerrod

---

## 🎯 Mission objectives

You will:

1. Create a **ServiceAccount** for the squadron using a **declarative manifest**.
2. Modify the **`squadron` Deployment manifest** to use this ServiceAccount.
3. Apply the changes and **verify** that the pods are using the correct identity.

All tasks must be completed as **declaratively as possible**—use manifests, not imperative commands.

---

## 🧭 Step-by-step: assigning identity to Imperial units

01. Create the ServiceAccount Manifest

Create a YAML manifest file named `sa-squadron.yaml` with the following content

---

02. Update the Deployment Manifest

Update your existing `squadron.yaml` deployment to include the `serviceAccountName` field

---

03. Verify Pod Identity

Confirm that the squadron pods are using the correct service account

You should see all pods using `sa-squadron`.

---

## 📚 Resources
- [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
- [Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)