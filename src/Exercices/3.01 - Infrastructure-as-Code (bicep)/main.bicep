// MARK: Target Scope
targetScope = 'subscription'

// MARK: Parameters
// MARK: Global Parameters
param location string

// MARK: AKS Parameters
param resourceGroupName string
param clusterName string

// MARK: Resources
// MARK: AKS Resources
resource resourceGroupAks 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}

// MARK: AKS Cluster
module aks 'modules/aks.bicep' = {
  scope: resourceGroupAks
  params: {
    clusterName: clusterName
  }
}

// MARK: Key Vault Resources
// TODO: Add Key Vault Resource Group

// TODO: Add Key Vault

// TODO: Add Key Vault Secret
