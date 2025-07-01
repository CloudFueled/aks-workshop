# 🧱 Lab 3.01 - Imperial Archives – Infrastructure as Code with Bicep

### **Galactic security protocol – operation Vault Shield**

The loss of the Death Star was catastrophic, not just militarily—but in terms of exposed Imperial secrets. To prevent future breaches, **all sensitive assets must be protected with ironclad policy, encrypted storage, and secure identity boundaries.**

Using **Bicep**, the Empire’s official Infrastructure as Code standard, you are now assigned to build a **resilient and policy-enforced Kubernetes base**, complete with **network controls** and **vaulted secrets**.

> _"Without control, there is chaos. With Bicep and network policy, there is order."_ – Grand Moff Tarkin

---

## 🎯 Mission objectives

You will:

- Extend an existing `main.bicep` file
- Add a **User Assigned Managed Identity** with **Federated Credentials** for secrets integration
- Deploy a **Key Vault** in a dedicated resource group with RBAC
- Store a top-secret value
- Enable **Advanced Container Networking Services (ACNS)** and **L7 Network Policies** on your AKS cluster after provisioning

---

## 🧭 Step-by-step: orders from the Imperial DevSecOps command

1. Create the Azure Key Vault module in the modules folder

2.  Review and Extend the `main.bicep`

Locate the `main.bicep` file and complete the following TODOs:

- Define a **Key Vault Resource Group** in the `main.bicep` file:

  - Define it as a `resource`
  - Use the same location as the AKS cluster

- Define and deploy a **Key Vault** with the modified module. The **name** of the Key Vault **should be unique**.
- Assign yourself to the Key Vault with the `Key Vault Administrator` role
- Make sure the tags are propagated to all resources, including the Key Vault.

3.  Deploy the Resources

First, register the necessary feature for Advanced Networking:

```bash
az feature register --namespace Microsoft.ContainerService --name AdvancedNetworkingL7PolicyPreview
```

Then, ensure you have the latest version of the `aks-preview` extension:

```bash
az extension add --name aks-preview
az extension update --name aks-preview
```

Use the following command to deploy:

```bash
az deployment sub create \
  --location francecentral \
  --template-file main.bicep \
  --name aks-imperial-outpost \
  --parameters params/midSector.bicepparam
```

> 🛰️ _ACNS ensures your cluster enforces advanced network segmentation, crucial for preventing Rebel interference._

4.  Confirm the ACNS Configuration

```bash
az aks show \
  --resource-group rg-imperial-outpost-aks \
  --name aks-imperial-outpost \
  --query networkProfile.advancedNetworking.security
```

You should see:

- `enabled: true`
- `advancedNetworkPolicies: L7`

5. Fetch the credentials to be able to connect to the cluster

```bash
az aks get-credentials \
  --resource-group rg-imperial-outpost-aks \
  --name aks-imperial-outpost
```

6. Manually add a Key Vault secret in the newly created Key Vault

---

## 📚 Resources

- [What is Advanced Container Networking Services](https://learn.microsoft.com/en-us/azure/aks/advanced-container-networking-services-overview?tabs=cilium)
- [Azure Key Vault](https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-bicep)
- [Azure Resource Group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/create-resource-group)
- [Azure Managed Identity](https://learn.microsoft.com/en-us/azure/templates/microsoft.managedidentity/userassignedidentities?pivots=deployment-language-bicep)
