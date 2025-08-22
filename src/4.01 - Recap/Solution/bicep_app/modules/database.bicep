// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
@description('The location for the Postgres DB.')
param location string

@description('The Name for the Postgres DB.')
param dbName string

@description('The administrator login for the Postgres DB.')
param administratorLogin string

@description('The administrator login password for the Postgres DB.')
@secure()
param administratorLoginPassword string

@description('The SKU Tier for the Postgres DB.')
@allowed([
  'Burstable'
  'GeneralPurpose'
  'MemoryOptimized'
])
param skuTier string

@description('The SKU Name for the Postgres DB.')
param skuName string

param tags object

// MARK: Resources
// MARK: PostgreSQL Flexible Server
resource db 'Microsoft.DBforPostgreSQL/flexibleServers@2025-01-01-preview' = {
  name: dbName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    authConfig: {
      activeDirectoryAuth: 'Enabled'
      passwordAuth: 'Enabled'
      tenantId: tenant().tenantId
    }
    network: {
      publicNetworkAccess: 'Enabled'
    }
    version: '15'
    storage: {
      storageSizeGB: 32
      iops: 120
      autoGrow: 'Enabled'
      tier: 'P4'
    }
  }
  sku: {
    name: skuName
    tier: skuTier
  }
  tags: tags
}

// MARK: Outputs
