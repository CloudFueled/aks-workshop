# 🧱 Lab 3.01 - Imperial Archives – Infrastructure as Code with Bicep

### **Galactic security protocol – operation Vault Shield**

The loss of the Death Star was catastrophic, not just militarily—but in terms of exposed Imperial secrets. To prevent future breaches, **all sensitive assets must be protected with ironclad policy, encrypted storage, and secure identity boundaries.**

Using **Bicep**, the Empire’s official Infrastructure as Code standard, you are now assigned to build a **resilient and policy-enforced Kubernetes base**, complete with **network controls** and **vaulted secrets**.

> _"Without control, there is chaos. With Bicep and network policy, there is order."_ – Grand Moff Tarkin

---

## 🎯 Mission objectives

You will:

- Extend an existing `main.bicep` file
- Add a **User Assigned Managed Identity** for secrets integration
- Deploy a **Key Vault** in a dedicated resource group with RBAC
- Store a top-secret value
- Enable **Advanced Container Networking Services (ACNS)** and **L7 Network Policies** on your AKS cluster after provisioning

---

## 🧭 Step-by-step: orders from the Imperial DevSecOps command

1.  Review and Extend the `main.bicep`

Locate the `main.bicep` file and complete the following TODOs:

- Define a **Key Vault Resource Group**
- Deploy a **Key Vault** with RBAC (`enableRbacAuthorization: true`)
- Add a **secret**

2.  Deploy the Resources

Use the following command to deploy:

```bash
az feature register --namespace Microsoft.ContainerService --name AdvancedNetworkingL7PolicyPreview

az extension add --name aks-preview
az extension update --name aks-preview

az deployment sub create \
  --location francecentral \
  --template-file main.bicep \
  --name aks-imperial-outpost \
  --parameters params/midSector.bicepparam
```

3.  Confirm the ACNS Configuration

Check if hubble appears under the workloads tab in the Azure Portal.

---
## 📚 Resources
* [What is Advanced Container Networking Services](https://learn.microsoft.com/en-us/azure/aks/advanced-container-networking-services-overview?tabs=cilium)