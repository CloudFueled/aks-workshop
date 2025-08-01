// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
param location string
param name string
param tags object
param federatedCredentialName string
param issuer string
param subject string

// MARK: Resources
resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  location: location
  name: name
  tags: tags
}

resource federatedCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2025-01-31-preview' = {
  parent: identity
  name: federatedCredentialName
  properties: {
    audiences: [
      'api://AzureADTokenExchange'
    ]
    issuer: issuer
    subject: subject
  }
}

// MARK: Outputs
output identityId string = identity.id
output identityName string = identity.name
output identityPrincipalId string = identity.properties.principalId
output identityClientId string = identity.properties.clientId
