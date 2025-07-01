// MARK: Target Scope
targetScope = 'subscription'

// MARK: Parameters
// MARK: Global Parameters
param location string
param tags object

// MARK: AKS Parameters
param aksResourceGroupName string
param clusterName string
param systemNodeVmSize string
param userNodeVmSize string
param minCount int
param maxCount int
param systemNodeCount int
param userNodeCount int
param osDiskSizeGB int
param podCidr string

// MARK: Key Vault Parameters
@description('The Sku Name for the Key Vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string

@description('The Role Assignment Configuration for the Key Vault.')
param roleAssignment object

// MARK: Variables
param keyVaultResourceGroupName string
param keyVaultName string

// MARK: Resources
// MARK: AKS Resources
resource resourceGroupAks 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: aksResourceGroupName
  location: location
  tags: tags
}

// MARK: AKS Cluster
module aks 'modules/aks.bicep' = {
  scope: resourceGroupAks
  params: {
    clusterName: clusterName
    systemNodeVmSize: systemNodeVmSize
    userNodeVmSize: userNodeVmSize
    minCount: minCount
    maxCount: maxCount
    systemNodeCount: systemNodeCount
    userNodeCount: userNodeCount
    osDiskSizeGB: osDiskSizeGB
    podCidr: podCidr
    tags: tags
  }
}

// MARK: Key Vault Resources
// MARK: Resource Group
resource resourceGroupKv 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: keyVaultResourceGroupName
  location: location
  tags: tags
}

// TODO: Managed Identity

// MARK: Key Vault
module keyVault 'modules/keyVault.bicep' = {
  scope: resourceGroupKv
  params: {
    location: location
    keyVaultName: keyVaultName
    skuName: skuName
    roleAssignments: [
      roleAssignment
      // TODO: Add role assignment for managed identity
    ]
    tags: tags
  }
}
