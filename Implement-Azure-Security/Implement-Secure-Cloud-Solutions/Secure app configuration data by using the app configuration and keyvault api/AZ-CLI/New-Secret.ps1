param(
    [string]$name = '',
    [string]$vaultName = ''
)

$value = Read-Host "what is the secret value?"
$plaintText = ConvertTo-SecureString -AsPlainText -Force $value

az keyvault secret set --name $name `
                       --vault-name $vaultName `
                       --value $value