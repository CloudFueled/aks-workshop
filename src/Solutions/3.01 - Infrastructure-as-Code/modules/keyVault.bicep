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
param roleAssignmentConfiguration object

@description('The Name of the Key Vault Secret.')
param secretName string

@description('The Value of the Key Vault Secret.')
@secure()
param secretValue string

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
}

// MARK: Role Assignments
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    scope: keyVault
    name: guid(roleAssignmentConfiguration.roleDefinitionId, roleAssignmentConfiguration.principalId, keyVault.name)
    properties: {
      principalId: roleAssignmentConfiguration.principalId
      principalType: roleAssignmentConfiguration.principalType
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignmentConfiguration.roleDefinitionId)
    }
  }

// MARK: Secrets
resource secret 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: keyVault
  name: secretName
  properties: {
    value: secretValue
  }
}

// MARK: Outputs
output id string = keyVault.id
output name string = keyVault.name
output location string = keyVault.location
