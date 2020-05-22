param(
    [string]$sourceStorageAccount = '',
    [string]$destinationStorageAccount = '',
    [string]$sourceContainer = '',
    [string]$destinationContainer = ''
)

$key = $(az storage account keys list --account-name $sourceStorageAccount --output json | ConvertFrom-Json | Select -First 1 -ExpandProperty Value)

az storage blob copy start --destination-container $destinationContainer `
                           --destination-blob 'newMSBUILD.jpg' `
                           --account-name $sourceStorageAccount `
                           --account-key $key `
                           --source-container $sourceContainer `
                           --source-blob '2020-04-29_07-19-57.jpg'

