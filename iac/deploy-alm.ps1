<#
.SYNOPSIS
Deploys the ALM infrastructure (Resource Group & User-Assigned Managed Identity) to Azure.

.DESCRIPTION
Deploys the `alm.bicep` template with parameters from `alm.bicepparam` to create the
resource group `rg-spora-web-alm-prd-bec` and the User-Assigned Managed Identity.
#>

[CmdletBinding()]
param(
    [string]$Location = "belgiumcentral",
    [string]$DeploymentName = "deploy-spora-web-alm-$(Get-Date -Format 'yyyyMMddHHmmss')"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$templateFile = Join-Path $scriptDir "alm.bicep"
$parametersFile = Join-Path $scriptDir "alm.bicepparam"

Write-Host "Deploying ALM infrastructure to Azure..." -ForegroundColor Cyan
Write-Host "Location:        $Location"
Write-Host "Template:        $templateFile"
Write-Host "Parameters:      $parametersFile"
Write-Host "Deployment Name: $DeploymentName"

az deployment sub create `
    --name $DeploymentName `
    --location $Location `
    --template-file $templateFile `
    --parameters $parametersFile

if ($LASTEXITCODE -eq 0) {
    Write-Host "Deployment completed successfully!" -ForegroundColor Green
} else {
    Write-Error "Deployment failed with exit code $LASTEXITCODE"
}
