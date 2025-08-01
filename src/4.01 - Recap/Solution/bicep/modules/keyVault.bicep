// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
@description('The location for the Key Vault.')
param location string

@description('The Name for the Key Vault.')
param keyVaultName string

@description('The SKU Name for the Key Vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string

@description('Role Assignment for the Key Vault.')
param roleAssignments object[]

param tags object

// MARK: Resources

// MARK: Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: skuName
      family: 'A'
    }
    enableRbacAuthorization: true
    tenantId: subscription().tenantId
  }
  tags: tags
}

// MARK: Role Assignments
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for role in roleAssignments: {
    scope: keyVault
    name: guid(role.roleDefinitionId, role.principalId, keyVault.name)
    properties: {
      principalId: role.principalId
      principalType: role.principalType
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', role.roleDefinitionId)
    }
  }
]

// MARK: Outputs
output id string = keyVault.id
output name string = keyVault.name
output location string = keyVault.location
