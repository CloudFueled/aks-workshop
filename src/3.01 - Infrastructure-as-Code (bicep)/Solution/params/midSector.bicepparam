// MARK: Usings
using '../main.bicep'

// MARK: Global
param location = 'northeurope'
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

// MARK: Key Vault
param keyVaultResourceGroupName = 'rg-deathstar-archive-midsector'
param keyVaultName = 'kv-deathstar-mvh'
param skuName = 'standard'
param roleAssignment = {
  principalId: '3c38f345-972c-41c7-8b56-d345d6a5d10b' // Your Azure AD User Object ID
  principalType: 'User'
  roleDefinitionId: '00482a5a-887f-4fb3-b363-3b7fe8e74483' // Key Vault Administrator
}
