param(
    [string]$resourceGroupName = 'CBTAzure',
    [string]$image = 'nginx',
    [string]$name = 'nginxweb'

)

az container create --resource-group $resourceGroupName --image nginx --name $name