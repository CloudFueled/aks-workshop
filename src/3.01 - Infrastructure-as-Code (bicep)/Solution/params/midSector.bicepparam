// MARK: Usings
using '../main.bicep'

// MARK: Global
param location = 'northeurope'

// MARK: AKS Parameters
param clusterName = 'aks-imperial-outpost'

// MARK: Key Vault
param skuName = 'standard'
param roleAssignment = {
  principalId: '3c38f345-972c-41c7-8b56-d345d6a5d10b' // Your Azure AD User Object ID
  principalType: 'User'
  roleDefinitionId: '00482a5a-887f-4fb3-b363-3b7fe8e74483' // Key Vault Administrator
}
param secretName = 'deathstar-plans-encryption-key'
param secretValue = 'Th3s3AreN0tTh3PlansY0uAr3L00kingF0r'
