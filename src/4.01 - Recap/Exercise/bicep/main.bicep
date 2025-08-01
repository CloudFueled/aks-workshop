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

// MARK: Managed Identity Parameters
param managedIdentityName string
param federatedCredentialName string
param subject string

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

// MARK: User Managed Identity
module managedIdentity 'modules/managedIdentity.bicep' = {
  name: '${managedIdentityName}-deployment'
  scope: resourceGroupAks
  params: {
    location: location
    name: managedIdentityName
    federatedCredentialName: federatedCredentialName
    issuer: aks.outputs.oidcIssuer
    subject: subject
    tags: tags
  }
}

// MARK: Key Vault
module keyVault 'modules/keyVault.bicep' = {
  scope: resourceGroupKv
  params: {
    location: location
    keyVaultName: keyVaultName
    skuName: skuName
    roleAssignments: [
      roleAssignment
      {
        principalId: managedIdentity.outputs.identityPrincipalId
        principalType: 'ServicePrincipal'
        roleDefinitionId: '00482a5a-887f-4fb3-b363-3b7fe8e74483' // Key Vault Administrator
      }
    ]
    tags: tags
  }
}
