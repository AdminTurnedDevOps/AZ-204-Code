function Create-SQLCosmosDB {

    param(
        [string]$accountName,
        [string]$databaseName,
        [string]$resourceGroupName
    )

    begin {
        $checker = az cosmosdb check-name-exists --name $accountName
        if ($checker) {
            Write-Warning "Cosmos account name exists: $accountName"
            Pause
        }
    }

    process {    
        try {
            Write-Host -ForegroundColor Green 'Creating Cosmos DB Account...'
            az cosmosdb create --name $accountName `
                --resource-group $resourceGroupName

            Write-Host -ForegroundColor Blue 'Creating Microsoft SQL database...'
            az cosmosdb sql database create --account-name $accountName `
                --name $databaseName `
                --resource-group $resourceGroupName
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {
        Write-Output "Command Complete: $($MyInvocation.MyCommand)."
    }
}