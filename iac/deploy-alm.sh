#!/usr/bin/env bash
set -euo pipefail

# Deploys the ALM infrastructure (Resource Group & User-Assigned Managed Identity) to Azure.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCATION="${1:-belgiumcentral}"
DEPLOYMENT_NAME="deploy-spora-web-alm-$(date +%Y%m%d%H%M%S)"
TEMPLATE_FILE="${SCRIPT_DIR}/alm.bicep"
PARAMETERS_FILE="${SCRIPT_DIR}/alm.bicepparam"

echo "Deploying ALM infrastructure to Azure..."
echo "Location:        ${LOCATION}"
echo "Template:        ${TEMPLATE_FILE}"
echo "Parameters:      ${PARAMETERS_FILE}"
echo "Deployment Name: ${DEPLOYMENT_NAME}"

az deployment sub create \
    --name "${DEPLOYMENT_NAME}" \
    --location "${LOCATION}" \
    --template-file "${TEMPLATE_FILE}" \
    --parameters "${PARAMETERS_FILE}"

echo "Deployment completed successfully!"
