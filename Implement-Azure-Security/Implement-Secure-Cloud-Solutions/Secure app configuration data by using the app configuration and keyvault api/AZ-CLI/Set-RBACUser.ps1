param(
    [string]$keyVaultName = 'az204kv1992'
)

$appReg = az ad sp create-for-rbac --name "keyvaultUser" `
                                   --sdk-auth `
                                   -o table | ConvertFrom-Json

az keyvault set-policy -n $keyVaultName `
                       --spn $appReg.clientId `
                       --secret-permissions delete get list set `
                       --key-permissions create decrypt delete encrypt get list unwrapKey wrapKey
