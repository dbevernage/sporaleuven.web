// Deploys the Azure infrastructure for the Spora Leuven website: a dedicated resource group,
// an App Service Plan (Linux) and an App Service (Web App), using Azure Verified Modules (AVM).
targetScope = 'resourceGroup'

@description('Azure region for all resources.')
param location string = 'westeurope'

@description('Name of the dedicated resource group.')
param resourceGroupName string = 'rg-spora-leuven-web'

@description('Name of the App Service Plan.')
param appServicePlanName string = 'asp-spora-leuven'

@description('Name of the App Service (must be globally unique).')
param appServiceName string = 'app-spora-leuven'

@description('App Service Plan SKU name (e.g. B1, S1, P1v3).')
param skuName string = 'B1'

@description('App Service Plan instance count.')
param skuCapacity int = 1

//module resourceGroupDeployment 'resourceGroup.bicep' = {
//  name: 'deploy-resource-group'
//  params: {
//    resourceGroupName: resourceGroupName
//    location: location
//  }
//}

module appServicePlan 'br/public:avm/res/web/serverfarm:0.4.1' = {
  name: 'deploy-app-service-plan'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: appServicePlanName
    location: location
    skuName: skuName
    skuCapacity: skuCapacity
    kind: 'linux'
    reserved: true
    zoneRedundant: false
  }
}

module appService 'br/public:avm/res/web/site:0.15.1' = {
  name: 'deploy-app-service'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: appServiceName
    location: location
    kind: 'app,linux'
    serverFarmResourceId: appServicePlan.outputs.resourceId
    siteConfig: {
      linuxFxVersion: 'NODE|26-lts'
      appCommandLine: 'npm start'
    }
    appSettingsKeyValuePairs: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
      WEBSITE_NODE_DEFAULT_VERSION: '~26'
    }
  }
}

@description('Default hostname of the deployed App Service.')
output appServiceHostName string = appService.outputs.defaultHostname

@description('Name of the resource group that was created.')
output resourceGroupName string = resourceGroupName

@description('Name of the App Service that was created.')
output appServiceName string = appServiceName
