// MARK: Usings
using '../main.bicep'

// MARK: Parameters
// MARK: Global Parameters
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
