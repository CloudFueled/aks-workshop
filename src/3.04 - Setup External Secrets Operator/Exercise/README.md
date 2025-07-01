# 🕵️‍♂️ Lab 3.04 – Secrets from the Shadows: Secure Your Pipelines with External Secrets

### **Operation: Shadow Fetch – Protecting Imperial Pipeline Credentials**

The Empire’s DevOps command now mandates all mission-critical credentials—such as Azure DevOps **Personal Access Tokens (PATs)**—must be managed through the **Imperial Archive** (Azure Key Vault), with **no static credentials** stored in Git or clusters.

To enforce this, we’ll use the **External Secrets Operator**, **Workload Identity Federation**, and **ArgoCD integration** to automatically and securely sync your DevOps tokens into your Kubernetes cluster.

> _"Secrets are the currency of control. Let them flow only through sanctioned channels."_ – Moff Gideon, Cybersecurity Division

---

## 🎯 Mission objectives

You will:

1. Create an **Azure DevOps PAT token** and upload it to Azure Key Vault.
2. Deploy the **External Secrets Operator**.
3. Provision a **User Assigned Managed Identity (UAMI)** with access to the Key Vault.
4. Configure **Workload Identity Federation** for your Kubernetes service account.
5. Set up a **ClusterSecretStore** pointing to Azure Key Vault.
6. Define an **ExternalSecret** that fetches the PAT.
7. Deploy a **pod** that consumes the synced PAT secret.
8. Create an **ArgoCD repository secret** using the synced PAT.

---

## 🛠️ Step-by-step: Securing DevOps Integration with External Secrets

---

### ⚙️ Phase I: create and upload Azure DevOps PAT

1. Generate a PAT from [Azure DevOps](https://dev.azure.com/):

   - Scope: **Code (Read)** and **Service Connections (Read/Write)**
   - Expiry: 30–90 days (for demo purposes)

2. Store the PAT in Azure Key Vault:

```bash
az keyvault secret set \
  --vault-name kv-deathstar-mvh \
  --name azdo-pat \
  --value <your-pat-token>
```

---

### ⚙️ Phase II: deploy External Secrets Operator

Install ESO using Helm.
Replace the `client-id` with your UAMI's client ID.

```bash
helm repo add external-secrets https://charts.external-secrets.io

helm install external-secrets external-secrets/external-secrets \
  -n external-secrets \
  --create-namespace \
  --set-string serviceAccount.annotations."azure\.workload\.identity/client-id"="2802047a-44e1-47f6-94c3-3303202941be" \
  --set-string serviceAccount.annotations."azure\.workload\.identity/use"="true"
```

---

### ⚙️ Phase III: provision Azure resources with Bicep

Use a Bicep template to:

- Define a **User Assigned Managed Identity** module in the modules folder:

  - Use the `Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview` API version
  - Set the `location` to the same as the AKS cluster
  - Use a unique name for the identity
  - Create a federated credential with the following specifications:

    - audience: `api://AzureADTokenExchange`
    - issuer: the oidcIssuerURL from the AKS cluster
    - subject: `system:serviceaccount:external-secrets:sa-external-secrets`


- Assign it **Key Vault Secrets User** role scoped to the vault
- Set up the **federated identity credential** on the UAMI
- Define and deploy an **User Managed Identity** with the created module.
- Assign the Managed Identity to the Key Vault with the `Key Vault Administrator` role
- Make sure the tags are propagated to all resources, including the Key Vault and Managed Identity.

Deploy:

```bash
az deployment sub create \
  --location francecentral \
  --template-file main.bicep \
  --name aks-imperial-outpost \
  --parameters params/midSector.bicepparam
```

---

### ⚙️ Phase IV: create a ClusterSecretStore

Define a `ClusterSecretStore` to connect to Azure Key Vault using the UAMI via workload identity.

---

### ⚙️ Phase V: create the ExternalSecret for the PAT

Define a `ExternalSecret` to fetch the secret from the Azure Key Vault and make it usable within the cluster.

---

### ⚙️ Phase VI: deploy a Pod that uses the PAT

Create a simple pod that reads the `azdo-pat` secret:

```yaml
env:
  - name: AZDO_PAT
    valueFrom:
      secretKeyRef:
        name: azdo-pat
        key: pat
```

Or mount it as a volume.

---

### ⚙️ Phase VII: Use the PAT in ArgoCD Repository Configuration via ExternalSecret

Create a `Namespace` named argocd
Create an `ExternalSecret` that **creates the full ArgoCD repo `Secret`**, including both the username and PAT, directly from Azure Key Vault.

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: azdo-repo
  namespace: argocd
spec:
  secretStoreRef:
    name: azure-kv
    kind: ClusterSecretStore
  target:
    name: azdo-repo
    creationPolicy: Owner
    template:
      metadata:
        labels:
          argocd.argoproj.io/secret-type: repository
      type: Opaque
      data:
        type: git
        url: https://dev.azure.com/<org>/<project>/_git/<repo>
        username: <your-azdo-username>
        password: "{{ .pat }}"
  data:
    - secretKey: pat
      remoteRef:
        key: azdo-pat
        property: pat
```

---

## 📚 Resources

- [ClusterSecretStore](https://external-secrets.io/latest/api/clustersecretstore/)

- [ClusterExternalSecret](https://external-secrets.io/latest/api/clusterexternalsecret/)

- [Repository Credential](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#repository-credentials)
