# 🕵️‍♂️ Lab 3.04 – Secrets from the Shadows: Secure Your Pipelines with External Secrets

### **Operation: Shadow Fetch – Protecting Imperial Pipeline Credentials**

The Empire’s DevOps command now mandates all mission-critical credentials—such as Azure DevOps **Personal Access Tokens (PATs)**—must be managed through the **Imperial Archive** (Azure Key Vault), with **no static credentials** stored in Git or clusters.

To enforce this, we’ll use the **External Secrets Operator**, **Workload Identity Federation**, and **ArgoCD integration** to automatically and securely sync your DevOps tokens into your Kubernetes cluster.

> _"Secrets are the currency of control. Let them flow only through sanctioned channels."_ – Moff Gideon, Cybersecurity Division

---

## 🎯 Mission objectives

You will:

1. Create an **Azure DevOps PAT token** and upload it to Azure Key Vault.
2. Provision a **User Assigned Managed Identity (UAMI)** with access to the Key Vault.
3. Configure **Workload Identity Federation** for your Kubernetes service account.
4. Deploy the **External Secrets Operator**.
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
  --vault-name <key-vault-name> \
  --name azdo-pat \
  --value <your-pat-token>
```

---

### ⚙️ Phase II: provision Azure resources with Bicep

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

### ⚙️ Phase III: deploy External Secrets Operator

Install ESO using Helm.
Replace the `client-id` with your UAMI's client ID.

```bash
helm repo add external-secrets https://charts.external-secrets.io

helm install external-secrets external-secrets/external-secrets \
  -n external-secrets \
  --create-namespace \
  --set-string serviceAccount.annotations."azure\.workload\.identity/client-id"="0d6015d9-363b-4806-b76f-1a3aa5bd7eba" \
  --set-string serviceAccount.annotations."azure\.workload\.identity/use"="true" \
  --set-string "serviceAccount.name"="sa-external-secrets"
```

---

### ⚙️ Phase IV: create a ClusterSecretStore

Define a `ClusterSecretStore` to connect to Azure Key Vault using the UAMI via workload identity:

- The name of the ClusterSecretStore should be **imperial-secure-archive**
- The `vaultUrl` should point to your Key Vault URL
- The `tenantId` should be your Microsoft Entra tenant ID
- The `authType` should be set to `WorkloadIdentity`
- The `serviceAccountRef` should point to the `sa-external-secrets` service account in the `external-secrets` namespace

---

### ⚙️ Phase V: create the ExternalSecret for the PAT

Define an `ExternalSecret` to fetch the secret from the Azure Key Vault and make it usable within the cluster.

- The name of the ExternalSecret should be **azdo-pat**
- Reference the `imperial-secure-archive` ClusterSecretStore
- Set the `target` to create a secret named `azdo-pat`
- Use the `data` field to specify the secret key and remote reference

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
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: azdo-repo
  namespace: argocd
spec:
  secretStoreRef:
    name: imperial-secure-archive
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
