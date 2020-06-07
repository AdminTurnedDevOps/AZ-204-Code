function New-CosmosDBContainer {

    param(
        [parameter(Mandatory,
            HelpMessage = 'Enter the CosmosDB account name that you are creating a container under')]
        [string]$cosmosDBAccountName,

        [parameter(Mandatory,
            HelpMessage = 'Enter the CosmosDB database that you are creating the container under')]
        [string]$cosmosDBDatabaseName,

        [parameter(Mandatory,
            HelpMessage = 'Enter the container name that will be created')]
        [string]$containerName,

        [parameter(Mandatory,
            HelpMessage = 'Enter the path of the partition. For example, `/users`')]
        [string]$partitionKey,

        [parameter(Mandatory,
            HelpMessage = 'Enter the resource group name that the CosmosDB account resides in')]
        [string]$resourceGroupName
    )

    az cosmosdb sql container create -g $resourceGroupName `
                                     -a $cosmosDBAccountName `
                                     -d $cosmosDBDatabaseName `
                                     -n $containerName `
                                     --partition-key-path $partitionKey
                                     
}