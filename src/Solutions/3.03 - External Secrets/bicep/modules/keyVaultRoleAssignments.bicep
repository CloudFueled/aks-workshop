// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
@description('The Name of the Key Vault.')
param keyVaultName string

@description('Role Assignment for the Key Vault.')
param roleAssignmentConfiguration object

// MARK: Existing Resources
resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' existing = {
  name: keyVaultName
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
