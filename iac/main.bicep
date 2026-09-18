// Deploys the Azure infrastructure for the Spora Leuven website: a dedicated resource group,
// an App Service Plan, an App Service, and a Static Web App, using Azure Verified Modules (AVM).
targetScope = 'resourceGroup'

@description('Default Azure region for all resources.')
param location string = 'westeurope'

@description('Alt. Azure region for Application Insights.')
param locationAI string = 'westeurope'

@description('Name of the dedicated resource group.')
param resourceGroupName string = 'rg-spora-web-prd-bec'

@description('Name of the App Service Plan.')
param appServicePlanName string = 'asp-spora-web-prd-bec'

@description('Name of the App Service (must be globally unique).')
param appServiceName string = 'app-spora-web-prd-bec'

@description('App Service Plan SKU name (e.g. B1, S1, P1v3).')
param skuName string = 'B1'

@description('App Service Plan instance count.')
param skuCapacity int = 1

@description('Name of the Log Analytics workspace backing Application Insights.')
param logAnalyticsWorkspaceName string = 'log-spora-web-prd-bec'

@description('Name of the Application Insights instance.')
param applicationInsightsName string = 'appi-spora-web-prd-bec'

@description('Azure region for the Static Web App.')
param staticWebAppLocation string = 'westeurope'

@description('Name of the Static Web App.')
param staticWebAppName string = 'stapp-spora-web-prd-bec'

@allowed([
  'Free'
  'Standard'
])
@description('Static Web App SKU.')
param staticWebAppSku string = 'Free'

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

module logAnalyticsWorkspace 'br/public:avm/res/operational-insights/workspace:0.16.0' = {
  name: 'deploy-log-analytics-workspace'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: logAnalyticsWorkspaceName
    location: locationAI
  }
}

module applicationInsights 'br/public:avm/res/insights/component:0.8.0' = {
  name: 'deploy-application-insights'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: applicationInsightsName
    location: locationAI
    kind: 'web'
    applicationType: 'web'
    workspaceResourceId: logAnalyticsWorkspace.outputs.resourceId
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
      APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.outputs.connectionString
      ApplicationInsightsAgent_EXTENSION_VERSION: '~3'
    }
  }
}

module staticWebApp 'br/public:avm/res/web/static-site:0.9.6' = {
  name: 'deploy-static-web-app'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: staticWebAppName
    location: staticWebAppLocation
    sku: staticWebAppSku
  }
}

@description('Default hostname of the deployed App Service.')
output appServiceHostName string = appService.outputs.defaultHostname

@description('Default hostname of the deployed Static Web App.')
output staticWebAppHostName string = staticWebApp.outputs.defaultHostname

@description('Name of the resource group that was created.')
output resourceGroupName string = resourceGroupName

@description('Name of the App Service that was created.')
output appServiceName string = appServiceName

@description('Name of the Static Web App that was created.')
output staticWebAppName string = staticWebApp.outputs.name

@description('Name of the Application Insights instance that was created.')
output applicationInsightsName string = applicationInsights.outputs.name

@secure()
@description('Connection string of the Application Insights instance.')
output applicationInsightsConnectionString string = applicationInsights.outputs.connectionString
