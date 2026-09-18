// Deploys the Azure infrastructure for the Spora Leuven website: a dedicated resource group,
// an App Service Plan, an App Service, and a Static Web App, using Azure Verified Modules (AVM).
targetScope = 'resourceGroup'

@description('Default Azure region for all resources.')
param location string = 'westeurope'

@description('Alternative Azure region for all resources outside of primary region.')
param locationAlt string = 'westeurope'

@description('Name of the dedicated resource group.')
param resourceGroupName string = 'rg-spora-web-prd-bec'

@description('Name of the Log Analytics workspace backing Application Insights.')
param logAnalyticsWorkspaceName string = 'log-spora-web-prd-bec'

@description('Name of the Static Web App.')
param staticWebAppName string = 'stapp-spora-web-prd-bec'

@description('Custom domain for the Static Web App.')
param staticWebAppCustomDomain string = 'sporaleuven.be'

@allowed([
  'Free'
  'Standard'
])
@description('Static Web App SKU.')
param staticWebAppSku string = 'Free'

// module appServicePlan 'br/public:avm/res/web/serverfarm:0.4.1' = {
//   name: 'deploy-app-service-plan'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     name: appServicePlanName
//     location: location
//     skuName: skuName
//     skuCapacity: skuCapacity
//     kind: 'linux'
//     reserved: true
//     zoneRedundant: false
//   }
// }

module logAnalyticsWorkspace 'br/public:avm/res/operational-insights/workspace:0.16.0' = {
  name: 'deploy-log-analytics-workspace'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: logAnalyticsWorkspaceName
    location: locationAlt
  }
}

module staticWebApp 'br/public:avm/res/web/static-site:0.9.6' = {
  name: 'deploy-static-web-app'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: staticWebAppName
    location: locationAlt
    sku: staticWebAppSku
    customDomains: [
      staticWebAppCustomDomain
    ]
    validationMethod: 'dns-txt-token'
  }
}

// module applicationInsights 'br/public:avm/res/insights/component:0.8.0' = {
//   name: 'deploy-application-insights'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     name: applicationInsightsName
//     location: locationAlt
//     kind: 'web'
//     applicationType: 'web'
//     workspaceResourceId: logAnalyticsWorkspace.outputs.resourceId
//   }
// }

// module appService 'br/public:avm/res/web/site:0.15.1' = {
//   name: 'deploy-app-service'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     name: appServiceName
//     location: location
//     kind: 'app,linux'
//     serverFarmResourceId: appServicePlan.outputs.resourceId
//     siteConfig: {
//       linuxFxVersion: 'NODE|26-lts'
//       appCommandLine: 'npm start'
//     }
//     appSettingsKeyValuePairs: {
//       SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
//       WEBSITE_NODE_DEFAULT_VERSION: '~26'
//       APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.outputs.connectionString
//       ApplicationInsightsAgent_EXTENSION_VERSION: '~3'
//     }
//   }
// }

@description('Default hostname of the deployed Static Web App.')
output staticWebAppHostName string = staticWebApp.outputs.defaultHostname

@description('Name of the resource group that was created.')
output resourceGroupName string = resourceGroupName

@description('Name of the Static Web App that was created.')
output staticWebAppName string = staticWebApp.outputs.name
