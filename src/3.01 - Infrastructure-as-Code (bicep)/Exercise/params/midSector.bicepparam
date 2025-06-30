// MARK: Usings
using '../main.bicep'

// MARK: Parameters
// MARK: Global Parameters
param location = 'francecentral'

// MARK: AKS Parameters
param clusterName = 'aks-imperial-outpost'
param resourceGroupName = 'rg-imperial-outpost-aks'

param tags = {
  environment: 'imperial-outpost'
  owner: 'Darth Vader'
}
