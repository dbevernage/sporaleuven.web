// Deploys the ALM (Application Lifecycle Management) infrastructure for Spora Leuven:
// a dedicated resource group and a User-Assigned Managed Identity, using Azure Verified Modules (AVM).
targetScope = 'subscription'

@description('Azure region for all resources.')
param location string = 'belgiumcentral'

@description('Name of the ALM resource group.')
param resourceGroupName string = 'rg-spora-web-alm-prd-bec'

@description('Name of the User-Assigned Managed Identity.')
param managedIdentityName string = 'id-spora-web-alm-prd-bec'

@description('Name of the resource group the Managed Identity is granted Contributor access to.')
param targetResourceGroupName string = 'rg-spora-web-prd-bec'

@description('Built-in "Contributor" role definition ID.')
var contributorRoleDefinitionId = 'b24988ac-6180-42a0-ab88-20f7382dd24c'

module resourceGroupDeployment 'resourceGroup.bicep' = {
  name: 'deploy-resource-group-alm'
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}

module managedIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.4.1' = {
  name: 'deploy-managed-identity'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: managedIdentityName
    location: location
  }
  dependsOn: [
    resourceGroupDeployment
  ]
}

// Grants the Managed Identity Contributor access on the target resource group.
resource contributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, targetResourceGroupName, managedIdentityName, contributorRoleDefinitionId)
  scope: resourceGroup(targetResourceGroupName)
  properties: {
    principalId: managedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', contributorRoleDefinitionId)
  }
}

@description('Name of the resource group that was created.')
output resourceGroupName string = resourceGroupName

@description('Name of the User-Assigned Managed Identity that was created.')
output managedIdentityName string = managedIdentityName

@description('Resource ID of the User-Assigned Managed Identity.')
output managedIdentityResourceId string = managedIdentity.outputs.resourceId

@description('Client ID of the User-Assigned Managed Identity (used for OIDC/federated credentials).')
output managedIdentityClientId string = managedIdentity.outputs.clientId

@description('Principal ID (Object ID) of the User-Assigned Managed Identity.')
output managedIdentityPrincipalId string = managedIdentity.outputs.principalId
