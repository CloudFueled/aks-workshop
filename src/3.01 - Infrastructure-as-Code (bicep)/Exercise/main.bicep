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

// MARK: Resources
resource resourceGroupAks 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: aksResourceGroupName
  location: location
  tags: tags
}

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

// TODO: Add User Assigned Managed Identity Module

// TODO: Add Key Vault Resource Group

// TODO: Add Key Vault Module
