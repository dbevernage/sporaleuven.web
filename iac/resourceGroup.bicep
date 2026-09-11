// Creates the dedicated resource group for the Spora Leuven website resources.
targetScope = 'subscription'

@description('Azure region for the resource group.')
param location string

@description('Name of the resource group.')
param resourceGroupName string

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.1' = {
  name: 'deploy-resource-group'
  params: {
    name: resourceGroupName
    location: location
  }
}

@description('Name of the resource group that was created.')
output resourceGroupName string = resourceGroupName
