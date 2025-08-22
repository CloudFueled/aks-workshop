// MARK: Target Scope
targetScope = 'subscription'

// MARK: Parameters
// MARK: Global Parameters
param location string
param tags object

// MARK: Variables
param keyVaultResourceGroupName string
param keyVaultName string

// MARK: Database Parameters
@description('The Sku Name for the Database.')
param databaseSkuName string

@description('The Sku Tier for the Database.')
@allowed([
  'Burstable'
  'GeneralPurpose'
  'MemoryOptimized'
])
param databaseSkuTier string
param databaseResourceGroupName string
param databaseName string
param administratorLogin string

// MARK: Resources

// MARK: Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2025-04-01' existing = {
  name: keyVaultName
  scope: resourceGroup(keyVaultResourceGroupName)
}

// MARK: Database Resources
// MARK: Resource Group
resource resourceGroupDb 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: databaseResourceGroupName
  location: location
  tags: tags
}

// MARK: PostgreSQL Flexible Server Module
module database 'modules/database.bicep' = {
  name: databaseName
  scope: resourceGroupDb
  params: {
    location: location
    dbName: databaseName
    administratorLogin: administratorLogin
    administratorLoginPassword: keyVault.getSecret('dbAdminPassword')
    skuName: databaseSkuName
    skuTier: databaseSkuTier
    tags: tags
  }
}
