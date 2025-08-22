// MARK: Usings
using '../main.bicep'

// MARK: Global
param location = 'francecentral'
param tags = {
  Environment: 'Imperial Outpost'
  Owner: 'Darth Vader'
  Purpose: 'Training and Operations'
  ManagedWith: 'Bicep'
}

// MARK: AKS Parameters
param aksResourceGroupName = 'rg-deathstar-aks-midsector'
param clusterName = 'aks-imperial-outpost'
param systemNodeVmSize = 'Standard_D4ads_v6'
param userNodeVmSize = 'Standard_D4ads_v6'
param minCount = 1
param maxCount = 5
param systemNodeCount = 1
param userNodeCount = 1
param osDiskSizeGB = 64
param podCidr = '172.16.0.0/16'

// MARK: Managed Identity Parameters
param managedIdentityName = 'id-eso-${clusterName}'
param federatedCredentialName = 'external-secrets'
param subject = 'system:serviceaccount:external-secrets:sa-external-secrets'

// MARK: Key Vault
param keyVaultResourceGroupName = 'rg-deathstar-archive-midsector'
param keyVaultName = 'kv-deathstar-unique01' // Change this to a unique name
param keyVaultSkuName = 'standard'
param roleAssignment = {
  principalId: '2a17465b-d754-4033-bda9-2e3f0a918e72' // Your Azure AD User Object ID
  principalType: 'User'
  roleDefinitionId: '00482a5a-887f-4fb3-b363-3b7fe8e74483' // Key Vault Administrator
}
