// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
param clusterName string
param systemNodeVmSize string
param userNodeVmSize string
param minCount int
param maxCount int
param systemNodeCount int
param userNodeCount int
param osDiskSizeGB int
param podCidr string
param tags object

// MARK: Resources
resource aks 'Microsoft.ContainerService/managedClusters@2025-03-02-preview' = {
  name: clusterName
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: '1.31'
    dnsPrefix: clusterName
    enableRBAC: true
    oidcIssuerProfile: {
      enabled: true
    }
    networkProfile: {
      advancedNetworking: {
        enabled: true
        security: {
          advancedNetworkPolicies: 'L7'
          enabled: true
        }
      }
      networkPlugin: 'azure'
      networkDataplane: 'cilium'
      networkPluginMode: 'overlay'
      podCidr: podCidr
    }
    securityProfile: {
      workloadIdentity: {
        enabled: true
      }
    }
    agentPoolProfiles: [
      {
        name: 'systempool'
        count: systemNodeCount
        vmSize: systemNodeVmSize
        osDiskSizeGB: osDiskSizeGB
        type: 'VirtualMachineScaleSets'
        mode: 'System'
        enableAutoScaling: true
        minCount: minCount
        maxCount: maxCount
        osDiskType: 'Managed'
      }
    ]
    apiServerAccessProfile: {
      enablePrivateCluster: false
    }
  }
  tags: tags
}

resource userNodePool 'Microsoft.ContainerService/managedClusters/agentPools@2025-03-01' = {
  parent: aks
  name: 'userpool'
  properties: {
    count: userNodeCount
    vmSize: userNodeVmSize
    mode: 'User'
    osDiskType: 'Ephemeral'
    osDiskSizeGB: osDiskSizeGB
    type: 'VirtualMachineScaleSets'
    tags: tags
  }
}

// MARK: Outputs
output oidcIssuer string = aks.properties.oidcIssuerProfile.issuerURL
