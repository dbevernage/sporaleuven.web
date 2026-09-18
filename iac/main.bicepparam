using 'main.bicep'

param location = 'belgiumcentral'
param locationAlt = 'westeurope'
param resourceGroupName = 'rg-spora-web-prd-bec'
param appServicePlanName = 'asp-spora-web-prd-bec'
param appServiceName = 'app-spora-web-prd-bec'
param skuName = 'P0v3'
param skuCapacity = 1
param logAnalyticsWorkspaceName = 'log-spora-web-prd-bec'
param applicationInsightsName = 'appi-spora-web-prd-bec'
param staticWebAppName = 'stapp-spora-web-prd-euw'
param staticWebAppCustomDomain = 'sporaleuven.be'
param staticWebAppSku = 'Free'
