# Use AZ CLI to deploy the ARM template

param(
    [string]$resourceGroupName = 'CBTAzure'
)

az deployment group create --resource-group $resourceGroupName `
                           --template-file ./azuredeploy.json `
                           --parameters ./azuredeploy.params.json