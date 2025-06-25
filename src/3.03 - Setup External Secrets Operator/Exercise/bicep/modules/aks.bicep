// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
param clusterName string
param systemNodeVmSize string = 'Standard_D4ads_v6'
param userNodeVmSize string = 'Standard_D4ads_v6'
param minCount int = 1
param maxCount int = 5
param systemNodeCount int = 1
param userNodeCount int = 1
param osDiskSizeGB int = 64
param podCidr string = '172.16.0.0/16'

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
}

resource userNodePool 'Microsoft.ContainerService/managedClusters/agentPools@2024-01-01' = {
  parent: aks
  name: 'userpool'
  properties: {
    count: userNodeCount
    vmSize: userNodeVmSize
    mode: 'User'
    osDiskType: 'Ephemeral'
    osDiskSizeGB: osDiskSizeGB
    type: 'VirtualMachineScaleSets'
  }
}
