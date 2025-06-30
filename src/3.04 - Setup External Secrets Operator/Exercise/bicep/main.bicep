// MARK: Target Scope
targetScope = 'subscription'

// MARK: Parameters
// MARK: Global Parameters
param location string

// MARK: AKS Parameters
param clusterName string

// MARK: Key Vault Parameters
@description('The Sku Name for the Key Vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string

@description('The Role Assignment Configuration for the Key Vault.')
param roleAssignment object

@description('The Name of the Key Vault Secret.')
param secretName string

@description('The Value of the Key Vault Secret.')
@secure()
param secretValue string

// MARK: Variables
var aksResourceGroupName = 'rg-deathstar-aks-midsector'
var keyVaultResourceGroupName = 'rg-deathstar-archive-midsector'
var keyVaultName = 'kv-deathstar-mvh'

// MARK: Resources
// MARK: AKS Resources
resource resourceGroupAks 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: aksResourceGroupName
  location: location
  tags: {
    'Created By': 'Bicep'
    Owner: 'Death Star Operations Inc.'
  }
}

// MARK: AKS Cluster
module aks 'modules/aks.bicep' = {
  scope: resourceGroupAks
  params: {
    clusterName: clusterName
  }
}

// MARK: Key Vault Resources
// MARK: Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: keyVaultResourceGroupName
  location: location
  tags: {
    'Created By': 'Bicep'
    Owner: 'Death Star Operations Inc.'
  }
}

// MARK: Key Vault
module keyVault 'modules/keyVault.bicep' = {
  scope: resourceGroup
  params: {
    location: location
    keyVaultName: keyVaultName 
    skuName: skuName
    roleAssignmentConfiguration: roleAssignment
    secretName: secretName
    secretValue: secretValue
  }
}
