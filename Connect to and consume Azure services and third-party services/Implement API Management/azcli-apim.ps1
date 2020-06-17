param(
    [string]$apimName = 'clouddevtest',
    [string]$resourceGroupName = 'Dev2',
    [string]$region = 'eastus',
    [string]$email = 'your_azure_email'
)

az apim create --name $apimName `
               --resource-group $resourceGroupName `
               --publisher-email $email `
               --publisher-name Microsoft `
               --location $region