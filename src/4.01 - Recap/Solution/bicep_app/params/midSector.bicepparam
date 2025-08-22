// MARK: Usings
using '../main.bicep'

// MARK: Global
param location = 'francecentral'
param tags = {
  Environment: 'Imperial Outpost'
  Owner: 'Darth Vader'
  Purpose: 'Training and Operations'
  ManagedWith: 'Bicep'
}

// MARK: Key Vault
param keyVaultResourceGroupName = 'rg-deathstar-archive-midsector'
param keyVaultName = 'kv-deathstar-unique01' // Change this to a unique name

// MARK: Database
param databaseResourceGroupName = 'rg-deathstar-archive-midsector'
param databaseName = 'psql-db-midsector-unique01' // Change this to a unique name
param administratorLogin = 'dbadmin'
param databaseSkuName = 'Standard_B1ms'
param databaseSkuTier = 'Burstable'
