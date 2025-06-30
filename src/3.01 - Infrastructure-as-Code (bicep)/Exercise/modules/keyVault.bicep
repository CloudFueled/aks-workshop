// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
@description('The Sku Name for the Key Vault.')
param skuName string

@description('The Sku Name for the Key Vault.')
param kvName string

// MARK: Resources
resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: kvName
  location: resourceGroup().location
  properties: {
    tenantId: subscription().tenantId
    accessPolicies: []
    sku: {
      name: skuName
      family: 'A'
    }
    enableRbacAuthorization: true
  }
}

// MARK: Outputs
