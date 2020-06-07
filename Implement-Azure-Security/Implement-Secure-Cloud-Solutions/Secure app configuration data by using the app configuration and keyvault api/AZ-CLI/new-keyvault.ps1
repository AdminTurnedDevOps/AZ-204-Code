param(
     [string]$name = '',
     [string]$resourceGroup = '',
     [string]$location = ''
)

az keyvault create --name $name `
                    --resource-group $resourceGroup `
                    --location $location